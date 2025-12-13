import 'package:flutter/material.dart';
import 'workout_library.dart';
import 'activity_tracker.dart';

import 'widgets/common_widgets.dart';
import 'widgets/card_widgets.dart';

class FitnessDashboard
    extends
        StatefulWidget {
  const FitnessDashboard({
    super.key,
  });

  @override
  State<
    FitnessDashboard
  >
  createState() => _FitnessDashboardState();
}

class _FitnessDashboardState
    extends
        State<
          FitnessDashboard
        > {
  final int totalXP = 1250;
  final int dailyGoalSteps = 8500;
  final int dailyGoalCalories = 450;
  final int dailyGoalMinutes = 35;

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );
    const fitnessGreen = Color(
      0xFF4CAF50,
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: 20,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 10,
              ),

              // TOP BAR --------------------------------------------------------
              Row(
                children: [
                  const Text(
                    "Fitness",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 22,
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
                      size: 24,
                    ),
                    onPressed: () {},
                  ),
                ],
              ),

              const SizedBox(
                height: 20,
              ),

              // LEVEL & XP CARD --------------------------------------------
              const SizedBox(
                height: 10,
              ),

              const SizedBox(
                height: 25,
              ),

              // TODAY'S WORKOUT PLAN -----------------------------------------
              const Text(
                "Today's Plan",
                style: TextStyle(
                  color: Color(
                    0xFF1A2A2C,
                  ),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              Container(
                padding: const EdgeInsets.all(
                  18,
                ),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    20,
                  ),
                  border: Border.all(
                    color: primary.withOpacity(
                      0.3,
                    ),
                  ),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            14,
                          ),
                          decoration: BoxDecoration(
                            color: fitnessGreen.withOpacity(
                              0.2,
                            ),
                            borderRadius: BorderRadius.circular(
                              14,
                            ),
                          ),
                          child: const Icon(
                            Icons.fitness_center,
                            color: fitnessGreen,
                            size: 30,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Full Body Strength",
                                style: TextStyle(
                                  color: Color(
                                    0xFF1A2A2C,
                                  ),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              SizedBox(
                                height: 4,
                              ),
                              Text(
                                "45 min • Intermediate • +80 XP",
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
                      ],
                    ),
                    const SizedBox(
                      height: 16,
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: const [
                              Text(
                                "Progress",
                                style: TextStyle(
                                  color: Color(
                                    0xFF687779,
                                  ),
                                  fontSize: 12,
                                ),
                              ),
                              SizedBox(
                                height: 6,
                              ),
                            ],
                          ),
                        ),
                        const Text(
                          "2/5 exercises",
                          style: TextStyle(
                            color: Color(
                              0xFF1A2A2C,
                            ),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(
                        10,
                      ),
                      child: LinearProgressIndicator(
                        value: 0.4,
                        minHeight: 8,
                        backgroundColor: Colors.grey.shade200,
                        valueColor:
                            const AlwaysStoppedAnimation<
                              Color
                            >(
                              fitnessGreen,
                            ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(
                height: 25,
              ),

              // QUICK ACTIONS ------------------------------------------------
              Row(
                children: [
                  Expanded(
                    child: FitnessQuickAction(
                      icon: Icons.track_changes,
                      label: "Activity Tracker",
                      color: fitnessGreen,
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder:
                                (
                                  _,
                                ) => const ActivityTracker(),
                          ),
                        );
                      },
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),

                  Expanded(
                    child: FitnessQuickAction(
                      icon: Icons.library_books,
                      label: "Workout Plans",
                      color: const Color(
                        0xFFFF9800,
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
                  ),
                ],
              ),

              const SizedBox(
                height: 25,
              ),

              // FITNESS GOALS ------------------------------------------------
              const Text(
                "Today's Goals",
                style: TextStyle(
                  color: Color(
                    0xFF1A2A2C,
                  ),
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 12,
              ),

              GoalCard(
                icon: Icons.directions_walk,
                title: "Steps",
                current: dailyGoalSteps,
                goal: 10000,
                unit: "",
                color: const Color(
                  0xFF2196F3,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              GoalCard(
                icon: Icons.local_fire_department,
                title: "Calories Burned",
                current: dailyGoalCalories,
                goal: 600,
                unit: "kcal",
                color: const Color(
                  0xFFFF5722,
                ),
              ),

              const SizedBox(
                height: 12,
              ),

              GoalCard(
                icon: Icons.timer,
                title: "Active Minutes",
                current: dailyGoalMinutes,
                goal: 60,
                unit: "min",
                color: fitnessGreen,
              ),

              const SizedBox(
                height: 40,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
