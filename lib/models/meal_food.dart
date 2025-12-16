class MealFood {
  final String id;       // Firestore document ID
  final String mealId;   // FK → meals
  final String foodId;   // FK → foods
  final double quantity;
  final double caloriesTotal;

  MealFood({
    required this.id,
    required this.mealId,
    required this.foodId,
    required this.quantity,
    required this.caloriesTotal,
  });

  // 🔒 SAFE fromMap
  factory MealFood.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return MealFood(
      id: id,

      // required FKs
      mealId: map['meal_id'] as String? ?? '',
      foodId: map['food_id'] as String? ?? '',

      // math-safe numbers
      quantity: (map['quantity'] as num?)?.toDouble() ?? 0.0,
      caloriesTotal:
          (map['calories_total'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'meal_id': mealId,
      'food_id': foodId,
      'quantity': quantity,
      'calories_total': caloriesTotal,
    };
  }
}
