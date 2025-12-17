import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class WorkoutsNotifier extends Notifier<List<WorkoutModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  List<WorkoutModel> build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return [];
    }
    return [];
  }

  Future<void> loadWorkoutsForDate(DateTime date) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }
    final workouts = await _db.getWorkoutsByDate(date, userEmail: userEmail);
    state = workouts;
  }

  Future<void> addWorkout(WorkoutModel workout) async {
    await _db.insertWorkout(workout);
    await loadWorkoutsForDate(workout.workoutDate);
  }
}

final workoutsProvider = NotifierProvider<WorkoutsNotifier, List<WorkoutModel>>(() {
  return WorkoutsNotifier();
});
