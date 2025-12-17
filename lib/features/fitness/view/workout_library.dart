import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../providers/men_workout_provider.dart';
import '../../../core/theme/app_colors.dart';

/// Men's workout with YouTube video link
class MenWorkout {
  final String name;
  final String muscleGroup;
  final String difficulty;
  final int durationMinutes;
  final int caloriesBurned;
  final String youtubeUrl;
  final String description;
  final List<String> exercises;

  const MenWorkout({
    required this.name,
    required this.muscleGroup,
    required this.difficulty,
    required this.durationMinutes,
    required this.caloriesBurned,
    required this.youtubeUrl,
    required this.description,
    required this.exercises,
  });

  int get xpReward {
    int base = 10;
    if (difficulty == 'intermediate') base = 20;
    if (difficulty == 'advanced') base = 35;
    return base + (durationMinutes ~/ 5) + (caloriesBurned ~/ 50);
  }
}

/// Men's Workout Library - All workouts with YouTube tutorials
class MenWorkoutLibrary {
  static const List<MenWorkout> chestWorkouts = [
    MenWorkout(
      name: 'Chest Builder',
      muscleGroup: 'chest',
      difficulty: 'intermediate',
      durationMinutes: 30,
      caloriesBurned: 200,
      youtubeUrl: 'https://www.youtube.com/watch?v=gRVjAtPip0Y',
      description: 'Complete chest workout for mass and definition',
      exercises: ['Bench Press', 'Incline Dumbbell Press', 'Cable Flyes', 'Push-Ups'],
    ),
    MenWorkout(
      name: 'Push-Up Mastery',
      muscleGroup: 'chest',
      difficulty: 'beginner',
      durationMinutes: 20,
      caloriesBurned: 150,
      youtubeUrl: 'https://www.youtube.com/watch?v=IODxDxX7oi4',
      description: 'Master the push-up with variations',
      exercises: ['Standard Push-Ups', 'Wide Push-Ups', 'Diamond Push-Ups', 'Incline Push-Ups'],
    ),
    MenWorkout(
      name: 'Advanced Chest Blast',
      muscleGroup: 'chest',
      difficulty: 'advanced',
      durationMinutes: 45,
      caloriesBurned: 300,
      youtubeUrl: 'https://www.youtube.com/watch?v=UVbMQvMYfkg',
      description: 'High intensity chest workout for experienced lifters',
      exercises: ['Heavy Bench Press', 'Weighted Dips', 'Incline Flyes', 'Decline Press', 'Cable Crossovers'],
    ),
  ];

  static const List<MenWorkout> backWorkouts = [
    MenWorkout(
      name: 'V-Taper Back',
      muscleGroup: 'back',
      difficulty: 'intermediate',
      durationMinutes: 35,
      caloriesBurned: 250,
      youtubeUrl: 'https://www.youtube.com/watch?v=eGo4IYlbE5g',
      description: 'Build a wide, powerful back',
      exercises: ['Pull-Ups', 'Barbell Rows', 'Lat Pulldowns', 'Face Pulls'],
    ),
    MenWorkout(
      name: 'Deadlift Power',
      muscleGroup: 'back',
      difficulty: 'advanced',
      durationMinutes: 40,
      caloriesBurned: 350,
      youtubeUrl: 'https://www.youtube.com/watch?v=op9kVnSso6Q',
      description: 'Master the king of all exercises',
      exercises: ['Conventional Deadlift', 'Romanian Deadlift', 'Rack Pulls', 'Good Mornings'],
    ),
    MenWorkout(
      name: 'Back Basics',
      muscleGroup: 'back',
      difficulty: 'beginner',
      durationMinutes: 25,
      caloriesBurned: 180,
      youtubeUrl: 'https://www.youtube.com/watch?v=r4MzxtBKyNE',
      description: 'Foundation exercises for back development',
      exercises: ['Lat Pulldowns', 'Seated Rows', 'Dumbbell Rows', 'Back Extensions'],
    ),
  ];

  static const List<MenWorkout> legWorkouts = [
    MenWorkout(
      name: 'Leg Day Destroyer',
      muscleGroup: 'legs',
      difficulty: 'advanced',
      durationMinutes: 50,
      caloriesBurned: 400,
      youtubeUrl: 'https://www.youtube.com/watch?v=RjexvOAsVtI',
      description: 'Complete leg workout for size and strength',
      exercises: ['Squats', 'Leg Press', 'Romanian Deadlifts', 'Leg Curls', 'Calf Raises'],
    ),
    MenWorkout(
      name: 'Squat Fundamentals',
      muscleGroup: 'legs',
      difficulty: 'beginner',
      durationMinutes: 30,
      caloriesBurned: 220,
      youtubeUrl: 'https://www.youtube.com/watch?v=ultWZbUMPL8',
      description: 'Learn proper squat form and technique',
      exercises: ['Bodyweight Squats', 'Goblet Squats', 'Lunges', 'Wall Sits'],
    ),
    MenWorkout(
      name: 'Quad Killer',
      muscleGroup: 'legs',
      difficulty: 'intermediate',
      durationMinutes: 35,
      caloriesBurned: 280,
      youtubeUrl: 'https://www.youtube.com/watch?v=Uv_DKDl7EjA',
      description: 'Focus on quad development',
      exercises: ['Front Squats', 'Leg Extensions', 'Hack Squats', 'Walking Lunges'],
    ),
  ];

