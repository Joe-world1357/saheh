import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'dart:io' show Platform;
import '../database/database_helper.dart';
import '../core/notifications/notification_manager.dart';
import 'auth_provider.dart';

/// User preferences model
class UserPreferences {
  final String themeMode; // 'light', 'dark', 'system'
  final bool fitnessReminders;
  final bool waterReminders;
  final bool sleepReminders;
  final bool nutritionReminders;
  final bool xpNotifications;
  final bool achievementNotifications;
  final String language; // 'en', 'ar', etc.

  UserPreferences({
    this.themeMode = 'system',
    this.fitnessReminders = true,
    this.waterReminders = true,
    this.sleepReminders = true,
    this.nutritionReminders = true,
    this.xpNotifications = true,
    this.achievementNotifications = true,
    this.language = 'en',
  });

  UserPreferences copyWith({
    String? themeMode,
    bool? fitnessReminders,
    bool? waterReminders,
    bool? sleepReminders,
    bool? nutritionReminders,
    bool? xpNotifications,
    bool? achievementNotifications,
    String? language,
  }) {
    return UserPreferences(
      themeMode: themeMode ?? this.themeMode,
      fitnessReminders: fitnessReminders ?? this.fitnessReminders,
      waterReminders: waterReminders ?? this.waterReminders,
      sleepReminders: sleepReminders ?? this.sleepReminders,
      nutritionReminders: nutritionReminders ?? this.nutritionReminders,
      xpNotifications: xpNotifications ?? this.xpNotifications,
      achievementNotifications: achievementNotifications ?? this.achievementNotifications,
      language: language ?? this.language,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'themeMode': themeMode,
      'fitnessReminders': fitnessReminders,
      'waterReminders': waterReminders,
      'sleepReminders': sleepReminders,
      'nutritionReminders': nutritionReminders,
      'xpNotifications': xpNotifications,
      'achievementNotifications': achievementNotifications,
      'language': language,
    };
  }

  factory UserPreferences.fromMap(Map<String, String> map) {
    return UserPreferences(
      themeMode: map['themeMode'] ?? 'system',
      fitnessReminders: map['fitnessReminders'] == 'true',
      waterReminders: map['waterReminders'] == 'true',
      sleepReminders: map['sleepReminders'] == 'true',
      nutritionReminders: map['nutritionReminders'] != 'false', // Default true
      xpNotifications: map['xpNotifications'] != 'false', // Default true
      achievementNotifications: map['achievementNotifications'] != 'false', // Default true
      language: map['language'] ?? 'en',
    );
  }
}

class UserPreferencesNotifier extends Notifier<UserPreferences> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  UserPreferences build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return UserPreferences(); // Default preferences
    }
    
    // Load preferences for current user
    _loadPreferences();
    return UserPreferences(); // Will be updated by _loadPreferences
  }

  Future<void> _loadPreferences() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = UserPreferences();
      return;
    }

    try {
      final settings = await _db.getAllUserSettings(userEmail);
      state = UserPreferences.fromMap(settings);
    } catch (e) {
      // Use defaults on error
      state = UserPreferences();
    }
  }

  Future<void> updateThemeMode(String themeMode) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'themeMode', themeMode);
      state = state.copyWith(themeMode: themeMode);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateFitnessReminders(bool enabled) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'fitnessReminders', enabled.toString());
      state = state.copyWith(fitnessReminders: enabled);
      
      // Update notifications
      _updateNotifications();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateWaterReminders(bool enabled) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'waterReminders', enabled.toString());
      state = state.copyWith(waterReminders: enabled);
      
      // Update notifications
      _updateNotifications();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateSleepReminders(bool enabled) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'sleepReminders', enabled.toString());
      state = state.copyWith(sleepReminders: enabled);
      
      // Update notifications
      _updateNotifications();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateNutritionReminders(bool enabled) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'nutritionReminders', enabled.toString());
      state = state.copyWith(nutritionReminders: enabled);
      
      // Update notifications
      _updateNotifications();
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateXPNotifications(bool enabled) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'xpNotifications', enabled.toString());
      state = state.copyWith(xpNotifications: enabled);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> updateAchievementNotifications(bool enabled) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'achievementNotifications', enabled.toString());
      state = state.copyWith(achievementNotifications: enabled);
    } catch (e) {
      // Handle error
    }
  }

  /// Update notifications when preferences change
  void _updateNotifications() {
    if (!Platform.isAndroid) return;
    
    // Use post-frame callback to avoid calling during build
    SchedulerBinding.instance.addPostFrameCallback((_) async {
      try {
        await NotificationManager.instance.setupNotifications(ref);
      } catch (e) {
        debugPrint('Error updating notifications: $e');
      }
    });
  }

  Future<void> updateLanguage(String language) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      await _db.insertOrUpdateUserSetting(userEmail, 'language', language);
      state = state.copyWith(language: language);
    } catch (e) {
      // Handle error
    }
  }

  Future<void> refresh() async {
    await _loadPreferences();
  }
}

final userPreferencesProvider = NotifierProvider<UserPreferencesNotifier, UserPreferences>(() {
  return UserPreferencesNotifier();
});

