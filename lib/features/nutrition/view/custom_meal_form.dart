import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/validators/validators.dart';
import '../../../shared/widgets/app_form_fields.dart';
import '../../../providers/nutrition_provider.dart';
import '../../../models/meal_model.dart';

class CustomMealForm extends ConsumerStatefulWidget {
  final DateTime? selectedDate;

  const CustomMealForm({
    super.key,
    this.selectedDate,
  });

  @override
  ConsumerState<CustomMealForm> createState() => _CustomMealFormState();
}

class _CustomMealFormState extends ConsumerState<CustomMealForm> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _fiberController = TextEditingController();
  
  String _selectedMealType = 'breakfast';
  final List<String> _mealTypes = ['breakfast', 'lunch', 'dinner', 'snack'];
  bool _isLoading = false;

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _fiberController.dispose();
    super.dispose();
  }

  Future<void> _saveMeal() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final meal = MealModel(
        userEmail: '', // Will be set by provider
        name: _nameController.text.trim(),
        mealType: _selectedMealType,
        calories: double.parse(_caloriesController.text),
        protein: double.parse(_proteinController.text),
        carbs: double.parse(_carbsController.text),
        fat: double.parse(_fatController.text),
        fiber: double.tryParse(_fiberController.text) ?? 0.0,
        mealDate: widget.selectedDate ?? DateTime.now(),
      );

      await ref.read(nutritionProvider.notifier).addMeal(meal);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Meal added successfully!'),
            backgroundColor: AppColors.getSuccess(Theme.of(context).brightness),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error adding meal: $e'),
            backgroundColor: AppColors.getError(Theme.of(context).brightness),
          ),
        );
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(
          'Add Custom Meal',
          style: theme.textTheme.titleLarge,
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Meal Name
                AppTextField(
                  controller: _nameController,
                  label: 'Meal Name',
                  hint: 'e.g. Grilled Chicken Salad',
                  validator: Validators.required,
                  prefixIcon: Icons.restaurant,
                ),

                const SizedBox(height: 20),

                // Meal Type
                Text(
                  'Meal Type',
                  style: theme.textTheme.labelLarge,
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  children: _mealTypes.map((type) {
                    final isSelected = _selectedMealType == type;
                    return ChoiceChip(
                      label: Text(type.toUpperCase()),
                      selected: isSelected,
                      onSelected: (selected) {
                        if (selected) {
                          setState(() => _selectedMealType = type);
                        }
                      },
                    );
                  }).toList(),
                ),

                const SizedBox(height: 24),

                // Calories
                AppNumberField(
                  controller: _caloriesController,
                  label: 'Calories (kcal)',
                  hint: 'e.g. 500',
                  validator: (value) => Validators.number(
                    value,
                    min: 0,
                    max: 10000,
                    fieldName: 'Calories',
                  ),
                  prefixIcon: Icons.local_fire_department,
                ),

                const SizedBox(height: 20),

                // Protein
                AppNumberField(
                  controller: _proteinController,
                  label: 'Protein (g)',
                  hint: 'e.g. 30',
                  validator: (value) => Validators.number(
                    value,
                    min: 0,
                    max: 500,
                    fieldName: 'Protein',
                  ),
                  prefixIcon: Icons.fitness_center,
                ),

                const SizedBox(height: 20),

                // Carbs
                AppNumberField(
                  controller: _carbsController,
                  label: 'Carbs (g)',
                  hint: 'e.g. 50',
                  validator: (value) => Validators.number(
                    value,
                    min: 0,
                    max: 1000,
                    fieldName: 'Carbs',
                  ),
                  prefixIcon: Icons.eco,
                ),

                const SizedBox(height: 20),

                // Fat
                AppNumberField(
                  controller: _fatController,
                  label: 'Fat (g)',
                  hint: 'e.g. 20',
                  validator: (value) => Validators.number(
                    value,
                    min: 0,
                    max: 500,
                    fieldName: 'Fat',
                  ),
                  prefixIcon: Icons.opacity,
                ),

                const SizedBox(height: 20),

                // Fiber (mandatory)
                AppNumberField(
                  controller: _fiberController,
                  label: 'Fiber (g)',
                  hint: 'e.g. 5',
                  validator: (value) => Validators.number(
                    value,
                    min: 0,
                    max: 200,
                    fieldName: 'Fiber',
                  ),
                  prefixIcon: Icons.eco,
                ),

                const SizedBox(height: 32),

                // Save Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _saveMeal,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            'Save Meal',
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

