import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'doctor_detail_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../providers/appointments_provider.dart';

class ClinicDashboard extends ConsumerStatefulWidget {
  const ClinicDashboard({super.key});

  @override
  ConsumerState<ClinicDashboard> createState() => _ClinicDashboardState();
}

class _ClinicDashboardState extends ConsumerState<ClinicDashboard> {
  String _selectedCategory = 'All';
  String _searchQuery = '';

  final List<String> _categories = [
    'All',
    'General',
    'Cardiology',
    'Dentist',
    'Neurology',
    'Orthopedic',
    'Dermatology',
    'Pediatrics',
  ];

  final List<Map<String, dynamic>> _doctors = [
    {
      'name': 'Dr. Sarah Johnson',
      'specialty': 'General Practitioner',
      'rating': 4.9,
      'experience': '15 years',
      'price': 150.0,
      'category': 'General',
    },
    {
      'name': 'Dr. Michael Chen',
      'specialty': 'Cardiologist',
      'rating': 4.8,
      'experience': '20 years',
      'price': 250.0,
      'category': 'Cardiology',
    },
    {
      'name': 'Dr. Jenny Wilson',
      'specialty': 'Dental Surgeon',
      'rating': 4.8,
      'experience': '12 years',
      'price': 200.0,
      'category': 'Dentist',
    },
    {
      'name': 'Dr. David Brown',
      'specialty': 'Neurologist',
      'rating': 4.7,
      'experience': '18 years',
      'price': 300.0,
      'category': 'Neurology',
    },
    {
      'name': 'Dr. Emily Davis',
      'specialty': 'Orthopedic Surgeon',
      'rating': 4.9,
      'experience': '14 years',
      'price': 280.0,
      'category': 'Orthopedic',
    },
    {
      'name': 'Dr. James Miller',
      'specialty': 'Dermatologist',
      'rating': 4.6,
      'experience': '10 years',
      'price': 180.0,
      'category': 'Dermatology',
    },
  ];

  List<Map<String, dynamic>> get _filteredDoctors {
    var filtered = _doctors;

    if (_selectedCategory != 'All') {
      filtered = filtered
          .where((doctor) => doctor['category'] == _selectedCategory)
          .toList();
    }

    if (_searchQuery.isNotEmpty) {
      filtered = filtered
          .where((doctor) =>
              doctor['name']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()) ||
              doctor['specialty']
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
    final appointmentsState = ref.watch(appointmentsProvider);
    final upcomingAppointments = appointmentsState.appointments
        .where((apt) =>
            apt.type == 'clinic' &&
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
        title: Text('Clinic Booking', style: theme.textTheme.titleLarge),
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
                    hintText: "Search doctors, specialties...",
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

            // Categories
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  final isSelected = _selectedCategory == category;

                  return GestureDetector(
                    onTap: () => setState(() => _selectedCategory = category),
                    child: Container(
                      margin: const EdgeInsets.only(right: 12),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primary : theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                        border: Border.all(
                          color: isSelected
                              ? primary
                              : theme.colorScheme.outline.withValues(alpha: 0.2),
                        ),
                      ),
                      child: Center(
                        child: Text(
                          category,
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
                  backgroundColor: AppColors.getInfo(brightness).withValues(alpha: 0.1),
                  border: Border.all(
                    color: AppColors.getInfo(brightness).withValues(alpha: 0.3),
                  ),
                  child: Row(
                    children: [
                      Icon(
                        Icons.calendar_today,
                        color: AppColors.getInfo(brightness),
                        size: 24,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Upcoming Appointment',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.getInfo(brightness),
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

            // Doctors List
            Expanded(
              child: _filteredDoctors.isEmpty
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
                            'No doctors found',
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      itemCount: _filteredDoctors.length,
                      itemBuilder: (context, index) {
                        final doctor = _filteredDoctors[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 12),
                          child: AppCard(
                            padding: const EdgeInsets.all(16),
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DoctorDetailScreen(
                                    doctorName: doctor['name'] as String,
                                    specialty: doctor['specialty'] as String,
                                    rating: doctor['rating'] as double,
                                    experience: doctor['experience'] as String,
                                    price: doctor['price'] as double,
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
                                    color: primary.withValues(alpha: 0.15),
                                    borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                                  ),
                                  child: Icon(
                                    Icons.person,
                                    color: primary,
                                    size: 36,
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        doctor['name'] as String,
                                        style: theme.textTheme.titleSmall?.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 4),
                                      Text(
                                        doctor['specialty'] as String,
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
                                            '${doctor['rating']}',
                                            style: theme.textTheme.bodySmall?.copyWith(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 12),
                                          Text(
                                            '• ${doctor['experience']}',
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
                                      '\$${doctor['price']}',
                                      style: theme.textTheme.titleMedium?.copyWith(
                                        fontWeight: FontWeight.bold,
                                        color: primary,
                                      ),
                                    ),
                                    Text(
                                      'per visit',
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
