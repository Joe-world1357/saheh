import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/validators/validators.dart';
import '../../../shared/widgets/app_form_fields.dart';
import '../../../providers/health_tracking_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../models/health_tracking_model.dart';

class HealthGoalsScreen extends ConsumerStatefulWidget {
  const HealthGoalsScreen({super.key});

  @override
  ConsumerState<HealthGoalsScreen> createState() => _HealthGoalsScreenState();
}

class _HealthGoalsScreenState extends ConsumerState<HealthGoalsScreen> {
  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final state = ref.watch(healthTrackingProvider);

    return Scaffold(
      backgroundColor: AppColors.getBackground(brightness),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddGoalDialog(context, brightness),
        icon: const Icon(Icons.add),
        label: const Text('Add Goal'),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // App Bar
            Padding(
              padding: const EdgeInsets.all(AppTheme.spacingM),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      border: Border.all(color: AppColors.getBorder(brightness)),
                    ),
                    child: IconButton(
                      icon: Icon(Icons.arrow_back_ios_new,
                          color: AppColors.getTextPrimary(brightness), size: 20),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: AppTheme.spacingM),
                  Text('Health Goals', style: AppTextStyles.titleLarge(brightness)),
                ],
              ),
            ),

            // Stats Summary
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
              child: Container(
                padding: const EdgeInsets.all(AppTheme.spacingM),
                decoration: BoxDecoration(
                  gradient: AppTheme.primaryGradient(brightness),
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      'Active',
                      state.goals.where((g) => g.progress < 1.0).length.toString(),
                      Icons.flag_rounded,
                    ),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildStatItem(
                      'Completed',
                      state.goals.where((g) => g.progress >= 1.0).length.toString(),
                      Icons.check_circle_rounded,
                    ),
                    Container(width: 1, height: 40, color: Colors.white30),
                    _buildStatItem(
                      'Total XP',
                      '+${state.goals.where((g) => g.progress >= 1.0).length * 50}',
                      Icons.star_rounded,
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: AppTheme.spacingM),

            // Goals List
            Expanded(
              child: state.goals.isEmpty
                  ? _buildEmptyState(brightness)
                  : ListView.builder(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      itemCount: state.goals.length,
                      itemBuilder: (context, index) {
                        final goal = state.goals[index];
                        return _GoalCard(
                          goal: goal,
                          onUpdate: () => _showUpdateDialog(context, goal, brightness),
                          onDelete: () => _confirmDelete(context, goal, brightness),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: AppTheme.spacingXS),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: TextStyle(
            color: Colors.white.withOpacity(0.8),
            fontSize: 12,
          ),
        ),
      ],
    );
  }

  Widget _buildEmptyState(Brightness brightness) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.flag_outlined,
            size: 80,
            color: AppColors.getTextTertiary(brightness),
          ),
          const SizedBox(height: AppTheme.spacingM),
          Text(
            'No goals yet',
            style: AppTextStyles.titleLarge(brightness).copyWith(
              color: AppColors.getTextTertiary(brightness),
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Tap the button below to add your first goal',
            style: AppTextStyles.bodyMedium(brightness).copyWith(
              color: AppColors.getTextTertiary(brightness),
            ),
          ),
        ],
      ),
    );
  }

  void _showAddGoalDialog(BuildContext context, Brightness brightness) {
    final formKey = GlobalKey<FormState>();
    final titleController = TextEditingController();
    final targetController = TextEditingController();
    final deadlineController = TextEditingController();
    String selectedCategory = 'fitness';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.getSurface(brightness),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusXLarge)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacingM,
            right: AppTheme.spacingM,
            top: AppTheme.spacingM,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacingM,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.getBorder(brightness),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              Text('Add New Goal', style: AppTextStyles.titleLarge(brightness)),
              const SizedBox(height: AppTheme.spacingL),

              // Category chips
              Wrap(
                spacing: AppTheme.spacingS,
                children: [
                  _buildCategoryChip('Fitness', 'fitness', selectedCategory, (val) {
                    setModalState(() => selectedCategory = val);
                  }, brightness),
                  _buildCategoryChip('Nutrition', 'nutrition', selectedCategory, (val) {
                    setModalState(() => selectedCategory = val);
                  }, brightness),
                  _buildCategoryChip('Sleep', 'sleep', selectedCategory, (val) {
                    setModalState(() => selectedCategory = val);
                  }, brightness),
                  _buildCategoryChip('Weight', 'weight', selectedCategory, (val) {
                    setModalState(() => selectedCategory = val);
                  }, brightness),
                ],
              ),
              const SizedBox(height: AppTheme.spacingM),

              Form(
                key: formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    AppTextField(
                      controller: titleController,
                      label: 'Goal Title',
                      hint: 'e.g., Run 5km daily',
                      validator: Validators.required,
                    ),
                    const SizedBox(height: AppTheme.spacingM),

                    AppTextField(
                      controller: targetController,
                      label: 'Target',
                      hint: 'e.g., 5 km, 70 kg, 8 hours',
                      validator: Validators.goalTarget,
                    ),
                    const SizedBox(height: AppTheme.spacingM),

                    AppTextField(
                      controller: deadlineController,
                      label: 'Deadline (Optional)',
                      hint: 'e.g., 30 days, End of month',
                    ),
                  ],
                ),
              ),
              const SizedBox(height: AppTheme.spacingL),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (!formKey.currentState!.validate()) {
                      return;
                    }

                    final userEmail = ref.read(authProvider).user?.email ?? '';
                    final goal = HealthGoalModel(
                      userEmail: userEmail,
                      title: titleController.text,
                      target: targetController.text,
                      current: '0',
                      progress: 0.0,
                      deadline: deadlineController.text.isEmpty
                          ? '30 days'
                          : deadlineController.text,
                    );

                    await ref.read(healthTrackingProvider.notifier).addGoal(goal);
                    if (mounted) Navigator.pop(context);
                  },
                  child: const Text('Create Goal'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildCategoryChip(String label, String value, String selected,
      Function(String) onSelect, Brightness brightness) {
    final isSelected = value == selected;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelect(value),
    );
  }

  void _showUpdateDialog(BuildContext context, HealthGoalModel goal, Brightness brightness) {
    final currentController = TextEditingController(text: goal.current);
    double progress = goal.progress;

    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.getSurface(brightness),
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(AppTheme.radiusXLarge)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setModalState) => Padding(
          padding: EdgeInsets.only(
            left: AppTheme.spacingM,
            right: AppTheme.spacingM,
            top: AppTheme.spacingM,
            bottom: MediaQuery.of(context).viewInsets.bottom + AppTheme.spacingM,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: AppColors.getBorder(brightness),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: AppTheme.spacingM),
              Text('Update Progress', style: AppTextStyles.titleLarge(brightness)),
              const SizedBox(height: AppTheme.spacingS),
              Text(goal.title, style: AppTextStyles.bodyLarge(brightness)),
              const SizedBox(height: AppTheme.spacingL),

              Text('Progress: ${(progress * 100).toInt()}%',
                  style: AppTextStyles.titleMedium(brightness)),
              Slider(
                value: progress,
                onChanged: (val) => setModalState(() => progress = val),
              ),
              const SizedBox(height: AppTheme.spacingM),

              TextField(
                controller: currentController,
                decoration: InputDecoration(
                  labelText: 'Current Value',
                  hintText: 'Target: ${goal.target}',
                ),
              ),
              const SizedBox(height: AppTheme.spacingL),

              SizedBox(
                width: double.infinity,
                child: FilledButton(
                  onPressed: () async {
                    if (goal.id != null) {
                      await ref.read(healthTrackingProvider.notifier).updateGoalProgress(
                            goal.id!,
                            progress,
                            currentController.text,
                          );
                    }
                    if (mounted) Navigator.pop(context);
                  },
                  child: const Text('Update'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _confirmDelete(BuildContext context, HealthGoalModel goal, Brightness brightness) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.getSurface(brightness),
        title: Text('Delete Goal?', style: AppTextStyles.titleLarge(brightness)),
        content: Text(
          'Are you sure you want to delete "${goal.title}"?',
          style: AppTextStyles.bodyMedium(brightness),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.getError(brightness),
            ),
            onPressed: () async {
              if (goal.id != null) {
                await ref.read(healthTrackingProvider.notifier).deleteGoal(goal.id!);
              }
              if (mounted) Navigator.pop(context);
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final HealthGoalModel goal;
  final VoidCallback onUpdate;
  final VoidCallback onDelete;

  const _GoalCard({
    required this.goal,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final isCompleted = goal.progress >= 1.0;

    return Container(
      margin: const EdgeInsets.only(bottom: AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.getSurface(brightness),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(
          color: isCompleted
              ? AppColors.getSuccess(brightness)
              : AppColors.getBorder(brightness),
          width: isCompleted ? 2 : 1,
        ),
      ),
      child: Column(
        children: [
          ListTile(
            leading: Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isCompleted
                    ? AppColors.getSuccessBackground(brightness)
                    : AppColors.getPrimary(brightness).withOpacity(0.1),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Icon(
                isCompleted ? Icons.check_circle_rounded : Icons.flag_rounded,
                color: isCompleted
                    ? AppColors.getSuccess(brightness)
                    : AppColors.getPrimary(brightness),
              ),
            ),
            title: Text(
              goal.title,
              style: AppTextStyles.titleSmall(brightness).copyWith(
                decoration: isCompleted ? TextDecoration.lineThrough : null,
              ),
            ),
            subtitle: Text(
              '${goal.current} / ${goal.target}',
              style: AppTextStyles.bodySmall(brightness),
            ),
            trailing: PopupMenuButton(
              icon: Icon(Icons.more_vert, color: AppColors.getTextSecondary(brightness)),
              itemBuilder: (context) => [
                PopupMenuItem(
                  onTap: onUpdate,
                  child: const Row(
                    children: [
                      Icon(Icons.edit),
                      SizedBox(width: 8),
                      Text('Update'),
                    ],
                  ),
                ),
                PopupMenuItem(
                  onTap: onDelete,
                  child: Row(
                    children: [
                      Icon(Icons.delete, color: AppColors.getError(brightness)),
                      const SizedBox(width: 8),
                      Text('Delete', style: TextStyle(color: AppColors.getError(brightness))),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppTheme.spacingM,
              0,
              AppTheme.spacingM,
              AppTheme.spacingM,
            ),
            child: Column(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: LinearProgressIndicator(
                    value: goal.progress.clamp(0.0, 1.0),
                    minHeight: 8,
                    backgroundColor: AppColors.getSurfaceVariant(brightness),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      isCompleted
                          ? AppColors.getSuccess(brightness)
                          : AppColors.getPrimary(brightness),
                    ),
                  ),
                ),
                const SizedBox(height: AppTheme.spacingS),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${(goal.progress * 100).toInt()}% complete',
                      style: AppTextStyles.labelSmall(brightness),
                    ),
                    Row(
                      children: [
                        Icon(Icons.timer_outlined,
                            size: 14, color: AppColors.getTextTertiary(brightness)),
                        const SizedBox(width: 4),
                        Text(
                          goal.deadline,
                          style: AppTextStyles.labelSmall(brightness),
                        ),
                      ],
                    ),
                  ],
                ),
                if (isCompleted) ...[
                  const SizedBox(height: AppTheme.spacingS),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: AppTheme.spacingS,
                      vertical: AppTheme.spacingXS,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.getSuccessBackground(brightness),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.star_rounded,
                            size: 16, color: AppColors.getSuccess(brightness)),
                        const SizedBox(width: 4),
                        Text(
                          '+50 XP Earned!',
                          style: AppTextStyles.labelSmall(brightness).copyWith(
                            color: AppColors.getSuccess(brightness),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}
