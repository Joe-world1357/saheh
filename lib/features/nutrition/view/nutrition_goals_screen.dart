import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/validators/validators.dart';
import '../../../shared/widgets/app_form_fields.dart';
import '../../../providers/nutrition_provider.dart';
import '../../../models/nutrition_goal_model.dart';

class NutritionGoalsScreen extends ConsumerStatefulWidget {
  const NutritionGoalsScreen({super.key});

  @override
  ConsumerState<NutritionGoalsScreen> createState() => _NutritionGoalsScreenState();
}

class _NutritionGoalsScreenState extends ConsumerState<NutritionGoalsScreen> {
  final _formKey = GlobalKey<FormState>();
  final _caloriesController = TextEditingController();
  final _proteinController = TextEditingController();
  final _carbsController = TextEditingController();
  final _fatController = TextEditingController();
  final _fiberController = TextEditingController();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _loadGoals();
  }

  Future<void> _loadGoals() async {
    final goal = await ref.read(nutritionProvider.notifier).getOrCreateGoal();
    setState(() {
      _caloriesController.text = goal.caloriesGoal.toStringAsFixed(0);
      _proteinController.text = goal.proteinGoal.toStringAsFixed(0);
      _carbsController.text = goal.carbsGoal.toStringAsFixed(0);
      _fatController.text = goal.fatGoal.toStringAsFixed(0);
      _fiberController.text = goal.fiberGoal.toStringAsFixed(0);
    });
  }

  @override
  void dispose() {
    _caloriesController.dispose();
    _proteinController.dispose();
    _carbsController.dispose();
    _fatController.dispose();
    _fiberController.dispose();
    super.dispose();
  }

  Future<void> _saveGoals() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final goal = NutritionGoalModel(
        userEmail: '', // Will be set by provider
        caloriesGoal: double.parse(_caloriesController.text),
        proteinGoal: double.parse(_proteinController.text),
        carbsGoal: double.parse(_carbsController.text),
        fatGoal: double.parse(_fatController.text),
        fiberGoal: double.parse(_fiberController.text),
        updatedAt: DateTime.now(),
      );

      await ref.read(nutritionProvider.notifier).updateNutritionGoal(goal);

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('Nutrition goals updated successfully!'),
            backgroundColor: AppColors.getSuccess(Theme.of(context).brightness),
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Error updating goals: $e'),
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
          'Nutrition Goals',
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
                Text(
                  'Set your daily nutrition targets',
                  style: theme.textTheme.bodyLarge?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(height: 24),

                // Calories
                AppNumberField(
                  controller: _caloriesController,
                  label: 'Daily Calories (kcal)',
                  hint: 'e.g. 2000',
                  validator: (value) => Validators.number(
                    value,
                    min: 1000,
                    max: 5000,
                    fieldName: 'Calories',
                  ),
                  prefixIcon: Icons.local_fire_department,
                ),

                const SizedBox(height: 20),

                // Protein
                AppNumberField(
                  controller: _proteinController,
                  label: 'Protein (g)',
                  hint: 'e.g. 150',
                  validator: (value) => Validators.number(
                    value,
                    min: 50,
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
                  hint: 'e.g. 250',
                  validator: (value) => Validators.number(
                    value,
                    min: 100,
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
                  hint: 'e.g. 65',
                  validator: (value) => Validators.number(
                    value,
                    min: 20,
                    max: 300,
                    fieldName: 'Fat',
                  ),
                  prefixIcon: Icons.opacity,
                ),

                const SizedBox(height: 20),

                // Fiber (mandatory)
                AppNumberField(
                  controller: _fiberController,
                  label: 'Fiber (g)',
                  hint: 'e.g. 25',
                  validator: (value) => Validators.number(
                    value,
                    min: 10,
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
                    onPressed: _isLoading ? null : _saveGoals,
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
                            'Save Goals',
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

