import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine_reminder_model.dart';
import '../models/meal_model.dart';
import '../models/workout_model.dart';
import '../models/health_tracking_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

/// Home screen data model
class HomeData {
  final String userName;
  final int userLevel;
  final int userXP;
  final int xpToNextLevel;
  
  // Medicine reminders
  final int pendingReminders;
  final String? nextReminder;
  final String? nextReminderTime;
  
  // Nutrition
  final double caloriesConsumed;
  final double caloriesGoal;
  final double proteinConsumed;
  final double carbsConsumed;
  final double fatConsumed;
  
  // Workout
  final WorkoutModel? todaysWorkout;
  final int totalSteps;
  final double caloriesBurned;
  
  // Health tracking
  final double? sleepHours;
  final int waterIntake; // in ml
  final int waterGoal; // in ml (default 2000ml)
  final int activeGoals;

  HomeData({
    required this.userName,
    required this.userLevel,
    required this.userXP,
    required this.xpToNextLevel,
    required this.pendingReminders,
    this.nextReminder,
    this.nextReminderTime,
    required this.caloriesConsumed,
    required this.caloriesGoal,
    required this.proteinConsumed,
    required this.carbsConsumed,
    required this.fatConsumed,
    this.todaysWorkout,
    required this.totalSteps,
    required this.caloriesBurned,
    this.sleepHours,
    required this.waterIntake,
    this.waterGoal = 2000,
    required this.activeGoals,
  });
}

/// Home data provider that aggregates all data
class HomeDataNotifier extends Notifier<HomeData> {
  final _db = DatabaseHelper.instance;

  @override
  HomeData build() {
    _loadHomeData();
    return _getDefaultHomeData();
  }

  HomeData _getDefaultHomeData() {
    final authState = ref.read(authProvider);
    final userName = authState.user?.name ?? 'User';
    final userLevel = authState.user?.level ?? 1;
    final userXP = authState.user?.xp ?? 0;
    final xpToNextLevel = (userLevel * 100) - userXP;

    return HomeData(
      userName: userName,
      userLevel: userLevel,
      userXP: userXP,
      xpToNextLevel: xpToNextLevel,
      pendingReminders: 0,
      caloriesConsumed: 0,
      caloriesGoal: 2000,
      proteinConsumed: 0,
      carbsConsumed: 0,
      fatConsumed: 0,
      totalSteps: 0,
      caloriesBurned: 0,
      waterIntake: 0,
      activeGoals: 0,
    );
  }

  Future<void> _loadHomeData() async {
    final today = DateTime.now();
    final startOfDay = DateTime(today.year, today.month, today.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    // Get user data
    final authState = ref.read(authProvider);
    final userName = authState.user?.name ?? 'User';
    final userLevel = authState.user?.level ?? 1;
    final userXP = authState.user?.xp ?? 0;
    final xpToNextLevel = (userLevel * 100) - userXP;

    // Load reminders (filtered by user)
    final userEmail = authState.user?.email;
    final reminders = await _db.getAllMedicineReminders(userEmail: userEmail);
    final activeReminders = reminders.where((r) => r.isActive).toList();
    final todayDayOfWeek = today.weekday % 7; // Convert to 0-6 (Sunday=0)
    
    // Filter reminders for today
    final todaysReminders = activeReminders.where((r) {
      return r.daysOfWeek.contains(todayDayOfWeek);
    }).toList();

    // Get next reminder
    String? nextReminder;
    String? nextReminderTime;
    if (todaysReminders.isNotEmpty) {
      todaysReminders.sort((a, b) => a.time.compareTo(b.time));
      final next = todaysReminders.first;
      nextReminder = next.medicineName;
      nextReminderTime = next.time;
    }

    // Load nutrition data for today
    final meals = await _db.getMealsByDate(today);
    final caloriesConsumed = meals.fold(0.0, (sum, meal) => sum + meal.calories);
    final proteinConsumed = meals.fold(0.0, (sum, meal) => sum + meal.protein);
    final carbsConsumed = meals.fold(0.0, (sum, meal) => sum + meal.carbs);
    final fatConsumed = meals.fold(0.0, (sum, meal) => sum + meal.fat);
    const caloriesGoal = 2000.0;

    // Load workout data for today
    final workouts = await _db.getWorkoutsByDate(today);
    WorkoutModel? todaysWorkout;
    if (workouts.isNotEmpty) {
      todaysWorkout = workouts.first;
    }
    final totalSteps = 7234; // TODO: Get from activity tracker
    final caloriesBurned = workouts.fold(0.0, (sum, w) => sum + w.caloriesBurned);

    // Load health tracking
    final sleep = await _db.getSleepByDate(today);
    final sleepHours = sleep?.duration;
    final waterIntake = await _db.getTotalWaterByDate(today);
    const waterGoal = 2000;
    
    // Load health goals
    final goals = await _db.getAllHealthGoals();
    final activeGoals = goals.length;

    state = HomeData(
      userName: userName,
      userLevel: userLevel,
      userXP: userXP,
      xpToNextLevel: xpToNextLevel,
      pendingReminders: todaysReminders.length,
      nextReminder: nextReminder,
      nextReminderTime: nextReminderTime,
      caloriesConsumed: caloriesConsumed,
      caloriesGoal: caloriesGoal,
      proteinConsumed: proteinConsumed,
      carbsConsumed: carbsConsumed,
      fatConsumed: fatConsumed,
      todaysWorkout: todaysWorkout,
      totalSteps: totalSteps,
      caloriesBurned: caloriesBurned,
      sleepHours: sleepHours,
      waterIntake: waterIntake,
      waterGoal: waterGoal,
      activeGoals: activeGoals,
    );
  }

  /// Refresh home data
  Future<void> refresh() async {
    await _loadHomeData();
    // Notify listeners that state has changed
    state = state; // Trigger rebuild
  }
}

final homeDataProvider = NotifierProvider<HomeDataNotifier, HomeData>(() {
  return HomeDataNotifier();
});

