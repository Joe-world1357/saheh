class WorkoutPlan {
  final String id;            // Firestore document ID
  final String goal;
  final String difficulty;
  final int durationWeeks;

  WorkoutPlan({
    required this.id,
    required this.goal,
    required this.difficulty,
    required this.durationWeeks,
  });

  // 🔒 SAFE fromMap
  factory WorkoutPlan.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return WorkoutPlan(
      id: id,

      // required text
      goal: map['goal'] as String? ?? '',
      difficulty: map['difficulty'] as String? ?? '',

      // duration-safe
      durationWeeks:
          (map['duration_weeks'] as num?)?.toInt() ?? 0,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'difficulty': difficulty,
      'duration_weeks': durationWeeks,
    };
  }
}
