import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/workout_model.dart';
import '../database/database_helper.dart';

class WorkoutsNotifier extends Notifier<List<WorkoutModel>> {
  final _db = DatabaseHelper.instance;

  @override
  List<WorkoutModel> build() => [];

  Future<void> loadWorkoutsForDate(DateTime date) async {
    final workouts = await _db.getWorkoutsByDate(date);
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

