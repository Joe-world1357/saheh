import 'package:flutter/material.dart';

class PrivacyControlsScreen extends StatefulWidget {
  const PrivacyControlsScreen({super.key});

  @override
  State<PrivacyControlsScreen> createState() => _PrivacyControlsScreenState();
}

class _PrivacyControlsScreenState extends State<PrivacyControlsScreen> {
  bool _profileVisibility = true;
  bool _activitySharing = false;
  bool _dataAnalytics = true;
  bool _marketingEmails = false;
  bool _locationTracking = true;
  bool _healthDataSharing = false;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

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
                      "Privacy Controls",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // INFO CARD
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2196F3).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.privacy_tip,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Text(
                              "Control who can see your information and how your data is used.",
                              style: TextStyle(
                                color: Colors.grey.shade700,
                                fontSize: 13,
                                height: 1.4,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // PROFILE & VISIBILITY
                    const Text(
                      "Profile & Visibility",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPrivacySwitch(
                      title: "Profile Visibility",
                      subtitle: "Allow others to see your profile",
                      value: _profileVisibility,
                      onChanged: (value) {
                        setState(() {
                          _profileVisibility = value;
                        });
                      },
                      icon: Icons.visibility,
                    ),

                    const SizedBox(height: 24),

                    // DATA SHARING
                    const Text(
                      "Data Sharing",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPrivacySwitch(
                      title: "Activity Sharing",
                      subtitle: "Share your workout and activity data",
                      value: _activitySharing,
                      onChanged: (value) {
                        setState(() {
                          _activitySharing = value;
                        });
                      },
                      icon: Icons.share,
                    ),
                    const SizedBox(height: 12),
                    _buildPrivacySwitch(
                      title: "Health Data Sharing",
                      subtitle: "Share health metrics with healthcare providers",
                      value: _healthDataSharing,
                      onChanged: (value) {
                        setState(() {
                          _healthDataSharing = value;
                        });
                      },
                      icon: Icons.health_and_safety,
                    ),

                    const SizedBox(height: 24),

                    // LOCATION & TRACKING
                    const Text(
                      "Location & Tracking",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPrivacySwitch(
                      title: "Location Tracking",
                      subtitle: "Allow app to access your location",
                      value: _locationTracking,
                      onChanged: (value) {
                        setState(() {
                          _locationTracking = value;
                        });
                      },
                      icon: Icons.location_on,
                    ),

                    const SizedBox(height: 24),

                    // ANALYTICS & MARKETING
                    const Text(
                      "Analytics & Marketing",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 12),
                    _buildPrivacySwitch(
                      title: "Data Analytics",
                      subtitle: "Help improve the app by sharing usage data",
                      value: _dataAnalytics,
                      onChanged: (value) {
                        setState(() {
                          _dataAnalytics = value;
                        });
                      },
                      icon: Icons.analytics,
                    ),
                    const SizedBox(height: 12),
                    _buildPrivacySwitch(
                      title: "Marketing Emails",
                      subtitle: "Receive promotional emails and offers",
                      value: _marketingEmails,
                      onChanged: (value) {
                        setState(() {
                          _marketingEmails = value;
                        });
                      },
                      icon: Icons.email,
                    ),

                    const SizedBox(height: 32),

                    // DELETE DATA BUTTON
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.red.shade50,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.red.shade200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.warning_amber_rounded,
                                color: Colors.red.shade700,
                                size: 24,
                              ),
                              const SizedBox(width: 12),
                              const Text(
                                "Danger Zone",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 12),
                          Text(
                            "Delete all your personal data and account information. This action cannot be undone.",
                            style: TextStyle(
                              color: Colors.red.shade700,
                              fontSize: 13,
                              height: 1.4,
                            ),
                          ),
                          const SizedBox(height: 16),
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () {
                                // Show confirmation dialog
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    title: const Text('Delete All Data?'),
                                    content: const Text(
                                      'This will permanently delete all your data. This action cannot be undone.',
                                    ),
                                    actions: [
                                      TextButton(
                                        onPressed: () => Navigator.pop(context),
                                        child: const Text('Cancel'),
                                      ),
                                      TextButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                          // Handle deletion
                                        },
                                        child: const Text(
                                          'Delete',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                              style: OutlinedButton.styleFrom(
                                side: const BorderSide(color: Colors.red),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                padding: const EdgeInsets.symmetric(vertical: 12),
                              ),
                              child: const Text(
                                "Delete All Data",
                                style: TextStyle(
                                  color: Colors.red,
                                  fontSize: 14,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildPrivacySwitch({
    required String title,
    required String subtitle,
    required bool value,
    required Function(bool) onChanged,
    required IconData icon,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: const Color(0xFF20C6B7).withOpacity(0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.privacy_tip,
              color: Color(0xFF20C6B7),
              size: 20,
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          Switch(
            value: value,
            onChanged: onChanged,
            activeColor: const Color(0xFF20C6B7),
          ),
        ],
      ),
    );
  }
}

