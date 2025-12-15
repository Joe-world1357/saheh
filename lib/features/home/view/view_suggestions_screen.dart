import 'package:flutter/material.dart';

class ViewSuggestionsScreen extends StatelessWidget {
  const ViewSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    final List<Map<String, dynamic>> suggestions = [
      {
        'category': 'Protein',
        'icon': Icons.restaurant,
        'color': const Color(0xFF4CAF50),
        'current': 75,
        'target': 100,
        'unit': 'g',
        'title': 'Increase Protein Intake',
        'description':
            'Your protein intake is 25g below your daily target. Protein helps build and repair muscles.',
        'suggestions': [
          {
            'food': 'Grilled Chicken Breast',
            'protein': '31g',
            'calories': '165 kcal',
            'serving': '100g',
          },
          {
            'food': 'Greek Yogurt',
            'protein': '17g',
            'calories': '100 kcal',
            'serving': '170g',
          },
          {
            'food': 'Protein Shake',
            'protein': '25g',
            'calories': '120 kcal',
            'serving': '1 scoop',
          },
          {
            'food': 'Eggs (2 large)',
            'protein': '13g',
            'calories': '140 kcal',
            'serving': '2 eggs',
          },
        ],
      },
      {
        'category': 'Hydration',
        'icon': Icons.water_drop,
        'color': const Color(0xFF2196F3),
        'current': 4,
        'target': 8,
        'unit': 'glasses',
        'title': 'Drink More Water',
        'description':
            'You\'ve only had 4 glasses of water today. Aim for 8 glasses to stay hydrated.',
        'suggestions': [
          {
            'food': 'Drink 1 glass now',
            'protein': '',
            'calories': '0 kcal',
            'serving': '250ml',
          },
          {
            'food': 'Set hourly reminders',
            'protein': '',
            'calories': '',
            'serving': '',
          },
        ],
      },
      {
        'category': 'Vitamins',
        'icon': Icons.medication,
        'color': const Color(0xFFFF9800),
        'current': 2,
        'target': 3,
        'unit': 'servings',
        'title': 'Add More Fruits & Vegetables',
        'description':
            'Include more colorful fruits and vegetables to get essential vitamins and minerals.',
        'suggestions': [
          {
            'food': 'Spinach Salad',
            'protein': '3g',
            'calories': '23 kcal',
            'serving': '100g',
          },
          {
            'food': 'Orange',
            'protein': '1g',
            'calories': '47 kcal',
            'serving': '1 medium',
          },
          {
            'food': 'Broccoli',
            'protein': '3g',
            'calories': '34 kcal',
            'serving': '100g',
          },
        ],
      },
    ];

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
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
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
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
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Health Suggestions",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      color: const Color(0xFF2196F3).withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.psychology,
                      color: Color(0xFF2196F3),
                      size: 24,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 8),

            // HEADER CARD
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                    colors: [
                      Color(0xFFE3F2FD),
                      Color(0xFFBBDEFB),
                    ],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF2196F3).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: const BoxDecoration(
                            color: Color(0xFF2196F3),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.psychology,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        const Expanded(
                          child: Text(
                            "AI-Powered Health Insights",
                            style: TextStyle(
                              color: Color(0xFF1A2A2C),
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    const Text(
                      "Based on your daily activity and nutrition data, here are personalized suggestions to help you reach your health goals.",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 14,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 24),

            // SUGGESTIONS LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  final progress = (suggestion['current'] as int) /
                      (suggestion['target'] as int);

                  return Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
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
                        // HEADER
                        Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(10),
                              decoration: BoxDecoration(
                                color: (suggestion['color'] as Color)
                                    .withOpacity(0.15),
                                shape: BoxShape.circle,
                              ),
                              child: Icon(
                                suggestion['icon'] as IconData,
                                color: suggestion['color'] as Color,
                                size: 24,
                              ),
                            ),
                            const SizedBox(width: 12),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    suggestion['title'] as String,
                                    style: const TextStyle(
                                      color: Color(0xFF1A2A2C),
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    '${suggestion['current']} / ${suggestion['target']} ${suggestion['unit']}',
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 6,
                              ),
                              decoration: BoxDecoration(
                                color: (suggestion['color'] as Color)
                                    .withOpacity(0.1),
                                borderRadius: BorderRadius.circular(20),
                              ),
                              child: Text(
                                '${(progress * 100).toInt()}%',
                                style: TextStyle(
                                  color: suggestion['color'] as Color,
                                  fontSize: 12,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        // PROGRESS BAR
                        ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: LinearProgressIndicator(
                            value: progress.clamp(0.0, 1.0),
                            minHeight: 8,
                            backgroundColor: Colors.grey.shade200,
                            valueColor: AlwaysStoppedAnimation<Color>(
                              suggestion['color'] as Color,
                            ),
                          ),
                        ),

                        const SizedBox(height: 16),

                        // DESCRIPTION
                        Text(
                          suggestion['description'] as String,
                          style: TextStyle(
                            color: Colors.grey.shade700,
                            fontSize: 13,
                            height: 1.5,
                          ),
                        ),

                        const SizedBox(height: 20),

                        // SUGGESTIONS LIST
                        const Text(
                          "Recommended Options:",
                          style: TextStyle(
                            color: Color(0xFF1A2A2C),
                            fontSize: 14,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 12),

                        ...(suggestion['suggestions'] as List)
                            .map((item) => Container(
                                  margin: const EdgeInsets.only(bottom: 10),
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: (suggestion['color'] as Color)
                                        .withOpacity(0.05),
                                    borderRadius: BorderRadius.circular(12),
                                    border: Border.all(
                                      color: (suggestion['color'] as Color)
                                          .withOpacity(0.2),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item['food'] as String,
                                              style: const TextStyle(
                                                color: Color(0xFF1A2A2C),
                                                fontSize: 14,
                                                fontWeight: FontWeight.w600,
                                              ),
                                            ),
                                            if (item['protein'] != '')
                                              const SizedBox(height: 4),
                                            if (item['protein'] != '')
                                              Row(
                                                children: [
                                                  if (item['protein'] != '')
                                                    Text(
                                                      '${item['protein']} protein',
                                                      style: TextStyle(
                                                        color: Colors.grey.shade600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  if (item['protein'] != '' &&
                                                      item['calories'] != '')
                                                    Text(
                                                      ' • ',
                                                      style: TextStyle(
                                                        color: Colors.grey.shade600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                  if (item['calories'] != '')
                                                    Text(
                                                      item['calories'] as String,
                                                      style: TextStyle(
                                                        color: Colors.grey.shade600,
                                                        fontSize: 12,
                                                      ),
                                                    ),
                                                ],
                                              ),
                                            if (item['serving'] != '')
                                              const SizedBox(height: 2),
                                            if (item['serving'] != '')
                                              Text(
                                                item['serving'] as String,
                                                style: TextStyle(
                                                  color: Colors.grey.shade500,
                                                  fontSize: 11,
                                                ),
                                              ),
                                          ],
                                        ),
                                      ),
                                      IconButton(
                                        icon: const Icon(
                                          Icons.add_circle_outline,
                                          color: Color(0xFF20C6B7),
                                        ),
                                        onPressed: () {
                                          // Add to meal/nutrition
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                'Added ${item['food']} to your meal plan',
                                              ),
                                              backgroundColor: primary,
                                            ),
                                          );
                                        },
                                      ),
                                    ],
                                  ),
                                ))
                            .toList(),
                      ],
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

