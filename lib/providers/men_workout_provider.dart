import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_helper.dart';
import '../models/activity_model.dart';
import 'auth_provider.dart';
import 'activity_provider.dart';

/// Men's workout state
class MenWorkoutState {
  final List<MenWorkoutModel> todayWorkouts;
  final List<MenWorkoutModel> history;
  final Map<String, dynamic> stats;
  final bool isLoading;
  final String? error;

  MenWorkoutState({
    this.todayWorkouts = const [],
    this.history = const [],
    this.stats = const {},
    this.isLoading = false,
    this.error,
  });

  MenWorkoutState copyWith({
    List<MenWorkoutModel>? todayWorkouts,
    List<MenWorkoutModel>? history,
    Map<String, dynamic>? stats,
    bool? isLoading,
    String? error,
  }) {
    return MenWorkoutState(
      todayWorkouts: todayWorkouts ?? this.todayWorkouts,
      history: history ?? this.history,
      stats: stats ?? this.stats,
      isLoading: isLoading ?? this.isLoading,
      error: error,
    );
  }

  int get completedToday => todayWorkouts.where((w) => w.isCompleted).length;
  int get pendingToday => todayWorkouts.where((w) => !w.isCompleted).length;
  double get todayCalories => todayWorkouts.where((w) => w.isCompleted).fold(0.0, (sum, w) => sum + w.caloriesBurned);
  int get todayMinutes => todayWorkouts.where((w) => w.isCompleted).fold(0, (sum, w) => sum + w.durationMinutes);
}

/// Men's workout notifier
class MenWorkoutNotifier extends Notifier<MenWorkoutState> {
  final DatabaseHelper _db = DatabaseHelper.instance;

  @override
  MenWorkoutState build() {
    ref.listen(authProvider, (prev, next) {
      if (prev?.user?.email != next.user?.email) {
        loadData();
      }
    });
    Future.microtask(() => loadData());
    return MenWorkoutState();
  }

  String get _userEmail {
    final authState = ref.read(authProvider);
    return authState.user?.email ?? '';
  }

  Future<void> loadData() async {
    if (_userEmail.isEmpty) {
      state = MenWorkoutState();
      return;
    }

    state = state.copyWith(isLoading: true);
    try {
      final today = await _db.getMenWorkoutsForDate(_userEmail, DateTime.now());
      final history = await _db.getMenWorkoutHistory(_userEmail);
      final stats = await _db.getMenWorkoutStats(_userEmail);

      state = state.copyWith(
        todayWorkouts: today,
        history: history,
        stats: stats,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(isLoading: false, error: e.toString());
    }
  }

  /// Add a workout from template
  Future<void> addWorkoutFromTemplate(Map<String, dynamic> template) async {
    if (_userEmail.isEmpty) return;

    final workout = MenWorkoutModel(
      userEmail: _userEmail,
      name: template['name'] as String,
      muscleGroup: template['muscleGroup'] as String,
      difficulty: template['difficulty'] as String,
      durationMinutes: template['duration'] as int,
      caloriesBurned: (template['calories'] as num).toDouble(),
      workoutDate: DateTime.now(),
    );

    await _db.insertMenWorkout(workout);
    await loadData();
  }

  /// Add custom workout
  Future<void> addCustomWorkout({
    required String name,
    required String muscleGroup,
    required String difficulty,
    required int durationMinutes,
    required double caloriesBurned,
    DateTime? workoutDate,
  }) async {
    if (_userEmail.isEmpty) return;

    final workout = MenWorkoutModel(
      userEmail: _userEmail,
      name: name,
      muscleGroup: muscleGroup,
      difficulty: difficulty,
      durationMinutes: durationMinutes,
      caloriesBurned: caloriesBurned,
      workoutDate: workoutDate ?? DateTime.now(),
    );

    await _db.insertMenWorkout(workout);
    await loadData();
  }

  /// Complete a workout and award XP
  Future<void> completeWorkout(MenWorkoutModel workout) async {
    if (_userEmail.isEmpty || workout.id == null) return;

    await _db.completeMenWorkout(workout.id!, _userEmail);
    
    // Update activity tracking
    await ref.read(activityProvider.notifier).addWorkoutMinutes(
      workout.durationMinutes,
      workout.caloriesBurned,
    );
    
    // Award XP
    final xp = workout.calculateXP();
    await ref.read(authProvider.notifier).addXP(xp);
    
    await loadData();
  }

  /// Delete a workout
  Future<void> deleteWorkout(int workoutId) async {
    if (_userEmail.isEmpty) return;
    await _db.deleteMenWorkout(workoutId, _userEmail);
    await loadData();
  }

  /// Get workouts by muscle group
  List<MenWorkoutModel> getByMuscleGroup(String muscleGroup) {
    return state.history.where((w) => w.muscleGroup == muscleGroup).toList();
  }

  Future<void> refresh() => loadData();
}

final menWorkoutProvider = NotifierProvider<MenWorkoutNotifier, MenWorkoutState>(() {
  return MenWorkoutNotifier();
});
