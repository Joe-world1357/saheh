import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'custom_meal_form.dart';
import 'search_food_screen.dart';
import 'nutrition_barcode_scanner.dart';
import 'meal_photo_capture.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../providers/nutrition_provider.dart';
import '../../../models/meal_model.dart';

class AddMeal extends ConsumerStatefulWidget {
  const AddMeal({super.key});

  @override
  ConsumerState<AddMeal> createState() => _AddMealState();
}

class _AddMealState extends ConsumerState<AddMeal> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final infoColor = AppColors.getInfo(brightness);
    final warningColor = AppColors.getWarning(brightness);
    final successColor = AppColors.getSuccess(brightness);

    final nutritionState = ref.watch(nutritionProvider);
    final recentMeals = nutritionState.meals.take(3).toList();

    final List<Map<String, dynamic>> addOptions = [
      {
        'icon': Icons.search,
        'color': infoColor,
        'title': 'Search Food',
        'subtitle': 'Find food from database',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const SearchFoodScreen()),
          );
        },
      },
      {
        'icon': Icons.qr_code_scanner,
        'color': primary,
        'title': 'Scan Barcode',
        'subtitle': 'Scan product barcode',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const NutritionBarcodeScanner()),
          );
        },
      },
      {
        'icon': Icons.camera_alt,
        'color': warningColor,
        'title': 'Take Photo',
        'subtitle': 'Capture meal with camera',
        'onTap': () async {
          final photoPath = await Navigator.push<String>(
            context,
            MaterialPageRoute(builder: (_) => const MealPhotoCapture()),
          );
          if (photoPath != null && mounted) {
            // Photo captured - could be used for AI meal recognition later
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: const Text('Photo saved! You can now add meal details.'),
                backgroundColor: successColor,
              ),
            );
            // Navigate to custom meal form with photo path
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => const CustomMealForm(),
              ),
            );
          }
        },
      },
      {
        'icon': Icons.add_circle_outline,
        'color': successColor,
        'title': 'Add Custom Meal',
        'subtitle': 'Create your own meal entry',
        'onTap': () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (_) => const CustomMealForm()),
          );
        },
      },
    ];

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Add Meal', style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Add Options
              Text(
                'Add Meal Options',
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              ...addOptions.map((option) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: AppCard(
                      padding: const EdgeInsets.all(18),
                      onTap: option['onTap'] as VoidCallback,
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: BoxDecoration(
                              color: (option['color'] as Color).withValues(alpha: 0.15),
                              borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                            ),
                            child: Icon(
                              option['icon'] as IconData,
                              color: option['color'] as Color,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  option['title'] as String,
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  option['subtitle'] as String,
                                  style: theme.textTheme.bodySmall?.copyWith(
                                    color: theme.colorScheme.onSurfaceVariant,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Icon(
                            Icons.chevron_right,
                            color: theme.colorScheme.onSurfaceVariant,
                            size: 24,
                          ),
                        ],
                      ),
                    ),
                  )),

              const SizedBox(height: 32),

              // Recent Meals
              if (recentMeals.isNotEmpty) ...[
                Text(
                  'Recent Meals',
                  style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                ...recentMeals.map((meal) => Padding(
                      padding: const EdgeInsets.only(bottom: 12),
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        onTap: () async {
                          // Quick add same meal
                          final newMeal = MealModel(
                            userEmail: meal.userEmail,
                            name: meal.name,
                            mealType: meal.mealType,
                            calories: meal.calories,
                            protein: meal.protein,
                            carbs: meal.carbs,
                            fat: meal.fat,
                            fiber: meal.fiber,
                            mealDate: DateTime.now(),
                            createdAt: DateTime.now(),
                          );
                          await ref.read(nutritionProvider.notifier).addMeal(newMeal);
                          if (mounted) {
                            Navigator.pop(context);
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text('${meal.name} added!'),
                                backgroundColor: successColor,
                              ),
                            );
                          }
                        },
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: primary.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: Icon(
                                Icons.restaurant,
                                color: primary,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    meal.name,
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${meal.calories.toStringAsFixed(0)} kcal',
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
                                color: primary,
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
            ],
          ),
        ),
      ),
    );
  }
}
