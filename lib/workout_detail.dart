import 'package:flutter/material.dart';
import 'widgets/card_widgets.dart';

class WorkoutDetail
    extends
        StatefulWidget {
  final Map<
    String,
    dynamic
  >
  workout;

  const WorkoutDetail({
    super.key,
    required this.workout,
  });

  @override
  State<
    WorkoutDetail
  >
  createState() => _WorkoutDetailState();
}

class _WorkoutDetailState
    extends
        State<
          WorkoutDetail
        > {
  final List<
    bool
  >
  completedSets = [
    false,
    false,
    false,
    false,
  ];
  bool isWorkoutCompleted = false;
  int restTimeSeconds = 60;
  bool isResting = false;

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

    Color difficultyColor;
    switch (widget.workout["difficulty"]) {
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

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: Column(
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
                    "Workout Details",
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
                    icon: const Icon(
                      Icons.favorite_border,
                      color: Color(
                        0xFF1A2A2C,
                      ),
                    ),
                    onPressed: () {},
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // VIDEO PLAYER PLACEHOLDER ------------------------------------
                    Container(
                      width: double.infinity,
                      height: 250,
                      color: Colors.black,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Container(
                            width: 120,
                            height: 120,
                            decoration: BoxDecoration(
                              color: primary.withOpacity(
                                0.3,
                              ),
                              borderRadius: BorderRadius.circular(
                                20,
                              ),
                            ),
                            child: const Icon(
                              Icons.fitness_center,
                              color: Colors.white,
                              size: 60,
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.all(
                              20,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white.withOpacity(
                                0.9,
                              ),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.play_arrow,
                              color: Colors.black,
                              size: 40,
                            ),
                          ),
                          Positioned(
                            bottom: 16,
                            right: 16,
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(
                                  0.7,
                                ),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: const Text(
                                "2:45",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TITLE & DIFFICULTY ------------------------------------
                          Row(
                            children: [
                              Expanded(
                                child: Text(
                                  widget.workout["title"],
                                  style: const TextStyle(
                                    color: Color(
                                      0xFF1A2A2C,
                                    ),
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: difficultyColor.withOpacity(
                                    0.2,
                                  ),
                                  borderRadius: BorderRadius.circular(
                                    12,
                                  ),
                                  border: Border.all(
                                    color: difficultyColor,
                                  ),
                                ),
                                child: Text(
                                  widget.workout["difficulty"],
                                  style: TextStyle(
                                    color: difficultyColor,
                                    fontSize: 13,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 12,
                          ),

                          // TARGET MUSCLES ----------------------------------------
                          Row(
                            children: [
                              const Icon(
                                Icons.track_changes,
                                size: 20,
                                color: Color(
                                  0xFF687779,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(
                                "Target: ${widget.workout["target"]}",
                                style: const TextStyle(
                                  color: Color(
                                    0xFF687779,
                                  ),
                                  fontSize: 16,
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 20,
                          ),

                          // XP REWARD BADGE ---------------------------------------
                          Container(
                            padding: const EdgeInsets.all(
                              16,
                            ),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  primary,
                                  fitnessGreen,
                                ],
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                              ),
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              border: Border.all(
                                color: Colors.black,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.stars,
                                  color: Color(
                                    0xFFFFC107,
                                  ),
                                  size: 28,
                                ),
                                const SizedBox(
                                  width: 10,
                                ),
                                Text(
                                  "Complete to earn +${widget.workout["xp"]} XP",
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // WORKOUT INFO ------------------------------------------
                          const Text(
                            "Workout Information",
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

                          Row(
                            children: [
                              Expanded(
                                child: InfoCard(
                                  icon: Icons.repeat,
                                  label: "Sets",
                                  value: widget.workout["sets"],
                                  color: const Color(
                                    0xFF2196F3,
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: InfoCard(
                                  icon: Icons.fitness_center,
                                  label: "Reps",
                                  value: widget.workout["reps"],
                                  color: fitnessGreen,
                                ),
                              ),
                              const SizedBox(
                                width: 12,
                              ),
                              Expanded(
                                child: InfoCard(
                                  icon: Icons.timer,
                                  label: "Rest",
                                  value: widget.workout["rest"],
                                  color: const Color(
                                    0xFFFF9800,
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // SETS TRACKER ------------------------------------------
                          const Text(
                            "Track Your Sets",
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

                          ...List.generate(
                            int.parse(
                              widget.workout["sets"].split(
                                " ",
                              )[0],
                            ),
                            (
                              index,
                            ) => SetTrackerCard(
                              setNumber:
                                  index +
                                  1,
                              isCompleted: completedSets[index],
                              onToggle: () {
                                setState(
                                  () {
                                    completedSets[index] = !completedSets[index];
                                  },
                                );
                              },
                              primary: primary,
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // INSTRUCTIONS ------------------------------------------
                          const Text(
                            "Instructions",
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
                              16,
                            ),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              border: Border.all(
                                color: primary.withOpacity(
                                  0.3,
                                ),
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Text(
                                  "1. Start in the proper position with correct form",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    height: 1.6,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "2. Perform the movement slowly and with control",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    height: 1.6,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "3. Focus on the target muscle group",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    height: 1.6,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "4. Rest between sets as indicated",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    height: 1.6,
                                  ),
                                ),
                                SizedBox(
                                  height: 8,
                                ),
                                Text(
                                  "5. Maintain proper breathing throughout",
                                  style: TextStyle(
                                    color: Color(
                                      0xFF687779,
                                    ),
                                    height: 1.6,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 25,
                          ),

                          // TIPS --------------------------------------------------
                          const Text(
                            "Tips & Proper Form",
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
                              16,
                            ),
                            decoration: BoxDecoration(
                              color: const Color(
                                0xFFFFF3E0,
                              ),
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                              border: Border.all(
                                color:
                                    const Color(
                                      0xFFFF9800,
                                    ).withOpacity(
                                      0.3,
                                    ),
                              ),
                            ),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: const [
                                Icon(
                                  Icons.lightbulb,
                                  color: Color(
                                    0xFFFF9800,
                                  ),
                                  size: 24,
                                ),
                                SizedBox(
                                  width: 12,
                                ),
                                Expanded(
                                  child: Text(
                                    "Keep your core engaged throughout the exercise. Avoid using momentum - focus on controlled movements for maximum benefit.",
                                    style: TextStyle(
                                      color: Color(
                                        0xFF1A2A2C,
                                      ),
                                      height: 1.5,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),

                          const SizedBox(
                            height: 30,
                          ),

                          // MARK AS COMPLETED BUTTON ------------------------------
                          ElevatedButton(
                            onPressed: isWorkoutCompleted
                                ? null
                                : () {
                                    setState(
                                      () {
                                        isWorkoutCompleted = true;
                                      },
                                    );
                                    _showCompletionDialog(
                                      context,
                                    );
                                  },
                            style: ElevatedButton.styleFrom(
                              backgroundColor: isWorkoutCompleted
                                  ? Colors.grey
                                  : fitnessGreen,
                              padding: const EdgeInsets.symmetric(
                                vertical: 16,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                  32,
                                ),
                                side: const BorderSide(
                                  color: Colors.black,
                                ),
                              ),
                            ),
                            child: Center(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    isWorkoutCompleted
                                        ? Icons.check_circle
                                        : Icons.check_circle_outline,
                                    color: Colors.black,
                                  ),
                                  const SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    isWorkoutCompleted
                                        ? "Completed!"
                                        : "Mark as Completed",
                                    style: const TextStyle(
                                      color: Colors.black,
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(
                            height: 40,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // COMPLETION DIALOG --------------------------------------------------
  void _showCompletionDialog(
    BuildContext context,
  ) {
    showDialog(
      context: context,
      builder:
          (
            context,
          ) => AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                20,
              ),
            ),
            title: Row(
              children: const [
                Icon(
                  Icons.celebration,
                  color: Color(
                    0xFFFFC107,
                  ),
                  size: 28,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  "Workout Completed!",
                ),
              ],
            ),
            content: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text(
                  "Great job! You've earned:",
                  style: TextStyle(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 16,
                ),
                Container(
                  padding: const EdgeInsets.all(
                    16,
                  ),
                  decoration: BoxDecoration(
                    color:
                        const Color(
                          0xFF4CAF50,
                        ).withOpacity(
                          0.2,
                        ),
                    borderRadius: BorderRadius.circular(
                      12,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.stars,
                        color: Color(
                          0xFFFFC107,
                        ),
                        size: 32,
                      ),
                      const SizedBox(
                        width: 10,
                      ),
                      Text(
                        "+${widget.workout["xp"]} XP",
                        style: const TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Color(
                            0xFF1A2A2C,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(
                    context,
                  );
                  Navigator.pop(
                    context,
                  );
                },
                child: const Text(
                  "Done",
                ),
              ),
            ],
          ),
    );
  }
}
