import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../providers/fitness_onboarding_provider.dart';

class FitnessOnboardingScreen extends ConsumerStatefulWidget {
  final VoidCallback? onComplete;
  
  const FitnessOnboardingScreen({super.key, this.onComplete});

  @override
  ConsumerState<FitnessOnboardingScreen> createState() => _FitnessOnboardingScreenState();
}

class _FitnessOnboardingScreenState extends ConsumerState<FitnessOnboardingScreen>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  void _nextPage() {
    final state = ref.read(fitnessOnboardingProvider);
    if (state.currentStep < 4) {
      ref.read(fitnessOnboardingProvider.notifier).nextStep();
      _pageController.nextPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void _previousPage() {
    final state = ref.read(fitnessOnboardingProvider);
    if (state.currentStep > 0) {
      ref.read(fitnessOnboardingProvider.notifier).previousStep();
      _pageController.previousPage(
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  Future<void> _completeOnboarding() async {
    final success = await ref.read(fitnessOnboardingProvider.notifier).completeOnboarding();
    if (success && mounted) {
      if (widget.onComplete != null) {
        widget.onComplete!();
      } else {
        Navigator.of(context).pop(true);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fitnessOnboardingProvider);
    final brightness = Theme.of(context).brightness;

    return Scaffold(
      backgroundColor: AppColors.getBackground(brightness),
      body: SafeArea(
        child: Column(
          children: [
            // Progress indicator
            _buildProgressIndicator(state.currentStep, brightness),
            
            // Page content
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  _WelcomeStep(onNext: _nextPage),
                  _GoalsStep(onNext: _nextPage, onBack: _previousPage),
                  _PreferencesStep(onNext: _nextPage, onBack: _previousPage),
                  _PersonalizationStep(onNext: _nextPage, onBack: _previousPage),
                  _SummaryStep(onComplete: _completeOnboarding, onBack: _previousPage),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressIndicator(int currentStep, Brightness brightness) {
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      child: Row(
        children: List.generate(5, (index) {
          final isActive = index <= currentStep;
          final isCurrent = index == currentStep;
          return Expanded(
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              height: 4,
              margin: const EdgeInsets.symmetric(horizontal: 2),
              decoration: BoxDecoration(
                color: isActive
                    ? AppColors.getPrimary(brightness)
                    : AppColors.getSurfaceVariant(brightness),
                borderRadius: BorderRadius.circular(2),
                boxShadow: isCurrent
                    ? [
                        BoxShadow(
                          color: AppColors.getPrimary(brightness).withOpacity(0.4),
                          blurRadius: 8,
                          spreadRadius: 1,
                        ),
                      ]
                    : null,
              ),
            ),
          );
        }),
      ),
    );
  }
}

// ============================================================================
// STEP 1: WELCOME
// ============================================================================

class _WelcomeStep extends ConsumerWidget {
  final VoidCallback onNext;
  
  const _WelcomeStep({required this.onNext});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final brightness = Theme.of(context).brightness;
    
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Animated icon
          TweenAnimationBuilder<double>(
            tween: Tween(begin: 0.0, end: 1.0),
            duration: const Duration(milliseconds: 800),
            curve: Curves.elasticOut,
            builder: (context, value, child) {
              return Transform.scale(
                scale: value,
                child: Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    gradient: AppTheme.primaryGradient(brightness),
                    shape: BoxShape.circle,
                    boxShadow: AppTheme.fabShadow(brightness),
                  ),
                  child: const Icon(
                    Icons.fitness_center_rounded,
                    size: 56,
                    color: Colors.white,
                  ),
                ),
              );
            },
          ),
          const SizedBox(height: AppTheme.spacingXL),
          
          // Title
          Text(
            'Welcome to Fitness!',
            style: AppTextStyles.headlineLarge(brightness),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingM),
          
          // Subtitle
          Text(
            'Your personalized fitness journey starts here. Let\'s set up your profile for the best experience.',
            style: AppTextStyles.bodyLarge(brightness).copyWith(
              color: AppColors.getTextSecondary(brightness),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppTheme.spacingXL),
          
          // Features list
          _FeatureItem(
            icon: Icons.track_changes_rounded,
            title: 'Track Workouts',
            description: 'Log your exercises and monitor progress',
            brightness: brightness,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _FeatureItem(
            icon: Icons.local_fire_department_rounded,
            title: 'Burn Calories',
            description: 'See real-time calorie tracking',
            brightness: brightness,
          ),
          const SizedBox(height: AppTheme.spacingM),
          _FeatureItem(
            icon: Icons.emoji_events_rounded,
            title: 'Earn XP',
            description: 'Level up with every workout',
            brightness: brightness,
          ),
          
          const Spacer(),
          
          // Next button
          SizedBox(
            width: double.infinity,
            child: FilledButton(
              onPressed: onNext,
              child: const Text('Get Started'),
            ),
          ),
        ],
      ),
    );
  }
}

class _FeatureItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String description;
  final Brightness brightness;

  const _FeatureItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 48,
          height: 48,
          decoration: BoxDecoration(
            color: AppColors.getPrimary(brightness).withOpacity(0.1),
            borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          ),
          child: Icon(
            icon,
            color: AppColors.getPrimary(brightness),
          ),
        ),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: AppTextStyles.titleSmall(brightness)),
              Text(
                description,
                style: AppTextStyles.bodySmall(brightness),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

// ============================================================================
// STEP 2: GOALS
// ============================================================================

class _GoalsStep extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  
  const _GoalsStep({required this.onNext, required this.onBack});

  static const _goals = [
    {'id': 'build_muscle', 'title': 'Build Muscle', 'icon': Icons.fitness_center_rounded, 'desc': 'Increase strength and muscle mass'},
    {'id': 'lose_fat', 'title': 'Lose Fat', 'icon': Icons.local_fire_department_rounded, 'desc': 'Burn calories and reduce body fat'},
    {'id': 'improve_stamina', 'title': 'Improve Stamina', 'icon': Icons.directions_run_rounded, 'desc': 'Boost endurance and cardiovascular health'},
    {'id': 'stay_active', 'title': 'Stay Active', 'icon': Icons.self_improvement_rounded, 'desc': 'Maintain general fitness and wellness'},
    {'id': 'flexibility', 'title': 'Flexibility', 'icon': Icons.accessibility_new_rounded, 'desc': 'Improve mobility and flexibility'},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fitnessOnboardingProvider);
    final brightness = Theme.of(context).brightness;
    
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('What are your goals?', style: AppTextStyles.headlineMedium(brightness)),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Select one or more fitness goals',
            style: AppTextStyles.bodyMedium(brightness).copyWith(
              color: AppColors.getTextSecondary(brightness),
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          
          Expanded(
            child: ListView.separated(
              itemCount: _goals.length,
              separatorBuilder: (_, __) => const SizedBox(height: AppTheme.spacingM),
              itemBuilder: (context, index) {
                final goal = _goals[index];
                final isSelected = state.selectedGoals.contains(goal['id']);
                
                return _SelectableCard(
                  title: goal['title'] as String,
                  description: goal['desc'] as String,
                  icon: goal['icon'] as IconData,
                  isSelected: isSelected,
                  onTap: () => ref.read(fitnessOnboardingProvider.notifier).toggleGoal(goal['id'] as String),
                  brightness: brightness,
                );
              },
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          _NavigationButtons(
            onBack: onBack,
            onNext: state.selectedGoals.isNotEmpty ? onNext : null,
            brightness: brightness,
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// STEP 3: PREFERENCES
// ============================================================================

class _PreferencesStep extends ConsumerWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  
  const _PreferencesStep({required this.onNext, required this.onBack});

  static const _days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
  static const _durations = [15, 30, 45, 60, 90];
  static const _types = [
    {'id': 'strength', 'title': 'Strength', 'icon': Icons.fitness_center_rounded},
    {'id': 'cardio', 'title': 'Cardio', 'icon': Icons.directions_run_rounded},
    {'id': 'mixed', 'title': 'Mixed', 'icon': Icons.shuffle_rounded},
  ];

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fitnessOnboardingProvider);
    final brightness = Theme.of(context).brightness;
    
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Preferences', style: AppTextStyles.headlineMedium(brightness)),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Customize your workout schedule',
            style: AppTextStyles.bodyMedium(brightness).copyWith(
              color: AppColors.getTextSecondary(brightness),
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Preferred days
                  Text('Workout Days', style: AppTextStyles.titleMedium(brightness)),
                  const SizedBox(height: AppTheme.spacingM),
                  Wrap(
                    spacing: AppTheme.spacingS,
                    runSpacing: AppTheme.spacingS,
                    children: _days.map((day) {
                      final isSelected = state.selectedDays.contains(day);
                      return _DayChip(
                        day: day,
                        isSelected: isSelected,
                        onTap: () => ref.read(fitnessOnboardingProvider.notifier).toggleDay(day),
                        brightness: brightness,
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingL),
                  
                  // Duration
                  Text('Workout Duration', style: AppTextStyles.titleMedium(brightness)),
                  const SizedBox(height: AppTheme.spacingM),
                  Wrap(
                    spacing: AppTheme.spacingS,
                    runSpacing: AppTheme.spacingS,
                    children: _durations.map((duration) {
                      final isSelected = state.workoutDuration == duration;
                      return ChoiceChip(
                        label: Text('$duration min'),
                        selected: isSelected,
                        onSelected: (_) => ref.read(fitnessOnboardingProvider.notifier).setWorkoutDuration(duration),
                      );
                    }).toList(),
                  ),
                  
                  const SizedBox(height: AppTheme.spacingL),
                  
                  // Workout type
                  Text('Preferred Type', style: AppTextStyles.titleMedium(brightness)),
                  const SizedBox(height: AppTheme.spacingM),
                  Row(
                    children: _types.map((type) {
                      final isSelected = state.workoutType == type['id'];
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 4),
                          child: _TypeCard(
                            title: type['title'] as String,
                            icon: type['icon'] as IconData,
                            isSelected: isSelected,
                            onTap: () => ref.read(fitnessOnboardingProvider.notifier).setWorkoutType(type['id'] as String),
                            brightness: brightness,
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          _NavigationButtons(
            onBack: onBack,
            onNext: state.selectedDays.isNotEmpty ? onNext : null,
            brightness: brightness,
          ),
        ],
      ),
    );
  }
}

class _DayChip extends StatelessWidget {
  final String day;
  final bool isSelected;
  final VoidCallback onTap;
  final Brightness brightness;

  const _DayChip({
    required this.day,
    required this.isSelected,
    required this.onTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimary(brightness)
              : AppColors.getSurfaceVariant(brightness),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: isSelected
              ? null
              : Border.all(color: AppColors.getBorder(brightness)),
        ),
        child: Center(
          child: Text(
            day.substring(0, 1),
            style: AppTextStyles.labelLarge(brightness).copyWith(
              color: isSelected
                  ? AppColors.getOnPrimary(brightness)
                  : AppColors.getTextPrimary(brightness),
            ),
          ),
        ),
      ),
    );
  }
}

class _TypeCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Brightness brightness;

  const _TypeCard({
    required this.title,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimary(brightness)
              : AppColors.getSurface(brightness),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: isSelected
              ? null
              : Border.all(color: AppColors.getBorder(brightness)),
        ),
        child: Column(
          children: [
            Icon(
              icon,
              color: isSelected
                  ? AppColors.getOnPrimary(brightness)
                  : AppColors.getPrimary(brightness),
            ),
            const SizedBox(height: AppTheme.spacingS),
            Text(
              title,
              style: AppTextStyles.labelMedium(brightness).copyWith(
                color: isSelected
                    ? AppColors.getOnPrimary(brightness)
                    : AppColors.getTextPrimary(brightness),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// STEP 4: PERSONALIZATION
// ============================================================================

class _PersonalizationStep extends ConsumerStatefulWidget {
  final VoidCallback onNext;
  final VoidCallback onBack;
  
  const _PersonalizationStep({required this.onNext, required this.onBack});

  @override
  ConsumerState<_PersonalizationStep> createState() => _PersonalizationStepState();
}

class _PersonalizationStepState extends ConsumerState<_PersonalizationStep> {
  late TextEditingController _ageController;
  late TextEditingController _weightController;
  late TextEditingController _heightController;

  static const _activityLevels = [
    {'id': 'sedentary', 'title': 'Sedentary', 'desc': 'Little or no exercise'},
    {'id': 'light', 'title': 'Light', 'desc': '1-3 days/week'},
    {'id': 'moderate', 'title': 'Moderate', 'desc': '3-5 days/week'},
    {'id': 'active', 'title': 'Active', 'desc': '6-7 days/week'},
    {'id': 'very_active', 'title': 'Very Active', 'desc': 'Intense daily'},
  ];

  @override
  void initState() {
    super.initState();
    final state = ref.read(fitnessOnboardingProvider);
    _ageController = TextEditingController(text: state.age.toString());
    _weightController = TextEditingController(text: state.weight.toString());
    _heightController = TextEditingController(text: state.height.toString());
  }

  @override
  void dispose() {
    _ageController.dispose();
    _weightController.dispose();
    _heightController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(fitnessOnboardingProvider);
    final brightness = Theme.of(context).brightness;
    
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('About You', style: AppTextStyles.headlineMedium(brightness)),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Help us personalize your experience',
            style: AppTextStyles.bodyMedium(brightness).copyWith(
              color: AppColors.getTextSecondary(brightness),
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Age, Weight, Height
                  Row(
                    children: [
                      Expanded(
                        child: _InputField(
                          label: 'Age',
                          suffix: 'years',
                          controller: _ageController,
                          onChanged: (v) {
                            final age = int.tryParse(v) ?? 25;
                            ref.read(fitnessOnboardingProvider.notifier).setAge(age);
                          },
                          brightness: brightness,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: _InputField(
                          label: 'Weight',
                          suffix: 'kg',
                          controller: _weightController,
                          onChanged: (v) {
                            final weight = double.tryParse(v) ?? 70.0;
                            ref.read(fitnessOnboardingProvider.notifier).setWeight(weight);
                          },
                          brightness: brightness,
                        ),
                      ),
                      const SizedBox(width: AppTheme.spacingM),
                      Expanded(
                        child: _InputField(
                          label: 'Height',
                          suffix: 'cm',
                          controller: _heightController,
                          onChanged: (v) {
                            final height = double.tryParse(v) ?? 170.0;
                            ref.read(fitnessOnboardingProvider.notifier).setHeight(height);
                          },
                          brightness: brightness,
                        ),
                      ),
                    ],
                  ),
                  
                  const SizedBox(height: AppTheme.spacingL),
                  
                  // Activity level
                  Text('Activity Level', style: AppTextStyles.titleMedium(brightness)),
                  const SizedBox(height: AppTheme.spacingM),
                  ...List.generate(_activityLevels.length, (index) {
                    final level = _activityLevels[index];
                    final isSelected = state.activityLevel == level['id'];
                    return Padding(
                      padding: const EdgeInsets.only(bottom: AppTheme.spacingS),
                      child: _ActivityLevelTile(
                        title: level['title'] as String,
                        description: level['desc'] as String,
                        isSelected: isSelected,
                        onTap: () => ref.read(fitnessOnboardingProvider.notifier).setActivityLevel(level['id'] as String),
                        brightness: brightness,
                      ),
                    );
                  }),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          _NavigationButtons(
            onBack: widget.onBack,
            onNext: widget.onNext,
            brightness: brightness,
          ),
        ],
      ),
    );
  }
}

class _InputField extends StatelessWidget {
  final String label;
  final String suffix;
  final TextEditingController controller;
  final ValueChanged<String> onChanged;
  final Brightness brightness;

  const _InputField({
    required this.label,
    required this.suffix,
    required this.controller,
    required this.onChanged,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppTextStyles.labelMedium(brightness)),
        const SizedBox(height: AppTheme.spacingS),
        TextField(
          controller: controller,
          keyboardType: TextInputType.number,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixText: suffix,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppTheme.spacingM,
              vertical: AppTheme.spacingS,
            ),
          ),
        ),
      ],
    );
  }
}

class _ActivityLevelTile extends StatelessWidget {
  final String title;
  final String description;
  final bool isSelected;
  final VoidCallback onTap;
  final Brightness brightness;

  const _ActivityLevelTile({
    required this.title,
    required this.description,
    required this.isSelected,
    required this.onTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimary(brightness).withOpacity(0.1)
              : AppColors.getSurface(brightness),
          borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
          border: Border.all(
            color: isSelected
                ? AppColors.getPrimary(brightness)
                : AppColors.getBorder(brightness),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Radio<bool>(
              value: true,
              groupValue: isSelected,
              onChanged: (_) => onTap(),
            ),
            const SizedBox(width: AppTheme.spacingS),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall(brightness)),
                  Text(description, style: AppTextStyles.bodySmall(brightness)),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ============================================================================
// STEP 5: SUMMARY
// ============================================================================

class _SummaryStep extends ConsumerWidget {
  final VoidCallback onComplete;
  final VoidCallback onBack;
  
  const _SummaryStep({required this.onComplete, required this.onBack});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(fitnessOnboardingProvider);
    final brightness = Theme.of(context).brightness;
    
    return Padding(
      padding: const EdgeInsets.all(AppTheme.spacingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Your Fitness Profile', style: AppTextStyles.headlineMedium(brightness)),
          const SizedBox(height: AppTheme.spacingS),
          Text(
            'Review your selections',
            style: AppTextStyles.bodyMedium(brightness).copyWith(
              color: AppColors.getTextSecondary(brightness),
            ),
          ),
          const SizedBox(height: AppTheme.spacingL),
          
          Expanded(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  _SummaryCard(
                    title: 'Goals',
                    icon: Icons.flag_rounded,
                    content: state.selectedGoals.map((g) => _formatGoal(g)).join(', '),
                    brightness: brightness,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  _SummaryCard(
                    title: 'Workout Days',
                    icon: Icons.calendar_today_rounded,
                    content: state.selectedDays.join(', '),
                    brightness: brightness,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  _SummaryCard(
                    title: 'Duration & Type',
                    icon: Icons.timer_rounded,
                    content: '${state.workoutDuration} min • ${_formatType(state.workoutType)}',
                    brightness: brightness,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  _SummaryCard(
                    title: 'Body Stats',
                    icon: Icons.person_rounded,
                    content: '${state.age} years • ${state.weight} kg • ${state.height} cm',
                    brightness: brightness,
                  ),
                  const SizedBox(height: AppTheme.spacingM),
                  _SummaryCard(
                    title: 'Activity Level',
                    icon: Icons.speed_rounded,
                    content: _formatActivityLevel(state.activityLevel),
                    brightness: brightness,
                  ),
                ],
              ),
            ),
          ),
          
          const SizedBox(height: AppTheme.spacingM),
          
          // Complete button
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: state.isLoading ? null : onComplete,
              icon: state.isLoading
                  ? const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(strokeWidth: 2),
                    )
                  : const Icon(Icons.rocket_launch_rounded),
              label: Text(state.isLoading ? 'Saving...' : 'Start Fitness Journey'),
            ),
          ),
          const SizedBox(height: AppTheme.spacingS),
          Center(
            child: TextButton(
              onPressed: onBack,
              child: const Text('Go Back'),
            ),
          ),
        ],
      ),
    );
  }

  String _formatGoal(String goal) {
    return goal.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
  }

  String _formatType(String type) {
    return type[0].toUpperCase() + type.substring(1);
  }

  String _formatActivityLevel(String level) {
    return level.split('_').map((w) => w[0].toUpperCase() + w.substring(1)).join(' ');
  }
}

class _SummaryCard extends StatelessWidget {
  final String title;
  final IconData icon;
  final String content;
  final Brightness brightness;

  const _SummaryCard({
    required this.title,
    required this.icon,
    required this.content,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(AppTheme.spacingM),
      decoration: BoxDecoration(
        color: AppColors.getSurface(brightness),
        borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
        border: Border.all(color: AppColors.getBorder(brightness)),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: AppColors.getPrimary(brightness).withOpacity(0.1),
              borderRadius: BorderRadius.circular(AppTheme.radiusSmall),
            ),
            child: Icon(icon, color: AppColors.getPrimary(brightness), size: 20),
          ),
          const SizedBox(width: AppTheme.spacingM),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: AppTextStyles.labelMedium(brightness)),
                Text(content, style: AppTextStyles.bodyMedium(brightness)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================================
// SHARED WIDGETS
// ============================================================================

class _SelectableCard extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final bool isSelected;
  final VoidCallback onTap;
  final Brightness brightness;

  const _SelectableCard({
    required this.title,
    required this.description,
    required this.icon,
    required this.isSelected,
    required this.onTap,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.all(AppTheme.spacingM),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.getPrimary(brightness).withOpacity(0.1)
              : AppColors.getSurface(brightness),
          borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
          border: Border.all(
            color: isSelected
                ? AppColors.getPrimary(brightness)
                : AppColors.getBorder(brightness),
            width: isSelected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Container(
              width: 48,
              height: 48,
              decoration: BoxDecoration(
                color: isSelected
                    ? AppColors.getPrimary(brightness)
                    : AppColors.getSurfaceVariant(brightness),
                borderRadius: BorderRadius.circular(AppTheme.radiusMedium),
              ),
              child: Icon(
                icon,
                color: isSelected
                    ? AppColors.getOnPrimary(brightness)
                    : AppColors.getPrimary(brightness),
              ),
            ),
            const SizedBox(width: AppTheme.spacingM),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: AppTextStyles.titleSmall(brightness)),
                  Text(description, style: AppTextStyles.bodySmall(brightness)),
                ],
              ),
            ),
            if (isSelected)
              Icon(
                Icons.check_circle_rounded,
                color: AppColors.getPrimary(brightness),
              ),
          ],
        ),
      ),
    );
  }
}

class _NavigationButtons extends StatelessWidget {
  final VoidCallback onBack;
  final VoidCallback? onNext;
  final Brightness brightness;

  const _NavigationButtons({
    required this.onBack,
    required this.onNext,
    required this.brightness,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: OutlinedButton(
            onPressed: onBack,
            child: const Text('Back'),
          ),
        ),
        const SizedBox(width: AppTheme.spacingM),
        Expanded(
          flex: 2,
          child: FilledButton(
            onPressed: onNext,
            child: const Text('Continue'),
          ),
        ),
      ],
    );
  }
}

