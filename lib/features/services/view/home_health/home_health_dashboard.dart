import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'caregiver_detail_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../providers/appointments_provider.dart';

class HomeHealthDashboard extends ConsumerStatefulWidget {
  const HomeHealthDashboard({super.key});

  @override
  ConsumerState<HomeHealthDashboard> createState() => _HomeHealthDashboardState();
}

class _HomeHealthDashboardState extends ConsumerState<HomeHealthDashboard> {
  String _searchQuery = '';
  String _selectedService = 'All';

  final List<String> _services = ['All', 'Nurse', 'Caregiver', 'Physical Therapy', 'Medical Equipment'];

  final List<Map<String, dynamic>> _caregivers = [
    {
      'name': 'Nurse Sarah Johnson',
      'role': 'Home Nurse',
      'rating': 4.9,
      'experience': '12 years',
      'price': 80.0,
      'service': 'Nurse',
      'specialties': ['Wound Care', 'Medication Management', 'Health Monitoring'],
    },
    {
      'name': 'Caregiver Michael Chen',
      'role': 'Elderly Care Specialist',
      'rating': 4.8,
      'experience': '15 years',
      'price': 70.0,
      'service': 'Caregiver',
      'specialties': ['Daily Living Assistance', 'Companionship', 'Meal Preparation'],
    },
    {
      'name': 'Nurse Emily Davis',
      'role': 'Pediatric Nurse',
      'rating': 4.7,
      'experience': '10 years',
      'price': 85.0,
      'service': 'Nurse',
      'specialties': ['Child Care', 'Health Monitoring', 'Vaccination'],
    },
    {
      'name': 'Therapist James Wilson',
      'role': 'Physical Therapist',
      'rating': 4.9,
      'experience': '18 years',
      'price': 100.0,
      'service': 'Physical Therapy',
      'specialties': ['Rehabilitation', 'Exercise Therapy', 'Pain Management'],
    },
  ];

  List<Map<String, dynamic>> get _filteredCaregivers {
    var filtered = _caregivers;

    if (_selectedService != 'All') {
      filtered = filtered
          .where((caregiver) => caregiver['service'] == _selectedService)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((caregiver) =>
              caregiver['name']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              caregiver['role']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
    }

    return filtered;
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final warningColor = AppColors.getWarning(brightness);
    final appointmentsState = ref.watch(appointmentsProvider);
    final upcomingAppointments = appointmentsState.appointments
        .where((apt) =>
            apt.type == 'home_health' &&
            apt.status == 'upcoming' &&
            apt.appointmentDate.isAfter(DateTime.now()))
        .toList()
      ..sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Home Health', style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Search Bar
            Padding(
              padding: const EdgeInsets.all(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.colorScheme.surfaceContainerHighest,
                  borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                  border: Border.all(
                    color: theme.colorScheme.outline.withValues(alpha: 0.1),
                  ),
                ),
                child: TextField(
                  onChanged: (value) => setState(() => _searchQuery = value),
                  style: theme.textTheme.bodyLarge,
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Search caregivers, services...",
                    hintStyle: theme.textTheme.bodyLarge?.copyWith(
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                    icon: Icon(
                      Icons.search,
                      color: theme.colorScheme.onSurfaceVariant,
                    ),
                  ),
                ),
              ),
            ),

            // Service Types
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _services.length,
                itemBuilder: (context, index) {
                  final service = _services[index];
                  final isSelected = _selectedService == service;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedService = service),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? warningColor : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(
                          color: isSelected
                              ? warningColor
                              : theme.colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          service,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: isSelected
                                ? Colors.white
                                : theme.colorScheme.onSurface,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 16),

            // Upcoming Appointments Banner
            if (upcomingAppointments.isNotEmpty)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: AppCard(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: warningColor.withValues(alpha: 0.1),
                  border: Border.all(
                    color: warningColor.withValues(alpha: 0.3),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.medical_services,
                        color: warningColor,
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upcoming Service',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: warningColor,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '${upcomingAppointments.first.providerName} - ${upcomingAppointments.first.appointmentDate.day}/${upcomingAppointments.first.appointmentDate.month}',
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
              ),

            const SizedBox(height: 16),

            // Caregivers List
            Expanded(
              child: _filteredCaregivers.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.search_off,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            'No caregivers found',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredCaregivers.length,
                      itemBuilder: (context, index) {
                        final caregiver = _filteredCaregivers[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppCard(
                            padding: const EdgeInsets.all(16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => CaregiverDetailScreen(
                                    name: caregiver['name'] as String,
                                    role: caregiver['role'] as String,
                                    rating: caregiver['rating'] as double,
                                    experience: caregiver['experience'] as String,
                                    price: caregiver['price'] as double,
                                    specialties: caregiver['specialties'] as List<String>,
                                  ),
                                ),
                              );
                            },
                            child: Row(
                              children: [
                                Container(
                                  width: 70,
                                  height: 70,
                                  decoration: BoxDecoration(
                                    color: warningColor.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                  ),
                                  child: Icon(
                                    Icons.medical_services,
                                    color: warningColor,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        caregiver['name'] as String,
                                        style: theme.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        caregiver['role'] as String,
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          color: theme.colorScheme.onSurfaceVariant,
                                        ),
                                      ),
                                      const SizedBox(height: 8),
                                      Row(
                                        children: [
                                          Icon(
                                            Icons.star_rounded,
                                            color: AppColors.getWarning(brightness),
                                            size: 16,
                                          ),
                                          const SizedBox(width: 4),
                                          Text(
                                            '${caregiver['rating']}',
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            '• ${caregiver['experience']}',
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              color: theme.colorScheme.onSurfaceVariant,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      '\$${caregiver['price']}',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: warningColor,
                                      ),
                                    ),
                                    Text(
                                      'per hour',
                                      style: theme.textTheme.bodySmall?.copyWith(
                                        color: theme.colorScheme.onSurfaceVariant,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}
