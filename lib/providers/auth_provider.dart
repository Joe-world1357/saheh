import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../core/storage/auth_storage.dart';

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

  /// Login with email and password
  Future<bool> login(String email, String password) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      // Verify credentials
      final isValid = AuthStorage.verifyPassword(email, password);
      if (!isValid) {
        state = state.copyWith(
          isLoading: false,
          error: 'Invalid email or password',
        );
        return false;
      }

      // Get user data
      final user = AuthStorage.getUserByEmail(email);
      if (user == null) {
        state = state.copyWith(
          isLoading: false,
          error: 'User not found',
        );
        return false;
      }

      // Login user
      await AuthStorage.login(user);

      state = AuthState(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );

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

      // Register user
      await AuthStorage.register(user, password);

      state = AuthState(
        isAuthenticated: true,
        user: user,
        isLoading: false,
      );

      return true;
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
      state = AuthState(isLoading: false);
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
      await AuthStorage.updateUser(user);
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

