import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/activity_provider.dart';
import '../../../core/theme/app_colors.dart';

class ActivityTrackerScreen extends ConsumerStatefulWidget {
  const ActivityTrackerScreen({super.key});

  @override
  ConsumerState<ActivityTrackerScreen> createState() => _ActivityTrackerScreenState();
}

class _ActivityTrackerScreenState extends ConsumerState<ActivityTrackerScreen> {
  @override
  Widget build(BuildContext context) {
    final activityState = ref.watch(activityProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final today = activityState.todayActivity;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text('Activity Tracker', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () => ref.read(activityProvider.notifier).refresh(),
          ),
        ],
      ),
      body: activityState.isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Today's Summary Card
                  _buildTodaySummary(today, isDark),
                  const SizedBox(height: 24),

                  // Quick Actions
                  Text(
                    'Log Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildQuickActions(isDark),
                  const SizedBox(height: 24),

                  // Weekly Stats
                  Text(
                    'Weekly Stats',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildWeeklyStats(activityState.stats, isDark),
                  const SizedBox(height: 24),

                  // History
                  Text(
                    'Recent Activity',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 12),
                  _buildHistory(activityState.history, isDark),
                ],
              ),
            ),
    );
  }

  Widget _buildTodaySummary(dynamic today, bool isDark) {
    final steps = today?.steps ?? 0;
    final activeMinutes = today?.activeMinutes ?? 0;
    final calories = today?.caloriesBurned ?? 0.0;
    final workoutMinutes = today?.workoutMinutes ?? 0;

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [AppColors.primary, AppColors.primary.withOpacity(0.7)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.3),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Today\'s Activity',
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              _ActivityStat(icon: Icons.directions_walk, value: '$steps', label: 'Steps', goal: '10,000'),
              _ActivityStat(icon: Icons.timer, value: '$activeMinutes', label: 'Active Min', goal: '30'),
              _ActivityStat(icon: Icons.local_fire_department, value: '${calories.toInt()}', label: 'Calories'),
              _ActivityStat(icon: Icons.fitness_center, value: '$workoutMinutes', label: 'Workout'),
            ],
          ),
          const SizedBox(height: 16),
          // Steps progress bar
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text('Steps Goal', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                  Text('$steps / 10,000', style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 12)),
                ],
              ),
              const SizedBox(height: 6),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: LinearProgressIndicator(
                  value: (steps / 10000).clamp(0.0, 1.0),
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                  minHeight: 8,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildQuickActions(bool isDark) {
    return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.5,
      children: [
        _QuickActionCard(
          icon: Icons.directions_walk,
          title: 'Add Steps',
          color: Colors.blue,
          isDark: isDark,
          onTap: () => _showAddDialog('Steps', (v) => ref.read(activityProvider.notifier).addSteps(v.toInt())),
        ),
        _QuickActionCard(
          icon: Icons.timer,
          title: 'Active Minutes',
          color: Colors.green,
          isDark: isDark,
          onTap: () => _showAddDialog('Active Minutes', (v) => ref.read(activityProvider.notifier).addActiveMinutes(v.toInt())),
        ),
        _QuickActionCard(
          icon: Icons.local_fire_department,
          title: 'Calories',
          color: Colors.orange,
          isDark: isDark,
          onTap: () => _showAddDialog('Calories', (v) => ref.read(activityProvider.notifier).addCaloriesBurned(v)),
        ),
        _QuickActionCard(
          icon: Icons.fitness_center,
          title: 'Workout',
          color: AppColors.primary,
          isDark: isDark,
          onTap: () => Navigator.pushNamed(context, '/men-workouts'),
        ),
      ],
    );
  }

  void _showAddDialog(String title, Function(double) onAdd) {
    final controller = TextEditingController();
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Add $title'),
        content: TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          decoration: InputDecoration(
            hintText: 'Enter $title',
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
          ),
        ),
        actions: [
          TextButton(onPressed: () => Navigator.pop(context), child: const Text('Cancel')),
          ElevatedButton(
            onPressed: () {
              final value = double.tryParse(controller.text) ?? 0;
              if (value > 0) {
                onAdd(value);
                Navigator.pop(context);
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
            child: const Text('Add', style: TextStyle(color: Colors.white)),
          ),
        ],
      ),
    );
  }

  Widget _buildWeeklyStats(Map<String, dynamic> stats, bool isDark) {
    final weekly = stats['weekly'] as Map<String, dynamic>? ?? {};
    
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: isDark ? AppColors.cardDark : Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _WeeklyStat(
            icon: Icons.directions_walk,
            value: '${weekly['total_steps'] ?? 0}',
            label: 'Steps',
            color: Colors.blue,
            isDark: isDark,
          ),
          _WeeklyStat(
            icon: Icons.timer,
            value: '${weekly['total_active_minutes'] ?? 0}',
            label: 'Minutes',
            color: Colors.green,
            isDark: isDark,
          ),
          _WeeklyStat(
            icon: Icons.local_fire_department,
            value: '${((weekly['total_calories'] ?? 0) as num).toInt()}',
            label: 'Calories',
            color: Colors.orange,
            isDark: isDark,
          ),
          _WeeklyStat(
            icon: Icons.fitness_center,
            value: '${weekly['total_workout_minutes'] ?? 0}',
            label: 'Workout',
            color: AppColors.primary,
            isDark: isDark,
          ),
        ],
      ),
    );
  }

  Widget _buildHistory(List<dynamic> history, bool isDark) {
    if (history.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(32),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Center(
          child: Text(
            'No activity history yet',
            style: TextStyle(color: Colors.grey[500]),
          ),
        ),
      );
    }

    return Column(
      children: history.take(7).map((activity) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8),
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: isDark ? AppColors.cardDark : Colors.white,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.calendar_today, color: AppColors.primary, size: 20),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      _formatDate(activity.date),
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: isDark ? Colors.white : Colors.black,
                      ),
                    ),
                    Text(
                      '${activity.steps} steps • ${activity.activeMinutes} min • ${activity.caloriesBurned.toInt()} cal',
                      style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                    ),
                  ],
                ),
              ),
              Text(
                '+${activity.calculateXP()} XP',
                style: const TextStyle(color: AppColors.primary, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final dateOnly = DateTime(date.year, date.month, date.day);
    
    if (dateOnly == today) return 'Today';
    if (dateOnly == today.subtract(const Duration(days: 1))) return 'Yesterday';
    return '${date.day}/${date.month}/${date.year}';
  }
}

class _ActivityStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final String? goal;

  const _ActivityStat({
    required this.icon,
    required this.value,
    required this.label,
    this.goal,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: Colors.white, size: 24),
        const SizedBox(height: 4),
        Text(value, style: const TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold)),
        Text(label, style: TextStyle(color: Colors.white.withOpacity(0.8), fontSize: 11)),
      ],
    );
  }
}

class _QuickActionCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final Color color;
  final bool isDark;
  final VoidCallback onTap;

  const _QuickActionCard({
    required this.icon,
    required this.title,
    required this.color,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: isDark ? AppColors.cardDark : Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.05),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: TextStyle(
                fontWeight: FontWeight.w600,
                color: isDark ? Colors.white : Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _WeeklyStat extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final bool isDark;

  const _WeeklyStat({
    required this.icon,
    required this.value,
    required this.label,
    required this.color,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 20),
        const SizedBox(height: 4),
        Text(value, style: TextStyle(fontWeight: FontWeight.bold, color: isDark ? Colors.white : Colors.black)),
        Text(label, style: TextStyle(fontSize: 10, color: Colors.grey[500])),
      ],
    );
  }
}

