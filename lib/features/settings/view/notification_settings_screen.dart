import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import 'dart:io' show Platform;
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/permissions/permission_handler.dart';
import '../../../core/notifications/notification_service.dart';
import '../../../shared/widgets/app_card.dart';
import '../../../providers/user_preferences_provider.dart';
import '../../../core/notifications/notification_manager.dart';
import '../../../core/localization/localization_helper.dart';

class NotificationSettingsScreen extends ConsumerStatefulWidget {
  const NotificationSettingsScreen({super.key});

  @override
  ConsumerState<NotificationSettingsScreen> createState() => _NotificationSettingsScreenState();
}

class _NotificationSettingsScreenState extends ConsumerState<NotificationSettingsScreen> {
  bool _isCheckingPermission = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final l10n = AppLocalizations.of(context)!;
    final userPrefs = ref.watch(userPreferencesProvider);
    final userPrefsNotifier = ref.read(userPreferencesProvider.notifier);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.notificationSettings, style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Permission Status Card
              if (Platform.isAndroid) ...[
                FutureBuilder<bool>(
                  future: NotificationService.instance.areNotificationsEnabled(),
                  builder: (context, snapshot) {
                    final isEnabled = snapshot.data ?? false;
                    return AppCard(
                      padding: const EdgeInsets.all(16),
                      backgroundColor: isEnabled
                          ? AppColors.getSuccess(brightness).withValues(alpha: 0.1)
                          : AppColors.getError(brightness).withValues(alpha: 0.1),
                      border: Border.all(
                        color: isEnabled
                            ? AppColors.getSuccess(brightness).withValues(alpha: 0.3)
                            : AppColors.getError(brightness).withValues(alpha: 0.3),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                isEnabled ? Icons.notifications_active : Icons.notifications_off,
                                color: isEnabled
                                    ? AppColors.getSuccess(brightness)
                                    : AppColors.getError(brightness),
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isEnabled ? l10n.notificationsEnabled : l10n.notificationsDisabled,
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: isEnabled
                                            ? AppColors.getSuccess(brightness)
                                            : AppColors.getError(brightness),
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isEnabled
                                          ? l10n.youWillReceiveNotifications
                                          : l10n.enableNotificationsToReceive,
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          if (!isEnabled) ...[
                            const SizedBox(height: 16),
                            SizedBox(
                              width: double.infinity,
                              child: FilledButton(
                                onPressed: _isCheckingPermission
                                    ? null
                                    : () async {
                                        setState(() => _isCheckingPermission = true);
                                        final granted = await PermissionHandler.requestNotificationPermission();
                                        setState(() => _isCheckingPermission = false);
                                        
                                        if (mounted) {
                                          if (granted) {
                                            setState(() {});
                                            ScaffoldMessenger.of(context).showSnackBar(
                                              SnackBar(
                                                content: Text(l10n.notificationsEnabled),
                                                backgroundColor: AppColors.getSuccess(brightness),
                                              ),
                                            );
                                            // Setup notifications after permission granted
                                            await NotificationManager.instance.setupNotifications(ref);
                                          } else {
                                            // Open settings if permanently denied
                                            final openSettings = await showDialog<bool>(
                                              context: context,
                                              builder: (context) => AlertDialog(
                                                title: Text(l10n.permissionRequired),
                                                content: Text(l10n.notificationsAreDisabled),
                                                actions: [
                                                  TextButton(
                                                    onPressed: () => Navigator.pop(context, false),
                                                    child: Text(l10n.cancel),
                                                  ),
                                                  FilledButton(
                                                    onPressed: () => Navigator.pop(context, true),
                                                    child: Text(l10n.openSettings),
                                                  ),
                                                ],
                                              ),
                                            );
                                            if (openSettings == true) {
                                              await PermissionHandler.openAppSettings();
                                            }
                                          }
                                        }
                                      },
                                style: FilledButton.styleFrom(
                                  backgroundColor: AppColors.getPrimary(brightness),
                                  foregroundColor: Colors.white,
                                  padding: const EdgeInsets.symmetric(vertical: 14),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                  ),
                                ),
                                child: _isCheckingPermission
                                    ? const SizedBox(
                                        height: 20,
                                        width: 20,
                                        child: CircularProgressIndicator(
                                          strokeWidth: 2,
                                          valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                                        ),
                                      )
                                    : Text(l10n.enableNotifications),
                              ),
                            ),
                          ],
                        ],
                      ),
                    );
                  },
                ),
                const SizedBox(height: 24),
              ],

              // Notification Types
              Text(
                context.isRTL ? "أنواع الإشعارات" : "Notification Types",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildNotificationToggle(
                      theme: theme,
                      brightness: brightness,
                      icon: Icons.fitness_center,
                      title: l10n.fitnessReminders,
                      subtitle: l10n.fitnessRemindersDesc,
                      value: userPrefs.fitnessReminders,
                      onChanged: (value) {
                        userPrefsNotifier.updateFitnessReminders(value);
                      },
                    ),
                    const Divider(height: 32),
                    _buildNotificationToggle(
                      theme: theme,
                      brightness: brightness,
                      icon: Icons.water_drop,
                      title: l10n.waterReminders,
                      subtitle: l10n.waterRemindersDesc,
                      value: userPrefs.waterReminders,
                      onChanged: (value) {
                        userPrefsNotifier.updateWaterReminders(value);
                      },
                    ),
                    const Divider(height: 32),
                    _buildNotificationToggle(
                      theme: theme,
                      brightness: brightness,
                      icon: Icons.bedtime,
                      title: l10n.sleepReminders,
                      subtitle: l10n.sleepRemindersDesc,
                      value: userPrefs.sleepReminders,
                      onChanged: (value) {
                        userPrefsNotifier.updateSleepReminders(value);
                      },
                    ),
                    const Divider(height: 32),
                    _buildNotificationToggle(
                      theme: theme,
                      brightness: brightness,
                      icon: Icons.restaurant,
                      title: l10n.nutritionReminders,
                      subtitle: l10n.nutritionRemindersDesc,
                      value: userPrefs.nutritionReminders,
                      onChanged: (value) {
                        userPrefsNotifier.updateNutritionReminders(value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 24),

              // XP & Achievement Notifications
              Text(
                context.isRTL ? "إشعارات نقاط الخبرة والإنجازات" : "XP & Achievement Notifications",
                style: theme.textTheme.titleLarge?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),

              AppCard(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    _buildNotificationToggle(
                      theme: theme,
                      brightness: brightness,
                      icon: Icons.star,
                      title: l10n.xpNotifications,
                      subtitle: l10n.xpNotificationsDesc,
                      value: userPrefs.xpNotifications,
                      onChanged: (value) {
                        userPrefsNotifier.updateXPNotifications(value);
                      },
                    ),
                    const Divider(height: 32),
                    _buildNotificationToggle(
                      theme: theme,
                      brightness: brightness,
                      icon: Icons.emoji_events,
                      title: l10n.achievementNotifications,
                      subtitle: l10n.achievementNotificationsDesc,
                      value: userPrefs.achievementNotifications,
                      onChanged: (value) {
                        userPrefsNotifier.updateAchievementNotifications(value);
                      },
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 32),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildNotificationToggle({
    required ThemeData theme,
    required Brightness brightness,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.getPrimary(brightness).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Icon(
            icon,
            color: AppColors.getPrimary(brightness),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Switch(
          value: value,
          onChanged: onChanged,
        ),
      ],
    );
  }

  Widget _buildInfoRow({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required String subtitle,
    required bool enabled,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: AppColors.getSuccess(theme.brightness).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Icon(
            icon,
            color: AppColors.getSuccess(theme.brightness),
            size: 24,
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.getSuccess(theme.brightness).withValues(alpha: 0.15),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            'Always On',
            style: theme.textTheme.labelSmall?.copyWith(
              color: AppColors.getSuccess(theme.brightness),
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

