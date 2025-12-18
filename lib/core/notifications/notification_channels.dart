import 'package:flutter_local_notifications/flutter_local_notifications.dart';

/// Android Notification Channels Configuration
/// 
/// Each channel defines how notifications of that type behave:
/// - Sound, vibration, importance, etc.
/// 
/// Android 8.0+ requires channels for all notifications.
class NotificationChannels {
  NotificationChannels._();

  // Channel IDs
  static const String workoutChannelId = 'workout_reminders';
  static const String waterChannelId = 'water_reminders';
  static const String sleepChannelId = 'sleep_reminders';
  static const String goalChannelId = 'goal_completion';
  static const String xpChannelId = 'xp_earned';
  static const String generalChannelId = 'general_notifications';

  // Channel Names (shown to user in Android settings)
  static const String workoutChannelName = 'Workout Reminders';
  static const String waterChannelName = 'Water Intake Reminders';
  static const String sleepChannelName = 'Sleep Reminders';
  static const String goalChannelName = 'Goal Completion';
  static const String xpChannelName = 'XP & Achievements';
  static const String generalChannelName = 'General Notifications';

  // Channel Descriptions
  static const String workoutChannelDescription = 'Notifications for scheduled workouts and fitness reminders';
  static const String waterChannelDescription = 'Reminders to drink water throughout the day';
  static const String sleepChannelDescription = 'Reminders for bedtime and sleep tracking';
  static const String goalChannelDescription = 'Notifications when you complete health goals';
  static const String xpChannelDescription = 'Notifications when you earn XP and level up';
  static const String generalChannelDescription = 'General app notifications and updates';

  /// Initialize all notification channels
  /// Call this during app initialization
  static Future<void> initializeChannels(
    FlutterLocalNotificationsPlugin plugin,
  ) async {
    const androidPlatformChannelSpecifics = AndroidNotificationChannel(
      workoutChannelId,
      workoutChannelName,
      description: workoutChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    const waterPlatformChannelSpecifics = AndroidNotificationChannel(
      waterChannelId,
      waterChannelName,
      description: waterChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    const sleepPlatformChannelSpecifics = AndroidNotificationChannel(
      sleepChannelId,
      sleepChannelName,
      description: sleepChannelDescription,
      importance: Importance.high,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    const goalPlatformChannelSpecifics = AndroidNotificationChannel(
      goalChannelId,
      goalChannelName,
      description: goalChannelDescription,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    const xpPlatformChannelSpecifics = AndroidNotificationChannel(
      xpChannelId,
      xpChannelName,
      description: xpChannelDescription,
      importance: Importance.max,
      playSound: true,
      enableVibration: true,
      showBadge: true,
    );

    const generalPlatformChannelSpecifics = AndroidNotificationChannel(
      generalChannelId,
      generalChannelName,
      description: generalChannelDescription,
      importance: Importance.defaultImportance,
      playSound: true,
      enableVibration: false,
      showBadge: true,
    );

    // Create channels (Android 8.0+)
    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(androidPlatformChannelSpecifics);

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(waterPlatformChannelSpecifics);

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(sleepPlatformChannelSpecifics);

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(goalPlatformChannelSpecifics);

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(xpPlatformChannelSpecifics);

    await plugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(generalPlatformChannelSpecifics);
  }
}

