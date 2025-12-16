class MealModel {
  final int? id;
  final String userEmail; // User isolation
  final String name;
  final String mealType; // breakfast, lunch, dinner, snack
  final double calories;
  final double protein; // in grams
  final double carbs; // in grams
  final double fat; // in grams
  final DateTime mealDate;
  final DateTime createdAt;

  MealModel({
    this.id,
    required this.userEmail,
    required this.name,
    required this.mealType,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.mealDate,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'name': name,
      'meal_type': mealType,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'meal_date': mealDate.toIso8601String(),
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory MealModel.fromMap(Map<String, dynamic> map) {
    return MealModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String? ?? '',
      name: map['name'] as String,
      mealType: map['meal_type'] as String,
      calories: (map['calories'] as num).toDouble(),
      protein: (map['protein'] as num).toDouble(),
      carbs: (map['carbs'] as num).toDouble(),
      fat: (map['fat'] as num).toDouble(),
      mealDate: DateTime.parse(map['meal_date'] as String),
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }
}

