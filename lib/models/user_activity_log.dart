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

  // 🔒 SAFE fromMap
  factory UserActivityLog.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return UserActivityLog(
      id: id,

      // required FK
      userId: map['user_id'] as String? ?? '',

      // activity-safe numbers
      steps: (map['steps'] as num?)?.toInt() ?? 0,
      caloriesBurned:
          (map['calories_burned'] as num?)?.toDouble() ?? 0.0,
      workoutMinutes:
          (map['workout_minutes'] as num?)?.toInt() ?? 0,

      // Firestore / offline safe date
      logDate: map['log_date'] != null
          ? DateTime.tryParse(
                map['log_date'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),
    );
  }

  // 🧼 CLEAN toMap
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
