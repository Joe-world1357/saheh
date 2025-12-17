import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../models/activity_model.dart';
import '../../../providers/men_workout_provider.dart';
import '../../../core/theme/app_colors.dart';

class MenWorkoutsScreen extends ConsumerStatefulWidget {
  const MenWorkoutsScreen({super.key});

  @override
  ConsumerState<MenWorkoutsScreen> createState() => _MenWorkoutsScreenState();
}

class _MenWorkoutsScreenState extends ConsumerState<MenWorkoutsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  final List<String> _muscleGroups = ['All', 'Chest', 'Back', 'Legs', 'Shoulders', 'Arms', 'Abs'];

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: _muscleGroups.length, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final workoutState = ref.watch(menWorkoutProvider);
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: AppColors.getBackground(Theme.of(context).brightness),
      appBar: AppBar(
        title: const Text('Men\'s Workouts', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
        bottom: TabBar(
          controller: _tabController,
          isScrollable: true,
          labelColor: AppColors.primary,
          unselectedLabelColor: isDark ? Colors.grey[400] : Colors.grey[600],
          indicatorColor: AppColors.primary,
          tabs: _muscleGroups.map((g) => Tab(text: g)).toList(),
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: _muscleGroups.map((group) {
          final templates = group == 'All'
              ? MenWorkoutTemplates.all
              : MenWorkoutTemplates.getByMuscleGroup(group.toLowerCase());
          return _buildWorkoutList(templates, workoutState, isDark);
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () => _showAddCustomWorkout(context, isDark),
        backgroundColor: AppColors.primary,
        icon: const Icon(Icons.add, color: Colors.white),
        label: const Text('Custom', style: TextStyle(color: Colors.white)),
      ),
    );
  }

  Widget _buildWorkoutList(List<Map<String, dynamic>> templates, MenWorkoutState state, bool isDark) {
    if (templates.isEmpty) {
      return const Center(child: Text('No workouts in this category'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: templates.length,
      itemBuilder: (context, index) {
        final template = templates[index];
        return _WorkoutCard(
          template: template,
          isDark: isDark,
          onAdd: () async {
            await ref.read(menWorkoutProvider.notifier).addWorkoutFromTemplate(template);
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${template['name']} added to today\'s workouts'),
                  backgroundColor: AppColors.primary,
                ),
              );
            }
          },
        );
      },
    );
  }

  void _showAddCustomWorkout(BuildContext context, bool isDark) {
    final nameController = TextEditingController();
    final durationController = TextEditingController();
    final caloriesController = TextEditingController();
    String selectedMuscle = 'chest';
    String selectedDifficulty = 'intermediate';

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: isDark ? AppColors.surfaceDark : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => StatefulBuilder(
        builder: (context, setState) => Padding(
          padding: EdgeInsets.only(
            left: 20,
            right: 20,
            top: 20,
            bottom: MediaQuery.of(context).viewInsets.bottom + 20,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Add Custom Workout',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black,
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                controller: nameController,
                decoration: InputDecoration(
                  labelText: 'Workout Name',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedMuscle,
                decoration: InputDecoration(
                  labelText: 'Muscle Group',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: ['chest', 'back', 'legs', 'shoulders', 'arms', 'abs']
                    .map((m) => DropdownMenuItem(value: m, child: Text(m.toUpperCase())))
                    .toList(),
                onChanged: (v) => setState(() => selectedMuscle = v!),
              ),
              const SizedBox(height: 12),
              DropdownButtonFormField<String>(
                value: selectedDifficulty,
                decoration: InputDecoration(
                  labelText: 'Difficulty',
                  border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                ),
                items: ['beginner', 'intermediate', 'advanced']
                    .map((d) => DropdownMenuItem(value: d, child: Text(d.toUpperCase())))
                    .toList(),
                onChanged: (v) => setState(() => selectedDifficulty = v!),
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: durationController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Duration (min)',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: TextField(
                      controller: caloriesController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        labelText: 'Calories',
                        border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    if (nameController.text.isEmpty) return;
                    await ref.read(menWorkoutProvider.notifier).addCustomWorkout(
                      name: nameController.text,
                      muscleGroup: selectedMuscle,
                      difficulty: selectedDifficulty,
                      durationMinutes: int.tryParse(durationController.text) ?? 20,
                      caloriesBurned: double.tryParse(caloriesController.text) ?? 100,
                    );
                    if (mounted) Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                  ),
                  child: const Text('Add Workout', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final Map<String, dynamic> template;
  final bool isDark;
  final VoidCallback onAdd;

  const _WorkoutCard({
    required this.template,
    required this.isDark,
    required this.onAdd,
  });

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner':
        return Colors.green;
      case 'intermediate':
        return Colors.orange;
      case 'advanced':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getMuscleIcon(String muscle) {
    switch (muscle.toLowerCase()) {
      case 'chest':
        return Icons.fitness_center;
      case 'back':
        return Icons.accessibility_new;
      case 'legs':
        return Icons.directions_run;
      case 'shoulders':
        return Icons.sports_gymnastics;
      case 'arms':
        return Icons.sports_martial_arts;
      case 'abs':
        return Icons.self_improvement;
      default:
        return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      color: isDark ? AppColors.cardDark : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.primary.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(_getMuscleIcon(template['muscleGroup']), color: AppColors.primary, size: 28),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    template['name'],
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        decoration: BoxDecoration(
                          color: _getDifficultyColor(template['difficulty']).withOpacity(0.2),
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          template['difficulty'].toString().toUpperCase(),
                          style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.bold,
                            color: _getDifficultyColor(template['difficulty']),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(Icons.timer, size: 14, color: Colors.grey[500]),
                      const SizedBox(width: 4),
                      Text('${template['duration']} min', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                      const SizedBox(width: 8),
                      Icon(Icons.local_fire_department, size: 14, color: Colors.orange[400]),
                      const SizedBox(width: 4),
                      Text('${template['calories']} cal', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                    ],
                  ),
                ],
              ),
            ),
            IconButton(
              onPressed: onAdd,
              icon: const Icon(Icons.add_circle, color: AppColors.primary, size: 32),
            ),
          ],
        ),
      ),
    );
  }
}

