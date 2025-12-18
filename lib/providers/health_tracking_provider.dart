import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/health_tracking_model.dart';
import '../database/database_helper.dart';
import '../core/notifications/notification_service.dart';
import 'auth_provider.dart';

/// State for health tracking data
class HealthTrackingState {
  final SleepTrackingModel? todaySleep;
  final List<SleepTrackingModel> weeklySleep;
  final int todayWaterIntake;
  final int waterGoal;
  final List<WaterIntakeModel> todayWaterLog;
  final List<int> weeklyWater;
  final List<HealthGoalModel> goals;
  final bool isLoading;

  const HealthTrackingState({
    this.todaySleep,
    this.weeklySleep = const [],
    this.todayWaterIntake = 0,
    this.waterGoal = 2000,
    this.todayWaterLog = const [],
    this.weeklyWater = const [],
    this.goals = const [],
    this.isLoading = false,
  });

  HealthTrackingState copyWith({
    SleepTrackingModel? todaySleep,
    List<SleepTrackingModel>? weeklySleep,
    int? todayWaterIntake,
    int? waterGoal,
    List<WaterIntakeModel>? todayWaterLog,
    List<int>? weeklyWater,
    List<HealthGoalModel>? goals,
    bool? isLoading,
  }) {
    return HealthTrackingState(
      todaySleep: todaySleep ?? this.todaySleep,
      weeklySleep: weeklySleep ?? this.weeklySleep,
      todayWaterIntake: todayWaterIntake ?? this.todayWaterIntake,
      waterGoal: waterGoal ?? this.waterGoal,
      todayWaterLog: todayWaterLog ?? this.todayWaterLog,
      weeklyWater: weeklyWater ?? this.weeklyWater,
      goals: goals ?? this.goals,
      isLoading: isLoading ?? this.isLoading,
    );
  }

  double get waterProgress => waterGoal > 0 ? todayWaterIntake / waterGoal : 0;
  
  double get averageSleepHours {
    if (weeklySleep.isEmpty) return 0;
    final total = weeklySleep.fold<double>(0, (sum, s) => sum + (s.duration ?? 0));
    return total / weeklySleep.length;
  }

  int get averageSleepQuality {
    if (weeklySleep.isEmpty) return 0;
    final total = weeklySleep.fold<int>(0, (sum, s) => sum + s.quality);
    return (total / weeklySleep.length).round();
  }
}

