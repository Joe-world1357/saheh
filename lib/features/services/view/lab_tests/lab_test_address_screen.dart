import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'lab_test_success_screen.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_theme.dart';
import '../../../../core/validators/validators.dart';
import '../../../../shared/widgets/app_form_fields.dart';
import '../../../../shared/widgets/app_card.dart';
import '../../../../providers/appointments_provider.dart';
import '../../../../providers/auth_provider.dart';
import '../../../../models/appointment_model.dart';

class LabTestAddressScreen extends ConsumerStatefulWidget {
  final String testName;
  final double price;
  final DateTime date;
  final String time;

  const LabTestAddressScreen({
    super.key,
    required this.testName,
    required this.price,
    required this.date,
    required this.time,
  });

  @override
  ConsumerState<LabTestAddressScreen> createState() => _LabTestAddressScreenState();
}

class _LabTestAddressScreenState extends ConsumerState<LabTestAddressScreen> {
  final _formKey = GlobalKey<FormState>();
  final _houseNumberController = TextEditingController();
  final _landmarkController = TextEditingController();
  final _addressTitleController = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() {
    _houseNumberController.dispose();
    _landmarkController.dispose();
    _addressTitleController.dispose();
    super.dispose();
  }

  Future<void> _saveAddressAndBook() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final user = ref.read(authProvider).user;
      final fullAddress = '${_houseNumberController.text.trim()}, ${_landmarkController.text.trim().isNotEmpty ? _landmarkController.text.trim() + ', ' : ''}${user?.address ?? ''}';

      final appointment = AppointmentModel(
        userEmail: '', // Will be set by provider
        type: 'lab_test',
        providerName: widget.testName,
        specialty: 'Lab Test',
        appointmentDate: widget.date,
        time: widget.time,
        status: 'upcoming',
        notes: 'Address: $fullAddress\nTitle: ${_addressTitleController.text.trim()}',
      );

      final success = await ref.read(appointmentsProvider.notifier).bookAppointment(appointment);

      if (mounted) {
        if (success) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (_) => LabTestSuccessScreen(
                testName: widget.testName,
                date: widget.date,
                time: widget.time,
                address: fullAddress,
              ),
            ),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(ref.read(appointmentsProvider).error ?? 'Failed to book test'),
              backgroundColor: AppColors.getError(Theme.of(context).brightness),
            ),
          );
        }
      }
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);
    final user = ref.watch(authProvider).user;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Delivery Address', style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Current Address Card
                AppCard(
                  padding: const EdgeInsets.all(16),
                  backgroundColor: primary.withValues(alpha: 0.1),
                  child: Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        color: primary,
                        size: 28,
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user?.address ?? 'No address set',
                              style: theme.textTheme.bodyLarge?.copyWith(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 4),
                            Text(
                              'Default address from profile',
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

                const SizedBox(height: 24),

                // Address Details
                Text(
                  'Address Details',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),

                AppTextField(
                  controller: _houseNumberController,
                  label: 'House Number / Flat / Block No.',
                  hint: 'e.g. 123, Flat 4B',
                  validator: Validators.required,
                  prefixIcon: Icons.home,
                ),

                const SizedBox(height: 20),

                AppTextField(
                  controller: _landmarkController,
                  label: 'Landmark (Optional)',
                  hint: 'e.g. Near ABC School',
                  prefixIcon: Icons.place,
                ),

                const SizedBox(height: 20),

                AppTextField(
                  controller: _addressTitleController,
                  label: 'Address Title',
                  hint: 'e.g. Home, Office',
                  validator: Validators.required,
                  prefixIcon: Icons.label,
                ),

                const SizedBox(height: 32),

                // Test Summary
                AppCard(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Test',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            widget.testName,
                            style: theme.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            'Price',
                            style: theme.textTheme.bodyMedium,
                          ),
                          Text(
                            '\$${widget.price.toStringAsFixed(2)}',
                            style: theme.textTheme.titleMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                              color: primary,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),

                const SizedBox(height: 24),

                // Save & Book Button
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: _isLoading ? null : _saveAddressAndBook,
                    style: FilledButton.styleFrom(
                      backgroundColor: primary,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                            ),
                          )
                        : Text(
                            'Save Address & Book Test',
                            style: theme.textTheme.titleMedium?.copyWith(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),

                const SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
