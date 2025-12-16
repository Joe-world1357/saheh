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

  // 🔒 SAFE fromMap
  factory Meal.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Meal(
      id: id,

      // required FK
      userId: map['user_id'] as String? ?? '',

      // required type
      mealType: map['meal_type'] as String? ?? '',

      // Firestore / offline safe date
      mealDateTime: map['meal_datetime'] != null
          ? DateTime.tryParse(
                map['meal_datetime'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),

      // optional notes
      notes: map['notes'] as String?,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'meal_type': mealType,
      'meal_datetime': mealDateTime.toIso8601String(),
      if (notes != null) 'notes': notes,
    };
  }
}
