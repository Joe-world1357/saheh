import 'package:flutter/material.dart';
import 'widgets/common_widgets.dart';
import 'widgets/form_widgets.dart';

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
  bool notifications = true;
  bool twoFactorAuth = false;

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
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.lock_outline,
                        title: "Change Password",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.login_outlined,
                        title: "Login Methods",
                        onTap: () {},
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
                        onTap: () {},
                        trailing: "English",
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItemWithSwitch(
                        icon: Icons.dark_mode_outlined,
                        title: "Dark Mode",
                        value: darkMode,
                        onChanged:
                            (
                              value,
                            ) => setState(
                              () => darkMode = value,
                            ),
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
                        onTap: () {},
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
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.sync,
                        title: "Sync Activity Data",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.fitness_center,
                        title: "Workout Preferences",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.restaurant,
                        title: "Nutrition Settings",
                        onTap: () {},
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
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.policy_outlined,
                        title: "Privacy Policy",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
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
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.contact_support_outlined,
                        title: "Contact Support",
                        onTap: () {},
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      SettingItem(
                        icon: Icons.feedback_outlined,
                        title: "Send Feedback",
                        onTap: () {},
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
