import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/meal_model.dart';
import '../models/nutrition_goal_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

/// Nutrition state containing meals and goals
class NutritionState {
  final List<MealModel> meals;
  final NutritionGoalModel? goal;
  final DateTime selectedDate;
  final int xpEarnedToday;
  final List<String> aiInsights;

  NutritionState({
    required this.meals,
    this.goal,
    required this.selectedDate,
    this.xpEarnedToday = 0,
    List<String>? aiInsights,
  }) : aiInsights = aiInsights ?? [];

  NutritionState copyWith({
    List<MealModel>? meals,
    NutritionGoalModel? goal,
    DateTime? selectedDate,
    int? xpEarnedToday,
    List<String>? aiInsights,
  }) {
    return NutritionState(
      meals: meals ?? this.meals,
      goal: goal ?? this.goal,
      selectedDate: selectedDate ?? this.selectedDate,
      xpEarnedToday: xpEarnedToday ?? this.xpEarnedToday,
      aiInsights: aiInsights ?? this.aiInsights,
    );
  }
}

class NutritionNotifier extends Notifier<NutritionState> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  NutritionState build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return NutritionState(
        meals: [],
        selectedDate: DateTime.now(),
      );
    }
    return NutritionState(
      meals: [],
      selectedDate: DateTime.now(),
    );
  }

  /// Load meals and goals for a specific date
  Future<void> loadNutritionForDate(DateTime date) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = state.copyWith(meals: [], goal: null);
      return;
    }

    // Load meals
    final meals = await _db.getMealsByDate(date, userEmail: userEmail);

    // Load or create default goal
    var goal = await _db.getNutritionGoal(userEmail);
    if (goal == null) {
      goal = NutritionGoalModel.defaults(userEmail);
      await _db.insertNutritionGoal(goal);
    }

    // Calculate XP earned today
    final xpEarned = await _calculateXPEarned(meals, goal);

    // Generate AI insights
    final insights = _generateAIInsights(meals, goal);

    state = state.copyWith(
      meals: meals,
      goal: goal,
      selectedDate: date,
      xpEarnedToday: xpEarned,
      aiInsights: insights,
    );
  }

  /// Add a new meal
  Future<void> addMeal(MealModel meal) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      throw Exception('User not authenticated');
    }

    // Ensure meal has user email
    final mealWithUser = MealModel(
      id: meal.id,
      userEmail: userEmail,
      name: meal.name,
      mealType: meal.mealType,
      calories: meal.calories,
      protein: meal.protein,
      carbs: meal.carbs,
      fat: meal.fat,
      fiber: meal.fiber,
      mealDate: meal.mealDate,
      createdAt: meal.createdAt,
    );

    await _db.insertMeal(mealWithUser);
    
    // Award XP for logging meal
    await ref.read(authProvider.notifier).addXP(10);

    // Reload nutrition data
    await loadNutritionForDate(meal.mealDate);

    // Check and award XP for reaching goals
    await _checkAndAwardGoalXP();
  }

  /// Update nutrition goals
  Future<void> updateNutritionGoal(NutritionGoalModel goal) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      throw Exception('User not authenticated');
    }

    final goalWithUser = NutritionGoalModel(
      id: goal.id,
      userEmail: userEmail,
      caloriesGoal: goal.caloriesGoal,
      proteinGoal: goal.proteinGoal,
      carbsGoal: goal.carbsGoal,
      fatGoal: goal.fatGoal,
      fiberGoal: goal.fiberGoal,
      updatedAt: DateTime.now(),
    );

    await _db.updateNutritionGoal(goalWithUser);
    await loadNutritionForDate(state.selectedDate);
  }

  /// Get or create default nutrition goal
  Future<NutritionGoalModel> getOrCreateGoal() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      throw Exception('User not authenticated');
    }

    var goal = await _db.getNutritionGoal(userEmail);
    if (goal == null) {
      goal = NutritionGoalModel.defaults(userEmail);
      await _db.insertNutritionGoal(goal);
    }
    return goal;
  }

  /// Calculate daily totals
  double get totalCalories => state.meals.fold(0.0, (sum, meal) => sum + meal.calories);
  double get totalProtein => state.meals.fold(0.0, (sum, meal) => sum + meal.protein);
  double get totalCarbs => state.meals.fold(0.0, (sum, meal) => sum + meal.carbs);
  double get totalFat => state.meals.fold(0.0, (sum, meal) => sum + meal.fat);
  double get totalFiber => state.meals.fold(0.0, (sum, meal) => sum + meal.fiber);

  /// Calculate progress percentages
  double get caloriesProgress => state.goal != null && state.goal!.caloriesGoal > 0
      ? (totalCalories / state.goal!.caloriesGoal).clamp(0.0, 1.0)
      : 0.0;

  double get proteinProgress => state.goal != null && state.goal!.proteinGoal > 0
      ? (totalProtein / state.goal!.proteinGoal).clamp(0.0, 1.0)
      : 0.0;

  double get carbsProgress => state.goal != null && state.goal!.carbsGoal > 0
      ? (totalCarbs / state.goal!.carbsGoal).clamp(0.0, 1.0)
      : 0.0;

  double get fatProgress => state.goal != null && state.goal!.fatGoal > 0
      ? (totalFat / state.goal!.fatGoal).clamp(0.0, 1.0)
      : 0.0;

  double get fiberProgress => state.goal != null && state.goal!.fiberGoal > 0
      ? (totalFiber / state.goal!.fiberGoal).clamp(0.0, 1.0)
      : 0.0;

  /// Get status text
  String get statusText {
    if (state.goal == null) return 'Set goals to track progress';
    if (caloriesProgress >= 1.0) return 'Goal reached! 🎉';
    if (caloriesProgress >= 0.9) return 'Almost there!';
    if (caloriesProgress >= 0.7) return 'On track';
    if (caloriesProgress >= 0.5) return 'Keep going';
    return 'Getting started';
  }

  /// Calculate XP earned today from nutrition goals
  Future<int> _calculateXPEarned(List<MealModel> meals, NutritionGoalModel goal) async {
    int xp = 0;
    
    final totalCal = meals.fold(0.0, (sum, m) => sum + m.calories);
    final totalProt = meals.fold(0.0, (sum, m) => sum + m.protein);
    final totalFib = meals.fold(0.0, (sum, m) => sum + m.fiber);
    final totalCarb = meals.fold(0.0, (sum, m) => sum + m.carbs);
    final totalFat = meals.fold(0.0, (sum, m) => sum + m.fat);

    // Calorie goal reached
    if (totalCal >= goal.caloriesGoal * 0.95) {
      xp += 20;
    }

    // Protein goal reached
    if (totalProt >= goal.proteinGoal * 0.95) {
      xp += 15;
    }

    // Fiber goal reached (important)
    if (totalFib >= goal.fiberGoal * 0.95) {
      xp += 15;
    }

    // All macros balanced (all within 90-110% of goal)
    final allBalanced = 
        (totalCal >= goal.caloriesGoal * 0.9 && totalCal <= goal.caloriesGoal * 1.1) &&
        (totalProt >= goal.proteinGoal * 0.9 && totalProt <= goal.proteinGoal * 1.1) &&
        (totalCarb >= goal.carbsGoal * 0.9 && totalCarb <= goal.carbsGoal * 1.1) &&
        (totalFat >= goal.fatGoal * 0.9 && totalFat <= goal.fatGoal * 1.1) &&
        (totalFib >= goal.fiberGoal * 0.9 && totalFib <= goal.fiberGoal * 1.1);
    
    if (allBalanced) {
      xp += 30; // Bonus XP for balanced macros
    }

    return xp;
  }

  /// Check and award XP for reaching goals (called after adding meal)
  Future<void> _checkAndAwardGoalXP() async {
    if (state.goal == null) return;

    final totalCal = totalCalories;
    final totalProt = totalProtein;
    final totalFib = totalFiber;
    final totalCarb = totalCarbs;
    final totalFatValue = totalFat;

    // Award XP for reaching goals (only once per day)
    // We track this by checking if we're close to the goal threshold
    // In a production app, you'd track which goals were already awarded today
    
    // Calorie goal reached
    if (totalCal >= state.goal!.caloriesGoal * 0.95 && totalCal < state.goal!.caloriesGoal * 1.05) {
      await ref.read(authProvider.notifier).addXP(20);
    }

    // Protein goal reached
    if (totalProt >= state.goal!.proteinGoal * 0.95 && totalProt < state.goal!.proteinGoal * 1.05) {
      await ref.read(authProvider.notifier).addXP(15);
    }

    // Fiber goal reached
    if (totalFib >= state.goal!.fiberGoal * 0.95 && totalFib < state.goal!.fiberGoal * 1.05) {
      await ref.read(authProvider.notifier).addXP(15);
    }

    // All macros balanced
    final allBalanced = 
        (totalCal >= state.goal!.caloriesGoal * 0.9 && totalCal <= state.goal!.caloriesGoal * 1.1) &&
        (totalProt >= state.goal!.proteinGoal * 0.9 && totalProt <= state.goal!.proteinGoal * 1.1) &&
        (totalCarb >= state.goal!.carbsGoal * 0.9 && totalCarb <= state.goal!.carbsGoal * 1.1) &&
        (totalFatValue >= state.goal!.fatGoal * 0.9 && totalFatValue <= state.goal!.fatGoal * 1.1) &&
        (totalFib >= state.goal!.fiberGoal * 0.9 && totalFib <= state.goal!.fiberGoal * 1.1);
    
    if (allBalanced) {
      await ref.read(authProvider.notifier).addXP(30);
    }
  }

  /// Generate AI-powered nutrition insights
  List<String> _generateAIInsights(List<MealModel> meals, NutritionGoalModel? goal) {
    if (goal == null || meals.isEmpty) {
      return ['Start logging meals to get personalized nutrition insights!'];
    }

    final insights = <String>[];
    final totalCal = totalCalories;
    final totalProt = totalProtein;
    final totalFib = totalFiber;
    final totalCarb = totalCarbs;
    final totalFatValue = totalFat;

    // Low protein
    if (totalProt < goal.proteinGoal * 0.7) {
      insights.add('Increase protein intake today. Try adding lean meat, eggs, or legumes.');
    }

    // Low fiber
    if (totalFib < goal.fiberGoal * 0.7) {
      insights.add('Add more fiber to your diet. Include vegetables, whole grains, or oats.');
    }

    // Over calories
    if (totalCal > goal.caloriesGoal * 1.1) {
      insights.add('You\'re over your calorie goal. Consider reducing carbs at dinner.');
    }

    // Low calories
    if (totalCal < goal.caloriesGoal * 0.7) {
      insights.add('You\'re below your calorie goal. Add a healthy snack to meet your target.');
    }

    // High carbs, low protein
    if (totalCarb > goal.carbsGoal * 1.2 && totalProt < goal.proteinGoal * 0.8) {
      insights.add('Balance your macros: reduce carbs and increase protein for better nutrition.');
    }

    // Consistent goal hits (if we had historical data, we'd check here)
    if (totalCal >= goal.caloriesGoal * 0.95 && totalProt >= goal.proteinGoal * 0.95) {
      insights.add('Great job! You\'re consistently hitting your goals. Consider increasing your targets?');
    }

    // Balanced macros
    if (insights.isEmpty) {
      insights.add('Your nutrition is well-balanced today! Keep up the great work.');
    }

    return insights;
  }

  /// Refresh nutrition data
  Future<void> refresh() async {
    await loadNutritionForDate(state.selectedDate);
  }
}

final nutritionProvider = NotifierProvider<NutritionNotifier, NutritionState>(() {
  return NutritionNotifier();
});
