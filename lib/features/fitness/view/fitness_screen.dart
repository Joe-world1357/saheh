import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/fitness_onboarding_provider.dart';
import '../../../core/theme/app_colors.dart';
import 'fitness_dashboard.dart';
import 'fitness_onboarding_screen.dart';

/// Main fitness screen that handles onboarding check
class FitnessScreen extends ConsumerWidget {
  const FitnessScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final needsOnboarding = ref.watch(needsFitnessOnboardingProvider);
    final brightness = Theme.of(context).brightness;

    return needsOnboarding.when(
      data: (needsOnboarding) {
        if (needsOnboarding) {
          // Show onboarding for first-time users
          return const _OnboardingWrapper();
        }
        // Show dashboard for returning users
        return const FitnessDashboard();
      },
      loading: () => Scaffold(
        backgroundColor: AppColors.getBackground(brightness),
        body: const Center(
          child: CircularProgressIndicator(),
        ),
      ),
      error: (_, __) => const FitnessDashboard(),
    );
  }
}

class _OnboardingWrapper extends ConsumerStatefulWidget {
  const _OnboardingWrapper();

  @override
  ConsumerState<_OnboardingWrapper> createState() => _OnboardingWrapperState();
}

class _OnboardingWrapperState extends ConsumerState<_OnboardingWrapper> {
  bool _showDashboard = false;

  @override
  Widget build(BuildContext context) {
    if (_showDashboard) {
      return const FitnessDashboard();
    }

    return FitnessOnboardingScreen(
      onComplete: () {
        setState(() {
          _showDashboard = true;
        });
        // Invalidate the provider to refresh state
        ref.invalidate(needsFitnessOnboardingProvider);
        ref.invalidate(fitnessOnboardingProvider);
      },
    );
  }
}