  static const List<MenWorkout> shoulderWorkouts = [
    MenWorkout(
      name: 'Boulder Shoulders',
      muscleGroup: 'shoulders',
      difficulty: 'intermediate',
      durationMinutes: 30,
      caloriesBurned: 180,
      youtubeUrl: 'https://www.youtube.com/watch?v=qEwKCR5JCog',
      description: 'Build 3D delts from all angles',
      exercises: ['Overhead Press', 'Lateral Raises', 'Front Raises', 'Face Pulls'],
    ),
    MenWorkout(
      name: 'Shoulder Strength',
      muscleGroup: 'shoulders',
      difficulty: 'advanced',
      durationMinutes: 40,
      caloriesBurned: 220,
      youtubeUrl: 'https://www.youtube.com/watch?v=B-aVuyhvLHU',
      description: 'Heavy pressing for shoulder power',
      exercises: ['Military Press', 'Push Press', 'Arnold Press', 'Upright Rows'],
    ),
    MenWorkout(
      name: 'Shoulder Basics',
      muscleGroup: 'shoulders',
      difficulty: 'beginner',
      durationMinutes: 20,
      caloriesBurned: 120,
      youtubeUrl: 'https://www.youtube.com/watch?v=2yjwXTZQDDI',
      description: 'Introduction to shoulder training',
      exercises: ['Dumbbell Press', 'Lateral Raises', 'Rear Delt Flyes'],
    ),
  ];

  static const List<MenWorkout> armWorkouts = [
    MenWorkout(
      name: 'Arm Blaster',
      muscleGroup: 'arms',
      difficulty: 'intermediate',
      durationMinutes: 35,
      caloriesBurned: 180,
      youtubeUrl: 'https://www.youtube.com/watch?v=UelQpJmGXPQ',
      description: 'Complete biceps and triceps workout',
      exercises: ['Barbell Curls', 'Skull Crushers', 'Hammer Curls', 'Tricep Pushdowns'],
    ),
    MenWorkout(
      name: 'Bicep Peak',
      muscleGroup: 'arms',
      difficulty: 'intermediate',
      durationMinutes: 25,
      caloriesBurned: 140,
      youtubeUrl: 'https://www.youtube.com/watch?v=ykJmrZ5v0Oo',
      description: 'Focus on bicep development',
      exercises: ['Concentration Curls', 'Preacher Curls', 'Incline Curls', 'Cable Curls'],
    ),
    MenWorkout(
      name: 'Tricep Horseshoe',
      muscleGroup: 'arms',
      difficulty: 'intermediate',
      durationMinutes: 25,
      caloriesBurned: 140,
      youtubeUrl: 'https://www.youtube.com/watch?v=2-LAMcpzODU',
      description: 'Build massive triceps',
      exercises: ['Close-Grip Bench', 'Overhead Extensions', 'Dips', 'Rope Pushdowns'],
    ),
  ];

  static const List<MenWorkout> absWorkouts = [
    MenWorkout(
      name: '6-Pack Abs',
      muscleGroup: 'abs',
      difficulty: 'intermediate',
      durationMinutes: 20,
      caloriesBurned: 150,
      youtubeUrl: 'https://www.youtube.com/watch?v=DHD1-2P94DI',
      description: 'Complete core workout for defined abs',
      exercises: ['Crunches', 'Leg Raises', 'Planks', 'Russian Twists'],
    ),
    MenWorkout(
      name: 'Core Strength',
      muscleGroup: 'abs',
      difficulty: 'beginner',
      durationMinutes: 15,
      caloriesBurned: 100,
      youtubeUrl: 'https://www.youtube.com/watch?v=AnYl6Nk9GOA',
      description: 'Build a strong foundation',
      exercises: ['Dead Bugs', 'Bird Dogs', 'Planks', 'Mountain Climbers'],
    ),
    MenWorkout(
      name: 'Advanced Core',
      muscleGroup: 'abs',
      difficulty: 'advanced',
      durationMinutes: 25,
      caloriesBurned: 180,
      youtubeUrl: 'https://www.youtube.com/watch?v=9VsDP584zyQ',
      description: 'Challenging core exercises',
      exercises: ['Hanging Leg Raises', 'Ab Wheel Rollouts', 'Dragon Flags', 'L-Sits'],
    ),
  ];

  static List<MenWorkout> getByMuscleGroup(String group) {
    switch (group.toLowerCase()) {
      case 'chest': return chestWorkouts;
      case 'back': return backWorkouts;
      case 'legs': return legWorkouts;
      case 'shoulders': return shoulderWorkouts;
      case 'arms': return armWorkouts;
      case 'abs': return absWorkouts;
      default: return [];
    }
  }

  static List<MenWorkout> get allWorkouts => [
    ...chestWorkouts,
    ...backWorkouts,
    ...legWorkouts,
    ...shoulderWorkouts,
    ...armWorkouts,
    ...absWorkouts,
  ];
}

