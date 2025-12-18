import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'lab_test_detail_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../providers/appointments_provider.dart';

class LabTestsScreen extends ConsumerStatefulWidget {
  const LabTestsScreen({super.key});

  @override
  ConsumerState<LabTestsScreen> createState() => _LabTestsScreenState();
}

class _LabTestsScreenState extends ConsumerState<LabTestsScreen> {
  String _searchQuery = '';
  String _selectedTab = 'Browse';

  final List<Map<String, dynamic>> _testCategories = [
    {
      'name': 'Blood Tests',
      'icon': Icons.bloodtype,
      'color': (brightness) => AppColors.getError(brightness),
      'tests': [
        {'name': 'Complete Blood Count (CBC)', 'price': 50.0, 'fasting': true},
        {'name': 'Hemoglobin', 'price': 30.0, 'fasting': false},
        {'name': 'Hematocrit', 'price': 30.0, 'fasting': false},
        {'name': 'Lipid Panel', 'price': 60.0, 'fasting': true},
        {'name': 'Liver Function Test', 'price': 70.0, 'fasting': true},
      ],
    },
    {
      'name': 'Diabetes Tests',
      'icon': Icons.monitor_heart,
      'color': (brightness) => AppColors.getWarning(brightness),
      'tests': [
        {'name': 'HbA1c (Glycated Hemoglobin)', 'price': 55.0, 'fasting': false},
        {'name': 'Fasting Blood Glucose', 'price': 40.0, 'fasting': true},
        {'name': 'Insulin', 'price': 80.0, 'fasting': true},
        {'name': 'Microalbuminuria', 'price': 45.0, 'fasting': false},
      ],
    },
    {
      'name': 'Hormone Tests',
      'icon': Icons.science,
      'color': (brightness) => AppColors.getInfo(brightness),
      'tests': [
        {'name': 'Thyroid Function Test', 'price': 90.0, 'fasting': false},
        {'name': 'Testosterone', 'price': 75.0, 'fasting': false},
        {'name': 'Cortisol', 'price': 65.0, 'fasting': true},
      ],
    },
    {
      'name': 'Vitamin Tests',
      'icon': Icons.wb_sunny,
      'color': (brightness) => AppColors.getSuccess(brightness),
      'tests': [
        {'name': 'Vitamin D', 'price': 50.0, 'fasting': false},
        {'name': 'Vitamin B12', 'price': 45.0, 'fasting': false},
        {'name': 'Folate', 'price': 40.0, 'fasting': false},
      ],
    },
  ];

