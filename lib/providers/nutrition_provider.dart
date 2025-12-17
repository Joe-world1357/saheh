import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class NutritionNotifier extends Notifier<List<MealModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  List<MealModel> build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return [];
    }
    return [];
  }

  Future<void> loadMealsForDate(DateTime date) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }
    final meals = await _db.getMealsByDate(date, userEmail: userEmail);
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
