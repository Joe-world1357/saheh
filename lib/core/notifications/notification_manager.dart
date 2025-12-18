import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../database/database_helper.dart';
import '../../providers/user_preferences_provider.dart';
import '../../providers/auth_provider.dart';
import 'notification_service.dart';

/// Notification Manager
/// 
/// Watches user preferences and schedules/cancels notifications accordingly.
/// Integrates with user data to trigger real notifications.
class NotificationManager {
  NotificationManager._();

  static final NotificationManager instance = NotificationManager._();

  final NotificationService _notificationService = NotificationService.instance;
  final DatabaseHelper _db = DatabaseHelper.instance;

  /// Setup all notifications based on user preferences
  /// Call this after user login or when preferences change
  /// Accepts both Ref (from Notifier) and WidgetRef (from widgets)
  Future<void> setupNotifications(dynamic ref) async {
    final userPrefs = ref.read(userPreferencesProvider);
    final authState = ref.read(authProvider);
    final userEmail = authState.user?.email;

    if (userEmail == null) {
      debugPrint('No user email, skipping notification setup');
      return;
    }

    // Check if notifications are enabled globally
    final notificationsEnabled = await _notificationService.areNotificationsEnabled();
    if (!notificationsEnabled) {
      debugPrint('Notifications not enabled, skipping setup');
      return;
    }

    try {
      // Cancel all existing notifications first
      await _notificationService.cancelAll();

      // Setup workout reminders
      if (userPrefs.fitnessReminders) {
        await _setupWorkoutReminders(userEmail);
      }

      // Setup water reminders
      if (userPrefs.waterReminders) {
        await _setupWaterReminders(userEmail);
      }

      // Setup sleep reminders
      if (userPrefs.sleepReminders) {
        await _setupSleepReminders(userEmail);
      }

      debugPrint('Notifications setup completed');
    } catch (e) {
      debugPrint('Error setting up notifications: $e');
    }
  }

  /// Setup workout reminders based on user's workout schedule
  Future<void> _setupWorkoutReminders(String userEmail) async {
    try {
      // Get user's workout preferences or default time (8:00 AM)
      final workoutTime = await _getWorkoutReminderTime(userEmail);
      
      await _notificationService.scheduleWorkoutReminder(
        time: workoutTime,
      );
      
      debugPrint('Workout reminder scheduled for ${workoutTime.hour}:${workoutTime.minute}');
    } catch (e) {
      debugPrint('Error setting up workout reminders: $e');
    }
  }

  /// Setup water intake reminders
  Future<void> _setupWaterReminders(String userEmail) async {
    try {
      // Default: Remind every 2 hours from 8 AM to 10 PM
      final startTime = const Time(8, 0);
      final endTime = const Time(22, 0);
      
      await _notificationService.scheduleWaterReminder(
        intervalMinutes: 120, // Every 2 hours
        startTime: startTime,
        endTime: endTime,
      );
      
      debugPrint('Water reminders scheduled');
    } catch (e) {
      debugPrint('Error setting up water reminders: $e');
    }
  }

  /// Setup sleep reminders based on user's sleep goal
  Future<void> _setupSleepReminders(String userEmail) async {
    try {
      // Get user's sleep goal time or default (10:00 PM)
      final bedtime = await _getSleepBedtime(userEmail);
      
      await _notificationService.scheduleSleepReminder(
        bedtime: bedtime,
      );
      
      debugPrint('Sleep reminder scheduled for ${bedtime.hour}:${bedtime.minute}');
    } catch (e) {
      debugPrint('Error setting up sleep reminders: $e');
    }
  }

  /// Get workout reminder time from user settings
  Future<Time> _getWorkoutReminderTime(String userEmail) async {
    try {
      final setting = await _db.getUserSetting(userEmail, 'workout_reminder_time');
      if (setting != null && setting.isNotEmpty) {
        // Parse time from setting (format: "HH:mm")
        final parts = setting.split(':');
        if (parts.length == 2) {
          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour != null && minute != null) {
            return Time(hour, minute);
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting workout reminder time: $e');
    }
    
    // Default: 8:00 AM
    return const Time(8, 0);
  }

  /// Get sleep bedtime from user settings
  Future<Time> _getSleepBedtime(String userEmail) async {
    try {
      final setting = await _db.getUserSetting(userEmail, 'sleep_bedtime');
      if (setting != null && setting.isNotEmpty) {
        // Parse time from setting (format: "HH:mm")
        final parts = setting.split(':');
        if (parts.length == 2) {
          final hour = int.tryParse(parts[0]);
          final minute = int.tryParse(parts[1]);
          if (hour != null && minute != null) {
            return Time(hour, minute);
          }
        }
      }
    } catch (e) {
      debugPrint('Error getting sleep bedtime: $e');
    }
    
    // Default: 10:00 PM
    return const Time(22, 0);
  }

  /// Cancel all notifications
  Future<void> cancelAllNotifications() async {
    await _notificationService.cancelAll();
  }
}

