import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/view/settings_screen.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  /// Get initials from user name
  String _getInitials(String? name) {
    if (name == null || name.isEmpty) return 'GU';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }

  /// Get month name from month number
  String _getMonthName(int month) {
    const months = [
      'January', 'February', 'March', 'April', 'May', 'June',
      'July', 'August', 'September', 'October', 'November', 'December'
    ];
    return months[month - 1];
  }

  /// Get duration text from join date
  String _getDurationText(DateTime joinDate) {
    final now = DateTime.now();
    final difference = now.difference(joinDate);
    final days = difference.inDays;
    
    if (days < 1) return 'Just joined';
    if (days == 1) return '1 day';
    if (days < 7) return '$days days';
    if (days < 30) return '${(days / 7).floor()} weeks';
    if (days < 365) return '${(days / 30).floor()} months';
    
    final years = (days / 365).floor();
    final months = ((days % 365) / 30).floor();
    if (months == 0) return '$years ${years == 1 ? 'year' : 'years'}';
    return '$years ${years == 1 ? 'year' : 'years'}, $months ${months == 1 ? 'month' : 'months'}';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    const primary = Color(0xFF20C6B7);
    
    // Watch authProvider to get current user data
    final authState = ref.watch(authProvider);
    final user = authState.user;
    
    // Get user details
    final userName = user?.name ?? 'Guest User';
    final userEmail = user?.email ?? 'No email';
    final userLevel = user?.level ?? 1;
    final userXP = user?.xp ?? 0;
    final userAge = user?.age;
    final userGender = user?.gender;
    final userHeight = user?.height;
    final userWeight = user?.weight;
    final userPhone = user?.phone;
    final userAddress = user?.address;
    final userInitials = _getInitials(userName);
    final memberSince = user?.createdAt;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER WITH GRADIENT BACKGROUND -------------------------------
            Container(
              width: double.infinity,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF20C6B7),
                    Color(0xFF17A89A),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Column(
                children: [
                  SizedBox(
                    height: MediaQuery.of(context).padding.top,
                  ),
                  // TOP BAR
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    child: Row(
                      children: [
                        const Spacer(),
                        IconButton(
                          icon: const Icon(
                            Icons.settings_outlined,
                            color: Colors.white,
                            size: 24,
                          ),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const SettingsScreen(),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  // PROFILE PICTURE
                  Container(
                    width: 100,
                    height: 100,
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        userInitials,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "👑 Level $userLevel",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "• $userXP XP",
                        style: const TextStyle(
                          color: Colors.white70,
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // PERSONAL INFORMATION -------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(
                        Icons.person_outline,
                        color: primary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Personal Information",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      children: [
                        Row(
                          children: [
                            Expanded(
                              child: InfoItem(
                                "Age",
                                userAge != null ? "$userAge years" : "N/A",
                              ),
                            ),
                            Expanded(
                              child: InfoItem(
                                "Gender",
                                userGender ?? "N/A",
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                        Row(
                          children: [
                            Expanded(
                              child: InfoItem(
                                "Height",
                                userHeight != null ? "${userHeight.toStringAsFixed(0)} cm" : "N/A",
                              ),
                            ),
                            Expanded(
                              child: InfoItem(
                                "Weight",
                                userWeight != null ? "${userWeight.toStringAsFixed(0)} kg" : "N/A",
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // HEALTH STATS -----------------------------------------------
                  Row(
                    children: const [
                      Icon(
                        Icons.favorite_outline,
                        color: primary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Health Stats",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Body Mass Index",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            Text(
                              "23.7",
                              style: TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 28,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.check_circle,
                              color: Color(
                                0xFF4CAF50,
                              ),
                              size: 28,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        const Text(
                          "Normal Range",
                          style: TextStyle(
                            color: Color(
                              0xFF4CAF50,
                            ),
                            fontSize: 13,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Medical Conditions",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Wrap(
                          spacing: 8,
                          children: [
                            ConditionChip(
                              "Mild Hypertension",
                              const Color(
                                0xFFFF9800,
                              ),
                            ),
                            ConditionChip(
                              "Seasonal Allergies",
                              const Color(
                                0xFF2196F3,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 16,
                        ),
                        Text(
                          "Activity Level",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 13,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        Row(
                          children: const [
                            Text(
                              "Moderately Active",
                              style: TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Spacer(),
                            Icon(
                              Icons.directions_run,
                              color: primary,
                              size: 24,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          "3-5 days/week exercise",
                          style: TextStyle(
                            color: Colors.grey.shade600,
                            fontSize: 12,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        ClipRRect(
                          borderRadius: BorderRadius.circular(
                            10,
                          ),
                          child: LinearProgressIndicator(
                            value: 0.7,
                            minHeight: 6,
                            backgroundColor: Colors.grey.shade200,
                            valueColor:
                                const AlwaysStoppedAnimation<
                                  Color
                                >(
                                  primary,
                                ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // CONTACT INFORMATION ----------------------------------------
                  Row(
                    children: const [
                      Icon(
                        Icons.contact_mail_outlined,
                        color: primary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Contact Information",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  ContactItem(
                    Icons.email_outlined,
                    "Email",
                    userEmail,
                    primary,
                  ),
                  const SizedBox(height: 12),
                  ContactItem(
                    Icons.phone_outlined,
                    "Phone",
                    userPhone ?? "Not set",
                    primary,
                  ),
                  const SizedBox(height: 12),
                  ContactItem(
                    Icons.location_on_outlined,
                    "Address",
                    userAddress ?? "Not set",
                    primary,
                  ),

                  const SizedBox(
                    height: 24,
                  ),

                  // ACCOUNT DETAILS --------------------------------------------
                  Row(
                    children: const [
                      Icon(
                        Icons.history,
                        color: primary,
                        size: 20,
                      ),
                      SizedBox(
                        width: 8,
                      ),
                      Text(
                        "Account Details",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Container(
                    padding: const EdgeInsets.all(
                      18,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(
                        16,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade200,
                      ),
                    ),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(
                            10,
                          ),
                          decoration: BoxDecoration(
                            color: primary.withOpacity(
                              0.15,
                            ),
                            borderRadius: BorderRadius.circular(
                              10,
                            ),
                          ),
                          child: const Icon(
                            Icons.calendar_today,
                            color: primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(
                          width: 14,
                        ),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Member Since",
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(
                                height: 4,
                              ),
                              Text(
                                memberSince != null
                                    ? "${_getMonthName(memberSince.month)} ${memberSince.day}, ${memberSince.year}"
                                    : "Recently joined",
                                style: const TextStyle(
                                  color: Color(0xFF1A2A2C),
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                memberSince != null
                                    ? "${_getDurationText(memberSince)} with Sehati"
                                    : "Welcome to Sehati!",
                                style: TextStyle(
                                  color: Colors.grey.shade500,
                                  fontSize: 12,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(
                    height: 40,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
