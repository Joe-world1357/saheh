import 'package:flutter/material.dart';
import 'add_meal.dart';
import 'nutrient_analysis.dart';
import 'widgets/card_widgets.dart';
import 'widgets/progress_widgets.dart';

class NutritionScreen
    extends
        StatelessWidget {
  const NutritionScreen({
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
    meals = [
      {
        'name': 'Breakfast',
        'time': '8:30 AM',
        'calories': 487,
        'protein': 26,
        'carbs': 52,
        'fats': 16,
        'icon': Icons.coffee,
        'color': const Color(
          0xFFFF9800,
        ),
      },
      {
        'name': 'Morning Snack',
        'time': '11:00 AM',
        'calories': 156,
        'protein': 8,
        'carbs': 24,
        'fats': 4,
        'icon': Icons.apple,
        'color': const Color(
          0xFF4CAF50,
        ),
      },
      {
        'name': 'Lunch',
        'time': '1:30 PM',
        'calories': 682,
        'protein': 45,
        'carbs': 68,
        'fats': 22,
        'icon': Icons.restaurant,
        'color': const Color(
          0xFF2196F3,
        ),
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
                  IconButton(
                    icon: Icon(
                      Icons.notifications_outlined,
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

                      // TITLE & SUBTITLE -------------------------------------------
                      const Text(
                        "Nutrition",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 28,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "Track your daily nutrition goals",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 14,
                        ),
                      ),

                      const SizedBox(
                        height: 24,
                      ),

                      // DAILY CALORIES CARD ----------------------------------------
                      Container(
                        padding: const EdgeInsets.all(
                          24,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(
                                0xFF7C4DFF,
                              ),
                              Color(
                                0xFF9C27B0,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              "Daily Calories",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
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
                                        "1,847",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 32,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        "/ 2,200",
                                        style: TextStyle(
                                          color: Colors.white70,
                                          fontSize: 16,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                SizedBox(
                                  width: 100,
                                  height: 100,
                                  child: Stack(
                                    alignment: Alignment.center,
                                    children: [
                                      SizedBox(
                                        width: 100,
                                        height: 100,
                                        child: CircularProgressIndicator(
                                          value:
                                              1847 /
                                              2200,
                                          strokeWidth: 8,
                                          backgroundColor: Colors.white24,
                                          valueColor:
                                              const AlwaysStoppedAnimation<
                                                Color
                                              >(
                                                Colors.white,
                                              ),
                                        ),
                                      ),
                                      const Text(
                                        "84%",
                                        style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [
                                Text(
                                  "🔥 353 kcal left",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 13,
                                  ),
                                ),
                                Text(
                                  "⏱️ Updated 2h ago",
                                  style: TextStyle(
                                    color: Colors.white70,
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

                      // MACROS SECTION ---------------------------------------------
                      const Text(
                        "Macros",
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

                      MacroProgressBar(
                        name: "Protein",
                        current: 128,
                        goal: 150,
                        color: primary,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MacroProgressBar(
                        name: "Carbs",
                        current: 198,
                        goal: 220,
                        color: const Color(
                          0xFFFF9800,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      MacroProgressBar(
                        name: "Fats",
                        current: 42,
                        goal: 65,
                        color: const Color(
                          0xFFE91E63,
                        ),
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // MEALS OF THE DAY -------------------------------------------
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: const [
                          Text(
                            "Meals of the Day",
                            style: TextStyle(
                              color: Color(
                                0xFF1A2A2C,
                              ),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "View All",
                            style: TextStyle(
                              color: Color(
                                0xFF20C6B7,
                              ),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      // MEAL CARDS -------------------------------------------------
                      ...meals
                          .map(
                            (
                              meal,
                            ) => Column(
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder:
                                            (
                                              _,
                                            ) => NutrientAnalysis(
                                              mealName: meal['name'],
                                              calories: meal['calories'],
                                              protein: meal['protein'],
                                              carbs: meal['carbs'],
                                              fats: meal['fats'],
                                            ),
                                      ),
                                    );
                                  },
                                  child: MealCard(
                                    name: meal['name'],
                                    time: meal['time'],
                                    calories: meal['calories'],
                                    protein: meal['protein'],
                                    carbs: meal['carbs'],
                                    fats: meal['fats'],
                                    icon: meal['icon'],
                                    color: meal['color'],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                          .toList(),

                      // ADD MEAL BUTTON --------------------------------------------
                      SizedBox(
                        width: double.infinity,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder:
                                    (
                                      _,
                                    ) => const AddMeal(),
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(
                              0xFF7C4DFF,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(
                                16,
                              ),
                            ),
                            padding: const EdgeInsets.symmetric(
                              vertical: 16,
                            ),
                          ),
                          child: const Text(
                            "+ Add Meal",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
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
}
