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

  factory WorkoutExercise.fromMap(
      Map<String, dynamic> data, String id) {
    return WorkoutExercise(
      id: id,
      planId: data['plan_id'],
      exerciseName: data['exercise_name'],
      repetitions: data['repetitions'],
      sets: data['sets'],
      description: data['description'],
    );
  }

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