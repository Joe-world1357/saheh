class UserActivityLog {
  final String id;           // Firestore document ID
  final String userId;       // FK → users
  final int steps;
  final double caloriesBurned;
  final int workoutMinutes;
  final DateTime logDate;

  UserActivityLog({
    required this.id,
    required this.userId,
    required this.steps,
    required this.caloriesBurned,
    required this.workoutMinutes,
    required this.logDate,
  });

  factory UserActivityLog.fromMap(
      Map<String, dynamic> data, String id) {
    return UserActivityLog(
      id: id,
      userId: data['user_id'],
      steps: data['steps'],
      caloriesBurned: data['calories_burned']?.toDouble(),
      workoutMinutes: data['workout_minutes'],
      logDate: DateTime.parse(data['log_date']),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'steps': steps,
      'calories_burned': caloriesBurned,
      'workout_minutes': workoutMinutes,
      'log_date': logDate.toIso8601String(),
    };
  }
}
