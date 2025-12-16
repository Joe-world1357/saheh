import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../../shared/widgets/common_widgets.dart';
import '../../../shared/widgets/form_widgets.dart';
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../../shared/widgets/form_widgets.dart';
import '../../../providers/theme_provider.dart';
import '../../../providers/auth_provider.dart';
import '../../auth/view/welcome_screen.dart';
>>>>>>> 11527b2 (Initial commit)
import '../../profile/view/edit_personal_info_screen.dart';
import '../../profile/view/change_password_screen.dart';
import '../../profile/view/login_methods_screen.dart';
import 'language_selection_screen.dart';
import 'privacy_controls_screen.dart';
import 'connect_devices_screen.dart';
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

<<<<<<< HEAD
class SettingsScreen
    extends
        StatefulWidget {
  const SettingsScreen({
    super.key,
  });

  @override
  State<
    SettingsScreen
  >
  createState() => _SettingsScreenState();
}

class _SettingsScreenState
    extends
        State<
          SettingsScreen
        > {
  bool darkMode = false;
=======
class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> {
>>>>>>> 11527b2 (Initial commit)
  bool notifications = true;
  bool twoFactorAuth = false;

  @override
<<<<<<< HEAD
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
=======
  Widget build(BuildContext context) {
    final themeState = ref.watch(themeProvider);
    final isDarkMode = themeState.isDarkMode(context);
    const primary = AppColors.primary;

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
>>>>>>> 11527b2 (Initial commit)
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
                    "Settings",
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

                      // ACCOUNT SETTINGS -------------------------------------------
                      SectionHeader(
                        icon: Icons.person_outline,
                        title: "Account Settings",
                        color: primary,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SettingItem(
                        icon: Icons.edit_outlined,
                        title: "Edit Personal Info",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const EditPersonalInfoScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.lock_outline,
                        title: "Change Password",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ChangePasswordScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.login_outlined,
                        title: "Login Methods",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LoginMethodsScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // APP PREFERENCES --------------------------------------------
                      SectionHeader(
                        icon: Icons.tune,
                        title: "App Preferences",
                        color: primary,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SettingItem(
                        icon: Icons.language,
                        title: "Language",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LanguageSelectionScreen(),
                            ),
                          );
                        },
                        trailing: "English",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItemWithSwitch(
                        icon: Icons.dark_mode_outlined,
                        title: "Dark Mode",
<<<<<<< HEAD
                        value: darkMode,
                        onChanged:
                            (
                              value,
                            ) => setState(
                              () => darkMode = value,
                            ),
=======
                        value: isDarkMode,
                        onChanged: (value) {
                          ref.read(themeProvider.notifier).toggleTheme();
                        },
>>>>>>> 11527b2 (Initial commit)
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItemWithSwitch(
                        icon: Icons.notifications_outlined,
                        title: "Notifications",
                        value: notifications,
                        onChanged:
                            (
                              value,
                            ) => setState(
                              () => notifications = value,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.privacy_tip_outlined,
                        title: "Privacy Controls",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyControlsScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // HEALTH & FITNESS -------------------------------------------
                      SectionHeader(
                        icon: Icons.favorite_outline,
                        title: "Health & Fitness",
                        color: const Color(
                          0xFFE91E63,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SettingItem(
                        icon: Icons.devices_outlined,
                        title: "Connect Devices",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConnectDevicesScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.sync,
                        title: "Sync Activity Data",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SyncActivityDataScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.fitness_center,
                        title: "Workout Preferences",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const WorkoutPreferencesScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.restaurant,
                        title: "Nutrition Settings",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const NutritionSettingsScreen(),
                            ),
                          );
                        },
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // SECURITY & PRIVACY -----------------------------------------
                      SectionHeader(
                        icon: Icons.security,
                        title: "Security & Privacy",
                        color: const Color(
                          0xFFFF9800,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SettingItemWithSwitch(
                        icon: Icons.security,
                        title: "Two-Factor Auth",
                        value: twoFactorAuth,
                        onChanged:
                            (
                              value,
                            ) => setState(
                              () => twoFactorAuth = value,
                            ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.phonelink_lock,
                        title: "Connected Devices",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ConnectedDevicesSecurityScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.policy_outlined,
                        title: "Privacy Policy",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const PrivacyPolicyScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.description_outlined,
                        title: "Terms of Service",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const TermsOfServiceScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
<<<<<<< HEAD
=======
                        icon: Icons.logout,
                        title: "Logout",
                        onTap: () => _handleLogout(context, ref),
                        textColor: Colors.red,
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
>>>>>>> 11527b2 (Initial commit)
                        icon: Icons.delete_outline,
                        title: "Delete Account",
                        onTap: () {},
                        textColor: Colors.red,
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // SUPPORT ----------------------------------------------------
                      SectionHeader(
                        icon: Icons.support_agent,
                        title: "Support",
                        color: const Color(
                          0xFF2196F3,
                        ),
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      SettingItem(
                        icon: Icons.help_outline,
                        title: "Help Center",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const HelpCenterScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.contact_support_outlined,
                        title: "Contact Support",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const ContactSupportScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.feedback_outlined,
                        title: "Send Feedback",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SendFeedbackScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.info_outline,
                        title: "About",
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AboutScreen(),
                            ),
                          );
                        },
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
<<<<<<< HEAD
=======

  Future<void> _handleLogout(BuildContext context, WidgetRef ref) async {
    // Show confirmation dialog
    final shouldLogout = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
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
>>>>>>> 11527b2 (Initial commit)
}
