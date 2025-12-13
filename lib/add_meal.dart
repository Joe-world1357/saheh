import 'package:flutter/material.dart';

class AddMeal
    extends
        StatelessWidget {
  const AddMeal({
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
    addOptions = [
      {
        'icon': Icons.search,
        'color': const Color(
          0xFF7C4DFF,
        ),
        'title': 'Search Food',
        'subtitle': 'Find food from our database',
      },
      {
        'icon': Icons.qr_code_scanner,
        'color': primary,
        'title': 'Scan Barcode',
        'subtitle': 'Scan product barcode',
      },
      {
        'icon': Icons.camera_alt,
        'color': const Color(
          0xFFE91E63,
        ),
        'title': 'Take Photo',
        'subtitle': 'Capture meal with camera',
      },
      {
        'icon': Icons.add_circle_outline,
        'color': const Color(
          0xFF7C4DFF,
        ),
        'title': 'Add Custom Meal',
        'subtitle': 'Create your own meal entry',
      },
    ];

    final List<
      Map<
        String,
        dynamic
      >
    >
    recentMeals = [
      {
        'name': 'Grilled Chicken Salad',
        'calories': 320,
      },
      {
        'name': 'Salmon with Rice',
        'calories': 450,
      },
      {
        'name': 'Avocado Toast',
        'calories': 280,
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
                  const SizedBox(
                    width: 16,
                  ),
                  const Text(
                    "Add Meal",
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

                      // ADD OPTIONS ------------------------------------------------
                      ...addOptions
                          .map(
                            (
                              option,
                            ) => Column(
                              children: [
                                _addOptionCard(
                                  icon: option['icon'],
                                  color: option['color'],
                                  title: option['title'],
                                  subtitle: option['subtitle'],
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                          .toList(),

                      const SizedBox(
                        height: 28,
                      ),

                      // RECENT MEALS -----------------------------------------------
                      const Text(
                        "Recent Meals",
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

                      // RECENT MEALS LIST ------------------------------------------
                      ...recentMeals
                          .map(
                            (
                              meal,
                            ) => Column(
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(
                                    16,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(
                                      12,
                                    ),
                                    border: Border.all(
                                      color: Colors.grey.shade200,
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              meal['name'],
                                              style: const TextStyle(
                                                color: Color(
                                                  0xFF1A2A2C,
                                                ),
                                                fontSize: 15,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            const SizedBox(
                                              height: 4,
                                            ),
                                            Text(
                                              "${meal['calories']} calories",
                                              style: TextStyle(
                                                color: Colors.grey.shade600,
                                                fontSize: 13,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(
                                          6,
                                        ),
                                        decoration: BoxDecoration(
                                          color: primary,
                                          shape: BoxShape.circle,
                                        ),
                                        child: const Icon(
                                          Icons.add,
                                          color: Colors.white,
                                          size: 20,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 12,
                                ),
                              ],
                            ),
                          )
                          .toList(),

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

  // ADD OPTION CARD WIDGET ---------------------------------------------
  Widget _addOptionCard({
    required IconData icon,
    required Color color,
    required String title,
    required String subtitle,
  }) {
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
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(
              12,
            ),
            decoration: BoxDecoration(
              color: color.withOpacity(
                0.15,
              ),
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Icon(
              icon,
              color: color,
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
                  title,
                  style: const TextStyle(
                    color: Color(
                      0xFF1A2A2C,
                    ),
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          Icon(
            Icons.chevron_right,
            color: Colors.grey.shade400,
            size: 24,
          ),
        ],
      ),
    );
  }
}
