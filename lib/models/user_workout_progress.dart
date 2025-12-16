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

  // 🔒 SAFE fromMap
  factory UserWorkoutProgress.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return UserWorkoutProgress(
      id: id,

      // required FKs
      userId: map['user_id'] as String? ?? '',
      planId: map['plan_id'] as String? ?? '',
      exerciseId: map['exercise_id'] as String? ?? '',

      // Firestore / offline safe date
      completedAt: map['completed_at'] != null
          ? DateTime.tryParse(
                map['completed_at'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'plan_id': planId,
      'exercise_id': exerciseId,
      'completed_at': completedAt.toIso8601String(),
    };
  }
}
