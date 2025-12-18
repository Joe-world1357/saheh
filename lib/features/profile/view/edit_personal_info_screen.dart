import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/localization/app_localizations.dart';
import '../../../models/user_model.dart';
import '../../../providers/user_provider.dart';
import '../../../shared/widgets/app_form_fields.dart';
import '../../../core/validators/validators.dart';
import '../../../core/validators/input_formatters.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/localization/localization_helper.dart';

class EditPersonalInfoScreen extends ConsumerStatefulWidget {
  const EditPersonalInfoScreen({super.key});

  @override
  ConsumerState<EditPersonalInfoScreen> createState() => _EditPersonalInfoScreenState();
}

class _EditPersonalInfoScreenState extends ConsumerState<EditPersonalInfoScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _ageController = TextEditingController();
  final _heightController = TextEditingController();
  final _weightController = TextEditingController();
  final _addressController = TextEditingController();

  String? _selectedGender;
  String? _selectedActivityLevel;
  bool _isLoading = false;
  bool _hasChanges = false;
  UserModel? _originalUser;

  List<String> _getGenders(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    return [l10n.male, l10n.female];
  }
  final List<String> _activityLevels = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Very Active',
  ];

  @override
  void initState() {
    super.initState();
    // Load user data when screen initializes
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _loadUserData();
    });
  }

  void _loadUserData() {
    final user = ref.read(userProvider);
    if (user != null) {
      setState(() {
        _originalUser = user;
        _nameController.text = user.name;
        _emailController.text = user.email;
        _phoneController.text = user.phone ?? '';
        _ageController.text = user.age?.toString() ?? '';
        _heightController.text = user.height?.toString() ?? '';
        _weightController.text = user.weight?.toString() ?? '';
        _addressController.text = user.address ?? '';
        _selectedGender = user.gender;
        // Activity level is not in UserModel yet, but we'll add it
        _selectedActivityLevel = 'Moderate'; // Default
      });

      // Add listeners to track changes
      _nameController.addListener(_checkForChanges);
      _emailController.addListener(_checkForChanges);
      _phoneController.addListener(_checkForChanges);
      _ageController.addListener(_checkForChanges);
      _heightController.addListener(_checkForChanges);
      _weightController.addListener(_checkForChanges);
      _addressController.addListener(_checkForChanges);
    }
  }

  void _checkForChanges() {
    if (_originalUser == null) return;
    
    final hasChanges = 
        _nameController.text.trim() != _originalUser!.name ||
        _emailController.text.trim() != _originalUser!.email ||
        _phoneController.text.trim() != (_originalUser!.phone ?? '') ||
        _ageController.text.trim() != (_originalUser!.age?.toString() ?? '') ||
        _heightController.text.trim() != (_originalUser!.height?.toString() ?? '') ||
        _weightController.text.trim() != (_originalUser!.weight?.toString() ?? '') ||
        _addressController.text.trim() != (_originalUser!.address ?? '') ||
        _selectedGender != _originalUser!.gender;

    if (hasChanges != _hasChanges) {
      setState(() {
        _hasChanges = hasChanges;
      });
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    _ageController.dispose();
    _heightController.dispose();
    _weightController.dispose();
    _addressController.dispose();
    super.dispose();
  }

  Future<void> _saveChanges() async {
    if (!_formKey.currentState!.validate() || !_hasChanges) {
      return;
    }

    setState(() => _isLoading = true);

    try {
      final userNotifier = ref.read(userProvider.notifier);
      final currentUser = ref.read(userProvider);

      if (currentUser == null) {
        throw Exception('User not found. Please log in again.');
      }

      final updatedUser = currentUser.copyWith(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        phone: _phoneController.text.trim().isEmpty ? null : _phoneController.text.trim(),
        age: _ageController.text.trim().isEmpty ? null : int.tryParse(_ageController.text.trim()),
        gender: _selectedGender,
        height: _heightController.text.trim().isEmpty ? null : double.tryParse(_heightController.text.trim()),
        weight: _weightController.text.trim().isEmpty ? null : double.tryParse(_weightController.text.trim()),
        address: _addressController.text.trim().isEmpty ? null : _addressController.text.trim(),
        updatedAt: DateTime.now(),
      );

      await userNotifier.updateUser(updatedUser);

      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.personalInformationUpdated),
            backgroundColor: AppColors.getSuccess(Theme.of(context).brightness),
          ),
        );
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        final l10n = AppLocalizations.of(context)!;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l10n.errorUpdatingInformation(e.toString())),
            backgroundColor: AppColors.getError(Theme.of(context).brightness),
          ),
        );
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
    final l10n = AppLocalizations.of(context)!;
    final user = ref.watch(userProvider);
    final genders = _getGenders(context);

    // Show loading if user is not loaded yet
    if (user == null && _originalUser == null) {
      return Scaffold(
        backgroundColor: theme.scaffoldBackgroundColor,
        appBar: AppBar(
          backgroundColor: theme.colorScheme.surface,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
            onPressed: () => Navigator.pop(context),
          ),
          title: Text(l10n.editPersonalInfo, style: theme.textTheme.titleLarge),
        ),
        body: const Center(child: CircularProgressIndicator()),
      );
    }

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text(l10n.editPersonalInfo, style: theme.textTheme.titleLarge),
      ),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 8),

                // NAME
                AppTextField(
                  controller: _nameController,
                  label: l10n.fullName,
                  hint: l10n.enterYourFullName,
                  validator: Validators.name,
                  prefixIcon: Icons.person_outline,
                  inputFormatters: [AppInputFormatters.name()],
                  textCapitalization: TextCapitalization.words,
                ),

                const SizedBox(height: 20),

                // EMAIL (read-only - email shouldn't be changed)
                AppTextField(
                  controller: _emailController,
                  label: l10n.email,
                  hint: l10n.enterYourEmail,
                  readOnly: true,
                  prefixIcon: Icons.email_outlined,
                  validator: Validators.email,
                ),

                const SizedBox(height: 20),

                // PHONE
                AppTextField(
                  controller: _phoneController,
                  label: l10n.phone,
                  hint: l10n.enterYourPhone,
                  validator: (value) {
                    if (value == null || value.trim().isEmpty) {
                      return null; // Optional field
                    }
                    return Validators.phone(value);
                  },
                  keyboardType: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  inputFormatters: [AppInputFormatters.phone()],
                ),

                const SizedBox(height: 20),

                // AGE & GENDER
                Row(
                  children: [
                    Expanded(
                      child: AppNumberField(
                        controller: _ageController,
                        label: l10n.age,
                        hint: l10n.enterAge,
                        validator: Validators.age,
                        min: 1,
                        max: 150,
                        prefixIcon: Icons.calendar_today_outlined,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(l10n.gender, style: theme.textTheme.labelLarge),
                          const SizedBox(height: 8),
                          DropdownButtonFormField<String>(
                            value: _selectedGender,
                            decoration: InputDecoration(
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                              ),
                              contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                            ),
                            items: genders.map((gender) => DropdownMenuItem(
                              value: gender,
                              child: Text(gender),
                            )).toList(),
                            onChanged: (value) {
                              setState(() {
                                _selectedGender = value;
                                _checkForChanges();
                              });
                            },
                            validator: (value) => value == null ? l10n.pleaseSelectGender : null,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // HEIGHT & WEIGHT
                Row(
                  children: [
                    Expanded(
                      child: AppNumberField(
                        controller: _heightController,
                        label: l10n.height,
                        hint: l10n.enterHeight,
                        validator: Validators.height,
                        min: 50,
                        max: 300,
                        allowDecimal: true,
                        prefixIcon: Icons.height,
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: AppNumberField(
                        controller: _weightController,
                        label: l10n.weight,
                        hint: l10n.enterWeight,
                        validator: Validators.weight,
                        min: 10,
                        max: 500,
                        allowDecimal: true,
                        prefixIcon: Icons.monitor_weight_outlined,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ACTIVITY LEVEL
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(l10n.activityLevel, style: theme.textTheme.labelLarge),
                    const SizedBox(height: 8),
                    DropdownButtonFormField<String>(
                      value: _selectedActivityLevel,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                        ),
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                        prefixIcon: const Icon(Icons.fitness_center),
                      ),
                      items: _activityLevels.map((level) => DropdownMenuItem(
                        value: level,
                        child: Text(level),
                      )).toList(),
                      onChanged: (value) {
                        setState(() {
                          _selectedActivityLevel = value;
                          _checkForChanges();
                        });
                      },
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                // ADDRESS
                AppTextField(
                  controller: _addressController,
                  label: l10n.address,
                  hint: l10n.enterYourAddress,
                  prefixIcon: Icons.location_on_outlined,
                  maxLines: 3,
                  validator: (value) {
                    // Optional field
                    return null;
                  },
                ),

                const SizedBox(height: 32),

                // SAVE BUTTON
                SizedBox(
                  width: double.infinity,
                  child: FilledButton(
                    onPressed: (_isLoading || !_hasChanges) ? null : _saveChanges,
                    style: FilledButton.styleFrom(
                      padding: const EdgeInsets.symmetric(vertical: 16),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
                      ),
                    ),
                    child: _isLoading
                        ? const SizedBox(
                            height: 20,
                            width: 20,
                            child: CircularProgressIndicator(strokeWidth: 2),
                          )
                        : Text(
                            l10n.saveChanges,
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: theme.colorScheme.onPrimary,
                            ),
                          ),
                  ),
                ),

                if (!_hasChanges && _originalUser != null)
                  Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      l10n.noChangesMade,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: theme.colorScheme.onSurfaceVariant,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),

                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
