import 'dart:io';
import 'package:flutter/foundation.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart' show
    FlutterLocalNotificationsPlugin,
    AndroidInitializationSettings,
    DarwinInitializationSettings,
    InitializationSettings,
    NotificationResponse,
    NotificationDetails,
    AndroidNotificationDetails,
    AndroidScheduleMode,
    UILocalNotificationDateInterpretation,
    DateTimeComponents,
    Importance,
    Priority,
    AndroidFlutterLocalNotificationsPlugin,
    AndroidNotificationChannel;
import 'package:timezone/timezone.dart' as tz;
import 'package:timezone/data/latest_all.dart' as tz;
import 'notification_channels.dart';
import '../permissions/permission_handler.dart';

/// Simple Time class to represent hour and minute
class Time {
  final int hour;
  final int minute;
  
  const Time(this.hour, this.minute);
  
  @override
  String toString() => '${hour.toString().padLeft(2, '0')}:${minute.toString().padLeft(2, '0')}';
}

/// Centralized Notification Service
/// 
/// Handles all local notifications for the app:
/// - Workout reminders
/// - Water intake reminders
/// - Sleep reminders
/// - Goal completion notifications
/// - XP earned notifications
class NotificationService {
  NotificationService._();

  static final NotificationService instance = NotificationService._();

  final FlutterLocalNotificationsPlugin _notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  bool _initialized = false;

  /// Initialize the notification service
  /// Must be called during app startup (in main.dart)
  Future<bool> initialize() async {
    if (_initialized) return true;

    try {
      // Initialize timezone data
      tz.initializeTimeZones();
      tz.setLocalLocation(tz.getLocation('UTC'));

      // Initialize Android settings
      const androidSettings = AndroidInitializationSettings('@mipmap/ic_launcher');

      // Initialize iOS settings (optional, for future iOS support)
      const iosSettings = DarwinInitializationSettings(
        requestAlertPermission: true,
        requestBadgePermission: true,
        requestSoundPermission: true,
      );

      const initSettings = InitializationSettings(
        android: androidSettings,
        iOS: iosSettings,
      );

      // Request permissions (Android 13+)
      if (Platform.isAndroid) {
        final granted = await PermissionHandler.requestNotificationPermission();
        if (!granted) {
          debugPrint('Notification permission denied');
          // Continue anyway - user can enable later in settings
        }
      }

      // Initialize plugin
      final initialized = await _notificationsPlugin.initialize(
        initSettings,
        onDidReceiveNotificationResponse: _onNotificationTapped,
      );

      if (initialized == true) {
        // Create notification channels (Android 8.0+)
        await NotificationChannels.initializeChannels(_notificationsPlugin);
        _initialized = true;
        debugPrint('NotificationService initialized successfully');
        return true;
      }

      return false;
    } catch (e) {
      debugPrint('Error initializing NotificationService: $e');
      return false;
    }
  }

  /// Handle notification tap
  void _onNotificationTapped(NotificationResponse response) {
    debugPrint('Notification tapped: ${response.id}');
    // Can navigate to specific screen based on notification payload
  }

  /// Check if notifications are enabled
  Future<bool> areNotificationsEnabled() async {
    if (Platform.isAndroid) {
      return await PermissionHandler.checkNotificationPermission();
    }
    return true; // iOS handled by system
  }

  // ============================================================================
  // WORKOUT REMINDERS
  // ============================================================================

