import 'package:flutter/material.dart';
import 'clinic/clinic_dashboard.dart';
import 'home_health/home_health_dashboard.dart';
import 'lab_tests/lab_tests_screen.dart';

class ServicesScreen
    extends
        StatelessWidget {
  const ServicesScreen({
    super.key,
  });

  @override
  Widget build(
    BuildContext context,
  ) {
    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        bottom: false,
        child: Column(
          children: [
            // Header
            const Padding(
              padding: EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 20,
              ),
              child: Row(
                children: [
                  Text(
                    "Services",
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF1A2A2C,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(
              height: 10,
            ),

            // Content Area
            Expanded(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                ),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      // Upcoming Appointment Card
                      Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(
                          16,
                        ),
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [
                              Color(
                                0xFFE0F7FA,
                              ),
                              Color(
                                0xFFB2EBF2,
                              ),
                            ],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(
                            20,
                          ),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(
                                0.05,
                              ),
                              blurRadius: 10,
                              offset: const Offset(
                                0,
                                4,
                              ),
                            ),
                          ],
                        ),
                        child: Row(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(
                                10,
                              ),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                shape: BoxShape.circle,
                              ),
                              child: const Icon(
                                Icons.calendar_today,
                                color: Color(
                                  0xFF00ACC1,
                                ),
                                size: 24,
                              ),
                            ),
                            const SizedBox(
                              width: 16,
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const Text(
                                    "Upcoming Appointment",
                                    style: TextStyle(
                                      fontSize: 14,
                                      fontWeight: FontWeight.bold,
                                      color: Color(
                                        0xFF006064,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 4,
                                  ),
                                  Text(
                                    "Your blood test is scheduled for Tuesday at 10 AM.",
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: Colors.grey.shade700,
                                      height: 1.4,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),

                      // Service List
                      _buildServiceCard(
                        context,
                        title: "Clinic Booking",
                        subtitle: "Specialist doctors",
                        icon: Icons.calendar_month_outlined,
                        color: const Color(
                          0xFFE0F7FA,
                        ),
                        iconColor: const Color(
                          0xFF00ACC1,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (
                                    context,
                                  ) => const ClinicDashboard(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildServiceCard(
                        context,
                        title: "Home Health",
                        subtitle: "Caregivers & Nurses",
                        icon: Icons.medical_services_outlined,
                        color: const Color(
                          0xFFFFF3E0,
                        ),
                        iconColor: const Color(
                          0xFFFF9800,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (
                                    context,
                                  ) => const HomeHealthDashboard(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      _buildServiceCard(
                        context,
                        title: "Lab Tests",
                        subtitle: "Home sample collection",
                        icon: Icons.science_outlined,
                        color: const Color(
                          0xFFE8F5E9,
                        ),
                        iconColor: const Color(
                          0xFF4DB6AC,
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (
                                    context,
                                  ) => const LabTestsScreen(),
                            ),
                          );
                        },
                      ),
                      const SizedBox(
                        height: 80,
                      ), // Extra space for bottom nav
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

  Widget _buildServiceCard(
    BuildContext context, {
    required String title,
    required String subtitle,
    required IconData icon,
    required Color color,
    required Color iconColor,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(
          24,
        ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            16,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(
                0.05,
              ),
              blurRadius: 10,
              offset: const Offset(
                0,
                4,
              ),
            ),
          ],
        ),
        child: Row(
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(
                icon,
                color: iconColor,
                size: 30,
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color(
                        0xFF1A2A2C,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.grey.shade600,
                    ),
                  ),
                ],
              ),
            ),
            const Icon(
              Icons.arrow_forward_ios_rounded,
              size: 20,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }
}
