import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:health/health.dart';
import '../../database/database_helper.dart';
import '../../models/activity_model.dart';
import '../../models/health_tracking_model.dart';
import '../../providers/auth_provider.dart';
import 'xp_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Google Fit Service - Syncs health data from Google Fit
class GoogleFitService {
  static final GoogleFitService _instance = GoogleFitService._internal();
  factory GoogleFitService() => _instance;
  GoogleFitService._internal();

  Health? _health;
  bool _isInitialized = false;
  bool _isConnected = false;
  DateTime? _lastSyncTime;
  String? _connectedAccountEmail;

  // Health data types to request
  final List<HealthDataType> _healthDataTypes = [
    HealthDataType.STEPS,
    HealthDataType.HEART_RATE,
    HealthDataType.ACTIVE_ENERGY_BURNED,
    HealthDataType.SLEEP_IN_BED,
    HealthDataType.WORKOUT,
    HealthDataType.DISTANCE_DELTA,
  ];

  /// Initialize Google Fit / Health Connect
  Future<bool> initialize() async {
    if (_isInitialized) return true;

    try {
      _health = Health();
      
      // Request permissions
      final hasPermissions = await _health!.hasPermissions(_healthDataTypes) ?? false;
      
      if (!hasPermissions) {
        final granted = await _health!.requestAuthorization(_healthDataTypes);
        if (granted == false) {
          debugPrint('Google Fit: Permissions not granted');
          return false;
        }
      }

      _isInitialized = true;
      _isConnected = true;
      
      // Try to get account information from Health Connect
      // Note: Health Connect doesn't directly expose account email,
      // but it syncs with Google Fit if connected
      _connectedAccountEmail = 'eng.yousif1357@gmail.com'; // Set default account
      
      return true;
    } catch (e) {
      debugPrint('Google Fit initialization error: $e');
      _isInitialized = false;
      _isConnected = false;
      return false;
    }
  }

  /// Check if Google Fit is connected
  bool get isConnected => _isConnected && _isInitialized;

  /// Get last sync time
  DateTime? get lastSyncTime => _lastSyncTime;

  /// Get connected account email (if available)
  String? get connectedAccountEmail => _connectedAccountEmail;

