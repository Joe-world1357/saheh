import 'package:flutter/material.dart';
import '../../health/view/reminder_screen.dart';
<<<<<<< HEAD
=======
import '../../health/view/sleep_tracker_screen.dart';
import '../../health/view/water_intake_screen.dart';
import '../../health/view/health_goals_screen.dart';
import '../../health/view/health_reports_screen.dart';
>>>>>>> 11527b2 (Initial commit)
import '../../fitness/view/workout_library.dart';
import '../../nutrition/view/nutrition_screen.dart';
import '../../fitness/view/xp_system.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../services/view/clinic/clinic_dashboard.dart';
import 'notifications_screen.dart';
import 'view_suggestions_screen.dart';

class HomeScreen
    extends
        StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // TOP BAR --------------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(
                        8,
                      ),
                      decoration: BoxDecoration(
                        color: primary,
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                      ),
                      child: const Icon(
                        Icons.health_and_safety,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                    const SizedBox(
                      width: 10,
                    ),
                    const Text(
                      "Sehati",
                      style: TextStyle(
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    IconButton(
                      icon: const Icon(
                        Icons.notifications_outlined,
                        color: Color(
                          0xFF1A2A2C,
                        ),
                      ),
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

              const SizedBox(
                height: 10,
              ),

              // GREETING CARD --------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (
                              _,
                            ) => const XPSystem(),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(
                      20,
                    ),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [
                          Color(
                            0xFF20C6B7,
                          ),
                          Color(
                            0xFF17A89A,
                          ),
                        ],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: const [
                            Expanded(
                              child: Text(
                                "Good Morning, John!",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            Icon(
                              Icons.emoji_events,
                              color: Color(
                                0xFFFFC107,
                              ),
                              size: 28,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            Text(
                              "Level 10",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "•",
                              style: TextStyle(
                                color: Colors.white,
                              ),
                            ),
                            SizedBox(
                              width: 4,
                            ),
                            Text(
                              "2,450/3,000 XP",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 12,
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
                            backgroundColor: Colors.white.withOpacity(
                              0.3,
                            ),
                            valueColor:
                                const AlwaysStoppedAnimation<
                                  Color
                                >(
                                  Colors.white,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // QUICK ACTIONS --------------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
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
                            builder:
                                (
                                  _,
                                ) => const ReminderScreen(),
                          ),
                        );
                      },
                    ),
                    HomeQuickAction(
                      icon: Icons.restaurant_outlined,
                      label: "Nutrition",
                      color: const Color(
                        0xFF9C27B0,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (
                                  _,
                                ) => const NutritionScreen(),
                          ),
                        );
                      },
                    ),
                    HomeQuickAction(
                      icon: Icons.fitness_center_outlined,
                      label: "Workout",
                      color: const Color(
                        0xFFFF5722,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (
                                  _,
                                ) => const WorkoutLibrary(),
                          ),
                        );
                      },
                    ),
                    HomeQuickAction(
                      icon: Icons.calendar_today_outlined,
                      label: "Book",
                      color: const Color(
                        0xFFFFC107,
                      ),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (
                                  context,
                                ) => const ClinicDashboard(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 24,
              ),

              // TODAY'S SUMMARY TITLE ------------------------------------------
              const Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Text(
                  "Today's Summary",
                  style: TextStyle(
                    color: Color(
                      0xFF1A2A2C,
                    ),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(
                height: 16,
              ),

              // DAILY OVERVIEW CARD --------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    16,
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
                        children: const [
                          Text(
                            "Daily Overview",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Spacer(),
                          Icon(
                            Icons.show_chart,
                            color: Color(
                              0xFF20C6B7,
                            ),
                            size: 20,
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: const [
                          Text(
                            "1,450/2,000 kcal",
                            style: TextStyle(
                              color: Color(
                                0xFF20C6B7,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "7,234 steps",
                            style: TextStyle(
                              color: Color(
                                0xFF9C27B0,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(
                            width: 16,
                          ),
                          Text(
                            "7h 30m sleep",
                            style: TextStyle(
                              color: Color(
                                0xFFFF5722,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      const Text(
                        "Calories • Steps • Sleep",
                        style: TextStyle(
                          color: Color(
                            0xFF687779,
                          ),
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // MEDICINE REMINDERS CARD ----------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    16,
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
                          const Text(
                            "Medicine Reminders",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(
                              6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  const Color(
                                    0xFFFFC107,
                                  ).withOpacity(
                                    0.2,
                                  ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: const Icon(
                              Icons.medication,
                              color: Color(
                                0xFFFFC107,
                              ),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "3 pending reminders",
                        style: TextStyle(
                          color: Color(
                            0xFF687779,
                          ),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      Row(
                        children: const [
                          Text(
                            "Next: Aspirin 9:00 AM",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 14,
                            ),
                          ),
                          Spacer(),
                          Text(
                            "Due soon",
                            style: TextStyle(
                              color: Color(
                                0xFFFF9800,
                              ),
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // NUTRITION PROGRESS CARD ----------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    16,
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
                          const Text(
                            "Nutrition Progress",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(
                              6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  const Color(
                                    0xFF4CAF50,
                                  ).withOpacity(
                                    0.2,
                                  ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: const Icon(
                              Icons.restaurant,
                              color: Color(
                                0xFF4CAF50,
                              ),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "73% of daily goal",
                        style: TextStyle(
                          color: Color(
                            0xFF687779,
                          ),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(
                          10,
                        ),
                        child: LinearProgressIndicator(
                          value: 0.73,
                          minHeight: 8,
                          backgroundColor: Colors.grey.shade200,
                          valueColor:
                              const AlwaysStoppedAnimation<
                                Color
                              >(
                                Color(
                                  0xFF4CAF50,
                                ),
                              ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // TODAY'S WORKOUT CARD -------------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    16,
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
                          const Text(
                            "Today's Workout",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(
                              6,
                            ),
                            decoration: BoxDecoration(
                              color:
                                  const Color(
                                    0xFF9C27B0,
                                  ).withOpacity(
                                    0.2,
                                  ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: const Icon(
                              Icons.fitness_center,
                              color: Color(
                                0xFF9C27B0,
                              ),
                              size: 18,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const Text(
                        "Full Body Strength • 45 min",
                        style: TextStyle(
                          color: Color(
                            0xFF687779,
                          ),
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 14,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (
                                    _,
                                  ) => const WorkoutLibrary(),
                            ),
                          );
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color(
                            0xFF9C27B0,
                          ),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(
                              12,
                            ),
                          ),
                          padding: const EdgeInsets.symmetric(
                            vertical: 12,
                          ),
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
                  ),
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              // AI HEALTH INSIGHT CARD -----------------------------------------
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: Container(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  decoration: BoxDecoration(
                    color: const Color(
                      0xFFE3F2FD,
                    ),
                    borderRadius: BorderRadius.circular(
                      16,
                    ),
                    border: Border.all(
                      color:
                          const Color(
                            0xFF2196F3,
<<<<<<< HEAD
                          ).withOpacity(
                            0.3,
=======
                          ).withValues(
                            alpha: 0.3,
>>>>>>> 11527b2 (Initial commit)
                          ),
                    ),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(
                              8,
                            ),
<<<<<<< HEAD
                            decoration: BoxDecoration(
                              color: const Color(
=======
                            decoration: const BoxDecoration(
                              color: Color(
>>>>>>> 11527b2 (Initial commit)
                                0xFF2196F3,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.psychology,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                          const Text(
                            "AI Health Insight",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Text(
                        "Your protein intake is 25g below target. Consider adding lean meats or protein shakes to your next meal.",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 14,
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => const ViewSuggestionsScreen(),
                            ),
                          );
                        },
                        child: const Text(
                          "View Suggestions",
                          style: TextStyle(
                            color: Color(
                              0xFF2196F3,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

<<<<<<< HEAD
=======
              const SizedBox(height: 24),

              // HEALTH TRACKING SECTION ------------------------------------------
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 20),
                child: Text(
                  "Health Tracking",
                  style: TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
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
                        value: "7h 30m",
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
                        value: "1.2L / 2L",
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
                        value: "3 active",
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

>>>>>>> 11527b2 (Initial commit)
              const SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
<<<<<<< HEAD
=======

  Widget _buildHealthTrackingCard(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String value,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey.shade200),
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
              style: const TextStyle(
                color: Color(0xFF687779),
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(
                color: Color(0xFF1A2A2C),
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
      ),
    );
  }
>>>>>>> 11527b2 (Initial commit)
}
