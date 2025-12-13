import 'package:flutter/material.dart';
import 'workout_detail.dart';

class WorkoutLibrary
    extends
        StatefulWidget {
  const WorkoutLibrary({
    super.key,
  });

  @override
  State<
    WorkoutLibrary
  >
  createState() => _WorkoutLibraryState();
}

class _WorkoutLibraryState
    extends
        State<
          WorkoutLibrary
        > {
  String selectedCategory = "All";
  String selectedDifficulty = "All";

  final List<
    String
  >
  categories = [
    "All",
    "Gym",
    "Home",
    "Strength",
    "Body-toning",
    "Fitness",
  ];

  final List<
    Map<
      String,
      dynamic
    >
  >
  workouts = [
    {
      "title": "Push-Up Challenge",
      "target": "Chest, Triceps",
      "sets": "3 sets",
      "reps": "15 reps",
      "rest": "60s rest",
      "difficulty": "Beginner",
      "category": "Home",
      "xp": 30,
    },
    {
      "title": "Barbell Squat",
      "target": "Legs, Glutes",
      "sets": "4 sets",
      "reps": "12 reps",
      "rest": "90s rest",
      "difficulty": "Intermediate",
      "category": "Gym",
      "xp": 50,
    },
    {
      "title": "Plank Hold",
      "target": "Core, Abs",
      "sets": "3 sets",
      "reps": "45s hold",
      "rest": "30s rest",
      "difficulty": "Beginner",
      "category": "Home",
      "xp": 25,
    },
    {
      "title": "Deadlift",
      "target": "Back, Hamstrings",
      "sets": "4 sets",
      "reps": "10 reps",
      "rest": "120s rest",
      "difficulty": "Advanced",
      "category": "Gym",
      "xp": 70,
    },
    {
      "title": "Burpees",
      "target": "Full Body",
      "sets": "3 sets",
      "reps": "20 reps",
      "rest": "60s rest",
      "difficulty": "Intermediate",
      "category": "Fitness",
      "xp": 60,
    },
    {
      "title": "Dumbbell Curls",
      "target": "Biceps",
      "sets": "3 sets",
      "reps": "12 reps",
      "rest": "45s rest",
      "difficulty": "Beginner",
      "category": "Strength",
      "xp": 35,
    },
    {
      "title": "Lunges",
      "target": "Legs, Glutes",
      "sets": "3 sets",
      "reps": "15 reps",
      "rest": "60s rest",
      "difficulty": "Beginner",
      "category": "Body-toning",
      "xp": 40,
    },
    {
      "title": "Bench Press",
      "target": "Chest, Shoulders",
      "sets": "4 sets",
      "reps": "10 reps",
      "rest": "90s rest",
      "difficulty": "Intermediate",
      "category": "Gym",
      "xp": 55,
    },
  ];

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

    // Filter workouts
    final filteredWorkouts = workouts.where(
      (
        workout,
      ) {
        final categoryMatch =
            selectedCategory ==
                "All" ||
            workout["category"] ==
                selectedCategory;
        final difficultyMatch =
            selectedDifficulty ==
                "All" ||
            workout["difficulty"] ==
                selectedDifficulty;
        return categoryMatch &&
            difficultyMatch;
      },
    ).toList();

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),

            // TOP BAR --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                        color: primary,
                        width: 2,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios,
                        color: primary,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "Workout Plans",
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
                      Icons.search,
                      color: Color(
                        0xFF1A2A2C,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // CATEGORY TABS -------------------------------------------------
            SizedBox(
              height: 45,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                itemCount: categories.length,
                itemBuilder:
                    (
                      context,
                      index,
                    ) {
                      final category = categories[index];
                      final isSelected =
                          selectedCategory ==
                          category;

                      return GestureDetector(
                        onTap: () => setState(
                          () => selectedCategory = category,
                        ),
                        child: Container(
                          margin: const EdgeInsets.only(
                            right: 10,
                          ),
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: isSelected
                                ? primary
                                : Colors.white,
                            borderRadius: BorderRadius.circular(
                              20,
                            ),
                            border: Border.all(
                              color: isSelected
                                  ? Colors.black
                                  : primary.withOpacity(
                                      0.3,
                                    ),
                            ),
                          ),
                          child: Center(
                            child: Text(
                              category,
                              style: TextStyle(
                                color: isSelected
                                    ? Colors.black
                                    : const Color(
                                        0xFF687779,
                                      ),
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.normal,
                              ),
                            ),
                          ),
                        ),
                      );
                    },
              ),
            ),

            const SizedBox(
              height: 16,
            ),

            // DIFFICULTY FILTER ---------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Row(
                children: [
                  const Text(
                    "Difficulty:",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(
                    width: 12,
                  ),
                  Expanded(
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children:
                            [
                              "All",
                              "Beginner",
                              "Intermediate",
                              "Advanced",
                            ].map(
                              (
                                diff,
                              ) {
                                final isSelected =
                                    selectedDifficulty ==
                                    diff;
                                return GestureDetector(
                                  onTap: () => setState(
                                    () => selectedDifficulty = diff,
                                  ),
                                  child: Container(
                                    margin: const EdgeInsets.only(
                                      right: 8,
                                    ),
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 14,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: isSelected
                                          ? fitnessGreen.withOpacity(
                                              0.2,
                                            )
                                          : Colors.white,
                                      borderRadius: BorderRadius.circular(
                                        16,
                                      ),
                                      border: Border.all(
                                        color: isSelected
                                            ? fitnessGreen
                                            : Colors.grey.shade300,
                                      ),
                                    ),
                                    child: Text(
                                      diff,
                                      style: TextStyle(
                                        color: isSelected
                                            ? fitnessGreen
                                            : const Color(
                                                0xFF687779,
                                              ),
                                        fontSize: 13,
                                        fontWeight: isSelected
                                            ? FontWeight.bold
                                            : FontWeight.normal,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            ).toList(),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 20,
            ),

            // WORKOUT CARDS -------------------------------------------------
            Expanded(
              child: filteredWorkouts.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                          Icon(
                            Icons.fitness_center,
                            size: 60,
                            color: Color(
                              0xFF687779,
                            ),
                          ),
                          SizedBox(
                            height: 16,
                          ),
                          Text(
                            "No workouts found",
                            style: TextStyle(
                              color: Color(
                                0xFF687779,
                              ),
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      itemCount: filteredWorkouts.length,
                      itemBuilder:
                          (
                            context,
                            index,
                          ) {
                            final workout = filteredWorkouts[index];
                            return _workoutCard(
                              context: context,
                              workout: workout,
                              primary: primary,
                              fitnessGreen: fitnessGreen,
                            );
                          },
                    ),
            ),
          ],
        ),
      ),
    );
  }

  // WORKOUT CARD WIDGET ------------------------------------------------
  Widget _workoutCard({
    required BuildContext context,
    required Map<
      String,
      dynamic
    >
    workout,
    required Color primary,
    required Color fitnessGreen,
  }) {
    Color difficultyColor;
    switch (workout["difficulty"]) {
      case "Beginner":
        difficultyColor = fitnessGreen;
        break;
      case "Intermediate":
        difficultyColor = const Color(
          0xFFFF9800,
        );
        break;
      case "Advanced":
        difficultyColor = const Color(
          0xFFF44336,
        );
        break;
      default:
        difficultyColor = Colors.grey;
    }

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder:
                (
                  _,
                ) => WorkoutDetail(
                  workout: workout,
                ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.only(
          bottom: 16,
        ),
        padding: const EdgeInsets.all(
          16,
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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                // VIDEO PREVIEW PLACEHOLDER
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    color: primary.withOpacity(
                      0.15,
                    ),
                    borderRadius: BorderRadius.circular(
                      14,
                    ),
                  ),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Icon(
                        Icons.fitness_center,
                        color: primary,
                        size: 40,
                      ),
                      Positioned(
                        bottom: 8,
                        right: 8,
                        child: Container(
                          padding: const EdgeInsets.all(
                            4,
                          ),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(
                              0.7,
                            ),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.play_arrow,
                            color: Colors.white,
                            size: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(
                  width: 16,
                ),

                // WORKOUT INFO
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        workout["title"],
                        style: const TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 6,
                      ),
                      Row(
                        children: [
                          const Icon(
                            Icons.track_changes,
                            size: 16,
                            color: Color(
                              0xFF687779,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Expanded(
                            child: Text(
                              workout["target"],
                              style: const TextStyle(
                                color: Color(
                                  0xFF687779,
                                ),
                                fontSize: 13,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 4,
                            ),
                            decoration: BoxDecoration(
                              color: difficultyColor.withOpacity(
                                0.2,
                              ),
                              borderRadius: BorderRadius.circular(
                                8,
                              ),
                            ),
                            child: Text(
                              workout["difficulty"],
                              style: TextStyle(
                                color: difficultyColor,
                                fontSize: 11,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const Icon(
                            Icons.stars,
                            size: 14,
                            color: Color(
                              0xFFFFC107,
                            ),
                          ),
                          const SizedBox(
                            width: 4,
                          ),
                          Text(
                            "+${workout["xp"]} XP",
                            style: const TextStyle(
                              color: Color(
                                0xFF687779,
                              ),
                              fontSize: 12,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),

            const SizedBox(
              height: 12,
            ),

            // SETS, REPS, REST INFO
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _infoChip(
                  Icons.repeat,
                  workout["sets"],
                ),
                _infoChip(
                  Icons.fitness_center,
                  workout["reps"],
                ),
                _infoChip(
                  Icons.timer,
                  workout["rest"],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  // INFO CHIP WIDGET ---------------------------------------------------
  Widget _infoChip(
    IconData icon,
    String text,
  ) {
    return Row(
      children: [
        Icon(
          icon,
          size: 16,
          color: const Color(
            0xFF687779,
          ),
        ),
        const SizedBox(
          width: 6,
        ),
        Text(
          text,
          style: const TextStyle(
            color: Color(
              0xFF687779,
            ),
            fontSize: 13,
          ),
        ),
      ],
    );
  }
}
