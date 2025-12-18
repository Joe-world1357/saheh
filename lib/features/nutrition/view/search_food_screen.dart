import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../providers/nutrition_provider.dart';
import '../../../models/meal_model.dart';
import 'package:intl/intl.dart';

class SearchFoodScreen extends ConsumerStatefulWidget {
  const SearchFoodScreen({super.key});

  @override
  ConsumerState<SearchFoodScreen> createState() => _SearchFoodScreenState();
}

class _SearchFoodScreenState extends ConsumerState<SearchFoodScreen> {
  final TextEditingController _searchController = TextEditingController();
  String _selectedMealType = 'Breakfast';
  final List<String> _mealTypes = ['Breakfast', 'Lunch', 'Dinner', 'Snack'];

  // Sample food database - In production, this would come from an API
  final List<Map<String, dynamic>> _foodDatabase = [
    {
      'name': 'Grilled Chicken Breast',
      'calories': 231,
      'protein': 43.5,
      'carbs': 0.0,
      'fat': 5.0,
      'fiber': 0.0,
      'serving': '100g',
    },
    {
      'name': 'Brown Rice',
      'calories': 111,
      'protein': 2.6,
      'carbs': 23.0,
      'fat': 0.9,
      'fiber': 1.8,
      'serving': '100g',
    },
    {
      'name': 'Salmon Fillet',
      'calories': 206,
      'protein': 22.0,
      'carbs': 0.0,
      'fat': 12.0,
      'fiber': 0.0,
      'serving': '100g',
    },
    {
      'name': 'Avocado',
      'calories': 160,
      'protein': 2.0,
      'carbs': 8.5,
      'fat': 14.7,
      'fiber': 6.7,
      'serving': '100g',
    },
    {
      'name': 'Greek Yogurt',
      'calories': 59,
      'protein': 10.0,
      'carbs': 3.6,
      'fat': 0.4,
      'fiber': 0.0,
      'serving': '100g',
    },
    {
      'name': 'Oatmeal',
      'calories': 68,
      'protein': 2.4,
      'carbs': 12.0,
      'fat': 1.4,
      'fiber': 1.7,
      'serving': '100g',
    },
    {
      'name': 'Banana',
      'calories': 89,
      'protein': 1.1,
      'carbs': 23.0,
      'fat': 0.3,
      'fiber': 2.6,
      'serving': '100g',
    },
    {
      'name': 'Eggs',
      'calories': 155,
      'protein': 13.0,
      'carbs': 1.1,
      'fat': 11.0,
      'fiber': 0.0,
      'serving': '100g',
    },
    {
      'name': 'Broccoli',
      'calories': 34,
      'protein': 2.8,
      'carbs': 7.0,
      'fat': 0.4,
      'fiber': 2.6,
      'serving': '100g',
    },
    {
      'name': 'Sweet Potato',
      'calories': 86,
      'protein': 1.6,
      'carbs': 20.0,
      'fat': 0.1,
      'fiber': 3.0,
      'serving': '100g',
    },
  ];

  List<Map<String, dynamic>> get _filteredFoods {
    if (_searchController.text.isEmpty) {
      return _foodDatabase;
    }
    return _foodDatabase
        .where((food) => food['name']
            .toString()
            .toLowerCase()
            .contains(_searchController.text.toLowerCase()))
        .toList();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Search Food', style: theme.textTheme.titleLarge),
      ),
      body: Column(
        children: [
          // Search Bar
          Padding(
            padding: const EdgeInsets.all(16),
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
              decoration: BoxDecoration(
                color: theme.colorScheme.surfaceContainerHighest,
                borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                border: Border.all(
                  color: theme.colorScheme.outline.withValues(alpha: 0.1),
                ),
              ),
              child: TextField(
                controller: _searchController,
                autofocus: true,
                style: theme.textTheme.bodyLarge,
                decoration: InputDecoration(
                  border: InputBorder.none,
                  hintText: "Search foods...",
                  hintStyle: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                  icon: Icon(
                    Icons.search,
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
                onChanged: (_) => setState(() {}),
              ),
            ),
          ),

          // Meal Type Selector
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _mealTypes.length,
              itemBuilder: (context, index) {
                final type = _mealTypes[index];
                final isSelected = _selectedMealType == type;

                return GestureDetector(
                  onTap: () => setState(() => _selectedMealType = type),
                  child: Container(
                    margin: const EdgeInsets.only(right: 12),
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected ? primary : theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                      border: Border.all(
                        color: isSelected
                            ? primary
                            : theme.colorScheme.outline.withValues(alpha: 0.2),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        type,
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: isSelected ? Colors.white : theme.colorScheme.onSurface,
                          fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          const SizedBox(height: 16),

          // Food List
          Expanded(
            child: _filteredFoods.isEmpty
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off,
                          size: 64,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "No foods found",
                          style: theme.textTheme.bodyLarge,
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: _filteredFoods.length,
                    itemBuilder: (context, index) {
                      final food = _filteredFoods[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 12),
                        child: AppCard(
                          padding: const EdgeInsets.all(16),
                          onTap: () => _showAddFoodDialog(context, food),
                          child: Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: primary.withValues(alpha: 0.15),
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                child: Icon(
                                  Icons.restaurant,
                                  color: primary,
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      food['name'] as String,
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${food['calories']} kcal • ${food['serving']}',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Icon(
                                Icons.add_circle,
                                color: primary,
                                size: 28,
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  void _showAddFoodDialog(BuildContext context, Map<String, dynamic> food) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final quantityController = TextEditingController(text: '100');

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        ),
        title: Text('Add ${food['name']}', style: theme.textTheme.titleLarge),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Serving size: ${food['serving']}',
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 16),
            TextField(
              controller: quantityController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: 'Quantity (g)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                ),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final quantity = double.tryParse(quantityController.text) ?? 100.0;
              final multiplier = quantity / 100.0;

              final meal = MealModel(
                userEmail: '', // Will be set by provider
                name: food['name'] as String,
                mealType: _selectedMealType.toLowerCase(),
                calories: (food['calories'] as num) * multiplier,
                protein: (food['protein'] as num) * multiplier,
                carbs: (food['carbs'] as num) * multiplier,
                fat: (food['fat'] as num) * multiplier,
                fiber: (food['fiber'] as num) * multiplier,
                mealDate: DateTime.now(),
                createdAt: DateTime.now(),
              );

              await ref.read(nutritionProvider.notifier).addMeal(meal);
              if (context.mounted) {
                Navigator.pop(context); // Close dialog
                Navigator.pop(context); // Close search screen
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('${food['name']} added successfully!'),
                    backgroundColor: primary,
                  ),
                );
              }
            },
            style: FilledButton.styleFrom(backgroundColor: primary),
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }
}

