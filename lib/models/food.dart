class Food {
  final String id; // Firestore document ID
  final String foodName;
  final String? brand;

  // required nutrition (safe defaults)
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double sugar;
  final double sodium;
  final double fiber;

  // optional micronutrients
  final double? vitaminA;
  final double? vitaminB;
  final double? vitaminC;
  final double? vitaminD;

  final String? servingSize;

  Food({
    required this.id,
    required this.foodName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fat,
    required this.sugar,
    required this.sodium,
    required this.fiber,
    this.brand,
    this.vitaminA,
    this.vitaminB,
    this.vitaminC,
    this.vitaminD,
    this.servingSize,
  });

  // 🔒 SAFE fromMap
  factory Food.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Food(
      id: id,

      // required text
      foodName: map['food_name'] as String? ?? '',

      // optional text
      brand: map['brand'] as String?,
      servingSize: map['serving_size'] as String?,

      // required macros (num-safe)
      calories: (map['calories'] as num?)?.toDouble() ?? 0.0,
      protein: (map['protein'] as num?)?.toDouble() ?? 0.0,
      carbs: (map['carbs'] as num?)?.toDouble() ?? 0.0,
      fat: (map['fat'] as num?)?.toDouble() ?? 0.0,
      sugar: (map['sugar'] as num?)?.toDouble() ?? 0.0,
      sodium: (map['sodium'] as num?)?.toDouble() ?? 0.0,
      fiber: (map['fiber'] as num?)?.toDouble() ?? 0.0,

      // optional micros
      vitaminA: (map['vitamin_a'] as num?)?.toDouble(),
      vitaminB: (map['vitamin_b'] as num?)?.toDouble(),
      vitaminC: (map['vitamin_c'] as num?)?.toDouble(),
      vitaminD: (map['vitamin_d'] as num?)?.toDouble(),
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'food_name': foodName,
      if (brand != null) 'brand': brand,
      'calories': calories,
      'protein': protein,
      'carbs': carbs,
      'fat': fat,
      'sugar': sugar,
      'sodium': sodium,
      'fiber': fiber,
      if (vitaminA != null) 'vitamin_a': vitaminA,
      if (vitaminB != null) 'vitamin_b': vitaminB,
      if (vitaminC != null) 'vitamin_c': vitaminC,
      if (vitaminD != null) 'vitamin_d': vitaminD,
      if (servingSize != null) 'serving_size': servingSize,
    };
  }
}
