class Food {
  final String id; // Firestore document ID
  final String foodName;
  final String? brand;
  final double calories;
  final double protein;
  final double carbs;
  final double fat;
  final double sugar;
  final double sodium;
  final double fiber;
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

  factory Food.fromMap(Map<String, dynamic> data, String id) {
    return Food(
      id: id,
      foodName: data['food_name'],
      brand: data['brand'],
      calories: data['calories']?.toDouble(),
      protein: data['protein']?.toDouble(),
      carbs: data['carbs']?.toDouble(),
      fat: data['fat']?.toDouble(),
      sugar: data['sugar']?.toDouble(),
      sodium: data['sodium']?.toDouble(),
      fiber: data['fiber']?.toDouble(),
      vitaminA: data['vitamin_a']?.toDouble(),
      vitaminB: data['vitamin_b']?.toDouble(),
      vitaminC: data['vitamin_c']?.toDouble(),
      vitaminD: data['vitamin_d']?.toDouble(),
      servingSize: data['serving_size'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'food_name': foodName,
      'brand': brand,
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