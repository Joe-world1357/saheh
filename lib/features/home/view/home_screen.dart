import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../health/view/reminder_screen.dart';
import '../../health/view/sleep_tracker_screen.dart';
import '../../health/view/water_intake_screen.dart';
import '../../health/view/health_goals_screen.dart';
import '../../health/view/health_reports_screen.dart';
import '../../fitness/view/workout_library.dart';
import '../../nutrition/view/nutrition_screen.dart';
import '../../fitness/view/xp_system.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../../providers/home_data_provider.dart';
import '../../services/view/clinic/clinic_dashboard.dart';
import 'notifications_screen.dart';
import 'view_suggestions_screen.dart';
import 'package:intl/intl.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh home data when screen loads
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(homeDataProvider.notifier).refresh();
    });
  }

  String _getGreeting() {
    final hour = DateTime.now().hour;
    if (hour < 12) return 'Good Morning';
    if (hour < 17) return 'Good Afternoon';
    return 'Good Evening';
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primary = theme.colorScheme.primary;
    final homeData = ref.watch(homeDataProvider);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () => ref.read(homeDataProvider.notifier).refresh(),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
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
                        padding: const EdgeInsets.all(8),
                        decoration: BoxDecoration(
                          color: primary,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.health_and_safety,
                          color: Colors.white,
                          size: 20,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        "Sehati",
                        style: theme.textTheme.titleLarge,
                      ),
                      const Spacer(),
                      IconButton(
                        icon: const Icon(Icons.notifications_outlined),
                        color: theme.colorScheme.onSurface,
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NotificationsScreen(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 10),

                // GREETING CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const XPSystem(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            primary,
                            primary.withValues(alpha: 0.8),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  "${_getGreeting()}, ${homeData.userName}!",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              const Icon(
                                Icons.emoji_events,
                                color: Color(0xFFFFC107),
                                size: 28,
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Row(
                            children: [
                              Text(
                                "Level ${homeData.userLevel}",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                              const SizedBox(width: 4),
                              const Text(
                                "•",
                                style: TextStyle(color: Colors.white),
                              ),
                              const SizedBox(width: 4),
                              Text(
                                "${homeData.userXP}/${homeData.userLevel * 100} XP",
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          ClipRRect(
                            borderRadius: BorderRadius.circular(10),
                            child: LinearProgressIndicator(
                              value: homeData.userLevel * 100 > 0
                                  ? homeData.userXP / (homeData.userLevel * 100)
                                  : 0,
                              minHeight: 8,
                              backgroundColor: Colors.white.withValues(alpha: 0.3),
                              valueColor: const AlwaysStoppedAnimation<Color>(
                                Colors.white,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // QUICK ACTIONS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      HomeQuickAction(
                        icon: Icons.medical_services_outlined,
                        label: "Medicines",
                        color: primary,
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ReminderScreen(),
                            ),
                          );
                        },
                      ),
                      HomeQuickAction(
                        icon: Icons.restaurant_outlined,
                        label: "Nutrition",
                        color: const Color(0xFF9C27B0),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const NutritionScreen(),
                            ),
                          );
                        },
                      ),
                      HomeQuickAction(
                        icon: Icons.fitness_center_outlined,
                        label: "Workout",
                        color: const Color(0xFFFF5722),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const WorkoutLibrary(),
                            ),
                          );
                        },
                      ),
                      HomeQuickAction(
                        icon: Icons.calendar_today_outlined,
                        label: "Book",
                        color: const Color(0xFFFFC107),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ClinicDashboard(),
                            ),
                          );
                        },
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // TODAY'S SUMMARY TITLE
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Today's Summary",
                    style: theme.textTheme.titleLarge,
                  ),
                ),

                const SizedBox(height: 16),

                // DAILY OVERVIEW CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Daily Overview",
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Icon(
                              Icons.show_chart,
                              color: primary,
                              size: 20,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            Text(
                              "${homeData.caloriesConsumed.toInt()}/${homeData.caloriesGoal.toInt()} kcal",
                              style: TextStyle(
                                color: primary,
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              "${homeData.totalSteps} steps",
                              style: const TextStyle(
                                color: Color(0xFF9C27B0),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(width: 16),
                            Text(
                              homeData.sleepHours != null
                                  ? "${homeData.sleepHours!.toStringAsFixed(1)}h sleep"
                                  : "No sleep data",
                              style: const TextStyle(
                                color: Color(0xFFFF5722),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Calories • Steps • Sleep",
                          style: theme.textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // MEDICINE REMINDERS CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Medicine Reminders",
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFFFFC107)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.medication,
                                color: Color(0xFFFFC107),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${homeData.pendingReminders} pending ${homeData.pendingReminders == 1 ? 'reminder' : 'reminders'}",
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (homeData.nextReminder != null) ...[
                          const SizedBox(height: 12),
                          Row(
                            children: [
                              Text(
                                "Next: ${homeData.nextReminder} ${homeData.nextReminderTime ?? ''}",
                                style: theme.textTheme.bodyLarge,
                              ),
                              const Spacer(),
                              const Text(
                                "Due soon",
                                style: TextStyle(
                                  color: Color(0xFFFF9800),
                                  fontSize: 13,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // NUTRITION PROGRESS CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Nutrition Progress",
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF4CAF50)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.restaurant,
                                color: Color(0xFF4CAF50),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "${((homeData.caloriesConsumed / homeData.caloriesGoal) * 100).toStringAsFixed(0)}% of daily goal",
                          style: theme.textTheme.bodyMedium,
                        ),
                        const SizedBox(height: 12),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: homeData.caloriesGoal > 0
                                ? homeData.caloriesConsumed / homeData.caloriesGoal
                                : 0,
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: const AlwaysStoppedAnimation<Color>(
                              Color(0xFF4CAF50),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // TODAY'S WORKOUT CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: theme.colorScheme.surface,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(color: theme.dividerColor),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              "Today's Workout",
                              style: theme.textTheme.titleMedium,
                            ),
                            const Spacer(),
                            Container(
                              padding: const EdgeInsets.all(6),
                              decoration: BoxDecoration(
                                color: const Color(0xFF9C27B0)
                                    .withValues(alpha: 0.2),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: const Icon(
                                Icons.fitness_center,
                                color: Color(0xFF9C27B0),
                                size: 18,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 8),
                        Text(
                          homeData.todaysWorkout != null
                              ? "${homeData.todaysWorkout!.name} • ${homeData.todaysWorkout!.duration} min"
                              : "No workout today",
                          style: theme.textTheme.bodyMedium,
                        ),
                        if (homeData.todaysWorkout == null) ...[
                          const SizedBox(height: 14),
                          ElevatedButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => const WorkoutLibrary(),
                                ),
                              );
                            },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: const Color(0xFF9C27B0),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(12),
                              ),
                              padding: const EdgeInsets.symmetric(vertical: 12),
                            ),
                            child: const Center(
                              child: Text(
                                "Start Workout",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 12),

                // AI HEALTH INSIGHT CARD
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: const Color(0xFFE3F2FD),
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: const Color(0xFF2196F3)
                            .withValues(alpha: 0.3),
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: const BoxDecoration(
                                color: Color(0xFF2196F3),
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.psychology,
                                color: Colors.white,
                                size: 20,
                              ),
                            ),
                            const SizedBox(width: 10),
                            Text(
                              "AI Health Insight",
                              style: theme.textTheme.titleMedium,
                            ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Text(
                          homeData.proteinConsumed < 50
                              ? "Your protein intake is ${(50 - homeData.proteinConsumed).toStringAsFixed(0)}g below target. Consider adding lean meats or protein shakes to your next meal."
                              : "Great job on your nutrition today! Keep up the healthy eating habits.",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            height: 1.5,
                          ),
                        ),
                        const SizedBox(height: 12),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const ViewSuggestionsScreen(),
                              ),
                            );
                          },
                          child: Text(
                            "View Suggestions",
                            style: TextStyle(
                              color: primary,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 24),

                // HEALTH TRACKING SECTION
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Health Tracking",
                    style: theme.textTheme.titleLarge,
                  ),
                ),

                const SizedBox(height: 16),

                // HEALTH TRACKING CARDS
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildHealthTrackingCard(
                          context,
                          icon: Icons.bedtime,
                          label: "Sleep",
                          value: homeData.sleepHours != null
                              ? "${homeData.sleepHours!.toStringAsFixed(1)}h"
                              : "Not logged",
                          color: const Color(0xFF6C5CE7),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SleepTrackerScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildHealthTrackingCard(
                          context,
                          icon: Icons.water_drop,
                          label: "Water",
                          value: "${(homeData.waterIntake / 1000).toStringAsFixed(1)}L / ${(homeData.waterGoal / 1000).toStringAsFixed(1)}L",
                          color: const Color(0xFF2196F3),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const WaterIntakeScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 12),

                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: _buildHealthTrackingCard(
                          context,
                          icon: Icons.flag,
                          label: "Goals",
                          value: "${homeData.activeGoals} active",
                          color: const Color(0xFF4CAF50),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HealthGoalsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: _buildHealthTrackingCard(
                          context,
                          icon: Icons.analytics,
                          label: "Reports",
                          value: "View all",
                          color: const Color(0xFFFF9800),
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const HealthReportsScreen(),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 30),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildHealthTrackingCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    final theme = Theme.of(context);
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: theme.dividerColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.15),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: theme.textTheme.bodyMedium,
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: theme.textTheme.titleSmall,
            ),
          ],
        ),
      ),
    );
  }
}