  List<Map<String, dynamic>> get _filteredTests {
    if (_searchQuery.isEmpty) {
      return _testCategories;
    }

    return _testCategories.map((category) {
      final filteredTests = (category['tests'] as List)
          .where((test) =>
              test['name']
                  .toString()
                  .toLowerCase()
                  .contains(_searchQuery.toLowerCase()))
          .toList();
      return {
        ...category,
        'tests': filteredTests,
      };
    }).where((category) => (category['tests'] as List).isNotEmpty).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final successColor = AppColors.getSuccess(brightness);
    final appointmentsState = ref.watch(appointmentsProvider);
    final myRequests = appointmentsState.appointments
        .where((apt) => apt.type == 'lab_test')
        .toList()
      ..sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Lab Tests', style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Column(
          children: [
            // Tabs
            Padding(
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 'Browse'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 'Browse'
                              ? primary
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          border: Border.all(
                            color: _selectedTab == 'Browse'
                                ? primary
                                : theme.colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'Browse Tests',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _selectedTab == 'Browse'
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                              fontWeight: _selectedTab == 'Browse'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: GestureDetector(
                      onTap: () => setState(() => _selectedTab = 'My Requests'),
                      child: Container(
                        padding: const EdgeInsets.symmetric(vertical: 12),
                        decoration: BoxDecoration(
                          color: _selectedTab == 'My Requests'
                              ? primary
                              : theme.colorScheme.surface,
                          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                          border: Border.all(
                            color: _selectedTab == 'My Requests'
                                ? primary
                                : theme.colorScheme.outline.withValues(alpha: 0.2),
                          ),
                        ),
                        child: Center(
                          child: Text(
                            'My Requests (${myRequests.length})',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: _selectedTab == 'My Requests'
                                  ? Colors.white
                                  : theme.colorScheme.onSurface,
                              fontWeight: _selectedTab == 'My Requests'
                                  ? FontWeight.bold
                                  : FontWeight.normal,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),

            // Search Bar (only for Browse)
            if (_selectedTab == 'Browse')
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
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
                      hintText: "Search tests...",
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

            const SizedBox(height: 16),

            // Content
            Expanded(
              child: _selectedTab == 'Browse'
                  ? _buildBrowseTab(theme, brightness, primary)
                  : _buildMyRequestsTab(theme, brightness, myRequests),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBrowseTab(ThemeData theme, Brightness brightness, Color primary) {
    final filteredCategories = _filteredTests;

    if (filteredCategories.isEmpty) {
      return Center(
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
              'No tests found',
              style: theme.textTheme.bodyLarge,
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      itemCount: filteredCategories.length,
      itemBuilder: (context, categoryIndex) {
        final category = filteredCategories[categoryIndex];
        final categoryColorFn = category['color'] as Color Function(Brightness);
        final categoryColor = categoryColorFn(brightness);

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Icon(category['icon'] as IconData, color: categoryColor, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      category['name'] as String,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 12),
            SizedBox(
              height: 140,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: (category['tests'] as List).length,
                itemBuilder: (context, testIndex) {
                  final test = (category['tests'] as List)[testIndex];
                  return Padding(
                    padding: const EdgeInsets.only(right: 12),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => LabTestDetailScreen(
                              testName: test['name'] as String,
                              price: test['price'] as double,
                              requiresFasting: test['fasting'] as bool,
                            ),
                          ),
                        );
                      },
                      child: AppCard(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                color: categoryColor.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Icon(
                                category['icon'] as IconData,
                                color: categoryColor,
                                size: 24,
                              ),
                            ),
                            const SizedBox(height: 12),
                            Expanded(
                              child: Text(
                                test['name'] as String,
                                style: theme.textTheme.bodySmall?.copyWith(
                                  fontWeight: FontWeight.bold,
                                ),
                                maxLines: 3,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              '\$${test['price']}',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.bold,
                                color: primary,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            const SizedBox(height: 24),
          ],
        );
      },
    );
  }

  Widget _buildMyRequestsTab(ThemeData theme, Brightness brightness, List appointments) {
    if (appointments.isEmpty) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.description_outlined,
              size: 64,
              color: theme.colorScheme.onSurfaceVariant,
            ),
            const SizedBox(height: 16),
            Text(
              'No test requests yet',
              style: theme.textTheme.bodyLarge,
            ),
            const SizedBox(height: 8),
            Text(
              'Browse tests to request one',
              style: theme.textTheme.bodySmall?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: appointments.length,
      itemBuilder: (context, index) {
        final appointment = appointments[index];
        return Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: AppCard(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.getInfo(brightness).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        Icons.science,
                        color: AppColors.getInfo(brightness),
                        size: 20,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            appointment.providerName,
                            style: theme.textTheme.titleSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            '${appointment.appointmentDate.day}/${appointment.appointmentDate.month}/${appointment.appointmentDate.year} at ${appointment.time}',
                            style: theme.textTheme.bodySmall?.copyWith(
                              color: theme.colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: appointment.status == 'upcoming'
                            ? AppColors.getInfo(brightness).withValues(alpha: 0.15)
                            : AppColors.getSuccess(brightness).withValues(alpha: 0.15),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Text(
                        appointment.status.toUpperCase(),
                        style: theme.textTheme.labelSmall?.copyWith(
                          color: appointment.status == 'upcoming'
                              ? AppColors.getInfo(brightness)
                              : AppColors.getSuccess(brightness),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
