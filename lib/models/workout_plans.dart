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

  factory WorkoutPlan.fromMap(
      Map<String, dynamic> data, String id) {
    return WorkoutPlan(
      id: id,
      goal: data['goal'],
      difficulty: data['difficulty'],
      durationWeeks: data['duration_weeks'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'goal': goal,
      'difficulty': difficulty,
      'duration_weeks': durationWeeks,
    };
  }
}