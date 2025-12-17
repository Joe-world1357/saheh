import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../core/storage/auth_storage.dart';
import '../database/database_helper.dart';
import 'home_data_provider.dart';
import 'reminders_provider.dart';
import 'medicine_intake_provider.dart';

/// Authentication state
class AuthState {
  final bool isAuthenticated;
  final UserModel? user;
  final bool isLoading;
  final String? error;

  AuthState({
    this.isAuthenticated = false,
    this.user,
    this.isLoading = false,
    this.error,
  });

  AuthState copyWith({
    bool? isAuthenticated,
    UserModel? user,
    bool? isLoading,
    String? error,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: user ?? this.user,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Authentication provider
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _checkAuthStatus();
    return AuthState();
  }

  /// Check authentication status on app start
  Future<void> _checkAuthStatus() async {
    state = state.copyWith(isLoading: true);
    
    try {
      final isLoggedIn = AuthStorage.isLoggedIn();
      if (isLoggedIn) {
        final user = AuthStorage.getCurrentUser();
        state = AuthState(
          isAuthenticated: true,
          user: user,
          isLoading: false,
        );
      } else {
        state = AuthState(isLoading: false);
      }
    } catch (e) {
      state = AuthState(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Refresh authentication state (public method)
  Future<bool> refreshAuthState() async {
    await _checkAuthStatus();
    return state.isAuthenticated;
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // First check if user exists
      final userExists = AuthStorage.userExists(email) || AuthStorage.getUserByEmail(email) != null;
      if (!userExists) {
        state = state.copyWith(
          isLoading: false,
          error: 'No account found with this email. Please register first.',
        );
        return false;
      }

      // Verify credentials
      final isValid = AuthStorage.verifyPassword(email, password);
      if (!isValid) {
        state = state.copyWith(
          isLoading: false,
          error: 'Incorrect password. Please try again.',
        );
        return false;
      }

      // Get user data from Hive
      var user = AuthStorage.getUserByEmail(email);
      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'User data not found. Please register again.',
        );
        return false;
      }

      // Try to load user from SQLite database (more complete data)
      final db = DatabaseHelper.instance;
      final dbUser = await db.getUserByEmail(email);
      
      // If SQLite has user data, use it (it might have more updated XP/level)
      if (dbUser != null) {
        user = dbUser;
        // Sync to Hive
        await AuthStorage.updateUser(user);
      } else {
        // If no SQLite user, create one from Hive data
        try {
          await db.insertUser(user);
        } catch (e) {
          // User might already exist, try to update instead
          debugPrint('Insert failed, trying update: $e');
          await db.updateUserByEmail(user);
        }
      }

      // Login user
      await AuthStorage.login(user);

      state = AuthState(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );

      // Refresh all user-specific data for the newly logged in user
      ref.invalidate(homeDataProvider);
      ref.invalidate(remindersProvider);
      ref.invalidate(medicineIntakeProvider);

      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Register new user
  Future<bool> register({
    required String name,
    required String email,
    required String password,
    String? phone,
  }) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Check if user already exists
      final existingUser = AuthStorage.getUserByEmail(email);
      if (existingUser != null) {
        state = state.copyWith(
          isLoading: false,
          error: 'User with this email already exists',
        );
        return false;
      }

      // Create new user
      final user = UserModel(
        name: name,
        email: email,
        phone: phone,
        xp: 0,
        level: 1,
      );

      // Register user in Hive (this also logs them in via AuthStorage.register)
      await AuthStorage.register(user, password);
      
      // Also save to SQLite database
      try {
        final db = DatabaseHelper.instance;
        // Check if user already exists in SQLite
        final existingDbUser = await db.getUserByEmail(email);
        if (existingDbUser == null) {
          await db.insertUser(user);
        }
      } catch (e) {
        // If SQLite insert fails, continue anyway (Hive has the data)
        debugPrint('Warning: Could not save user to SQLite: $e');
      }

      // Verify login was successful and get user from storage
      final isLoggedIn = AuthStorage.isLoggedIn();
      final loggedInUser = AuthStorage.getCurrentUser();
      
      if (isLoggedIn && loggedInUser != null) {
        state = AuthState(
          isAuthenticated: true,
          user: loggedInUser,
          isLoading: false,
        );
        return true;
      } else {
        // Fallback: set state manually
        state = AuthState(
          isAuthenticated: true,
          user: user,
          isLoading: false,
        );
        return true;
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  /// Logout user
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      await AuthStorage.logout();
      
      // Clear state and invalidate all user-specific providers
      state = AuthState(isLoading: false);
      
      // These will auto-clear because they watch authProvider
      ref.invalidate(homeDataProvider);
      ref.invalidate(remindersProvider);
      ref.invalidate(medicineIntakeProvider);
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Update user profile
  Future<void> updateUser(UserModel user) async {
    try {
      // Update in both Hive and SQLite
      await AuthStorage.updateUser(user);
      final db = DatabaseHelper.instance;
      await db.updateUser(user);
      state = state.copyWith(user: user);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  /// Add XP to current user
  Future<void> addXP(int amount) async {
    if (state.user == null) return;

    try {
      final updatedUser = state.user!.copyWith(
        xp: state.user!.xp + amount,
        level: _calculateLevel(state.user!.xp + amount),
        updatedAt: DateTime.now(),
      );

      await updateUser(updatedUser);
    } catch (e) {
      state = state.copyWith(error: e.toString());
    }
  }

  int _calculateLevel(int xp) {
    // Simple level calculation: 100 XP per level
    return (xp / 100).floor() + 1;
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});

