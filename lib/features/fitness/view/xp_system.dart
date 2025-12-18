import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';

class XPSystem extends ConsumerWidget {
  const XPSystem({super.key});

  /// Get level title based on level number
  String _getLevelTitle(int level) {
    if (level <= 5) return 'Beginner';
    if (level <= 10) return 'Explorer';
    if (level <= 20) return 'Achiever';
    if (level <= 35) return 'Champion';
    if (level <= 50) return 'Master';
    if (level <= 75) return 'Legend';
    return 'Elite';
  }

  /// Calculate XP needed for a specific level
  int _xpForLevel(int level) {
    return level * 100;
  }

  /// Get XP progress within current level
  Map<String, int> _getXpProgress(int totalXp, int level) {
    final xpForCurrentLevel = _xpForLevel(level - 1);
    final xpForNextLevel = _xpForLevel(level);
    final currentLevelXp = totalXp - xpForCurrentLevel;
    final xpForNextLevelTotal = xpForNextLevel - xpForCurrentLevel;
    final xpToNext = xpForNextLevel - totalXp;
    
    return {
      'current': currentLevelXp,
      'needed': xpForNextLevelTotal,
      'toNext': xpToNext > 0 ? xpToNext : 0,
    };
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    
    // Get real user data
    final authState = ref.watch(authProvider);
    final user = authState.user;
    final userXP = user?.xp ?? 0;
    final userLevel = user?.level ?? 1;
    final levelTitle = _getLevelTitle(userLevel);
    final xpProgress = _getXpProgress(userXP, userLevel);
    final progressPercent = xpProgress['needed']! > 0 
        ? xpProgress['current']! / xpProgress['needed']! 
        : 1.0;

    // Sample recent activities - in a real app, these would come from the database
    final List<Map<String, dynamic>> activities = [
      if (userXP > 0)
        {
          'icon': Icons.medication,
          'color': AppColors.getSuccess(brightness),
          'title': 'Medicine taken',
          'subtitle': '+10 XP • Daily adherence',
          'time': 'Today',
        },
      {
        'icon': Icons.emoji_events,
        'color': AppColors.getWarning(brightness),
        'title': 'Account created',
        'subtitle': '+50 XP • Welcome bonus',
        'time': 'Registration',
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
        title: Text('XP System', style: theme.textTheme.titleLarge),
        actions: [
          IconButton(
            icon: Icon(Icons.info_outline, color: theme.colorScheme.onSurface),
            onPressed: () => _showXpInfoDialog(context, theme),
          ),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // LEVEL CARD
              AppCard(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Level $userLevel",
                                style: theme.textTheme.headlineMedium?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 4,
                                ),
                                decoration: BoxDecoration(
                                  color: primary.withValues(alpha: 0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  levelTitle,
                                  style: theme.textTheme.labelMedium?.copyWith(
                                    color: primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            gradient: AppTheme.primaryGradient(brightness),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.emoji_events,
                            color: Colors.white,
                            size: 32,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    
                    // Total XP display
                    Center(
                      child: Column(
                        children: [
                          Text(
                            "$userXP",
                            style: theme.textTheme.displaySmall?.copyWith(
                              color: primary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "Total XP",
                            style: theme.textTheme.bodyLarge?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    
                    const SizedBox(height: 20),
                    
                    // Progress to next level
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${xpProgress['current']} / ${xpProgress['needed']} XP",
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Text(
                          "${xpProgress['toNext']} XP to Level ${userLevel + 1}",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 10),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: LinearProgressIndicator(
                        value: progressPercent.clamp(0.0, 1.0),
                        minHeight: 10,
                        backgroundColor: theme.colorScheme.surfaceVariant,
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // HOW TO EARN XP
              AppCard(
                padding: const EdgeInsets.all(16),
                backgroundColor: AppColors.getInfo(brightness).withValues(alpha: 0.1),
                border: Border.all(
                  color: AppColors.getInfo(brightness).withValues(alpha: 0.3),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: AppColors.getInfo(brightness),
                          size: 20,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          "How to Earn XP",
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    _buildXpItem(context, Icons.medication, "Take medicine on time", "+10 XP", theme),
                    _buildXpItem(context, Icons.restaurant, "Log a meal", "+5 XP", theme),
                    _buildXpItem(context, Icons.fitness_center, "Complete workout", "+15 XP", theme),
                    _buildXpItem(context, Icons.water_drop, "Meet water goal", "+5 XP", theme),
                    _buildXpItem(context, Icons.bedtime, "Log sleep", "+5 XP", theme),
                  ],
                ),
              ),

              const SizedBox(height: 28),

              // RECENT ACTIVITIES
              Text(
                "Recent Activities",
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              if (activities.isEmpty)
                AppCard(
                  padding: const EdgeInsets.all(32),
                  child: Center(
                    child: Column(
                      children: [
                        Icon(
                          Icons.emoji_events_outlined,
                          size: 48,
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                        const SizedBox(height: 12),
                        Text(
                          "No activities yet",
                          style: theme.textTheme.bodyLarge,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          "Start tracking to earn XP!",
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              else
                ...activities.map((activity) => Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: AppInfoCard(
                    title: activity['title'] as String,
                    subtitle: activity['subtitle'] as String,
                    icon: activity['icon'] as IconData,
                    iconColor: activity['color'] as Color,
                  ),
                )),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildXpItem(BuildContext context, IconData icon, String title, String xp, ThemeData theme) {
    final brightness = theme.brightness;
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: theme.colorScheme.onSurfaceVariant,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyMedium,
            ),
          ),
          Text(
            xp,
            style: theme.textTheme.bodyMedium?.copyWith(
              color: AppColors.getPrimary(brightness),
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }

  void _showXpInfoDialog(BuildContext context, ThemeData theme) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('About XP System', style: theme.textTheme.titleLarge),
        content: Text(
          'XP (Experience Points) rewards you for healthy habits!\n\n'
          '• Every 100 XP = 1 Level\n'
          '• Higher levels unlock achievements\n'
          '• Stay consistent to level up faster\n\n'
          'Earn XP by:\n'
          '• Taking medicines on time\n'
          '• Logging meals & water\n'
          '• Completing workouts\n'
          '• Tracking sleep',
          style: theme.textTheme.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it!'),
          ),
        ],
      ),
    );
  }
}
