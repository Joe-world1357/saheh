import 'package:hive_flutter/hive_flutter.dart';
import '../../models/user_model.dart';

/// Local storage service for authentication using Hive
/// Stores user credentials and session data
/// Supports multiple users with isolated credentials
class AuthStorage {
  static const String _authBoxName = 'auth';
  static const String _userBoxName = 'users';
  static const String _credentialsBoxName = 'credentials';
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

  /// Ensure boxes are open (call before any operation)
  static Future<void> _ensureBoxesOpen() async {
    if (_authBox == null || !_authBox!.isOpen) {
      _authBox = await Hive.openBox(_authBoxName);
    }
    if (_userBox == null || !_userBox!.isOpen) {
      _userBox = await Hive.openBox(_userBoxName);
    }
    if (_credentialsBox == null || !_credentialsBox!.isOpen) {
      _credentialsBox = await Hive.openBox(_credentialsBoxName);
    }
  }

  /// Check if user is logged in
  static bool isLoggedIn() {
    if (_authBox == null || !_authBox!.isOpen) return false;
    return _authBox?.get(_sessionKey, defaultValue: false) ?? false;
  }

  /// Get current user ID (email)
  static String? getCurrentUserId() {
    if (_authBox == null || !_authBox!.isOpen) return null;
    return _authBox?.get(_currentUserKey);
  }

  /// Get current user
  static UserModel? getCurrentUser() {
    final userId = getCurrentUserId();
    if (userId == null) return null;
    if (_userBox == null || !_userBox!.isOpen) return null;
    
    final userData = _userBox?.get(userId);
    if (userData == null) return null;
    
    return UserModel.fromMap(Map<String, dynamic>.from(userData));
  }

  /// Save user credentials (per user - keyed by email)
  static Future<void> saveCredentials(String email, String hashedPassword) async {
    await _ensureBoxesOpen();
    await _credentialsBox?.put(email, {
      'email': email,
      'password': hashedPassword,
    });
  }

  /// Get stored credentials for a specific user
  static Map<String, String>? getCredentialsForUser(String email) {
    if (_credentialsBox == null || !_credentialsBox!.isOpen) return null;
    final creds = _credentialsBox?.get(email);
    if (creds == null) return null;
    return Map<String, String>.from(creds);
  }

  /// Verify password for a specific user
  static bool verifyPassword(String email, String password) {
    // Get credentials for this specific user
    var creds = getCredentialsForUser(email);
    
    // Fallback: Check old auth box format (for backward compatibility)
    if (creds == null && _authBox != null && _authBox!.isOpen) {
      final oldCreds = _authBox?.get('credentials');
      if (oldCreds != null) {
        final oldCredsMap = Map<String, dynamic>.from(oldCreds);
        if (oldCredsMap['email'] == email) {
          final hashedPwd = oldCredsMap['password'] as String?;
          if (hashedPwd != null && hashedPwd == _hashPassword(password)) {
            // Migrate credentials to new format
            _credentialsBox?.put(email, {
              'email': email,
              'password': hashedPwd,
            });
            return true;
          }
        }
      }
      return false;
    }
    
    if (creds == null) return false;
    return creds['password'] == _hashPassword(password);
  }

  /// Hash password
  static String _hashPassword(String password) {
    return password.hashCode.toString();
  }

  /// Save user data
  static Future<void> saveUser(UserModel user) async {
    await _ensureBoxesOpen();
    final userId = user.email;
    await _userBox?.put(userId, user.toMap());
  }

  /// Get user by email
  static UserModel? getUserByEmail(String email) {
    if (_userBox == null || !_userBox!.isOpen) return null;
    final userData = _userBox?.get(email);
    if (userData == null) return null;
    return UserModel.fromMap(Map<String, dynamic>.from(userData));
  }

  /// Check if user exists
  static bool userExists(String email) {
    if (_credentialsBox == null || !_credentialsBox!.isOpen) return false;
    return _credentialsBox?.containsKey(email) ?? false;
  }

  /// Login user - sets session flags
  static Future<void> login(UserModel user) async {
    await _ensureBoxesOpen();
    await _authBox?.put(_sessionKey, true);
    await _authBox?.put(_currentUserKey, user.email);
    await saveUser(user);
  }

  /// Logout user - clears session only, preserves user data
  static Future<void> logout() async {
    await _ensureBoxesOpen();
    await _authBox?.put(_sessionKey, false);
    await _authBox?.delete(_currentUserKey);
    // DO NOT delete user data or credentials - allow re-login
  }

  /// Register new user
  static Future<void> register(UserModel user, String password) async {
    await _ensureBoxesOpen();
    await saveUser(user);
    await saveCredentials(user.email, _hashPassword(password));
    await login(user);
  }

  /// Update user data
  static Future<void> updateUser(UserModel user) async {
    await _ensureBoxesOpen();
    await saveUser(user);
  }

  /// Clear all data (for account deletion only)
  static Future<void> clearAll() async {
    await _ensureBoxesOpen();
    await _authBox?.clear();
    await _userBox?.clear();
    await _credentialsBox?.clear();
  }

  /// Delete a specific user's data
  static Future<void> deleteUser(String email) async {
    await _ensureBoxesOpen();
    await _userBox?.delete(email);
    await _credentialsBox?.delete(email);
    if (getCurrentUserId() == email) {
      await logout();
    }
  }
}
