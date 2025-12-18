import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/user_preferences_provider.dart';
import '../../auth/view/welcome_screen.dart';
import '../../profile/view/edit_personal_info_screen.dart';
import '../../profile/view/change_password_screen.dart';
import '../../profile/view/login_methods_screen.dart';
import 'language_selection_screen.dart';
import 'privacy_controls_screen.dart';
import 'connect_devices_screen.dart';
import 'wearable_google_fit_screen.dart';
import 'privacy_policy_screen.dart';
import 'terms_of_service_screen.dart';
import 'help_center_screen.dart';
import 'contact_support_screen.dart';
import 'send_feedback_screen.dart';
import 'about_screen.dart';
import 'sync_activity_data_screen.dart';
import 'workout_preferences_screen.dart';
import 'nutrition_settings_screen.dart';
import 'connected_devices_security_screen.dart';
import 'notification_settings_screen.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
  bool twoFactorAuth = false;

  @override
  void initState() {
    super.initState();
    // Load user preferences when screen opens
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(userPreferencesProvider.notifier).refresh();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final themeState = ref.watch(themeProvider);
    final userPrefs = ref.watch(userPreferencesProvider);
    final userPrefsNotifier = ref.read(userPreferencesProvider.notifier);
    final authState = ref.watch(authProvider);
    final isDarkMode = themeState.isDarkMode(context);

    // Get language display name
    final languageDisplayName = _getLanguageDisplayName(userPrefs.language);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Settings', style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // User Info Card (if authenticated)
              if (authState.isAuthenticated && authState.user != null) ...[
                _buildUserInfoCard(theme, authState.user!.name, authState.user!.email),
                const SizedBox(height: 24),
              ],

              // ========== ACCOUNT SETTINGS ==========
              _buildSectionHeader(
                icon: Icons.person_outline,
                title: 'Account',
                color: AppColors.getPrimary(brightness),
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                theme: theme,
                icon: Icons.edit_outlined,
                title: 'Edit Personal Info',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const EditPersonalInfoScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.lock_outline,
                title: 'Change Password',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ChangePasswordScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.login_outlined,
                title: 'Login Methods',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LoginMethodsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // ========== APP PREFERENCES ==========
              _buildSectionHeader(
                icon: Icons.tune,
                title: 'Preferences',
                color: AppColors.getPrimary(brightness),
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                theme: theme,
                icon: Icons.language,
                title: 'Language',
                trailing: languageDisplayName,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const LanguageSelectionScreen(),
                    ),
                  ).then((_) {
                    // Refresh preferences after language change
                    ref.read(userPreferencesProvider.notifier).refresh();
                  });
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItemWithSwitch(
                theme: theme,
                icon: Icons.dark_mode_outlined,
                title: 'Dark Mode',
                value: isDarkMode,
                onChanged: (value) {
                  ref.read(themeProvider.notifier).toggleTheme();
                  // Also save to user preferences
                  final newMode = value ? 'dark' : 'light';
                  userPrefsNotifier.updateThemeMode(newMode);
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.notifications_outlined,
                title: 'Notification Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => NotificationSettingsScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.privacy_tip_outlined,
                title: 'Privacy Controls',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyControlsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // ========== HEALTH & FITNESS ==========
              _buildSectionHeader(
                icon: Icons.favorite_outline,
                title: 'Health & Fitness',
                color: AppColors.getError(brightness),
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                theme: theme,
                icon: Icons.devices_outlined,
                title: 'Wearable & Google Fit',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WearableGoogleFitScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.sync,
                title: 'Sync Activity Data',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SyncActivityDataScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.fitness_center,
                title: 'Workout Preferences',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const WorkoutPreferencesScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.restaurant,
                title: 'Nutrition Settings',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const NutritionSettingsScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // ========== SECURITY & PRIVACY ==========
              _buildSectionHeader(
                icon: Icons.security,
                title: 'Security & Privacy',
                color: AppColors.getWarning(brightness),
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSettingItemWithSwitch(
                theme: theme,
                icon: Icons.security,
                title: 'Two-Factor Authentication',
                value: twoFactorAuth,
                onChanged: (value) {
                  setState(() {
                    twoFactorAuth = value;
                  });
                  // TODO: Implement 2FA logic
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.phonelink_lock,
                title: 'Connected Devices',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConnectedDevicesSecurityScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.policy_outlined,
                title: 'Privacy Policy',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PrivacyPolicyScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.description_outlined,
                title: 'Terms of Service',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const TermsOfServiceScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 32),

              // ========== ACCOUNT ACTIONS ==========
              _buildSectionHeader(
                icon: Icons.account_circle_outlined,
                title: 'Account Actions',
                color: AppColors.getError(brightness),
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                theme: theme,
                icon: Icons.logout,
                title: 'Logout',
                textColor: AppColors.getError(brightness),
                onTap: () => _handleLogout(context, ref),
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.delete_outline,
                title: 'Delete Account',
                textColor: AppColors.getError(brightness),
                onTap: () => _handleDeleteAccount(context, ref),
              ),

              const SizedBox(height: 32),

              // ========== SUPPORT ==========
              _buildSectionHeader(
                icon: Icons.support_agent,
                title: 'Support',
                color: AppColors.getInfo(brightness),
                theme: theme,
              ),
              const SizedBox(height: 12),
              _buildSettingItem(
                theme: theme,
                icon: Icons.help_outline,
                title: 'Help Center',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HelpCenterScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.contact_support_outlined,
                title: 'Contact Support',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ContactSupportScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.feedback_outlined,
                title: 'Send Feedback',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const SendFeedbackScreen(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 8),
              _buildSettingItem(
                theme: theme,
                icon: Icons.info_outline,
                title: 'About',
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const AboutScreen(),
                    ),
                  );
                },
              ),

              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildUserInfoCard(ThemeData theme, String name, String email) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              color: AppColors.getPrimary(theme.brightness).withValues(alpha: 0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person,
              color: AppColors.getPrimary(theme.brightness),
              size: 28,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  style: theme.textTheme.titleMedium,
                ),
                const SizedBox(height: 4),
                Text(
                  email,
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionHeader({
    required IconData icon,
    required String title,
    required Color color,
    required ThemeData theme,
  }) {
    return Row(
      children: [
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Icon(icon, color: color, size: 20),
        ),
        const SizedBox(width: 12),
        Text(
          title,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _buildSettingItem({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    String? trailing,
    Color? textColor,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(color: theme.colorScheme.outline),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: textColor ?? theme.colorScheme.onSurface,
              size: 22,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                title,
                style: theme.textTheme.bodyLarge?.copyWith(
                  color: textColor ?? theme.colorScheme.onSurface,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            if (trailing != null) ...[
              Text(
                trailing,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(width: 8),
            ],
            Icon(
              Icons.chevron_right,
              color: theme.colorScheme.onSurfaceVariant,
              size: 20,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSettingItemWithSwitch({
    required ThemeData theme,
    required IconData icon,
    required String title,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
        border: Border.all(color: theme.colorScheme.outline),
      ),
      child: Row(
        children: [
          Icon(
            icon,
            color: theme.colorScheme.onSurface,
            size: 22,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              title,
              style: theme.textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
          ),
        ],
      ),
    );
  }

  String _getLanguageDisplayName(String languageCode) {
    switch (languageCode.toLowerCase()) {
      case 'en':
        return 'English';
      case 'ar':
        return 'العربية';
      case 'fr':
        return 'Français';
      case 'es':
        return 'Español';
      default:
        return 'English';
    }
  }

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Logout', style: Theme.of(context).textTheme.titleLarge),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.getError(Theme.of(context).brightness),
            ),
            child: const Text('Logout'),
          ),
        ],
      ),
    );

    if (shouldLogout == true && context.mounted) {
      // Logout user
      await ref.read(authProvider.notifier).logout();

      // Navigate to welcome screen
      if (context.mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          (route) => false,
        );
      }
    }
  }

  Future<void> _handleDeleteAccount(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final shouldDelete = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(
          'Delete Account',
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.getError(Theme.of(context).brightness),
              ),
        ),
        content: const Text(
          'This action cannot be undone. All your data will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            style: FilledButton.styleFrom(
              backgroundColor: AppColors.getError(Theme.of(context).brightness),
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (shouldDelete == true && context.mounted) {
      // TODO: Implement account deletion logic
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Text('Account deletion is not yet implemented'),
          backgroundColor: AppColors.getWarning(Theme.of(context).brightness),
        ),
      );
    }
  }
}