  /// Schedule daily workout reminder
  /// 
  /// [time] - Time of day (e.g., 8:00 AM)
  /// [workoutName] - Optional workout name
  Future<void> scheduleWorkoutReminder({
    required Time time,
    String? workoutName,
  }) async {
    if (!_initialized) return;

    final androidDetails = AndroidNotificationDetails(
      NotificationChannels.workoutChannelId,
      NotificationChannels.workoutChannelName,
      channelDescription: NotificationChannels.workoutChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    // Schedule for today at specified time
    final scheduledDate = _getNextScheduledTime(time);
    
    await _notificationsPlugin.zonedSchedule(
      _getNotificationId('workout', time.hour, time.minute),
      'Workout Reminder',
      workoutName != null
          ? 'Time for your $workoutName workout! 💪'
          : 'Time for your daily workout! 💪',
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancel workout reminder
  Future<void> cancelWorkoutReminder(Time time) async {
    await _notificationsPlugin.cancel(
      _getNotificationId('workout', time.hour, time.minute),
    );
  }

  /// Cancel all workout reminders
  Future<void> cancelAllWorkoutReminders() async {
    // Cancel all workout-related notifications
    // Note: In production, you'd track notification IDs
    await _notificationsPlugin.cancelAll();
  }

  // ============================================================================
  // WATER INTAKE REMINDERS
  // ============================================================================

  /// Schedule repeating water intake reminder
  /// 
  /// [intervalMinutes] - How often to remind (e.g., 120 for every 2 hours)
  /// [startTime] - When to start reminders (e.g., 8:00 AM)
  /// [endTime] - When to stop reminders (e.g., 10:00 PM)
  Future<void> scheduleWaterReminder({
    required int intervalMinutes,
    required Time startTime,
    required Time endTime,
  }) async {
    if (!_initialized) return;

    final androidDetails = AndroidNotificationDetails(
      NotificationChannels.waterChannelId,
      NotificationChannels.waterChannelName,
      channelDescription: NotificationChannels.waterChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    // Schedule first reminder for today at start time
    final firstReminder = _getNextScheduledTime(startTime);
    
    await _notificationsPlugin.zonedSchedule(
      _getNotificationId('water', startTime.hour, startTime.minute),
      '💧 Water Reminder',
      'Stay hydrated! Drink a glass of water',
      firstReminder,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );

    // Schedule additional reminders at intervals
    // Note: For exact repeating, you'd need to schedule multiple notifications
    // or use a background task. For now, we schedule the first one.
  }

  /// Cancel all water reminders
  Future<void> cancelWaterReminders() async {
    // Cancel all water-related notifications
    await _notificationsPlugin.cancelAll();
  }

  // ============================================================================
  // SLEEP REMINDERS
  // ============================================================================

  /// Schedule sleep reminder
  /// 
  /// [bedtime] - When user should go to bed (e.g., 10:00 PM)
  Future<void> scheduleSleepReminder({
    required Time bedtime,
  }) async {
    if (!_initialized) return;

    // Schedule reminder 30 minutes before bedtime
    final reminderMinute = bedtime.minute >= 30 ? bedtime.minute - 30 : bedtime.minute + 30;
    final reminderHour = bedtime.minute >= 30 ? bedtime.hour : (bedtime.hour > 0 ? bedtime.hour - 1 : 23);
    final reminderTime = Time(reminderHour, reminderMinute);

    final androidDetails = AndroidNotificationDetails(
      NotificationChannels.sleepChannelId,
      NotificationChannels.sleepChannelName,
      channelDescription: NotificationChannels.sleepChannelDescription,
      importance: Importance.high,
      priority: Priority.high,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    final scheduledDate = _getNextScheduledTime(reminderTime);

    await _notificationsPlugin.zonedSchedule(
      _getNotificationId('sleep', reminderTime.hour, reminderTime.minute),
      '🌙 Sleep Reminder',
      'Time to wind down and prepare for sleep',
      scheduledDate,
      notificationDetails,
      androidScheduleMode: AndroidScheduleMode.exactAllowWhileIdle,
      uiLocalNotificationDateInterpretation:
          UILocalNotificationDateInterpretation.absoluteTime,
      matchDateTimeComponents: DateTimeComponents.time,
    );
  }

  /// Cancel sleep reminder
  Future<void> cancelSleepReminder(Time bedtime) async {
    final reminderMinute = bedtime.minute >= 30 ? bedtime.minute - 30 : bedtime.minute + 30;
    final reminderHour = bedtime.minute >= 30 ? bedtime.hour : (bedtime.hour > 0 ? bedtime.hour - 1 : 23);
    final reminderTime = Time(reminderHour, reminderMinute);
    await _notificationsPlugin.cancel(
      _getNotificationId('sleep', reminderTime.hour, reminderTime.minute),
    );
  }

  // ============================================================================
  // GOAL COMPLETION NOTIFICATIONS (IMMEDIATE)
  // ============================================================================

  /// Show immediate notification when goal is completed
  Future<void> showGoalCompletionNotification({
    required String goalName,
  }) async {
    if (!_initialized) return;

    final androidDetails = AndroidNotificationDetails(
      NotificationChannels.goalChannelId,
      NotificationChannels.goalChannelName,
      channelDescription: NotificationChannels.goalChannelDescription,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      _getNotificationId('goal', DateTime.now().millisecondsSinceEpoch, 0),
      '🎯 Goal Completed!',
      'Congratulations! You completed: $goalName',
      notificationDetails,
    );
  }

  // ============================================================================
  // XP EARNED NOTIFICATIONS (IMMEDIATE)
  // ============================================================================

  /// Show immediate notification when XP is earned
  Future<void> showXPEarnedNotification({
    required int xpAmount,
    required int totalXP,
    required int level,
    bool levelUp = false,
  }) async {
    if (!_initialized) return;

    final androidDetails = AndroidNotificationDetails(
      NotificationChannels.xpChannelId,
      NotificationChannels.xpChannelName,
      channelDescription: NotificationChannels.xpChannelDescription,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    final title = levelUp
        ? '🎉 Level Up!'
        : '⭐ XP Earned!';
    final body = levelUp
        ? 'You reached Level $level! Keep it up!'
        : 'You earned $xpAmount XP! Total: $totalXP XP';

    await _notificationsPlugin.show(
      _getNotificationId('xp', DateTime.now().millisecondsSinceEpoch, 0),
      title,
      body,
      notificationDetails,
    );
  }

  // ============================================================================
  // ACHIEVEMENT NOTIFICATIONS (IMMEDIATE)
  // ============================================================================

  /// Show immediate notification when achievement is unlocked
  Future<void> showAchievementNotification({
    required String title,
    required String body,
  }) async {
    if (!_initialized) return;

    final androidDetails = AndroidNotificationDetails(
      NotificationChannels.goalChannelId, // Reuse goal channel
      NotificationChannels.goalChannelName,
      channelDescription: NotificationChannels.goalChannelDescription,
      importance: Importance.max,
      priority: Priority.max,
      playSound: true,
      enableVibration: true,
      icon: '@mipmap/ic_launcher',
    );

    final notificationDetails = NotificationDetails(android: androidDetails);

    await _notificationsPlugin.show(
      _getNotificationId('achievement', DateTime.now().millisecondsSinceEpoch, 0),
      '🏆 $title',
      body,
      notificationDetails,
    );
  }

  // ============================================================================
  // HELPER METHODS
  // ============================================================================

  /// Get next scheduled time for a given Time
  tz.TZDateTime _getNextScheduledTime(Time time) {
    final now = tz.TZDateTime.now(tz.local);
    var scheduledDate = tz.TZDateTime(
      tz.local,
      now.year,
      now.month,
      now.day,
      time.hour,
      time.minute,
      0,
    );

    // If time has passed today, schedule for tomorrow
    if (scheduledDate.isBefore(now)) {
      scheduledDate = scheduledDate.add(const Duration(days: 1));
    }

    return scheduledDate;
  }

  /// Generate unique notification ID
  int _getNotificationId(String type, int value1, int value2) {
    // Create unique ID based on type and values
    final hash = '$type-$value1-$value2'.hashCode;
    return hash.abs() % 2147483647; // Max int32
  }

  /// Cancel all notifications
  Future<void> cancelAll() async {
    await _notificationsPlugin.cancelAll();
  }

  /// Cancel specific notification by ID
  Future<void> cancel(int notificationId) async {
    await _notificationsPlugin.cancel(notificationId);
  }
}

