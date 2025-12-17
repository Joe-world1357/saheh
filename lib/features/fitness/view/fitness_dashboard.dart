import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'workout_library.dart';
import 'activity_tracker_screen.dart';
import 'today_workouts_screen.dart';
import 'xp_system.dart' show XPSystem;
import '../../../providers/activity_provider.dart';
import '../../../providers/men_workout_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';

class FitnessDashboard extends ConsumerWidget {
  const FitnessDashboard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activityState = ref.watch(activityProvider);
    final workoutState = ref.watch(menWorkoutProvider);
    final authState = ref.watch(authProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    
    final user = authState.user;
    final todayActivity = activityState.todayActivity;
    
    // Real data from providers
    final steps = todayActivity?.steps ?? 0;
    final calories = todayActivity?.caloriesBurned.toInt() ?? 0;
    final activeMinutes = todayActivity?.activeMinutes ?? 0;
    final userXP = user?.xp ?? 0;
    final userLevel = user?.level ?? 1;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            await ref.read(activityProvider.notifier).refresh();
            await ref.read(menWorkoutProvider.notifier).refresh();
          },
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 10),

                // TOP BAR
                Row(
                  children: [
                    Text(
                      "Fitness",
                      style: TextStyle(
                        color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    // XP Badge
                    GestureDetector(
                      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const XPSystem())),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                            colors: [AppColors.primary, AppColors.primaryDark],
                          ),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Row(
                          children: [
                            const Icon(Icons.star, color: Colors.amber, size: 18),
                            const SizedBox(width: 4),
                            Text(
                              'Lv.$userLevel • $userXP XP',
                              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 12),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // TODAY'S WORKOUT PLAN - Real Data
                Text(
                  "Today's Workouts",
                  style: TextStyle(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                _buildTodayWorkoutCard(context, workoutState, isDark),

                const SizedBox(height: 25),

                // QUICK ACTIONS
                Row(
                  children: [
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.track_changes,
                        label: "Activity Tracker",
                        color: AppColors.success,
                        isDark: isDark,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const ActivityTrackerScreen())),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: _QuickActionCard(
                        icon: Icons.fitness_center,
                        label: "Workouts",
                        color: AppColors.warning,
                        isDark: isDark,
                        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkoutLibrary())),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 25),

                // FITNESS GOALS - Real Data
                Text(
                  "Today's Goals",
                  style: TextStyle(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 12),

                _GoalCard(
                  icon: Icons.directions_walk,
                  title: "Steps",
                  current: steps,
                  goal: 10000,
                  unit: "",
                  color: AppColors.info,
                  isDark: isDark,
                ),
                const SizedBox(height: 12),

                _GoalCard(
                  icon: Icons.local_fire_department,
                  title: "Calories Burned",
                  current: calories,
                  goal: 500,
                  unit: "kcal",
                  color: AppColors.error,
                  isDark: isDark,
                ),
                const SizedBox(height: 12),

                _GoalCard(
                  icon: Icons.timer,
                  title: "Active Minutes",
                  current: activeMinutes,
                  goal: 30,
                  unit: "min",
                  color: AppColors.success,
                  isDark: isDark,
                ),
                const SizedBox(height: 12),

                _GoalCard(
                  icon: Icons.fitness_center,
                  title: "Workouts Completed",
                  current: workoutState.completedToday,
                  goal: workoutState.todayWorkouts.isEmpty ? 3 : workoutState.todayWorkouts.length,
                  unit: "",
                  color: AppColors.primary,
                  isDark: isDark,
                ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTodayWorkoutCard(BuildContext context, MenWorkoutState state, bool isDark) {
    if (state.todayWorkouts.isEmpty) {
      return GestureDetector(
        onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const WorkoutLibrary())),
        child: Container(
          padding: const EdgeInsets.all(24),
          decoration: BoxDecoration(
            color: isDark ? AppColors.surfaceDark : Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
          ),
          child: Column(
            children: [
              Icon(Icons.add_circle_outline, size: 48, color: AppColors.primary),
              const SizedBox(height: 12),
              Text(
                'No workouts scheduled',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                'Tap to add workouts from the library',
                style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
              ),
            ],
          ),
        ),
      );
    }

    final completed = state.completedToday;
    final total = state.todayWorkouts.length;
    final progress = total > 0 ? completed / total : 0.0;

    return GestureDetector(
      onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const TodayWorkoutsScreen())),
      child: Container(
        padding: const EdgeInsets.all(18),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: AppColors.primary.withOpacity(0.3)),
        ),
        child: Column(
          children: [
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.all(14),
                  decoration: BoxDecoration(
                    color: AppColors.success.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(14),
                  ),
                  child: Icon(Icons.fitness_center, color: AppColors.success, size: 30),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        '$total Workouts Today',
                        style: TextStyle(
                          color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '${state.todayMinutes} min • ${state.todayCalories.toInt()} cal burned',
                        style: TextStyle(
                          color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                Icon(Icons.chevron_right, color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('Progress', style: TextStyle(color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary, fontSize: 12)),
                Text(
                  '$completed/$total completed',
                  style: TextStyle(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),
            ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: LinearProgressIndicator(
                value: progress,
                minHeight: 8,
                backgroundColor: isDark ? AppColors.surfaceVariantDark : Colors.grey.shade200,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.success),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: isDark ? AppColors.borderDark : AppColors.border),
        ),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: color.withOpacity(0.15),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 28),
            ),
            const SizedBox(height: 10),
            Text(
              label,
              style: TextStyle(
                color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                fontWeight: FontWeight.w600,
                fontSize: 13,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}

class _GoalCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final int current;
  final int goal;
  final String unit;
  final Color color;
  final bool isDark;

  const _GoalCard({
    required this.icon,
    required this.title,
    required this.current,
    required this.goal,
    required this.unit,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final progress = (current / goal).clamp(0.0, 1.0);
    final isCompleted = current >= goal;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: isCompleted ? color.withOpacity(0.5) : (isDark ? AppColors.borderDark : AppColors.border),
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: color.withOpacity(0.15),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(icon, color: color, size: 24),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: isDark ? AppColors.textSecondaryDark : AppColors.textSecondary,
                        fontSize: 13,
                      ),
                    ),
                    if (isCompleted)
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: color.withOpacity(0.2),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text('✓ Done', style: TextStyle(color: color, fontSize: 10, fontWeight: FontWeight.bold)),
                      ),
                  ],
                ),
                const SizedBox(height: 4),
                Text(
                  '$current / $goal $unit',
                  style: TextStyle(
                    color: isDark ? AppColors.textPrimaryDark : AppColors.textPrimary,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                ClipRRect(
                  borderRadius: BorderRadius.circular(6),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 6,
                    backgroundColor: isDark ? AppColors.surfaceVariantDark : Colors.grey.shade200,
                    valueColor: AlwaysStoppedAnimation<Color>(color),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
