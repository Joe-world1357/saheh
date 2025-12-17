import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_helper.dart';
import '../models/activity_model.dart';
import 'auth_provider.dart';

/// Activity state
class ActivityState {
  final ActivityModel? todayActivity;
  final List<ActivityModel> history;
  final Map<String, dynamic> stats;
  final bool isLoading;
  final String? error;

  ActivityState({
    this.todayActivity,
    this.history = const [],
    this.stats = const {},
    this.isLoading = false,
    this.error,
  });

  ActivityState copyWith({
    ActivityModel? todayActivity,
    List<ActivityModel>? history,
    Map<String, dynamic>? stats,
    bool? isLoading,
    String? error,
  }) {
    return ActivityState(
      todayActivity: todayActivity ?? this.todayActivity,
      history: history ?? this.history,
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }
}

/// Activity notifier
class ActivityNotifier extends Notifier<ActivityState> {
  final DatabaseHelper _db = DatabaseHelper.instance;

  @override
  ActivityState build() {
    ref.listen(authProvider, (prev, next) {
      if (prev?.user?.email != next.user?.email) {
        loadData();
      }
    });
    Future.microtask(() => loadData());
    return ActivityState();
  }

  String get _userEmail {
    final authState = ref.read(authProvider);
    return authState.user?.email ?? '';
  }

  Future<void> loadData() async {
    if (_userEmail.isEmpty) {
      state = ActivityState();
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      final today = await _db.getActivityForDate(_userEmail, DateTime.now());
      final history = await _db.getActivityHistory(_userEmail);
      final stats = await _db.getActivityStats(_userEmail);

      state = state.copyWith(
        todayActivity: today,
        history: history,
        stats: stats,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Add steps
  Future<void> addSteps(int steps) async {
    if (_userEmail.isEmpty) return;

    final today = DateTime.now();
    final current = state.todayActivity ?? ActivityModel(
      userEmail: _userEmail,
      date: today,
    );

    final updated = current.copyWith(
      steps: current.steps + steps,
      updatedAt: DateTime.now(),
    );

    await _db.insertOrUpdateActivity(updated);
    await _awardXPForActivity(updated);
    await loadData();
  }

  /// Add active minutes
  Future<void> addActiveMinutes(int minutes) async {
    if (_userEmail.isEmpty) return;

    final today = DateTime.now();
    final current = state.todayActivity ?? ActivityModel(
      userEmail: _userEmail,
      date: today,
    );

    final updated = current.copyWith(
      activeMinutes: current.activeMinutes + minutes,
      updatedAt: DateTime.now(),
    );

    await _db.insertOrUpdateActivity(updated);
    await _awardXPForActivity(updated);
    await loadData();
  }

  /// Add calories burned
  Future<void> addCaloriesBurned(double calories) async {
    if (_userEmail.isEmpty) return;

    final today = DateTime.now();
    final current = state.todayActivity ?? ActivityModel(
      userEmail: _userEmail,
      date: today,
    );

    final updated = current.copyWith(
      caloriesBurned: current.caloriesBurned + calories,
      updatedAt: DateTime.now(),
    );

    await _db.insertOrUpdateActivity(updated);
    await loadData();
  }

  /// Add workout minutes (called when workout is completed)
  Future<void> addWorkoutMinutes(int minutes, double calories) async {
    if (_userEmail.isEmpty) return;

    final today = DateTime.now();
    final current = state.todayActivity ?? ActivityModel(
      userEmail: _userEmail,
      date: today,
    );

    final updated = current.copyWith(
      workoutMinutes: current.workoutMinutes + minutes,
      activeMinutes: current.activeMinutes + minutes,
      caloriesBurned: current.caloriesBurned + calories,
      updatedAt: DateTime.now(),
    );

    await _db.insertOrUpdateActivity(updated);
    await loadData();
  }

  /// Update full activity for today
  Future<void> updateTodayActivity({
    int? steps,
    int? activeMinutes,
    double? caloriesBurned,
    int? workoutMinutes,
  }) async {
    if (_userEmail.isEmpty) return;

    final today = DateTime.now();
    final current = state.todayActivity ?? ActivityModel(
      userEmail: _userEmail,
      date: today,
    );

    final updated = current.copyWith(
      steps: steps ?? current.steps,
      activeMinutes: activeMinutes ?? current.activeMinutes,
      caloriesBurned: caloriesBurned ?? current.caloriesBurned,
      workoutMinutes: workoutMinutes ?? current.workoutMinutes,
      updatedAt: DateTime.now(),
    );

    await _db.insertOrUpdateActivity(updated);
    await _awardXPForActivity(updated);
    await loadData();
  }

  /// Award XP based on activity goals
  Future<void> _awardXPForActivity(ActivityModel activity) async {
    // Check if daily goal met (e.g., 10000 steps or 30 active minutes)
    final stepsGoalMet = activity.steps >= 10000;
    final activeGoalMet = activity.activeMinutes >= 30;
    
    if (stepsGoalMet || activeGoalMet) {
      // Award bonus XP for meeting daily goals
      final xp = activity.calculateXP();
      if (xp > 0) {
        await ref.read(authProvider.notifier).addXP(xp);
      }
    }
  }

  Future<void> refresh() => loadData();
}

final activityProvider = NotifierProvider<ActivityNotifier, ActivityState>(() {
  return ActivityNotifier();
});
