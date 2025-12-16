class UserWorkoutProgress {
  final String id;           // Firestore document ID
  final String userId;       // FK → users
  final String planId;       // FK → workout_plans
  final String exerciseId;   // FK → workout_exercises
  final DateTime completedAt;

  UserWorkoutProgress({
    required this.id,
    required this.userId,
    required this.planId,
    required this.exerciseId,
    required this.completedAt,
  });

  factory UserWorkoutProgress.fromMap(
      Map<String, dynamic> data, String id) {
    return UserWorkoutProgress(
      id: id,
      userId: data['user_id'],
      planId: data['plan_id'],
      exerciseId: data['exercise_id'],
      completedAt:
          DateTime.parse(data['completed_at']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'plan_id': planId,
      'exercise_id': exerciseId,
      'completed_at': completedAt.toIso8601String(),
    };
  }
}