class WorkoutExercise {
  final String id;          // Firestore document ID
  final String planId;      // FK → workout_plans
  final String exerciseName;
  final int repetitions;
  final int sets;
  final String? description;

  WorkoutExercise({
    required this.id,
    required this.planId,
    required this.exerciseName,
    required this.repetitions,
    required this.sets,
    this.description,
  });

  // 🔒 SAFE fromMap
  factory WorkoutExercise.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return WorkoutExercise(
      id: id,

      // required FK
      planId: map['plan_id'] as String? ?? '',

      // required text
      exerciseName: map['exercise_name'] as String? ?? '',

      // reps & sets safe parsing
      repetitions:
          (map['repetitions'] as num?)?.toInt() ?? 0,
      sets: (map['sets'] as num?)?.toInt() ?? 0,

      // optional text
      description: map['description'] as String?,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'plan_id': planId,
      'exercise_name': exerciseName,
      'repetitions': repetitions,
      'sets': sets,
      if (description != null) 'description': description,
    };
  }
}
