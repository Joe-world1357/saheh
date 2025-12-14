import 'package:flutter/material.dart';

class AchievementsScreen extends StatefulWidget {
  const AchievementsScreen({super.key});

  @override
  State<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends State<AchievementsScreen> {
  final List<Map<String, dynamic>> _achievements = [
    {
      'title': 'First Steps',
      'description': 'Complete your first workout',
      'icon': Icons.directions_walk,
      'color': const Color(0xFF4CAF50),
      'unlocked': true,
      'xp': 50,
    },
    {
      'title': 'Week Warrior',
      'description': 'Complete 7 workouts in a week',
      'icon': Icons.fitness_center,
      'color': const Color(0xFF2196F3),
      'unlocked': true,
      'xp': 200,
    },
    {
      'title': 'Hydration Hero',
      'description': 'Drink 2L of water for 7 days',
      'icon': Icons.water_drop,
      'color': const Color(0xFF2196F3),
      'unlocked': true,
      'xp': 150,
    },
    {
      'title': 'Early Bird',
      'description': 'Complete 10 morning workouts',
      'icon': Icons.wb_sunny,
      'color': const Color(0xFFFFC107),
      'unlocked': false,
      'xp': 100,
    },
    {
      'title': 'Sleep Master',
      'description': 'Get 8 hours of sleep for 30 days',
      'icon': Icons.bedtime,
      'color': const Color(0xFF6C5CE7),
      'unlocked': false,
      'xp': 300,
    },
    {
      'title': 'Nutrition Pro',
      'description': 'Log meals for 30 days',
      'icon': Icons.restaurant,
      'color': const Color(0xFFE91E63),
      'unlocked': false,
      'xp': 250,
    },
  ];

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);
    final unlockedCount = _achievements.where((a) => a['unlocked'] as bool).length;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF1A2A2C),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Achievements",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // PROGRESS CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    const Text(
                      "Achievement Progress",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      '$unlockedCount / ${_achievements.length}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 36,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: unlockedCount / _achievements.length,
                        minHeight: 8,
                        backgroundColor: Colors.white.withOpacity(0.3),
                        valueColor: const AlwaysStoppedAnimation<Color>(Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: GridView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 12,
                  mainAxisSpacing: 12,
                  childAspectRatio: 0.9,
                ),
                itemCount: _achievements.length,
                itemBuilder: (context, index) {
                  final achievement = _achievements[index];
                  final isUnlocked = achievement['unlocked'] as bool;
                  return Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: isUnlocked
                            ? (achievement['color'] as Color).withOpacity(0.3)
                            : Colors.grey.shade200,
                        width: isUnlocked ? 2 : 1,
                      ),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: isUnlocked
                                ? (achievement['color'] as Color).withOpacity(0.1)
                                : Colors.grey.shade100,
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            achievement['icon'] as IconData,
                            color: isUnlocked
                                ? achievement['color'] as Color
                                : Colors.grey.shade400,
                            size: 32,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          achievement['title'] as String,
                          style: TextStyle(
                            color: isUnlocked
                                ? const Color(0xFF1A2A2C)
                                : Colors.grey.shade600,
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          achievement['description'] as String,
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 11,
                          ),
                          textAlign: TextAlign.center,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 8),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.star,
                              size: 14,
                              color: isUnlocked
                                  ? const Color(0xFFFFC107)
                                  : Colors.grey.shade400,
                            ),
                            const SizedBox(width: 4),
                            Text(
                              '${achievement['xp']} XP',
                              style: TextStyle(
                                color: isUnlocked
                                    ? const Color(0xFFFFC107)
                                    : Colors.grey.shade400,
                                fontSize: 12,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

