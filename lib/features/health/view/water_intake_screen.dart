import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/health_tracking_provider.dart';

class WaterIntakeScreen extends ConsumerStatefulWidget {
  const WaterIntakeScreen({super.key});

  @override
  ConsumerState<WaterIntakeScreen> createState() => _WaterIntakeScreenState();
}

class _WaterIntakeScreenState extends ConsumerState<WaterIntakeScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  final TextEditingController _customAmountController = TextEditingController();
  final TextEditingController _goalController = TextEditingController();
  bool _isAddingCustom = false;

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _customAmountController.dispose();
    _goalController.dispose();
    super.dispose();
  }

  Future<void> _addWater(int amount) async {
    await ref.read(healthTrackingProvider.notifier).addWater(amount);
    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('+${amount}ml added'),
          backgroundColor: AppColors.success,
          duration: const Duration(seconds: 1),
        ),
      );
    }
  }

  Future<void> _addCustomAmount() async {
    final amount = int.tryParse(_customAmountController.text);
    if (amount != null && amount > 0) {
      await _addWater(amount);
      _customAmountController.clear();
      setState(() => _isAddingCustom = false);
    }
  }

  void _showGoalDialog() {
    final state = ref.read(healthTrackingProvider);
    _goalController.text = state.waterGoal.toString();
    final brightness = Theme.of(context).brightness;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: AppColors.getSurface(brightness),
        title: Text('Set Daily Goal', style: AppTextStyles.titleLarge(brightness)),
        content: TextField(
          controller: _goalController,
          keyboardType: TextInputType.number,
          decoration: const InputDecoration(
            labelText: 'Goal (ml)',
            suffixText: 'ml',
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () async {
              final goal = int.tryParse(_goalController.text);
              if (goal != null && goal > 0) {
                await ref.read(healthTrackingProvider.notifier).setWaterGoal(goal);
                if (mounted) Navigator.pop(context);
              }
            },
            child: const Text('Save'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final brightness = Theme.of(context).brightness;
    final state = ref.watch(healthTrackingProvider);
    final progress = state.waterProgress;
    final timeFormat = DateFormat('h:mm a');

    return Scaffold(
      backgroundColor: AppColors.getBackground(brightness),
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
                  Expanded(
                    child: Text('Water Intake', style: AppTextStyles.titleLarge(brightness)),
                  ),
                  IconButton(
                    icon: Icon(Icons.settings, color: AppColors.getTextSecondary(brightness)),
                    onPressed: _showGoalDialog,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: AppTheme.spacingM),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppTheme.spacingM),

                    // Progress Card
                    AnimatedBuilder(
                      animation: _animationController,
                      builder: (context, child) {
                        return Transform.scale(
                          scale: 0.8 + (0.2 * _animationController.value),
                          child: Opacity(
                            opacity: _animationController.value,
                            child: child,
                          ),
                        );
                      },
                      child: Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          boxShadow: AppTheme.elevatedShadow(brightness),
                        ),
                        child: Column(
                          children: [
                            // Animated water drop
                            TweenAnimationBuilder<double>(
                              tween: Tween(begin: 0, end: progress.clamp(0.0, 1.0)),
                              duration: const Duration(milliseconds: 1000),
                              builder: (context, value, child) {
                                return Stack(
                                  alignment: Alignment.center,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      height: 100,
                                      child: CircularProgressIndicator(
                                        value: value,
                                        strokeWidth: 8,
                                        backgroundColor: Colors.white.withOpacity(0.3),
                                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                                      ),
                                    ),
                                    const Icon(Icons.water_drop_rounded, 
                                      color: Colors.white, size: 48),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: AppTheme.spacingM),
                            Text(
                              '${state.todayWaterIntake} / ${state.waterGoal} ml',
                              style: AppTextStyles.metricMedium(brightness).copyWith(
                                color: Colors.white,
                              ),
                            ),
                            const SizedBox(height: AppTheme.spacingS),
                            Text(
                              '${(progress * 100).toInt()}% of daily goal',
                              style: AppTextStyles.bodyMedium(brightness).copyWith(
                                color: Colors.white.withOpacity(0.9),
                              ),
                            ),
                            if (progress >= 1.0) ...[
                              const SizedBox(height: AppTheme.spacingM),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: AppTheme.spacingM,
                                  vertical: AppTheme.spacingS,
                                ),
                                decoration: BoxDecoration(
                                  color: Colors.white.withOpacity(0.2),
                                  borderRadius: BorderRadius.circular(AppTheme.spacingL),
                                ),
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const Icon(Icons.check_circle, color: Colors.white, size: 20),
                                    const SizedBox(width: AppTheme.spacingS),
                                    Text(
                                      'Goal Reached! +20 XP',
                                      style: AppTextStyles.labelMedium(brightness).copyWith(
                                        color: Colors.white,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Quick Add
                    Text('Quick Add', style: AppTextStyles.titleMedium(brightness)),
                    const SizedBox(height: AppTheme.spacingM),
                    Row(
                      children: [
                        Expanded(child: _buildQuickAddButton(250, '250ml', brightness)),
                        const SizedBox(width: AppTheme.spacingS),
                        Expanded(child: _buildQuickAddButton(500, '500ml', brightness)),
                        const SizedBox(width: AppTheme.spacingS),
                        Expanded(child: _buildQuickAddButton(750, '750ml', brightness)),
                      ],
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Custom Amount
                    Text('Custom Amount', style: AppTextStyles.titleMedium(brightness)),
                    const SizedBox(height: AppTheme.spacingM),
                    AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppColors.getSurface(brightness),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(color: AppColors.getBorder(brightness)),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: TextField(
                              controller: _customAmountController,
                              keyboardType: TextInputType.number,
                              onTap: () => setState(() => _isAddingCustom = true),
                              decoration: InputDecoration(
                                hintText: 'Enter amount (ml)',
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.water_drop_rounded,
                                    color: AppColors.getPrimary(brightness)),
                              ),
                            ),
                          ),
                          FilledButton(
                            onPressed: _addCustomAmount,
                            child: const Text('Add'),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // Today's Log
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text("Today's Log", style: AppTextStyles.titleMedium(brightness)),
                        Text(
                          '${state.todayWaterLog.length} entries',
                          style: AppTextStyles.bodySmall(brightness),
                        ),
                      ],
                    ),
                    const SizedBox(height: AppTheme.spacingM),
                    if (state.todayWaterLog.isEmpty)
                      Container(
                        padding: const EdgeInsets.all(AppTheme.spacingL),
                        decoration: BoxDecoration(
                          color: AppColors.getSurface(brightness),
                          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          border: Border.all(color: AppColors.getBorder(brightness)),
                        ),
                        child: Center(
                          child: Column(
                            children: [
                              Icon(Icons.water_drop_outlined,
                                  color: AppColors.getTextTertiary(brightness), size: 48),
                              const SizedBox(height: AppTheme.spacingM),
                              Text(
                                'No water logged today',
                                style: AppTextStyles.bodyMedium(brightness).copyWith(
                                  color: AppColors.getTextTertiary(brightness),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                    else
                      ...state.todayWaterLog.map((entry) => Container(
                            margin: const EdgeInsets.only(bottom: AppTheme.spacingS),
                            padding: const EdgeInsets.all(AppTheme.spacingM),
                            decoration: BoxDecoration(
                              color: AppColors.getSurface(brightness),
                              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                              border: Border.all(color: AppColors.getBorder(brightness)),
                            ),
                            child: Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                    color: AppColors.getPrimary(brightness).withOpacity(0.1),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                  ),
                                  child: Icon(Icons.water_drop_rounded,
                                      color: AppColors.getPrimary(brightness), size: 20),
                                ),
                                const SizedBox(width: AppTheme.spacingM),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        '${entry.amount} ml',
                                        style: AppTextStyles.titleSmall(brightness),
                                      ),
                                      Text(
                                        timeFormat.format(entry.createdAt),
                                        style: AppTextStyles.bodySmall(brightness),
                                      ),
                                    ],
                                  ),
                                ),
                                IconButton(
                                  icon: Icon(Icons.delete_outline,
                                      color: AppColors.getError(brightness)),
                                  onPressed: () async {
                                    if (entry.id != null) {
                                      await ref
                                          .read(healthTrackingProvider.notifier)
                                          .removeWaterEntry(entry.id!);
                                    }
                                  },
                                ),
                              ],
                            ),
                          )),

                    const SizedBox(height: AppTheme.spacingL),

                    // Weekly Stats
                    Text('This Week', style: AppTextStyles.titleMedium(brightness)),
                    const SizedBox(height: AppTheme.spacingM),
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppColors.getSurface(brightness),
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(color: AppColors.getBorder(brightness)),
                      ),
                      child: Column(
                        children: List.generate(7, (index) {
                          final dayNames = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
                          final amount = index < state.weeklyWater.length
                              ? state.weeklyWater[index]
                              : 0;
                          final progress = amount / state.waterGoal;
                          
                          return Padding(
                            padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                            child: _buildWeekStat(
                              dayNames[index],
                              amount,
                              progress.clamp(0.0, 1.0),
                              brightness,
                            ),
                          );
                        }),
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingL),

                    // XP Info
                    Container(
                      padding: const EdgeInsets.all(AppTheme.spacingM),
                      decoration: BoxDecoration(
                        color: AppColors.getInfoBackground(brightness),
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                      child: Row(
                        children: [
                          Icon(Icons.emoji_events_rounded,
                              color: AppColors.getInfo(brightness)),
                          const SizedBox(width: AppTheme.spacingM),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('XP Rewards',
                                    style: AppTextStyles.titleSmall(brightness)),
                                Text(
                                  'Reach your daily water goal = +20 XP',
                                  style: AppTextStyles.bodySmall(brightness),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: AppTheme.spacingXL),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildQuickAddButton(int amount, String label, Brightness brightness) {
    return OutlinedButton(
      onPressed: () => _addWater(amount),
      style: OutlinedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: AppTheme.spacingM),
        side: BorderSide(color: AppColors.getPrimary(brightness)),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        ),
      ),
      child: Column(
        children: [
          Icon(Icons.water_drop_rounded, color: AppColors.getPrimary(brightness)),
          const SizedBox(height: AppTheme.spacingXS),
          Text(label, style: AppTextStyles.labelMedium(brightness)),
        ],
      ),
    );
  }

  Widget _buildWeekStat(String day, int amount, double progress, Brightness brightness) {
    final goalReached = progress >= 1.0;
    return Row(
      children: [
        SizedBox(
          width: 40,
          child: Text(day, style: AppTextStyles.labelMedium(brightness)),
        ),
        Expanded(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(4),
            child: LinearProgressIndicator(
              value: progress,
              minHeight: 8,
              backgroundColor: AppColors.getSurfaceVariant(brightness),
              valueColor: AlwaysStoppedAnimation<Color>(
                goalReached ? AppColors.getSuccess(brightness) : AppColors.getInfo(brightness),
              ),
            ),
          ),
        ),
        const SizedBox(width: AppTheme.spacingM),
        SizedBox(
          width: 60,
          child: Text(
            '${amount}ml',
            style: AppTextStyles.labelMedium(brightness),
            textAlign: TextAlign.right,
          ),
        ),
        if (goalReached)
          Padding(
            padding: const EdgeInsets.only(left: AppTheme.spacingXS),
            child: Icon(Icons.check_circle,
                color: AppColors.getSuccess(brightness), size: 16),
          ),
      ],
    );
  }
}