class WorkoutLibrary extends ConsumerStatefulWidget {
  const WorkoutLibrary({super.key});

  @override
  ConsumerState<WorkoutLibrary> createState() => _WorkoutLibraryState();
}

class _WorkoutLibraryState extends ConsumerState<WorkoutLibrary> with SingleTickerProviderStateMixin {
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
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.background,
      appBar: AppBar(
        title: const Text("Men's Workouts", style: TextStyle(fontWeight: FontWeight.bold)),
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
          final workouts = group == 'All'
              ? MenWorkoutLibrary.allWorkouts
              : MenWorkoutLibrary.getByMuscleGroup(group);
          return _buildWorkoutList(workouts, isDark);
        }).toList(),
      ),
    );
  }

  Widget _buildWorkoutList(List<MenWorkout> workouts, bool isDark) {
    if (workouts.isEmpty) {
      return const Center(child: Text('No workouts available'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: workouts.length,
      itemBuilder: (context, index) {
        final workout = workouts[index];
        return _WorkoutCard(
          workout: workout,
          isDark: isDark,
          onAdd: () async {
            await ref.read(menWorkoutProvider.notifier).addCustomWorkout(
              name: workout.name,
              muscleGroup: workout.muscleGroup,
              difficulty: workout.difficulty,
              durationMinutes: workout.durationMinutes,
              caloriesBurned: workout.caloriesBurned.toDouble(),
            );
            if (mounted) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('${workout.name} added to today\'s workouts'),
                  backgroundColor: AppColors.primary,
                ),
              );
            }
          },
          onWatch: () async {
            final uri = Uri.parse(workout.youtubeUrl);
            if (await canLaunchUrl(uri)) {
              await launchUrl(uri, mode: LaunchMode.externalApplication);
            }
          },
        );
      },
    );
  }
}

class _WorkoutCard extends StatelessWidget {
  final MenWorkout workout;
  final bool isDark;
  final VoidCallback onAdd;
  final VoidCallback onWatch;

  const _WorkoutCard({
    required this.workout,
    required this.isDark,
    required this.onAdd,
    required this.onWatch,
  });

  Color _getDifficultyColor(String difficulty) {
    switch (difficulty.toLowerCase()) {
      case 'beginner': return Colors.green;
      case 'intermediate': return Colors.orange;
      case 'advanced': return Colors.red;
      default: return Colors.grey;
    }
  }

  IconData _getMuscleIcon(String muscle) {
    switch (muscle.toLowerCase()) {
      case 'chest': return Icons.fitness_center;
      case 'back': return Icons.accessibility_new;
      case 'legs': return Icons.directions_run;
      case 'shoulders': return Icons.sports_gymnastics;
      case 'arms': return Icons.sports_martial_arts;
      case 'abs': return Icons.self_improvement;
      default: return Icons.fitness_center;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: isDark ? AppColors.cardDark : Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  width: 56,
                  height: 56,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(_getMuscleIcon(workout.muscleGroup), color: AppColors.primary, size: 28),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout.name,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: isDark ? Colors.white : Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        workout.description,
                        style: TextStyle(fontSize: 12, color: Colors.grey[500]),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            
            // Stats row
            Row(
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: _getDifficultyColor(workout.difficulty).withOpacity(0.2),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Text(
                    workout.difficulty.toUpperCase(),
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.bold,
                      color: _getDifficultyColor(workout.difficulty),
                    ),
                  ),
                ),
                const SizedBox(width: 8),
                Icon(Icons.timer, size: 14, color: Colors.grey[500]),
                const SizedBox(width: 4),
                Text('${workout.durationMinutes} min', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(width: 8),
                Icon(Icons.local_fire_department, size: 14, color: Colors.orange[400]),
                const SizedBox(width: 4),
                Text('${workout.caloriesBurned} cal', style: TextStyle(fontSize: 12, color: Colors.grey[500])),
                const SizedBox(width: 8),
                Icon(Icons.star, size: 14, color: Colors.amber),
                const SizedBox(width: 4),
                Text('+${workout.xpReward} XP', style: TextStyle(fontSize: 12, color: Colors.amber[700], fontWeight: FontWeight.bold)),
              ],
            ),
            
            const SizedBox(height: 12),
            
            // Exercises preview
            Wrap(
              spacing: 6,
              runSpacing: 6,
              children: workout.exercises.take(4).map((e) => Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: isDark ? AppColors.surfaceVariantDark : Colors.grey[100],
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(e, style: TextStyle(fontSize: 10, color: isDark ? Colors.grey[400] : Colors.grey[700])),
              )).toList(),
            ),
            
            const SizedBox(height: 16),
            
            // Action buttons
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: onWatch,
                    icon: const Icon(Icons.play_circle_outline, size: 18),
                    label: const Text('Watch Tutorial'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: Colors.red,
                      side: const BorderSide(color: Colors.red),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton.icon(
                    onPressed: onAdd,
                    icon: const Icon(Icons.add, size: 18),
                    label: const Text('Add to Today'),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
