import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../shared/widgets/card_widgets.dart';

class XPSystem extends ConsumerWidget {
  const XPSystem({super.key});

  /// Get level title based on level number
  String _getLevelTitle(int level) {
    if (level <= 5) return 'Beginner';
    if (level <= 10) return 'Explorer';
    if (level <= 20) return 'Achiever';
    if (level <= 35) return 'Champion';
    if (level <= 50) return 'Master';
    if (level <= 75) return 'Legend';
    return 'Elite';
  }

  /// Calculate XP needed for a specific level
  int _xpForLevel(int level) {
    return level * 100;
  }

  /// Get XP progress within current level
  Map<String, int> _getXpProgress(int totalXp, int level) {
    final xpForCurrentLevel = _xpForLevel(level - 1);
    final xpForNextLevel = _xpForLevel(level);
    final currentLevelXp = totalXp - xpForCurrentLevel;
    final xpNeeded = xpForNextLevel - xpForCurrentLevel;
    final xpToNext = xpForNextLevel - totalXp;
    
    return {
      'current': currentLevelXp,
      'needed': xpNeeded,
      'toNext': xpToNext > 0 ? xpToNext : 0,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primary = Color(0xFF20C6B7);
    
    // Get real user data
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final userXP = user?.xp ?? 0;
    final userLevel = user?.level ?? 1;
    final levelTitle = _getLevelTitle(userLevel);
    final xpProgress = _getXpProgress(userXP, userLevel);
    final progressPercent = xpProgress['needed']! > 0 
        ? xpProgress['current']! / xpProgress['needed']! 
        : 1.0;

    // Sample recent activities - in a real app, these would come from the database
    final List<Map<String, dynamic>> activities = [
      if (userXP > 0) {
        'icon': Icons.medication,
        'color': const Color(0xFF4CAF50),
        'title': 'Medicine taken',
        'subtitle': '+10 XP • Daily adherence',
        'time': 'Today',
      },
      {
        'icon': Icons.emoji_events,
        'color': const Color(0xFFFFD700),
        'title': 'Account created',
        'subtitle': '+50 XP • Welcome bonus',
        'time': 'Registration',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(color: Colors.grey.shade300, width: 1.5),
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
                  const Spacer(),
                  const Text(
                    "XP System",
                    style: TextStyle(
                      color: Color(0xFF1A2A2C),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.info_outline, color: Colors.grey.shade600),
                    onPressed: () => _showXpInfoDialog(context),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 10),

                      // LEVEL CARD
                      Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          border: Border.all(color: Colors.grey.shade200),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.05),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Level $userLevel",
                                        style: const TextStyle(
                                          color: Color(0xFF1A2A2C),
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 12,
                                          vertical: 4,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primary.withOpacity(0.1),
                                          borderRadius: BorderRadius.circular(20),
                                        ),
                                        child: Text(
                                          levelTitle,
                                          style: const TextStyle(
                                            color: primary,
                                            fontSize: 14,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(16),
                                  decoration: const BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    ),
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.emoji_events,
                                    color: Colors.white,
                                    size: 32,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 20),
                            
                            // Total XP display
                            Center(
                              child: Column(
                                children: [
                                  Text(
                                    "$userXP",
                                    style: const TextStyle(
                                      color: primary,
                                      fontSize: 48,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const Text(
                                    "Total XP",
                                    style: TextStyle(
                                      color: Color(0xFF687779),
                                      fontSize: 16,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            
                            const SizedBox(height: 20),
                            
                            // Progress to next level
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  "${xpProgress['current']} / ${xpProgress['needed']} XP",
                                  style: const TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "${xpProgress['toNext']} XP to Level ${userLevel + 1}",
                                  style: const TextStyle(
                                    color: Color(0xFF687779),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 10),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: LinearProgressIndicator(
                                value: progressPercent.clamp(0.0, 1.0),
                                minHeight: 10,
                                backgroundColor: Colors.grey.shade200,
                                valueColor: const AlwaysStoppedAnimation<Color>(primary),
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(height: 24),

                      // HOW TO EARN XP
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: primary.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: primary.withOpacity(0.3)),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Row(
                              children: [
                                Icon(Icons.lightbulb_outline, color: primary, size: 20),
                                SizedBox(width: 8),
                                Text(
                                  "How to Earn XP",
                                  style: TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            _buildXpItem(Icons.medication, "Take medicine on time", "+10 XP"),
                            _buildXpItem(Icons.restaurant, "Log a meal", "+5 XP"),
                            _buildXpItem(Icons.fitness_center, "Complete workout", "+15 XP"),
                            _buildXpItem(Icons.water_drop, "Meet water goal", "+5 XP"),
                            _buildXpItem(Icons.bedtime, "Log sleep", "+5 XP"),
                          ],
                        ),
                      ),

                      const SizedBox(height: 28),

                      // RECENT ACTIVITIES
                      const Text(
                        "Recent Activities",
                        style: TextStyle(
                          color: Color(0xFF1A2A2C),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(height: 16),

                      if (activities.isEmpty)
                        Container(
                          padding: const EdgeInsets.all(32),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey.shade200),
                          ),
                          child: const Center(
                            child: Column(
                              children: [
                                Icon(
                                  Icons.emoji_events_outlined,
                                  size: 48,
                                  color: Color(0xFF687779),
                                ),
                                SizedBox(height: 12),
                                Text(
                                  "No activities yet",
                                  style: TextStyle(
                                    color: Color(0xFF687779),
                                    fontSize: 16,
                                  ),
                                ),
                                SizedBox(height: 4),
                                Text(
                                  "Start tracking to earn XP!",
                                  style: TextStyle(
                                    color: Color(0xFF9E9E9E),
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      else
                        ...activities.map((activity) => Column(
                          children: [
                            ActivityCard(
                              icon: activity['icon'],
                              color: activity['color'],
                              title: activity['title'],
                              subtitle: activity['subtitle'],
                              time: activity['time'],
                            ),
                            const SizedBox(height: 12),
                          ],
                        )),

                      const SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildXpItem(IconData icon, String title, String xp) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: const Color(0xFF687779)),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: const TextStyle(
                color: Color(0xFF1A2A2C),
                fontSize: 14,
              ),
            ),
          ),
          Text(
            xp,
            style: const TextStyle(
              color: Color(0xFF20C6B7),
              fontSize: 14,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showXpInfoDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About XP System'),
        content: const Text(
          'XP (Experience Points) rewards you for healthy habits!\n\n'
          '• Every 100 XP = 1 Level\n'
          '• Higher levels unlock achievements\n'
          '• Stay consistent to level up faster\n\n'
          'Earn XP by:\n'
          '• Taking medicines on time\n'
          '• Logging meals & water\n'
          '• Completing workouts\n'
          '• Tracking sleep',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
