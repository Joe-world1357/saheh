class Meal {
  final String id;       // Firestore document ID
  final String userId;   // FK → users
  final String mealType;
  final DateTime mealDateTime;
  final String? notes;

  Meal({
    required this.id,
    required this.userId,
    required this.mealType,
    required this.mealDateTime,
    this.notes,
  });

  factory Meal.fromMap(Map<String, dynamic> data, String id) {
    return Meal(
      id: id,
      userId: data['user_id'],
      mealType: data['meal_type'],
      mealDateTime: DateTime.parse(data['meal_datetime']),
      notes: data['notes'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'meal_type': mealType,
      'meal_datetime': mealDateTime.toIso8601String(),
      if (notes != null) 'notes': notes,
    };
  }
}
