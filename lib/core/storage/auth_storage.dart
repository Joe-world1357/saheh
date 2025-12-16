import 'package:hive_flutter/hive_flutter.dart';
import '../../models/user_model.dart';

/// Local storage service for authentication using Hive
/// Stores user credentials and session data
/// Supports multiple users with isolated credentials
class AuthStorage {
  static const String _authBoxName = 'auth';
  static const String _userBoxName = 'users';
  static const String _credentialsBoxName = 'credentials'; // Separate box for credentials
  static const String _sessionKey = 'isLoggedIn';
  static const String _currentUserKey = 'currentUserId';

  static Box? _authBox;
  static Box? _userBox;
  static Box? _credentialsBox;

  /// Initialize Hive boxes
  static Future<void> init() async {
    await Hive.initFlutter();
    _authBox = await Hive.openBox(_authBoxName);
    _userBox = await Hive.openBox(_userBoxName);
    _credentialsBox = await Hive.openBox(_credentialsBoxName);
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    return _authBox?.get(_sessionKey, defaultValue: false) ?? false;
  }

  /// Get current user ID (email)
  static String? getCurrentUserId() {
    return _authBox?.get(_currentUserKey);
  }

  /// Get current user
  static UserModel? getCurrentUser() {
    final userId = getCurrentUserId();
    if (userId == null) return null;
    
    final userData = _userBox?.get(userId);
    if (userData == null) return null;
    
    return UserModel.fromMap(Map<String, dynamic>.from(userData));
  }

  /// Save user credentials (per user - keyed by email)
  static Future<void> saveCredentials(String email, String hashedPassword) async {
    // Store credentials keyed by email for multi-user support
    await _credentialsBox?.put(email, {
      'email': email,
      'password': hashedPassword,
    });
  }

  /// Get stored credentials for a specific user
  static Map<String, String>? getCredentialsForUser(String email) {
    final creds = _credentialsBox?.get(email);
    if (creds == null) return null;
    return Map<String, String>.from(creds);
  }

  /// Verify password for a specific user
  static bool verifyPassword(String email, String password) {
    // Get credentials for this specific user
    final creds = getCredentialsForUser(email);
    if (creds == null) return false;
    
    // Verify the password hash matches
    return creds['password'] == _hashPassword(password);
  }

  /// Hash password (simple implementation - use proper hashing in production)
  static String _hashPassword(String password) {
    // Simple hash - in production use bcrypt or similar
    return password.hashCode.toString();
  }

  /// Save user data
  static Future<void> saveUser(UserModel user) async {
    final userId = user.email; // Use email as user ID
    await _userBox?.put(userId, user.toMap());
  }

  /// Get user by email
  static UserModel? getUserByEmail(String email) {
    final userData = _userBox?.get(email);
    if (userData == null) return null;
    return UserModel.fromMap(Map<String, dynamic>.from(userData));
  }

  /// Check if user exists
  static bool userExists(String email) {
    return _credentialsBox?.containsKey(email) ?? false;
  }

  /// Login user
  static Future<void> login(UserModel user) async {
    await _authBox?.put(_sessionKey, true);
    await _authBox?.put(_currentUserKey, user.email);
    await saveUser(user);
  }

  /// Logout user
  static Future<void> logout() async {
    await _authBox?.put(_sessionKey, false);
    await _authBox?.delete(_currentUserKey);
    // Don't delete credentials - allow re-login
  }

  /// Register new user
  static Future<void> register(UserModel user, String password) async {
    await saveUser(user);
    await saveCredentials(user.email, _hashPassword(password));
    await login(user);
  }

  /// Update user data
  static Future<void> updateUser(UserModel user) async {
    await saveUser(user);
    // If this is the current user, update session
    if (getCurrentUserId() == user.email) {
      await _authBox?.put(_currentUserKey, user.email);
    }
  }

  /// Clear all data (for logout or account deletion)
  static Future<void> clearAll() async {
    await _authBox?.clear();
    await _userBox?.clear();
    await _credentialsBox?.clear();
  }

  /// Delete a specific user's data
  static Future<void> deleteUser(String email) async {
    await _userBox?.delete(email);
    await _credentialsBox?.delete(email);
    // If this was the current user, log out
    if (getCurrentUserId() == email) {
      await logout();
    }
  }
}

