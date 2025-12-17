/// Fitness preferences model for onboarding data
class FitnessPreferencesModel {
  final String id;
  final String userEmail;
  final List<String> fitnessGoals;
  final List<String> preferredDays;
  final int workoutDuration; // in minutes
  final String workoutType; // strength, cardio, mixed
  final int age;
  final double weight; // in kg
  final double height; // in cm
  final String activityLevel; // sedentary, light, moderate, active, very_active
  final bool onboardingCompleted;
  final DateTime createdAt;

  FitnessPreferencesModel({
    required this.id,
    required this.userEmail,
    this.fitnessGoals = const [],
    this.preferredDays = const [],
    this.workoutDuration = 30,
    this.workoutType = 'mixed',
    this.age = 25,
    this.weight = 70.0,
    this.height = 170.0,
    this.activityLevel = 'moderate',
    this.onboardingCompleted = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'fitness_goals': fitnessGoals.join(','),
      'preferred_days': preferredDays.join(','),
      'workout_duration': workoutDuration,
      'workout_type': workoutType,
      'age': age,
      'weight': weight,
      'height': height,
      'activity_level': activityLevel,
      'onboarding_completed': onboardingCompleted ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory FitnessPreferencesModel.fromMap(Map<String, dynamic> map) {
    return FitnessPreferencesModel(
      id: map['id'] ?? '',
      userEmail: map['user_email'] ?? '',
      fitnessGoals: (map['fitness_goals'] as String?)?.split(',').where((e) => e.isNotEmpty).toList() ?? [],
      preferredDays: (map['preferred_days'] as String?)?.split(',').where((e) => e.isNotEmpty).toList() ?? [],
      workoutDuration: map['workout_duration'] ?? 30,
      workoutType: map['workout_type'] ?? 'mixed',
      age: map['age'] ?? 25,
      weight: (map['weight'] ?? 70.0).toDouble(),
      height: (map['height'] ?? 170.0).toDouble(),
      activityLevel: map['activity_level'] ?? 'moderate',
      onboardingCompleted: map['onboarding_completed'] == 1,
      createdAt: DateTime.tryParse(map['created_at'] ?? '') ?? DateTime.now(),
    );
  }

  FitnessPreferencesModel copyWith({
    String? id,
    String? userEmail,
    List<String>? fitnessGoals,
    List<String>? preferredDays,
    int? workoutDuration,
    String? workoutType,
    int? age,
    double? weight,
    double? height,
    String? activityLevel,
    bool? onboardingCompleted,
    DateTime? createdAt,
  }) {
    return FitnessPreferencesModel(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      fitnessGoals: fitnessGoals ?? this.fitnessGoals,
      preferredDays: preferredDays ?? this.preferredDays,
      workoutDuration: workoutDuration ?? this.workoutDuration,
      workoutType: workoutType ?? this.workoutType,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      onboardingCompleted: onboardingCompleted ?? this.onboardingCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

