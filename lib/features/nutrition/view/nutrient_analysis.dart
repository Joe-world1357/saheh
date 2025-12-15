import 'package:flutter/material.dart';

class NutrientAnalysis
    extends
        StatelessWidget {
  final String mealName;
  final int calories;
  final int protein;
  final int carbs;
  final int fats;

  const NutrientAnalysis({
    super.key,
    required this.mealName,
    required this.calories,
    required this.protein,
    required this.carbs,
    required this.fats,
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
                      color: primary,
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Colors.white,
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    "Nutrient Analysis",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
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
                        height: 20,
                      ),

                      // MEAL INFO CARD ---------------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          18,
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
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                12,
                              ),
                              decoration: BoxDecoration(
                                color: primary.withOpacity(
                                  0.15,
                                ),
                                borderRadius: BorderRadius.circular(
                                  12,
                                ),
                              ),
                              child: const Icon(
                                Icons.restaurant,
                                color: primary,
                                size: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    mealName,
                                    style: const TextStyle(
                                      color: Color(
                                        0xFF1A2A2C,
                                      ),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Today's Lunch • $calories kcal",
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // NUTRIENTS --------------------------------------------------
                      _nutrientProgress(
                        "Protein",
                        protein,
                        50,
                        primary,
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _nutrientProgress(
                        "Carbohydrates",
                        carbs,
                        40,
                        const Color(
                          0xFFE91E63,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _nutrientProgress(
                        "Fats",
                        fats,
                        25,
                        const Color(
                          0xFFFF9800,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _nutrientProgress(
                        "Fiber",
                        8,
                        12,
                        primary,
                      ),

                      const SizedBox(
                        height: 32,
                      ),

                      // AI NUTRITION COACH -----------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          20,
                        ),
                        decoration: BoxDecoration(
                          color: const Color(
                            0xFFF5F5F5,
                          ),
                          borderRadius: BorderRadius.circular(
                            16,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    10,
                                  ),
                                  decoration: BoxDecoration(
                                    color: primary,
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.psychology,
                                    color: Colors.white,
                                    size: 20,
                                  ),
                                ),
                                const SizedBox(
                                  width: 12,
                                ),
                                const Text(
                                  "AI Nutrition Coach",
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
                              height: 16,
                            ),
                            Text(
                              "Great protein intake! Consider adding more calcium-rich foods like dairy or leafy greens to reach your daily goal. Your vitamin D is low - try salmon or fortified foods.",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 14,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
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

  // NUTRIENT PROGRESS WIDGET -------------------------------------------
  Widget _nutrientProgress(
    String name,
    int current,
    int goal,
    Color color,
  ) {
    return Container(
      padding: const EdgeInsets.all(
        18,
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
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                name,
                style: const TextStyle(
                  color: Color(
                    0xFF1A2A2C,
                  ),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
              ),
              Text(
                "${current}g / ${goal}g",
                style: TextStyle(
                  color: Colors.grey.shade600,
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
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
                  current /
                  goal,
              minHeight: 8,
              backgroundColor: Colors.grey.shade200,
              valueColor:
                  AlwaysStoppedAnimation<
                    Color
                  >(
                    color,
                  ),
            ),
          ),
        ],
      ),
    );
  }
}
