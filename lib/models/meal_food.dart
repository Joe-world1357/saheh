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

  factory MealFood.fromMap(Map<String, dynamic> data, String id) {
    return MealFood(
      id: id,
      mealId: data['meal_id'],
      foodId: data['food_id'],
      quantity: data['quantity']?.toDouble(),
      caloriesTotal: data['calories_total']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'meal_id': mealId,
      'food_id': foodId,
      'quantity': quantity,
      'calories_total': caloriesTotal,
    };
  }
}
