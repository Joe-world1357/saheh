import 'package:flutter/material.dart';

class PrivacyPolicyScreen extends StatelessWidget {
  const PrivacyPolicyScreen({super.key});

  @override
  Widget build(BuildContext context) {
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
                      "Privacy Policy",
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

                    // LAST UPDATED
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFFE3F2FD),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today,
                            color: Color(0xFF2196F3),
                            size: 20,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            "Last updated: December 2024",
                            style: TextStyle(
                              color: Colors.grey.shade700,
                              fontSize: 13,
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // SECTIONS
                    _buildSection(
                      "1. Information We Collect",
                      "We collect information that you provide directly to us, including:\n\n"
                      "• Personal information (name, email, phone number)\n"
                      "• Health data (medications, workouts, nutrition)\n"
                      "• Device information and usage data\n"
                      "• Location data (with your permission)",
                    ),
                    _buildSection(
                      "2. How We Use Your Information",
                      "We use the information we collect to:\n\n"
                      "• Provide and improve our services\n"
                      "• Send you notifications and reminders\n"
                      "• Process your orders and appointments\n"
                      "• Personalize your experience\n"
                      "• Communicate with you about our services",
                    ),
                    _buildSection(
                      "3. Data Security",
                      "We implement appropriate security measures to protect your personal information. However, no method of transmission over the internet is 100% secure.",
                    ),
                    _buildSection(
                      "4. Your Rights",
                      "You have the right to:\n\n"
                      "• Access your personal data\n"
                      "• Request correction of inaccurate data\n"
                      "• Request deletion of your data\n"
                      "• Object to processing of your data\n"
                      "• Data portability",
                    ),
                    _buildSection(
                      "5. Third-Party Services",
                      "We may use third-party services that collect information used to identify you. These services have their own privacy policies.",
                    ),
                    _buildSection(
                      "6. Contact Us",
                      "If you have questions about this Privacy Policy, please contact us at:\n\n"
                      "Email: privacy@sehati.com\n"
                      "Phone: +1 (555) 123-4567",
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

  Widget _buildSection(String title, String content) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              color: Color(0xFF1A2A2C),
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),
          Text(
            content,
            style: TextStyle(
              color: Colors.grey.shade700,
              fontSize: 14,
              height: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}


