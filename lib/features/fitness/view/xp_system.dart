import 'package:flutter/material.dart';
import '../../../shared/widgets/card_widgets.dart';

class XPSystem
    extends
        StatelessWidget {
  const XPSystem({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    final List<
      Map<
        String,
        dynamic
      >
    >
    activities = [
      {
        'icon': Icons.restaurant,
        'color': const Color(
          0xFF4CAF50,
        ),
        'title': 'Logged breakfast',
        'subtitle': '+25 XP • Healthy choices',
        'time': '8:30 AM',
      },
      {
        'icon': Icons.fitness_center,
        'color': const Color(
          0xFF2196F3,
        ),
        'title': 'Completed workout',
        'subtitle': '+40 XP • 45 min strength training',
        'time': '7:15 AM',
      },
      {
        'icon': Icons.directions_walk,
        'color': const Color(
          0xFF9C27B0,
        ),
        'title': 'Morning walk',
        'subtitle': '+20 XP • 8,500 steps',
        'time': 'Yesterday',
      },
      {
        'icon': Icons.local_hospital,
        'color': const Color(
          0xFFFF9800,
        ),
        'title': 'Doctor appointment',
        'subtitle': '+30 XP • Health checkup',
        'time': 'Yesterday',
      },
      {
        'icon': Icons.restaurant_menu,
        'color': const Color(
          0xFF4CAF50,
        ),
        'title': 'Logged dinner',
        'subtitle': '+25 XP • Balanced meal',
        'time': '2 days ago',
      },
      {
        'icon': Icons.directions_bike,
        'color': const Color(
          0xFF2196F3,
        ),
        'title': 'Cycling session',
        'subtitle': '+35 XP • 12.5 km ride',
        'time': '2 days ago',
      },
      {
        'icon': Icons.self_improvement,
        'color': const Color(
          0xFFE91E63,
        ),
        'title': 'Meditation',
        'subtitle': '+15 XP • 10 min session',
        'time': '3 days ago',
      },
    ];

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // TOP BAR --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "XP System",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                      color: Colors.grey.shade600,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 10,
                      ),

                      // LEVEL CARD -------------------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          20,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: const [
                                      Text(
                                        "Level 12",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF1A2A2C,
                                          ),
                                          fontSize: 24,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "Explorer",
                                        style: TextStyle(
                                          color: Color(
                                            0xFF687779,
                                          ),
                                          fontSize: 14,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Container(
                                  padding: const EdgeInsets.all(
                                    12,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    shape: BoxShape.circle,
                                  ),
                                  child: const Icon(
                                    Icons.emoji_events,
                                    color: Colors.white,
                                    size: 28,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "2,450 / 3,000 XP",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF1A2A2C,
                                    ),
                                    fontSize: 14,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                Text(
                                  "550 XP to next level",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            ClipRRect(
                              borderRadius: BorderRadius.circular(
                                10,
                              ),
                              child: LinearProgressIndicator(
                                value:
                                    2450 /
                                    3000,
                                minHeight: 8,
                                backgroundColor: Colors.grey.shade200,
                                valueColor:
                                    const AlwaysStoppedAnimation<
                                      Color
                                    >(
                                      primary,
                                    ),
                              ),
                            ),
                            const SizedBox(
                              height: 12,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "Today: +85 XP",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "Weekly: +420 XP",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    fontSize: 13,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // RECENT ACTIVITIES ------------------------------------------
                      const Text(
                        "Recent Activities",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // ACTIVITIES LIST --------------------------------------------
                      ...activities
                          .map(
                            (
                              activity,
                            ) => Column(
                              children: [
                                ActivityCard(
                                  icon: activity['icon'],
                                  color: activity['color'],
                                  title: activity['title'],
                                  subtitle: activity['subtitle'],
                                  time: activity['time'],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                          .toList(),

                      const SizedBox(
                        height: 20,
                      ),
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
}
