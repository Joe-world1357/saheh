/// Nutrition goals model for per-user nutrition targets
class NutritionGoalModel {
  final int? id;
  final String userEmail;
  final double caloriesGoal;
  final double proteinGoal; // in grams
  final double carbsGoal; // in grams
  final double fatGoal; // in grams
  final double fiberGoal; // in grams (mandatory)
  final DateTime updatedAt;

  NutritionGoalModel({
    this.id,
    required this.userEmail,
    required this.caloriesGoal,
    required this.proteinGoal,
    required this.carbsGoal,
    required this.fatGoal,
    required this.fiberGoal,
    DateTime? updatedAt,
  }) : updatedAt = updatedAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'calories_goal': caloriesGoal,
      'protein_goal': proteinGoal,
      'carbs_goal': carbsGoal,
      'fat_goal': fatGoal,
      'fiber_goal': fiberGoal,
      'updated_at': updatedAt.toIso8601String(),
    };
  }

  factory NutritionGoalModel.fromMap(Map<String, dynamic> map) {
    return NutritionGoalModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String? ?? '',
      caloriesGoal: (map['calories_goal'] as num).toDouble(),
      proteinGoal: (map['protein_goal'] as num).toDouble(),
      carbsGoal: (map['carbs_goal'] as num).toDouble(),
      fatGoal: (map['fat_goal'] as num).toDouble(),
      fiberGoal: (map['fiber_goal'] as num?)?.toDouble() ?? 25.0, // Default 25g
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : DateTime.now(),
    );
  }

  /// Default goals based on common recommendations
  factory NutritionGoalModel.defaults(String userEmail) {
    return NutritionGoalModel(
      userEmail: userEmail,
      caloriesGoal: 2000.0,
      proteinGoal: 150.0, // ~30% of 2000 cal
      carbsGoal: 250.0, // ~50% of 2000 cal
      fatGoal: 65.0, // ~30% of 2000 cal
      fiberGoal: 25.0, // Recommended daily fiber
    );
  }
}