class HealthTrackingNotifier extends Notifier<HealthTrackingState> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  HealthTrackingState build() {
    ref.watch(authProvider);
    _loadAllData();
    return const HealthTrackingState(isLoading: true);
  }

  Future<void> _loadAllData() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = const HealthTrackingState();
      return;
    }

    state = state.copyWith(isLoading: true);

    try {
      final today = DateTime.now();
      
      // Load today's sleep
      final todaySleep = await _db.getSleepByDate(today, userEmail: userEmail);
      
      // Load weekly sleep
      final weeklySleep = await _getWeeklySleep(userEmail);
      
      // Load today's water
      final todayWater = await _db.getTotalWaterByDate(today, userEmail: userEmail);
      
      // Load water log
      final waterLog = await _db.getWaterIntakeByDate(today, userEmail: userEmail);
      
      // Load weekly water
      final weeklyWater = await _getWeeklyWater(userEmail);
      
      // Load water goal
      final waterGoal = await _db.getWaterGoal(userEmail);
      
      // Load goals
      final goals = await _db.getAllHealthGoals(userEmail: userEmail);

      state = HealthTrackingState(
        todaySleep: todaySleep,
        weeklySleep: weeklySleep,
        todayWaterIntake: todayWater,
        waterGoal: waterGoal,
        todayWaterLog: waterLog,
        weeklyWater: weeklyWater,
        goals: goals,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false);
    }
  }

  Future<List<SleepTrackingModel>> _getWeeklySleep(String userEmail) async {
    final List<SleepTrackingModel> result = [];
    final today = DateTime.now();
    
    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final sleep = await _db.getSleepByDate(date, userEmail: userEmail);
      if (sleep != null) {
        result.add(sleep);
      }
    }
    return result;
  }

  Future<List<int>> _getWeeklyWater(String userEmail) async {
    final List<int> result = [];
    final today = DateTime.now();
    
    for (int i = 6; i >= 0; i--) {
      final date = today.subtract(Duration(days: i));
      final water = await _db.getTotalWaterByDate(date, userEmail: userEmail);
      result.add(water);
    }
    return result;
  }

  // ========== SLEEP TRACKING ==========

  Future<bool> saveSleep({
    required DateTime bedtime,
    required DateTime wakeTime,
    required int quality,
  }) async {
    final userEmail = _userEmail;
    if (userEmail == null) return false;

    final duration = wakeTime.difference(bedtime).inMinutes / 60.0;
    
    final sleep = SleepTrackingModel(
      userEmail: userEmail,
      date: DateTime.now(),
      bedtime: bedtime,
      wakeTime: wakeTime,
      duration: duration,
      quality: quality,
    );

    try {
      await _db.insertOrUpdateSleep(sleep);
      
      // Award XP for good sleep (7-9 hours)
      if (duration >= 7 && duration <= 9) {
        await ref.read(authProvider.notifier).addXP(15);
      } else if (duration >= 6) {
        await ref.read(authProvider.notifier).addXP(5);
      }

      await _loadAllData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<List<SleepTrackingModel>> getSleepHistory(int days) async {
    final userEmail = _userEmail;
    if (userEmail == null) return [];
    return await _db.getSleepHistory(userEmail, days);
  }

  // ========== WATER TRACKING ==========

  Future<bool> addWater(int amount) async {
    final userEmail = _userEmail;
    if (userEmail == null) return false;

    final water = WaterIntakeModel(
      userEmail: userEmail,
      date: DateTime.now(),
      amount: amount,
    );

    try {
      await _db.insertWaterIntake(water);
      
      // Check if goal reached and award XP
      final newTotal = state.todayWaterIntake + amount;
      if (state.todayWaterIntake < state.waterGoal && newTotal >= state.waterGoal) {
        await ref.read(authProvider.notifier).addXP(20);
      }

      await _loadAllData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> removeWaterEntry(int id) async {
    try {
      await _db.deleteWaterIntake(id);
      await _loadAllData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> setWaterGoal(int goal) async {
    final userEmail = _userEmail;
    if (userEmail == null) return false;

    try {
      await _db.setWaterGoal(userEmail, goal);
      state = state.copyWith(waterGoal: goal);
      return true;
    } catch (e) {
      return false;
    }
  }

  // ========== HEALTH GOALS ==========

  Future<bool> addGoal(HealthGoalModel goal) async {
    try {
      await _db.insertHealthGoal(goal);
      await _loadAllData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> updateGoalProgress(int id, double progress, String current) async {
    final userEmail = _userEmail;
    if (userEmail == null) return false;

    try {
      await _db.updateHealthGoalProgress(id, progress, current, userEmail);
      
      // Award XP for completing goal
      if (progress >= 1.0) {
        // Get goal name for notification
        final goal = state.goals.firstWhere((g) => g.id == id, orElse: () => state.goals.first);
        
        await ref.read(authProvider.notifier).addXP(50);
        
        // Show goal completion notification
        if (Platform.isAndroid) {
          try {
            await NotificationService.instance.showGoalCompletionNotification(
              goalName: goal.title,
            );
          } catch (e) {
            debugPrint('Error showing goal notification: $e');
          }
        }
      }

      await _loadAllData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> deleteGoal(int id) async {
    final userEmail = _userEmail;
    if (userEmail == null) return false;

    try {
      await _db.deleteHealthGoal(id, userEmail: userEmail);
      await _loadAllData();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<void> refresh() async {
    await _loadAllData();
  }
}

final healthTrackingProvider = NotifierProvider<HealthTrackingNotifier, HealthTrackingState>(() {
  return HealthTrackingNotifier();
});

/// AI Health Insights Provider
final healthInsightsProvider = Provider<List<HealthInsight>>((ref) {
  final healthState = ref.watch(healthTrackingProvider);
  final insights = <HealthInsight>[];

  // Sleep insights
  if (healthState.todaySleep == null) {
    insights.add(HealthInsight(
      type: InsightType.sleep,
      title: 'Track Your Sleep',
      description: 'Log your sleep to get personalized recommendations.',
      icon: '🌙',
      priority: 2,
    ));
  } else if ((healthState.todaySleep?.duration ?? 0) < 7) {
    insights.add(HealthInsight(
      type: InsightType.sleep,
      title: 'Get More Sleep',
      description: 'Aim for 7-9 hours tonight for optimal health.',
      icon: '😴',
      priority: 1,
    ));
  } else if ((healthState.todaySleep?.duration ?? 0) > 9) {
    insights.add(HealthInsight(
      type: InsightType.sleep,
      title: 'Oversleeping Alert',
      description: 'Try to maintain 7-9 hours of sleep consistently.',
      icon: '⏰',
      priority: 2,
    ));
  }

  // Water insights
  final hour = DateTime.now().hour;
  final expectedProgress = hour / 24;
  final actualProgress = healthState.waterProgress;

  if (actualProgress < expectedProgress * 0.7) {
    final remaining = healthState.waterGoal - healthState.todayWaterIntake;
    insights.add(HealthInsight(
      type: InsightType.water,
      title: 'Stay Hydrated',
      description: 'Drink ${remaining}ml more water today to reach your goal.',
      icon: '💧',
      priority: 1,
    ));
  }

  if (hour < 12 && healthState.todayWaterIntake < 500) {
    insights.add(HealthInsight(
      type: InsightType.water,
      title: 'Morning Hydration',
      description: 'Drink 500ml water before noon for better energy.',
      icon: '🌅',
      priority: 2,
    ));
  }

  // Goal insights
  for (final goal in healthState.goals) {
    if (goal.progress < 0.5) {
      insights.add(HealthInsight(
        type: InsightType.goal,
        title: 'Goal Progress: ${goal.title}',
        description: 'You\'re ${(goal.progress * 100).toInt()}% there. Keep pushing!',
        icon: '🎯',
        priority: 2,
      ));
    }
  }

  // Activity insights
  if (hour > 12 && hour < 14) {
    insights.add(HealthInsight(
      type: InsightType.activity,
      title: 'Post-Lunch Walk',
      description: 'Try a 20-minute walk after lunch to boost digestion.',
      icon: '🚶',
      priority: 3,
    ));
  }

  // Sort by priority
  insights.sort((a, b) => a.priority.compareTo(b.priority));

  return insights.take(5).toList();
});

enum InsightType { sleep, water, goal, activity, nutrition }

class HealthInsight {
  final InsightType type;
  final String title;
  final String description;
  final String icon;
  final int priority;

  HealthInsight({
    required this.type,
    required this.title,
    required this.description,
    required this.icon,
    required this.priority,
  });
}
