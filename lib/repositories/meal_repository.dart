import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/meal.dart';
import '../models/meal_food.dart';
import '../models/food.dart';

class MealRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _meals =>
      _db.collection('meals');

  CollectionReference<Map<String, dynamic>> get _mealFoods =>
      _db.collection('meal_foods');

  CollectionReference<Map<String, dynamic>> get _foods =>
      _db.collection('foods');

  /// Get meals for a user on a specific day
  Future<List<Meal>> getMealsByDate(
    String userId,
    DateTime date,
  ) async {
    final startOfDay =
        DateTime(date.year, date.month, date.day);
    final endOfDay = startOfDay.add(const Duration(days: 1));

    final snapshot = await _meals
        .where('user_id', isEqualTo: userId)
        .where(
          'meal_datetime',
          isGreaterThanOrEqualTo: startOfDay.toIso8601String(),
        )
        .where(
          'meal_datetime',
          isLessThan: endOfDay.toIso8601String(),
        )
        .orderBy('meal_datetime')
        .get();

    return snapshot.docs
        .map((d) => Meal.fromMap(d.data(), d.id))
        .toList();
  }

  /// Create or update a meal
  Future<void> saveMeal(Meal meal) async {
    await _meals.doc(meal.id).set(
          meal.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Delete a meal (does NOT delete related foods automatically)
  Future<void> deleteMeal(String mealId) async {
    await _meals.doc(mealId).delete();
  }

  /// Add or update food inside a meal
  Future<void> saveMealFood(MealFood mealFood) async {
    await _mealFoods.doc(mealFood.id).set(
          mealFood.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Get all foods for a specific meal
  Future<List<MealFood>> getMealFoods(String mealId) async {
    final snapshot = await _mealFoods
        .where('meal_id', isEqualTo: mealId)
        .get();

    return snapshot.docs
        .map((d) => MealFood.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get food catalog (search / picker)
  Future<List<Food>> getFoods({
    String? search,
  }) async {
    Query<Map<String, dynamic>> query = _foods;

    if (search != null && search.isNotEmpty) {
      query = query
          .where('food_name', isGreaterThanOrEqualTo: search)
          .where('food_name', isLessThan: '$search\uf8ff');
    }

    final snapshot = await query.limit(50).get();

    return snapshot.docs
        .map((d) => Food.fromMap(d.data(), d.id))
        .toList();
  }
}