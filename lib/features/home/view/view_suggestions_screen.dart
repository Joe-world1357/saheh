import 'package:flutter/material.dart';
import '../../health/view/ai_chatbot_screen.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';

class ViewSuggestionsScreen extends StatelessWidget {
  const ViewSuggestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final infoColor = AppColors.getInfo(brightness);

    final List<Map<String, dynamic>> suggestions = [
      {
        'category': 'Protein',
        'icon': Icons.restaurant,
        'color': AppColors.getSuccess(brightness),
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
        'color': AppColors.getInfo(brightness),
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
        'color': AppColors.getWarning(brightness),
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
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Health Suggestions', style: theme.textTheme.titleLarge),
        actions: [
          GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => const AIChatbotScreen(),
                ),
              );
            },
            child: Container(
              margin: const EdgeInsets.only(right: 16),
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient(brightness),
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.chat_bubble_outline,
                color: Colors.white,
                size: 24,
              ),
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 8),

            // HEADER CARD
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppCard(
                padding: const EdgeInsets.all(20),
                backgroundColor: infoColor.withValues(alpha: 0.1),
                border: Border.all(
                  color: infoColor.withValues(alpha: 0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: infoColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.psychology,
                            color: Colors.white,
                            size: 24,
                          ),
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            "AI-Powered Health Insights",
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Text(
                      "Based on your daily activity and nutrition data, here are personalized suggestions to help you reach your health goals.",
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                        height: 1.5,
                      ),
                    ),
                  ],
                ),
              ),
            ),

            // SUGGESTIONS LIST
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: suggestions.length,
                itemBuilder: (context, index) {
                  final suggestion = suggestions[index];
                  final progress = (suggestion['current'] as int) /
                      (suggestion['target'] as int);
                  final suggestionColor = suggestion['color'] as Color;

                  return Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: AppCard(
                      padding: const EdgeInsets.all(20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HEADER
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(10),
                                decoration: BoxDecoration(
                                  color: suggestionColor.withValues(alpha: 0.15),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  suggestion['icon'] as IconData,
                                  color: suggestionColor,
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
                                      style: theme.textTheme.titleSmall?.copyWith(
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${suggestion['current']} / ${suggestion['target']} ${suggestion['unit']}',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
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
                                  color: suggestionColor.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  '${(progress * 100).toInt()}%',
                                  style: theme.textTheme.labelSmall?.copyWith(
                                    color: suggestionColor,
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
                              backgroundColor: theme.colorScheme.surfaceContainerHighest,
                              valueColor: AlwaysStoppedAnimation<Color>(suggestionColor),
                            ),
                          ),

                          const SizedBox(height: 16),

                          // DESCRIPTION
                          Text(
                            suggestion['description'] as String,
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                              height: 1.5,
                            ),
                          ),

                          const SizedBox(height: 20),

                          // SUGGESTIONS LIST
                          Text(
                            "Recommended Options:",
                            style: theme.textTheme.labelLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),

                          const SizedBox(height: 12),

                          ...(suggestion['suggestions'] as List)
                              .map((item) => Padding(
                                    padding: const EdgeInsets.only(bottom: 10),
                                    child: AppCard(
                                      padding: const EdgeInsets.all(12),
                                      backgroundColor: suggestionColor.withValues(alpha: 0.05),
                                      border: Border.all(
                                        color: suggestionColor.withValues(alpha: 0.2),
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
                                                  style: theme.textTheme.bodyMedium?.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                  ),
                                                ),
                                                if (item['protein'] != '') ...[
                                                  const SizedBox(height: 4),
                                                  Row(
                                                    children: [
                                                      if (item['protein'] != '')
                                                        Text(
                                                          '${item['protein']} protein',
                                                          style: theme.textTheme.bodySmall?.copyWith(
                                                            color: theme.colorScheme.onSurfaceVariant,
                                                          ),
                                                        ),
                                                      if (item['protein'] != '' &&
                                                          item['calories'] != '')
                                                        Text(
                                                          ' • ',
                                                          style: theme.textTheme.bodySmall?.copyWith(
                                                            color: theme.colorScheme.onSurfaceVariant,
                                                          ),
                                                        ),
                                                      if (item['calories'] != '')
                                                        Text(
                                                          item['calories'] as String,
                                                          style: theme.textTheme.bodySmall?.copyWith(
                                                            color: theme.colorScheme.onSurfaceVariant,
                                                          ),
                                                        ),
                                                    ],
                                                  ),
                                                ],
                                                if (item['serving'] != '') ...[
                                                  const SizedBox(height: 2),
                                                  Text(
                                                    item['serving'] as String,
                                                    style: theme.textTheme.bodySmall?.copyWith(
                                                      color: theme.colorScheme.onSurfaceVariant,
                                                    ),
                                                  ),
                                                ],
                                              ],
                                            ),
                                          ),
                                          IconButton(
                                            icon: Icon(
                                              Icons.add_circle_outline,
                                              color: primary,
                                            ),
                                            onPressed: () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(
                                                SnackBar(
                                                  content: Text(
                                                    'Added ${item['food']} to your meal plan',
                                                  ),
                                                  backgroundColor: AppColors.getSuccess(brightness),
                                                ),
                                              );
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                  ))
                        ],
                      ),
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
