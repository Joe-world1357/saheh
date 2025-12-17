import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../database/database_helper.dart';
import '../models/fitness_preferences_model.dart';
import 'auth_provider.dart';

/// State for fitness onboarding
class FitnessOnboardingState {
  final int currentStep;
  final List<String> selectedGoals;
  final List<String> selectedDays;
  final int workoutDuration;
  final String workoutType;
  final int age;
  final double weight;
  final double height;
  final String activityLevel;
  final bool isLoading;
  final bool hasCompletedOnboarding;

  const FitnessOnboardingState({
    this.currentStep = 0,
    this.selectedGoals = const [],
    this.selectedDays = const [],
    this.workoutDuration = 30,
    this.workoutType = 'mixed',
    this.age = 25,
    this.weight = 70.0,
    this.height = 170.0,
    this.activityLevel = 'moderate',
    this.isLoading = false,
    this.hasCompletedOnboarding = false,
  });

  FitnessOnboardingState copyWith({
    int? currentStep,
    List<String>? selectedGoals,
    List<String>? selectedDays,
    int? workoutDuration,
    String? workoutType,
    int? age,
    double? weight,
    double? height,
    String? activityLevel,
    bool? isLoading,
    bool? hasCompletedOnboarding,
  }) {
    return FitnessOnboardingState(
      currentStep: currentStep ?? this.currentStep,
      selectedGoals: selectedGoals ?? this.selectedGoals,
      selectedDays: selectedDays ?? this.selectedDays,
      workoutDuration: workoutDuration ?? this.workoutDuration,
      workoutType: workoutType ?? this.workoutType,
      age: age ?? this.age,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      activityLevel: activityLevel ?? this.activityLevel,
      isLoading: isLoading ?? this.isLoading,
      hasCompletedOnboarding: hasCompletedOnboarding ?? this.hasCompletedOnboarding,
    );
  }
}

class FitnessOnboardingNotifier extends Notifier<FitnessOnboardingState> {
  @override
  FitnessOnboardingState build() {
    _checkOnboardingStatus();
    return const FitnessOnboardingState();
  }

  Future<void> _checkOnboardingStatus() async {
    final authState = ref.read(authProvider);
    if (authState.user == null) return;

    state = state.copyWith(isLoading: true);
    
    final prefs = await DatabaseHelper.instance.getFitnessPreferences(authState.user!.email);
    
    if (prefs != null) {
      state = FitnessOnboardingState(
        selectedGoals: prefs.fitnessGoals,
        selectedDays: prefs.preferredDays,
        workoutDuration: prefs.workoutDuration,
        workoutType: prefs.workoutType,
        age: prefs.age,
        weight: prefs.weight,
        height: prefs.height,
        activityLevel: prefs.activityLevel,
        hasCompletedOnboarding: prefs.onboardingCompleted,
        isLoading: false,
      );
    } else {
      state = state.copyWith(isLoading: false, hasCompletedOnboarding: false);
    }
  }

  void nextStep() {
    if (state.currentStep < 4) {
      state = state.copyWith(currentStep: state.currentStep + 1);
    }
  }

  void previousStep() {
    if (state.currentStep > 0) {
      state = state.copyWith(currentStep: state.currentStep - 1);
    }
  }

  void goToStep(int step) {
    if (step >= 0 && step <= 4) {
      state = state.copyWith(currentStep: step);
    }
  }

  void toggleGoal(String goal) {
    final goals = List<String>.from(state.selectedGoals);
    if (goals.contains(goal)) {
      goals.remove(goal);
    } else {
      goals.add(goal);
    }
    state = state.copyWith(selectedGoals: goals);
  }

  void toggleDay(String day) {
    final days = List<String>.from(state.selectedDays);
    if (days.contains(day)) {
      days.remove(day);
    } else {
      days.add(day);
    }
    state = state.copyWith(selectedDays: days);
  }

  void setWorkoutDuration(int duration) {
    state = state.copyWith(workoutDuration: duration);
  }

  void setWorkoutType(String type) {
    state = state.copyWith(workoutType: type);
  }

  void setAge(int age) {
    state = state.copyWith(age: age);
  }

  void setWeight(double weight) {
    state = state.copyWith(weight: weight);
  }

  void setHeight(double height) {
    state = state.copyWith(height: height);
  }

  void setActivityLevel(String level) {
    state = state.copyWith(activityLevel: level);
  }

  Future<bool> completeOnboarding() async {
    final authState = ref.read(authProvider);
    if (authState.user == null) return false;

    state = state.copyWith(isLoading: true);

    try {
      final prefs = FitnessPreferencesModel(
        id: '${authState.user!.email}_fitness',
        userEmail: authState.user!.email,
        fitnessGoals: state.selectedGoals,
        preferredDays: state.selectedDays,
        workoutDuration: state.workoutDuration,
        workoutType: state.workoutType,
        age: state.age,
        weight: state.weight,
        height: state.height,
        activityLevel: state.activityLevel,
        onboardingCompleted: true,
      );

      await DatabaseHelper.instance.insertFitnessPreferences(prefs);
      
      // Update user profile with age, weight, height if needed
      final user = authState.user!;
      final updatedUser = user.copyWith(
        age: state.age,
        weight: state.weight,
        height: state.height,
      );
      await DatabaseHelper.instance.updateUserByEmail(updatedUser);

      state = state.copyWith(
        isLoading: false,
        hasCompletedOnboarding: true,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false);
      return false;
    }
  }

  void reset() {
    state = const FitnessOnboardingState();
  }
}

final fitnessOnboardingProvider = NotifierProvider<FitnessOnboardingNotifier, FitnessOnboardingState>(
  FitnessOnboardingNotifier.new,
);

/// Check if user needs fitness onboarding
final needsFitnessOnboardingProvider = FutureProvider<bool>((ref) async {
  final authState = ref.watch(authProvider);
  if (authState.user == null) return false;
  
  final hasCompleted = await DatabaseHelper.instance.hasCompletedFitnessOnboarding(authState.user!.email);
  return !hasCompleted;
});

