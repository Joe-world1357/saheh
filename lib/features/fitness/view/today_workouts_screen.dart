import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/activity_model.dart';
import '../../../providers/men_workout_provider.dart';
import '../../../core/theme/app_colors.dart';

class TodayWorkoutsScreen extends ConsumerWidget {
  const TodayWorkoutsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final workoutState = ref.watch(menWorkoutProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Today\'s Workouts', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      ),
      body: workoutState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : workoutState.todayWorkouts.isEmpty
              ? _buildEmptyState(isDark)
              : _buildWorkoutList(context, ref, workoutState, isDark),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.fitness_center, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'No workouts scheduled for today',
            style: TextStyle(fontSize: 18, color: Colors.grey[600]),
          ),
          const SizedBox(height: 8),
          Text(
            'Add workouts from the workout library',
            style: TextStyle(fontSize: 14, color: Colors.grey[500]),
          ),
        ],
      ),
    );
  }

  Widget _buildWorkoutList(BuildContext context, WidgetRef ref, MenWorkoutState state, bool isDark) {
    return Column(
      children: [
        // Stats header
        Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _StatItem(
                icon: Icons.check_circle,
                value: '${state.completedToday}',
                label: 'Completed',
              ),
              _StatItem(
                icon: Icons.pending,
                value: '${state.pendingToday}',
                label: 'Pending',
              ),
              _StatItem(
                icon: Icons.timer,
                value: '${state.todayMinutes}',
                label: 'Minutes',
              ),
              _StatItem(
                icon: Icons.local_fire_department,
                value: '${state.todayCalories.toInt()}',
                label: 'Calories',
              ),
            ],
          ),
        ),
        // Workout list
        Expanded(
          child: ListView.builder(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            itemCount: state.todayWorkouts.length,
            itemBuilder: (context, index) {
              final workout = state.todayWorkouts[index];
              return _TodayWorkoutCard(
                workout: workout,
                isDark: isDark,
                onComplete: () async {
                  if (!workout.isCompleted) {
                    await ref.read(menWorkoutProvider.notifier).completeWorkout(workout);
                    if (context.mounted) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text('${workout.name} completed! +${workout.calculateXP()} XP'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    }
                  }
                },
                onDelete: () async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: const Text('Delete Workout?'),
                      content: Text('Remove ${workout.name} from today\'s workouts?'),
                      actions: [
                        TextButton(onPressed: () => Navigator.pop(context, false), child: const Text('Cancel')),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: const Text('Delete', style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );
                  if (confirm == true && workout.id != null) {
                    await ref.read(menWorkoutProvider.notifier).deleteWorkout(workout.id!);
                  }
                },
              );
            },
          ),
        ),
      ],
    );
  }
}

class _StatItem extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _StatItem({required this.icon, required this.value, required this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
      ],
    );
  }
}

class _TodayWorkoutCard extends StatelessWidget {
  final MenWorkoutModel workout;
  final bool isDark;
  final VoidCallback onComplete;
  final VoidCallback onDelete;

  const _TodayWorkoutCard({
    required this.workout,
    required this.isDark,
    required this.onComplete,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isDark ? AppColors.cardDark : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: ListTile(
        contentPadding: const EdgeInsets.all(16),
        leading: Container(
          width: 50,
          height: 50,
          decoration: BoxDecoration(
            color: workout.isCompleted ? Colors.green.withOpacity(0.2) : AppColors.primary.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(
            workout.isCompleted ? Icons.check : Icons.fitness_center,
            color: workout.isCompleted ? Colors.green : AppColors.primary,
          ),
        ),
        title: Text(
          workout.name,
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: isDark ? Colors.white : Colors.black,
            decoration: workout.isCompleted ? TextDecoration.lineThrough : null,
          ),
        ),
        subtitle: Row(
          children: [
            Text('${workout.muscleGroup.toUpperCase()} • ${workout.durationMinutes} min • ${workout.caloriesBurned.toInt()} cal'),
            if (workout.isCompleted) ...[
              const SizedBox(width: 8),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                decoration: BoxDecoration(
                  color: Colors.green.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text('+${workout.calculateXP()} XP', style: const TextStyle(color: Colors.green, fontSize: 10, fontWeight: FontWeight.bold)),
              ),
            ],
          ],
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (!workout.isCompleted)
              IconButton(
                onPressed: onComplete,
                icon: const Icon(Icons.check_circle_outline, color: Colors.green, size: 28),
              ),
            IconButton(
              onPressed: onDelete,
              icon: Icon(Icons.delete_outline, color: Colors.red[400], size: 24),
            ),
          ],
        ),
      ),
    );
  }
}

