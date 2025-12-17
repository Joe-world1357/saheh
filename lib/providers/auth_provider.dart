import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../core/storage/auth_storage.dart';
import '../database/database_helper.dart';
import 'home_data_provider.dart';
import 'reminders_provider.dart';
import 'medicine_intake_provider.dart';
import 'nutrition_provider.dart';
import 'workouts_provider.dart';
import 'appointments_provider.dart';
import 'health_tracking_provider.dart';
import 'orders_provider.dart';
import 'cart_provider.dart';
import 'activity_provider.dart';
import 'men_workout_provider.dart';

/// Authentication state
class AuthState {
  final bool isAuthenticated;
  final UserModel? user;
  final bool isLoading;
  final String? error;

  const AuthState({
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
    bool clearUser = false,
    bool clearError = false,
  }) {
    return AuthState(
      isAuthenticated: isAuthenticated ?? this.isAuthenticated,
      user: clearUser ? null : (user ?? this.user),
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Authentication provider
class AuthNotifier extends Notifier<AuthState> {
  @override
  AuthState build() {
    _checkAuthStatus();
    return const AuthState(isLoading: true);
  }

  /// Check authentication status on app start
  Future<void> _checkAuthStatus() async {
    try {
      final isLoggedIn = AuthStorage.isLoggedIn();
      if (isLoggedIn) {
        final user = AuthStorage.getCurrentUser();
        if (user != null) {
          state = AuthState(
            isAuthenticated: true,
            user: user,
            isLoading: false,
          );
          return;
        }
      }
      state = const AuthState(isLoading: false);
    } catch (e) {
      debugPrint('Auth check error: $e');
      state = const AuthState(isLoading: false);
    }
  }

  /// Refresh authentication state (public method)
  Future<bool> refreshAuthState() async {
    await _checkAuthStatus();
    return state.isAuthenticated;
  }

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    // Clear previous error and set loading
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Check if user exists
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
      try {
        final db = DatabaseHelper.instance;
        final dbUser = await db.getUserByEmail(email);
        
        if (dbUser != null) {
          // SQLite has more updated data (XP, level, etc.)
          user = dbUser;
          await AuthStorage.updateUser(user);
        } else {
          // Create user in SQLite from Hive data
          try {
            await db.insertUser(user);
          } catch (e) {
            await db.updateUserByEmail(user);
          }
        }
      } catch (e) {
        debugPrint('DB sync warning: $e');
      }

      // Set login session (user is guaranteed non-null at this point)
      await AuthStorage.login(user!);

      // Update state with authenticated user
      state = AuthState(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );

      // Refresh all user-specific providers
      _invalidateAllUserProviders();

      return true;
    } catch (e) {
      debugPrint('Login error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Login failed. Please try again.',
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
    state = state.copyWith(isLoading: true, clearError: true);

    try {
      // Check if user already exists
      final existingUser = AuthStorage.getUserByEmail(email);
      if (existingUser != null || AuthStorage.userExists(email)) {
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

      // Register user in Hive
      await AuthStorage.register(user, password);
      
      // Also save to SQLite database
      try {
        final db = DatabaseHelper.instance;
        final existingDbUser = await db.getUserByEmail(email);
        if (existingDbUser == null) {
          await db.insertUser(user);
        }
      } catch (e) {
        debugPrint('Warning: Could not save user to SQLite: $e');
      }

      // Update state
      state = AuthState(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );

      // Refresh providers for new user
      _invalidateAllUserProviders();

      return true;
    } catch (e) {
      debugPrint('Registration error: $e');
      state = state.copyWith(
        isLoading: false,
        error: 'Registration failed. Please try again.',
      );
      return false;
    }
  }

  /// Logout user - clears session only, preserves data
  Future<void> logout() async {
    state = state.copyWith(isLoading: true);

    try {
      // Clear session in storage (preserves user data)
      await AuthStorage.logout();
      
      // Reset state to logged out
      state = const AuthState(
        isAuthenticated: false,
        user: null,
        isLoading: false,
      );
      
      // Invalidate all providers so they refresh on next login
      _invalidateAllUserProviders();
    } catch (e) {
      debugPrint('Logout error: $e');
      // Even on error, clear state
      state = const AuthState(
        isAuthenticated: false,
        user: null,
        isLoading: false,
        error: 'Logout completed with warnings',
      );
    }
  }

  /// Update user profile
  Future<void> updateUser(UserModel user) async {
    try {
      await AuthStorage.updateUser(user);
      final db = DatabaseHelper.instance;
      await db.updateUserByEmail(user);
      state = state.copyWith(user: user);
    } catch (e) {
      debugPrint('Update user error: $e');
    }
  }

  /// Add XP to current user
  Future<void> addXP(int amount) async {
    if (state.user == null) return;

    try {
      final newXP = state.user!.xp + amount;
      final updatedUser = state.user!.copyWith(
        xp: newXP,
        level: _calculateLevel(newXP),
        updatedAt: DateTime.now(),
      );

      await updateUser(updatedUser);
    } catch (e) {
      debugPrint('Add XP error: $e');
    }
  }

  int _calculateLevel(int xp) {
    return (xp / 100).floor() + 1;
  }

  /// Invalidate all user-specific providers
  void _invalidateAllUserProviders() {
    try {
      ref.invalidate(homeDataProvider);
      ref.invalidate(remindersProvider);
      ref.invalidate(medicineIntakeProvider);
      ref.invalidate(nutritionProvider);
      ref.invalidate(workoutsProvider);
      ref.invalidate(appointmentsProvider);
      ref.invalidate(healthTrackingProvider);
      ref.invalidate(ordersProvider);
      ref.invalidate(cartProvider);
      ref.invalidate(activityProvider);
      ref.invalidate(menWorkoutProvider);
    } catch (e) {
      debugPrint('Provider invalidation warning: $e');
    }
  }
}

final authProvider = NotifierProvider<AuthNotifier, AuthState>(() {
  return AuthNotifier();
});
