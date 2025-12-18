import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/nutrition_provider.dart';
import '../../../shared/widgets/macro_progress_bar.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../models/meal_model.dart';
import 'add_meal.dart';
import 'nutrition_goals_screen.dart';

class NutritionScreenNew extends ConsumerStatefulWidget {
  const NutritionScreenNew({super.key});

  @override
  ConsumerState<NutritionScreenNew> createState() => _NutritionScreenNewState();
}

class _NutritionScreenNewState extends ConsumerState<NutritionScreenNew> {
  @override
  void initState() {
    super.initState();
    // Load nutrition data for today
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(nutritionProvider.notifier).loadNutritionForDate(DateTime.now());
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final nutritionState = ref.watch(nutritionProvider);
    final nutritionNotifier = ref.read(nutritionProvider.notifier);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Nutrition', style: theme.textTheme.titleLarge),
          actions: [
          IconButton(
            icon: Icon(Icons.settings, color: theme.colorScheme.onSurface),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const NutritionGoalsScreen(),
                ),
              );
            },
            tooltip: 'Nutrition Goals',
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () => nutritionNotifier.refresh(),
        child: SingleChildScrollView(
          physics: const AlwaysScrollableScrollPhysics(),
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Daily Calories Card
              _buildCaloriesCard(nutritionState, theme, brightness),

              const SizedBox(height: 24),

              // Macros Section
              Text('Macros', style: theme.textTheme.titleMedium),
              const SizedBox(height: 16),

              if (nutritionState.goal != null) ...[
                MacroProgressBar(
                  macroName: 'Protein',
                  current: nutritionNotifier.totalProtein,
                  target: nutritionState.goal!.proteinGoal,
                  type: MacroType.protein,
                ),
                const SizedBox(height: 16),
                MacroProgressBar(
                  macroName: 'Carbs',
                  current: nutritionNotifier.totalCarbs,
                  target: nutritionState.goal!.carbsGoal,
                  type: MacroType.carbs,
                ),
                const SizedBox(height: 16),
                MacroProgressBar(
                  macroName: 'Fat',
                  current: nutritionNotifier.totalFat,
                  target: nutritionState.goal!.fatGoal,
                  type: MacroType.fats,
                ),
                const SizedBox(height: 16),
                MacroProgressBar(
                  macroName: 'Fiber',
                  current: nutritionNotifier.totalFiber,
                  target: nutritionState.goal!.fiberGoal,
                  type: MacroType.protein, // Use protein color for fiber
                ),
              ] else ...[
                Text(
                  'Set nutrition goals to track macros',
                  style: theme.textTheme.bodyMedium,
                ),
              ],

              const SizedBox(height: 32),

              // Status & XP
              _buildStatusCard(nutritionState, theme),

              const SizedBox(height: 32),

              // Meals Section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Meals Today', style: theme.textTheme.titleMedium),
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const AddMeal(),
                        ),
                      );
                    },
                    child: const Text('Add Meal'),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Meals List
              if (nutritionState.meals.isEmpty)
                _buildEmptyState(theme)
              else
                ...nutritionState.meals.map((meal) => _buildMealCard(
                      meal as MealModel,
                      theme,
                      brightness,
                    )),

              const SizedBox(height: 32),

              // Suggested Meals
              _buildSuggestedMeals(nutritionState, theme, brightness),

              const SizedBox(height: 32),

              // AI Insights
              if (nutritionState.aiInsights.isNotEmpty) ...[
                Text('AI Insights', style: theme.textTheme.titleMedium),
                const SizedBox(height: 16),
                ...nutritionState.aiInsights.map((insight) => _buildInsightCard(
                      insight,
                      theme,
                    )),
              ],

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const AddMeal(),
            ),
          );
        },
        icon: const Icon(Icons.add),
        label: const Text('Add Meal'),
      ),
    );
  }

  Widget _buildCaloriesCard(
    NutritionState state,
    ThemeData theme,
    Brightness brightness,
  ) {
    final notifier = ref.read(nutritionProvider.notifier);
    final totalCal = notifier.totalCalories;
    final goal = state.goal?.caloriesGoal ?? 2000.0;
    final progress = goal > 0 ? (totalCal / goal).clamp(0.0, 1.0) : 0.0;
    final remaining = (goal - totalCal).clamp(0.0, double.infinity);

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.getPrimary(brightness),
            AppColors.getPrimary(brightness).withOpacity(0.7),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
      ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Daily Calories',
              style: theme.textTheme.titleMedium?.copyWith(color: Colors.white),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        totalCal.toStringAsFixed(0),
                        style: theme.textTheme.displaySmall?.copyWith(
                          color: Colors.white,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '/ ${goal.toStringAsFixed(0)}',
                        style: theme.textTheme.bodyLarge?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  width: 100,
                  height: 100,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      SizedBox(
                        width: 100,
                        height: 100,
                        child: CircularProgressIndicator(
                          value: progress,
                          strokeWidth: 8,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(
                            Colors.white,
                          ),
                        ),
                      ),
                      Text(
                        '${(progress * 100).toStringAsFixed(0)}%',
                        style: theme.textTheme.titleLarge?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  '🔥 ${remaining.toStringAsFixed(0)} kcal left',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
                Text(
                  '⭐ +${state.xpEarnedToday} XP today',
                  style: theme.textTheme.bodyMedium?.copyWith(color: Colors.white),
                ),
              ],
            ),
        ],
      ),
    );
  }

  Widget _buildStatusCard(
    NutritionState state,
    ThemeData theme,
  ) {
    final notifier = ref.read(nutritionProvider.notifier);
    final status = notifier.statusText;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(
            Icons.check_circle_outline,
            color: AppColors.getSuccess(theme.brightness),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              status,
              style: theme.textTheme.bodyLarge,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMealCard(
    MealModel meal,
    ThemeData theme,
    Brightness brightness,
  ) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                _getMealIcon(meal.mealType),
                color: AppColors.getPrimary(brightness),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Text(
                  meal.name,
                  style: theme.textTheme.titleSmall,
                ),
              ),
              Text(
                '${meal.calories.toStringAsFixed(0)} kcal',
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              _buildMacroChip('P', meal.protein, 'g', theme),
              const SizedBox(width: 8),
              _buildMacroChip('C', meal.carbs, 'g', theme),
              const SizedBox(width: 8),
              _buildMacroChip('F', meal.fat, 'g', theme),
              const SizedBox(width: 8),
              _buildMacroChip('Fiber', meal.fiber, 'g', theme),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMacroChip(
    String label,
    double value,
    String unit,
    ThemeData theme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: theme.colorScheme.surfaceVariant,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Text(
        '$label: ${value.toStringAsFixed(1)}$unit',
        style: theme.textTheme.bodySmall,
      ),
    );
  }

  Widget _buildInsightCard(
    String insight,
    ThemeData theme,
  ) {
    final brightness = theme.brightness;
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: AppColors.getInfo(brightness).withValues(alpha: 0.1),
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(
          color: AppColors.getInfo(brightness).withValues(alpha: 0.3),
        ),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            Icons.lightbulb_outline,
            color: AppColors.getInfo(brightness),
            size: 20,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              insight,
              style: theme.textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyState(ThemeData theme) {
    return Container(
      padding: const EdgeInsets.all(32),
      child: Column(
        children: [
          Icon(
            Icons.restaurant_outlined,
            size: 64,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(height: 16),
          Text(
            'No meals logged today',
            style: theme.textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          Text(
            'Start tracking your nutrition by adding your first meal',
            style: theme.textTheme.bodyMedium?.copyWith(
              color: theme.colorScheme.onSurfaceVariant,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  IconData _getMealIcon(String mealType) {
    switch (mealType.toLowerCase()) {
      case 'breakfast':
        return Icons.breakfast_dining;
      case 'lunch':
        return Icons.lunch_dining;
      case 'dinner':
        return Icons.dinner_dining;
      case 'snack':
        return Icons.cookie;
      default:
        return Icons.restaurant;
    }
  }

  Widget _buildSuggestedMeals(
    NutritionState state,
    ThemeData theme,
    Brightness brightness,
  ) {
    if (state.goal == null) {
      return const SizedBox.shrink();
    }

    final notifier = ref.read(nutritionProvider.notifier);
    final totalCal = notifier.totalCalories;
    final totalProt = notifier.totalProtein;
    final totalFib = notifier.totalFiber;
    final goal = state.goal!;

    // Generate suggestions based on deficits
    final suggestions = <Map<String, dynamic>>[];

    // Low protein suggestion
    if (totalProt < goal.proteinGoal * 0.7) {
      suggestions.add({
        'name': 'Grilled Chicken Breast',
        'calories': 231,
        'protein': 43.5,
        'carbs': 0.0,
        'fat': 5.0,
        'fiber': 0.0,
        'reason': 'High protein',
      });
    }

    // Low fiber suggestion
    if (totalFib < goal.fiberGoal * 0.7) {
      suggestions.add({
        'name': 'Oatmeal with Berries',
        'calories': 200,
        'protein': 5.0,
        'carbs': 40.0,
        'fat': 3.0,
        'fiber': 6.0,
        'reason': 'High fiber',
      });
    }

    // Low calories suggestion
    if (totalCal < goal.caloriesGoal * 0.7) {
      suggestions.add({
        'name': 'Salmon with Rice',
        'calories': 450,
        'protein': 30.0,
        'carbs': 50.0,
        'fat': 12.0,
        'fiber': 2.0,
        'reason': 'Balanced meal',
      });
    }

    // Balanced snack suggestion
    if (suggestions.isEmpty && totalCal < goal.caloriesGoal * 0.9) {
      suggestions.add({
        'name': 'Greek Yogurt with Nuts',
        'calories': 250,
        'protein': 15.0,
        'carbs': 20.0,
        'fat': 10.0,
        'fiber': 3.0,
        'reason': 'Healthy snack',
      });
    }

    if (suggestions.isEmpty) {
      return const SizedBox.shrink();
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Suggested Meals',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            TextButton(
              onPressed: () {},
              child: Text(
                'See all',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: AppColors.getPrimary(brightness),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(height: 12),
        ...suggestions.map((suggestion) => Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: AppCard(
                padding: const EdgeInsets.all(16),
                onTap: () async {
                  final meal = MealModel(
                    userEmail: '', // Will be set by provider
                    name: suggestion['name'] as String,
                    mealType: 'snack',
                    calories: suggestion['calories'] as double,
                    protein: suggestion['protein'] as double,
                    carbs: suggestion['carbs'] as double,
                    fat: suggestion['fat'] as double,
                    fiber: suggestion['fiber'] as double,
                    mealDate: DateTime.now(),
                    createdAt: DateTime.now(),
                  );
                  await notifier.addMeal(meal);
                  if (mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('${suggestion['name']} added!'),
                        backgroundColor: AppColors.getSuccess(brightness),
                      ),
                    );
                  }
                },
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(10),
                      decoration: BoxDecoration(
                        color: AppColors.getSuccess(brightness).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Icon(
                        Icons.restaurant,
                        color: AppColors.getSuccess(brightness),
                        size: 24,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            suggestion['name'] as String,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${suggestion['calories']} kcal • ${suggestion['reason']}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.getPrimary(brightness),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(
                        Icons.add,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
              ),
            )),
      ],
    );
  }
}

