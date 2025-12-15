class WorkoutModel {
  final int? id;
  final String name;
  final String type; // cardio, strength, yoga, etc.
  final int duration; // in minutes
  final double caloriesBurned;
  final DateTime workoutDate;
  final DateTime createdAt;

  WorkoutModel({
    this.id,
    required this.name,
    required this.type,
    required this.duration,
    required this.caloriesBurned,
    required this.workoutDate,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'duration': duration,
      'calories_burned': caloriesBurned,
      'workout_date': workoutDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory WorkoutModel.fromMap(Map<String, dynamic> map) {
    return WorkoutModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      type: map['type'] as String,
      duration: map['duration'] as int,
      caloriesBurned: (map['calories_burned'] as num).toDouble(),
      workoutDate: DateTime.parse(map['workout_date'] as String),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }
}