  /// Sync steps data
  Future<int> syncSteps(DateTime date, {String? userEmail}) async {
    if (!isConnected || _health == null) return 0;

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final steps = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.STEPS],
        startTime: startOfDay,
        endTime: endOfDay,
      );

      int totalSteps = 0;
      for (var data in steps) {
        if (data.value is NumericHealthValue) {
          totalSteps += (data.value as NumericHealthValue).numericValue.toInt();
        }
      }

      // Save to database
      if (userEmail != null && totalSteps > 0) {
        await _saveActivityData(
          userEmail: userEmail,
          date: date,
          steps: totalSteps,
        );
      }

      return totalSteps;
    } catch (e) {
      debugPrint('Error syncing steps: $e');
      return 0;
    }
  }

  /// Sync heart rate data
  Future<List<Map<String, dynamic>>> syncHeartRate(DateTime date) async {
    if (!isConnected || _health == null) return [];

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final heartRateData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.HEART_RATE],
        startTime: startOfDay,
        endTime: endOfDay,
      );

      return heartRateData.map((data) {
        final value = data.value is NumericHealthValue
            ? (data.value as NumericHealthValue).numericValue
            : 0.0;
        return {
          'value': value,
          'timestamp': data.dateFrom.millisecondsSinceEpoch,
        };
      }).toList();
    } catch (e) {
      debugPrint('Error syncing heart rate: $e');
      return [];
    }
  }

  /// Sync calories burned
  Future<double> syncCaloriesBurned(DateTime date, {String? userEmail}) async {
    if (!isConnected || _health == null) return 0.0;

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final caloriesData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.ACTIVE_ENERGY_BURNED],
        startTime: startOfDay,
        endTime: endOfDay,
      );

      double totalCalories = 0.0;
      for (var data in caloriesData) {
        if (data.value is NumericHealthValue) {
          totalCalories += (data.value as NumericHealthValue).numericValue;
        }
      }

      // Save to database
      if (userEmail != null && totalCalories > 0) {
        await _saveActivityData(
          userEmail: userEmail,
          date: date,
          caloriesBurned: totalCalories,
        );
      }

      return totalCalories;
    } catch (e) {
      debugPrint('Error syncing calories: $e');
      return 0.0;
    }
  }

  /// Sync sleep data
  Future<double?> syncSleep(DateTime date, {String? userEmail}) async {
    if (!isConnected || _health == null) return null;

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final sleepData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.SLEEP_IN_BED],
        startTime: startOfDay,
        endTime: endOfDay,
      );

      if (sleepData.isEmpty) return null;

      double totalSleepHours = 0.0;
      for (var data in sleepData) {
        final duration = data.dateTo.difference(data.dateFrom);
        totalSleepHours += duration.inMinutes / 60.0;
      }

      // Save to database
      if (userEmail != null && totalSleepHours > 0) {
        final db = DatabaseHelper.instance;
        await db.insertOrUpdateSleep(SleepTrackingModel(
          userEmail: userEmail,
          date: date,
          duration: totalSleepHours,
          quality: 3, // Default quality
        ));
      }

      return totalSleepHours;
    } catch (e) {
      debugPrint('Error syncing sleep: $e');
      return null;
    }
  }

  /// Sync workout sessions
  Future<List<Map<String, dynamic>>> syncWorkouts(DateTime date) async {
    if (!isConnected || _health == null) return [];

    try {
      final startOfDay = DateTime(date.year, date.month, date.day);
      final endOfDay = startOfDay.add(const Duration(days: 1));

      final workoutData = await _health!.getHealthDataFromTypes(
        types: [HealthDataType.WORKOUT],
        startTime: startOfDay,
        endTime: endOfDay,
      );

      return workoutData.map((data) {
        return {
          'type': data.typeString,
          'startTime': data.dateFrom.millisecondsSinceEpoch,
          'endTime': data.dateTo.millisecondsSinceEpoch,
          'duration': data.dateTo.difference(data.dateFrom).inMinutes,
        };
      }).toList();
    } catch (e) {
      debugPrint('Error syncing workouts: $e');
      return [];
    }
  }

  /// Sync all health data for a specific date
  Future<Map<String, dynamic>> syncAllData(DateTime date, {required String userEmail, dynamic ref}) async {
    if (!isConnected) {
      await initialize();
      if (!isConnected) {
        return {'success': false, 'error': 'Not connected to Google Fit'};
      }
    }

    try {
      final results = <String, dynamic>{
        'success': true,
        'steps': 0,
        'calories': 0.0,
        'sleep': null,
        'heartRate': [],
        'workouts': [],
      };

      // Sync steps
      final steps = await syncSteps(date, userEmail: userEmail);
      results['steps'] = steps;

      // Sync calories
      final calories = await syncCaloriesBurned(date, userEmail: userEmail);
      results['calories'] = calories;

      // Sync sleep
      final sleep = await syncSleep(date, userEmail: userEmail);
      results['sleep'] = sleep;

      // Sync heart rate
      final heartRate = await syncHeartRate(date);
      results['heartRate'] = heartRate;

      // Sync workouts
      final workouts = await syncWorkouts(date);
      results['workouts'] = workouts;

      // Award XP based on synced data
      if (ref != null) {
        await _awardXPFromSyncedData(ref, steps, calories, sleep, workouts.length);
      }

      _lastSyncTime = DateTime.now();
      return results;
    } catch (e) {
      debugPrint('Error syncing all data: $e');
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Save activity data to database
  Future<void> _saveActivityData({
    required String userEmail,
    required DateTime date,
    int? steps,
    double? caloriesBurned,
  }) async {
    try {
      final db = DatabaseHelper.instance;
      final existing = await db.getActivityForDate(userEmail, date);

      // Use insertOrUpdateActivity which handles both insert and update
      final activity = ActivityModel(
        userEmail: userEmail,
        date: date,
        steps: steps ?? (existing?.steps ?? 0),
        caloriesBurned: caloriesBurned ?? (existing?.caloriesBurned ?? 0.0),
        activeMinutes: existing?.activeMinutes ?? 0,
        workoutMinutes: existing?.workoutMinutes ?? 0,
      );
      await db.insertOrUpdateActivity(activity);
    } catch (e) {
      debugPrint('Error saving activity data: $e');
    }
  }

  /// Award XP based on synced data
  Future<void> _awardXPFromSyncedData(
    WidgetRef ref,
    int steps,
    double calories,
    double? sleep,
    int workoutCount,
  ) async {
    try {
      // Steps: 1 XP per 100 steps (max 50 XP per day)
      if (steps >= 100) {
        final stepsXP = (steps / 100).floor().clamp(0, 50);
        for (int i = 0; i < stepsXP; i++) {
          await ref.read(authProvider.notifier).addXP(1);
        }
      }

      // Calories: 1 XP per 50 calories burned (max 30 XP per day)
      if (calories >= 50) {
        final caloriesXP = (calories / 50).floor().clamp(0, 30);
        for (int i = 0; i < caloriesXP; i++) {
          await ref.read(authProvider.notifier).addXP(1);
        }
      }

      // Sleep: 5 XP if sleep >= 7 hours
      if (sleep != null && sleep >= 7.0) {
        await XPService.awardSleepLogged(ref);
      }

      // Workouts: 25 XP per workout
      for (int i = 0; i < workoutCount; i++) {
        await XPService.awardWorkoutCompleted(ref);
      }
    } catch (e) {
      debugPrint('Error awarding XP from synced data: $e');
    }
  }

  /// Disconnect from Google Fit
  Future<void> disconnect() async {
    _isConnected = false;
    _isInitialized = false;
    _health = null;
  }
}

/// Provider for Google Fit Service
final googleFitServiceProvider = Provider<GoogleFitService>((ref) {
  return GoogleFitService();
});

