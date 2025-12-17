/// Daily activity tracking model
class ActivityModel {
  final int? id;
  final String userEmail;
  final DateTime date;
  final int steps;
  final int activeMinutes;
  final double caloriesBurned;
  final int workoutMinutes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  ActivityModel({
    this.id,
    required this.userEmail,
    required this.date,
    this.steps = 0,
    this.activeMinutes = 0,
    this.caloriesBurned = 0,
    this.workoutMinutes = 0,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_email': userEmail,
      'date': date.toIso8601String().split('T')[0],
      'steps': steps,
      'active_minutes': activeMinutes,
      'calories_burned': caloriesBurned,
      'workout_minutes': workoutMinutes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory ActivityModel.fromMap(Map<String, dynamic> map) {
    return ActivityModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String? ?? '',
      date: DateTime.parse(map['date'] as String),
      steps: map['steps'] as int? ?? 0,
      activeMinutes: map['active_minutes'] as int? ?? 0,
      caloriesBurned: (map['calories_burned'] as num?)?.toDouble() ?? 0,
      workoutMinutes: map['workout_minutes'] as int? ?? 0,
      createdAt: DateTime.parse(map['created_at'] as String),
      updatedAt: map['updated_at'] != null ? DateTime.parse(map['updated_at'] as String) : null,
    );
  }

  ActivityModel copyWith({
    int? id,
    String? userEmail,
    DateTime? date,
    int? steps,
    int? activeMinutes,
    double? caloriesBurned,
    int? workoutMinutes,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return ActivityModel(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      date: date ?? this.date,
      steps: steps ?? this.steps,
      activeMinutes: activeMinutes ?? this.activeMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      workoutMinutes: workoutMinutes ?? this.workoutMinutes,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  /// Calculate XP earned from this activity
  int calculateXP() {
    int xp = 0;
    // Steps: 1 XP per 1000 steps
    xp += (steps / 1000).floor();
    // Active minutes: 1 XP per 10 minutes
    xp += (activeMinutes / 10).floor();
    // Workout minutes: 2 XP per 10 minutes
    xp += (workoutMinutes / 10).floor() * 2;
    return xp;
  }
}

/// Men's workout model
class MenWorkoutModel {
  final int? id;
  final String userEmail;
  final String name;
  final String muscleGroup; // chest, back, legs, shoulders, arms, abs
  final String difficulty; // beginner, intermediate, advanced
  final int durationMinutes;
  final double caloriesBurned;
  final bool isCompleted;
  final DateTime? completedAt;
  final DateTime workoutDate;
  final DateTime createdAt;

  MenWorkoutModel({
    this.id,
    required this.userEmail,
    required this.name,
    required this.muscleGroup,
    required this.difficulty,
    required this.durationMinutes,
    required this.caloriesBurned,
    this.isCompleted = false,
    this.completedAt,
    required this.workoutDate,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      if (id != null) 'id': id,
      'user_email': userEmail,
      'name': name,
      'muscle_group': muscleGroup,
      'difficulty': difficulty,
      'duration_minutes': durationMinutes,
      'calories_burned': caloriesBurned,
      'is_completed': isCompleted ? 1 : 0,
      'completed_at': completedAt?.toIso8601String(),
      'workout_date': workoutDate.toIso8601String().split('T')[0],
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory MenWorkoutModel.fromMap(Map<String, dynamic> map) {
    return MenWorkoutModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String? ?? '',
      name: map['name'] as String,
      muscleGroup: map['muscle_group'] as String,
      difficulty: map['difficulty'] as String,
      durationMinutes: map['duration_minutes'] as int,
      caloriesBurned: (map['calories_burned'] as num).toDouble(),
      isCompleted: (map['is_completed'] as int?) == 1,
      completedAt: map['completed_at'] != null ? DateTime.parse(map['completed_at'] as String) : null,
      workoutDate: DateTime.parse(map['workout_date'] as String),
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  MenWorkoutModel copyWith({
    int? id,
    String? userEmail,
    String? name,
    String? muscleGroup,
    String? difficulty,
    int? durationMinutes,
    double? caloriesBurned,
    bool? isCompleted,
    DateTime? completedAt,
    DateTime? workoutDate,
    DateTime? createdAt,
  }) {
    return MenWorkoutModel(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      name: name ?? this.name,
      muscleGroup: muscleGroup ?? this.muscleGroup,
      difficulty: difficulty ?? this.difficulty,
      durationMinutes: durationMinutes ?? this.durationMinutes,
      caloriesBurned: caloriesBurned ?? this.caloriesBurned,
      isCompleted: isCompleted ?? this.isCompleted,
      completedAt: completedAt ?? this.completedAt,
      workoutDate: workoutDate ?? this.workoutDate,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  /// Calculate XP earned from this workout
  int calculateXP() {
    int baseXP = 0;
    
    // Base XP by difficulty
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        baseXP = 10;
        break;
      case 'intermediate':
        baseXP = 20;
        break;
      case 'advanced':
        baseXP = 35;
        break;
      default:
        baseXP = 10;
    }
    
    // Bonus for duration (1 XP per 5 minutes)
    baseXP += (durationMinutes / 5).floor();
    
    // Bonus for calories (1 XP per 50 calories)
    baseXP += (caloriesBurned / 50).floor();
    
    return baseXP;
  }
}

/// Predefined men's workout templates
class MenWorkoutTemplates {
  static List<Map<String, dynamic>> get all => [
    // CHEST
    {'name': 'Bench Press', 'muscleGroup': 'chest', 'difficulty': 'intermediate', 'duration': 30, 'calories': 180},
    {'name': 'Incline Dumbbell Press', 'muscleGroup': 'chest', 'difficulty': 'intermediate', 'duration': 25, 'calories': 150},
    {'name': 'Push-Ups', 'muscleGroup': 'chest', 'difficulty': 'beginner', 'duration': 15, 'calories': 100},
    {'name': 'Cable Flyes', 'muscleGroup': 'chest', 'difficulty': 'intermediate', 'duration': 20, 'calories': 120},
    {'name': 'Dips', 'muscleGroup': 'chest', 'difficulty': 'advanced', 'duration': 20, 'calories': 140},
    
    // BACK
    {'name': 'Deadlift', 'muscleGroup': 'back', 'difficulty': 'advanced', 'duration': 35, 'calories': 250},
    {'name': 'Pull-Ups', 'muscleGroup': 'back', 'difficulty': 'intermediate', 'duration': 20, 'calories': 150},
    {'name': 'Barbell Rows', 'muscleGroup': 'back', 'difficulty': 'intermediate', 'duration': 25, 'calories': 170},
    {'name': 'Lat Pulldown', 'muscleGroup': 'back', 'difficulty': 'beginner', 'duration': 20, 'calories': 130},
    {'name': 'T-Bar Row', 'muscleGroup': 'back', 'difficulty': 'intermediate', 'duration': 25, 'calories': 160},
    
    // LEGS
    {'name': 'Squats', 'muscleGroup': 'legs', 'difficulty': 'intermediate', 'duration': 30, 'calories': 200},
    {'name': 'Leg Press', 'muscleGroup': 'legs', 'difficulty': 'beginner', 'duration': 25, 'calories': 180},
    {'name': 'Lunges', 'muscleGroup': 'legs', 'difficulty': 'beginner', 'duration': 20, 'calories': 150},
    {'name': 'Romanian Deadlift', 'muscleGroup': 'legs', 'difficulty': 'intermediate', 'duration': 25, 'calories': 170},
    {'name': 'Leg Curls', 'muscleGroup': 'legs', 'difficulty': 'beginner', 'duration': 15, 'calories': 100},
    {'name': 'Calf Raises', 'muscleGroup': 'legs', 'difficulty': 'beginner', 'duration': 10, 'calories': 60},
    
    // SHOULDERS
    {'name': 'Overhead Press', 'muscleGroup': 'shoulders', 'difficulty': 'intermediate', 'duration': 25, 'calories': 150},
    {'name': 'Lateral Raises', 'muscleGroup': 'shoulders', 'difficulty': 'beginner', 'duration': 15, 'calories': 90},
    {'name': 'Front Raises', 'muscleGroup': 'shoulders', 'difficulty': 'beginner', 'duration': 15, 'calories': 85},
    {'name': 'Arnold Press', 'muscleGroup': 'shoulders', 'difficulty': 'intermediate', 'duration': 20, 'calories': 130},
    {'name': 'Face Pulls', 'muscleGroup': 'shoulders', 'difficulty': 'beginner', 'duration': 15, 'calories': 80},
    
    // ARMS
    {'name': 'Barbell Curls', 'muscleGroup': 'arms', 'difficulty': 'beginner', 'duration': 15, 'calories': 80},
    {'name': 'Hammer Curls', 'muscleGroup': 'arms', 'difficulty': 'beginner', 'duration': 15, 'calories': 75},
    {'name': 'Tricep Pushdown', 'muscleGroup': 'arms', 'difficulty': 'beginner', 'duration': 15, 'calories': 70},
    {'name': 'Skull Crushers', 'muscleGroup': 'arms', 'difficulty': 'intermediate', 'duration': 20, 'calories': 100},
    {'name': 'Preacher Curls', 'muscleGroup': 'arms', 'difficulty': 'intermediate', 'duration': 15, 'calories': 85},
    {'name': 'Close-Grip Bench', 'muscleGroup': 'arms', 'difficulty': 'intermediate', 'duration': 20, 'calories': 120},
    
    // ABS
    {'name': 'Crunches', 'muscleGroup': 'abs', 'difficulty': 'beginner', 'duration': 10, 'calories': 50},
    {'name': 'Planks', 'muscleGroup': 'abs', 'difficulty': 'beginner', 'duration': 10, 'calories': 40},
    {'name': 'Hanging Leg Raises', 'muscleGroup': 'abs', 'difficulty': 'advanced', 'duration': 15, 'calories': 80},
    {'name': 'Cable Crunches', 'muscleGroup': 'abs', 'difficulty': 'intermediate', 'duration': 15, 'calories': 70},
    {'name': 'Ab Wheel Rollout', 'muscleGroup': 'abs', 'difficulty': 'advanced', 'duration': 15, 'calories': 90},
    {'name': 'Russian Twists', 'muscleGroup': 'abs', 'difficulty': 'intermediate', 'duration': 10, 'calories': 60},
  ];

  static List<Map<String, dynamic>> getByMuscleGroup(String group) {
    return all.where((w) => w['muscleGroup'] == group.toLowerCase()).toList();
  }

  static List<String> get muscleGroups => ['chest', 'back', 'legs', 'shoulders', 'arms', 'abs'];
}

