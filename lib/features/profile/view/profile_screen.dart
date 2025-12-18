import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../settings/view/settings_screen.dart';
import '../../../shared/widgets/common_widgets.dart';
import '../../../providers/auth_provider.dart';
import '../../../providers/activity_provider.dart';
import '../../../providers/men_workout_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';

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
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    
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
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER WITH GRADIENT BACKGROUND
            Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: AppTheme.primaryGradient(brightness),
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
                          icon: Icon(
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
                      color: Colors.white.withValues(alpha: 0.3),
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: Colors.white,
                        width: 3,
                      ),
                    ),
                    child: Center(
                      child: Text(
                        userInitials,
                        style: theme.textTheme.headlineMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    userName,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "👑 Level $userLevel",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Text(
                        "• $userXP XP",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          color: Colors.white70,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),

            // PERSONAL INFORMATION
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(
                        Icons.person_outline,
                        color: primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Personal Information",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    padding: const EdgeInsets.all(18),
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

                  const SizedBox(height: 24),

                  // HEALTH STATS
                  _buildHealthStats(context, ref, primary, userHeight, userWeight),

                  const SizedBox(height: 24),

                  // CONTACT INFORMATION
                  Row(
                    children: [
                      Icon(
                        Icons.contact_mail_outlined,
                        color: primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Contact Information",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
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

                  const SizedBox(height: 24),

                  // ACCOUNT DETAILS
                  Row(
                    children: [
                      Icon(
                        Icons.history,
                        color: primary,
                        size: 20,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        "Account Details",
                        style: theme.textTheme.titleSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  AppCard(
                    padding: const EdgeInsets.all(18),
                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            color: primary.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Icon(
                            Icons.calendar_today,
                            color: primary,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                "Member Since",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                memberSince != null
                                    ? "${_getMonthName(memberSince.month)} ${memberSince.day}, ${memberSince.year}"
                                    : "Recently joined",
                                style: theme.textTheme.bodyLarge?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              const SizedBox(height: 2),
                              Text(
                                memberSince != null
                                    ? "${_getDurationText(memberSince)} with Sehati"
                                    : "Welcome to Sehati!",
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHealthStats(BuildContext context, WidgetRef ref, Color primary, double? height, double? weight) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final activityState = ref.watch(activityProvider);
    final workoutState = ref.watch(menWorkoutProvider);
    
    // Calculate BMI
    double? bmi;
    String bmiCategory = 'N/A';
    Color bmiColor = AppColors.getInfo(brightness);
    if (height != null && weight != null && height > 0) {
      final heightM = height / 100;
      bmi = weight / (heightM * heightM);
      if (bmi < 18.5) {
        bmiCategory = 'Underweight';
        bmiColor = AppColors.getWarning(brightness);
      } else if (bmi < 25) {
        bmiCategory = 'Normal';
        bmiColor = AppColors.getSuccess(brightness);
      } else if (bmi < 30) {
        bmiCategory = 'Overweight';
        bmiColor = AppColors.getWarning(brightness);
      } else {
        bmiCategory = 'Obese';
        bmiColor = AppColors.getError(brightness);
      }
    }

    final todayActivity = activityState.todayActivity;
    final weeklyStats = activityState.stats['weekly'] as Map<String, dynamic>? ?? {};
    final workoutStats = workoutState.stats['total'] as Map<String, dynamic>? ?? {};

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(
              Icons.favorite_outline,
              color: primary,
              size: 20,
            ),
            const SizedBox(width: 8),
            Text(
              "Health Stats",
              style: theme.textTheme.titleSmall?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        const SizedBox(height: 16),
        AppCard(
          padding: const EdgeInsets.all(18),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // BMI Section
              Text(
                "Body Mass Index",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Text(
                    bmi != null ? bmi.toStringAsFixed(1) : 'N/A',
                    style: theme.textTheme.headlineMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  Icon(
                    bmi != null ? Icons.check_circle : Icons.help_outline,
                    color: bmiColor,
                    size: 28,
                  ),
                ],
              ),
              const SizedBox(height: 4),
              Text(
                bmiCategory,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: bmiColor,
                  fontWeight: FontWeight.w600,
                ),
              ),
              
              const SizedBox(height: 16),
              Divider(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
              const SizedBox(height: 16),
              
              // Today's Activity
              Text(
                "Today's Activity",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatColumn(
                    Icons.directions_walk,
                    '${todayActivity?.steps ?? 0}',
                    'Steps',
                    AppColors.getInfo(brightness),
                    theme,
                  ),
                  _StatColumn(
                    Icons.timer,
                    '${todayActivity?.activeMinutes ?? 0}',
                    'Minutes',
                    AppColors.getSuccess(brightness),
                    theme,
                  ),
                  _StatColumn(
                    Icons.local_fire_department,
                    '${(todayActivity?.caloriesBurned ?? 0).toInt()}',
                    'Calories',
                    AppColors.getWarning(brightness),
                    theme,
                  ),
                ],
              ),
              
              const SizedBox(height: 16),
              Divider(color: theme.colorScheme.outline.withValues(alpha: 0.2)),
              const SizedBox(height: 16),
              
              // Weekly Summary
              Text(
                "This Week",
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  _StatColumn(
                    Icons.directions_walk,
                    '${weeklyStats['total_steps'] ?? 0}',
                    'Steps',
                    AppColors.getInfo(brightness),
                    theme,
                  ),
                  _StatColumn(
                    Icons.fitness_center,
                    '${workoutStats['total_workouts'] ?? 0}',
                    'Workouts',
                    primary,
                    theme,
                  ),
                  _StatColumn(
                    Icons.local_fire_department,
                    '${((weeklyStats['total_calories'] ?? 0) as num).toInt()}',
                    'Calories',
                    AppColors.getWarning(brightness),
                    theme,
                  ),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _StatColumn extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;
  final Color color;
  final ThemeData theme;

  const _StatColumn(this.icon, this.value, this.label, this.color, this.theme);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, color: color, size: 24),
        const SizedBox(height: 4),
        Text(
          value,
          style: theme.textTheme.titleMedium?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
        Text(
          label,
          style: theme.textTheme.bodySmall?.copyWith(
            color: theme.colorScheme.onSurfaceVariant,
          ),
        ),
      ],
    );
  }
}
