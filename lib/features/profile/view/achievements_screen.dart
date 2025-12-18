import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../providers/achievements_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../core/localization/localization_helper.dart';

class AchievementsScreen extends ConsumerStatefulWidget {
  const AchievementsScreen({super.key});

  @override
  ConsumerState<AchievementsScreen> createState() => _AchievementsScreenState();
}

class _AchievementsScreenState extends ConsumerState<AchievementsScreen> {
  @override
  void initState() {
    super.initState();
    // Refresh achievements on load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(achievementsProvider.notifier).refresh();
    });
  }

  Color _getCategoryColor(String category) {
    switch (category) {
      case 'workout':
        return const Color(0xFF2196F3);
      case 'water':
        return const Color(0xFF2196F3);
      case 'nutrition':
        return const Color(0xFFE91E63);
      case 'xp':
        return const Color(0xFFFFC107);
      case 'sleep':
        return const Color(0xFF6C5CE7);
      default:
        return const Color(0xFF4CAF50);
    }
  }

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'workout':
        return Icons.fitness_center;
      case 'water':
        return Icons.water_drop;
      case 'nutrition':
        return Icons.restaurant;
      case 'xp':
        return Icons.star;
      case 'sleep':
        return Icons.bedtime;
      default:
        return Icons.emoji_events;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context)!;
    final primary = AppColors.getPrimary(brightness);
    final achievements = ref.watch(achievementsProvider);
    final unlockedCount = achievements.where((a) => a.isUnlocked).length;
    final totalCount = achievements.length;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.achievements, style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // PROGRESS CARD
            Padding(
              padding: const EdgeInsets.all(16),
              child: AppCard(
                padding: const EdgeInsets.all(20),
                backgroundColor: primary.withValues(alpha: 0.1),
                border: Border.all(
                  color: primary.withValues(alpha: 0.3),
                ),
                child: Column(
                  children: [
                      Text(
                        l10n.achievementProgress,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: primary,
                        ),
                      ),
                    const SizedBox(height: 12),
                    Text(
                      '$unlockedCount / ${totalCount > 0 ? totalCount : 1}',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: primary,
                      ),
                    ),
                    const SizedBox(height: 12),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      child: LinearProgressIndicator(
                        value: totalCount > 0 ? unlockedCount / totalCount : 0,
                        minHeight: 8,
                        backgroundColor: primary.withValues(alpha: 0.2),
                        valueColor: AlwaysStoppedAnimation<Color>(primary),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            Expanded(
              child: achievements.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.emoji_events_outlined,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            l10n.noAchievementsYet,
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    )
                  : GridView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        childAspectRatio: 0.9,
                      ),
                      itemCount: achievements.length,
                      itemBuilder: (context, index) {
                        final achievement = achievements[index];
                        final isUnlocked = achievement.isUnlocked;
                        final color = _getCategoryColor(achievement.category);
                        final icon = _getCategoryIcon(achievement.category);

                        return AppCard(
                          padding: const EdgeInsets.all(16),
                          backgroundColor: isUnlocked
                              ? null
                              : theme.colorScheme.surfaceContainerHighest,
                          border: Border.all(
                            color: isUnlocked
                                ? color.withValues(alpha: 0.3)
                                : theme.colorScheme.outline.withValues(alpha: 0.2),
                            width: isUnlocked ? 2 : 1,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Container(
                                padding: const EdgeInsets.all(16),
                                decoration: BoxDecoration(
                                  color: isUnlocked
                                      ? color.withValues(alpha: 0.15)
                                      : theme.colorScheme.surfaceContainerHighest,
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  icon,
                                  color: isUnlocked
                                      ? color
                                      : theme.colorScheme.onSurfaceVariant,
                                  size: 32,
                                ),
                              ),
                              const SizedBox(height: 12),
                              Text(
                                achievement.title,
                                style: theme.textTheme.titleSmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                  color: isUnlocked
                                      ? theme.colorScheme.onSurface
                                      : theme.colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 4),
                              Text(
                                achievement.description,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),
                              const SizedBox(height: 8),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.star,
                                    size: 14,
                                    color: isUnlocked
                                        ? AppColors.getWarning(brightness)
                                        : theme.colorScheme.onSurfaceVariant,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '${achievement.xpReward} ${l10n.xp}',
                                    style: theme.textTheme.labelSmall?.copyWith(
                                      fontWeight: FontWeight.bold,
                                      color: isUnlocked
                                          ? AppColors.getWarning(brightness)
                                          : theme.colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
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

