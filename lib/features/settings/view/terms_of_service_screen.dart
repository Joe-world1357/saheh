import 'package:flutter/material.dart';

class TermsOfServiceScreen extends StatelessWidget {
  const TermsOfServiceScreen({super.key});

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
                      "Terms of Service",
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
                      "1. Acceptance of Terms",
                      "By accessing and using Sehati, you accept and agree to be bound by the terms and provision of this agreement.",
                    ),
                    _buildSection(
                      "2. Use License",
                      "Permission is granted to temporarily use Sehati for personal, non-commercial use only. This is the grant of a license, not a transfer of title.",
                    ),
                    _buildSection(
                      "3. User Account",
                      "You are responsible for maintaining the confidentiality of your account and password. You agree to accept responsibility for all activities that occur under your account.",
                    ),
                    _buildSection(
                      "4. Medical Disclaimer",
                      "The information provided by Sehati is for general informational purposes only and is not intended as medical advice. Always consult with a healthcare professional before making health-related decisions.",
                    ),
                    _buildSection(
                      "5. Prohibited Uses",
                      "You may not use Sehati:\n\n"
                      "• For any unlawful purpose\n"
                      "• To violate any laws\n"
                      "• To transmit harmful code or viruses\n"
                      "• To collect user information without consent",
                    ),
                    _buildSection(
                      "6. Limitation of Liability",
                      "Sehati shall not be liable for any indirect, incidental, special, or consequential damages arising out of or in connection with your use of the app.",
                    ),
                    _buildSection(
                      "7. Changes to Terms",
                      "We reserve the right to modify these terms at any time. Your continued use of the app after changes constitutes acceptance of the new terms.",
                    ),
                    _buildSection(
                      "8. Contact Information",
                      "For questions about these Terms of Service, please contact us at:\n\n"
                      "Email: legal@sehati.com\n"
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


