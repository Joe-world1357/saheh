import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_model.dart';
import '../database/database_helper.dart';

class NutritionNotifier extends Notifier<List<MealModel>> {
  final _db = DatabaseHelper.instance;

  @override
  List<MealModel> build() => [];

  Future<void> loadMealsForDate(DateTime date) async {
    final meals = await _db.getMealsByDate(date);
    state = meals;
  }

  Future<void> addMeal(MealModel meal) async {
    await _db.insertMeal(meal);
    await loadMealsForDate(meal.mealDate);
  }

  double get totalCalories => state.fold(0.0, (sum, meal) => sum + meal.calories);
  double get totalProtein => state.fold(0.0, (sum, meal) => sum + meal.protein);
  double get totalCarbs => state.fold(0.0, (sum, meal) => sum + meal.carbs);
  double get totalFat => state.fold(0.0, (sum, meal) => sum + meal.fat);
}

final nutritionProvider = NotifierProvider<NutritionNotifier, List<MealModel>>(() {
  return NutritionNotifier();
});

