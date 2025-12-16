import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/workout_plans.dart';
import '../models/workout_exercises.dart';
import '../models/user_workout_progress.dart';

class WorkoutRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _plans =>
      _db.collection('workout_plans');

  CollectionReference<Map<String, dynamic>> get _exercises =>
      _db.collection('workout_exercises');

  CollectionReference<Map<String, dynamic>> get _progress =>
      _db.collection('workout_progress');

  /// Get all workout plans
  Future<List<WorkoutPlan>> getWorkoutPlans() async {
    final snapshot = await _plans.get();

    return snapshot.docs
        .map((d) => WorkoutPlan.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get exercises for a specific plan
  Future<List<WorkoutExercise>> getExercisesByPlan(
    String planId,
  ) async {
    final snapshot = await _exercises
        .where('plan_id', isEqualTo: planId)
        .get();

    return snapshot.docs
        .map((d) => WorkoutExercise.fromMap(d.data(), d.id))
        .toList();
  }

  /// Save workout progress (exercise completion)
  Future<void> saveProgress(
    UserWorkoutProgress progress,
  ) async {
    await _progress.doc(progress.id).set(
          progress.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Get user progress for a plan
  Future<List<UserWorkoutProgress>> getUserProgress(
    String userId,
    String planId,
  ) async {
    final snapshot = await _progress
        .where('user_id', isEqualTo: userId)
        .where('plan_id', isEqualTo: planId)
        .orderBy('completed_at', descending: true)
        .get();

    return snapshot.docs
        .map(
          (d) => UserWorkoutProgress.fromMap(d.data(), d.id),
        )
        .toList();
  }
}