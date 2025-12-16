import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/auth_provider.dart';

/// XP Service - Awards XP for user actions
class XPService {
  // XP rewards for different actions
  static const int xpMedicineIntake = 5;
  static const int xpMealLogged = 10;
  static const int xpWorkoutCompleted = 25;
  static const int xpAppointmentBooked = 15;
  static const int xpWaterIntake = 2;
  static const int xpSleepLogged = 5;
  static const int xpGoalCompleted = 50;

  /// Award XP for medicine intake
  static Future<void> awardMedicineIntake(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpMedicineIntake);
  }

  /// Award XP for meal logged
  static Future<void> awardMealLogged(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpMealLogged);
  }

  /// Award XP for workout completed
  static Future<void> awardWorkoutCompleted(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpWorkoutCompleted);
  }

  /// Award XP for appointment booked
  static Future<void> awardAppointmentBooked(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpAppointmentBooked);
  }

  /// Award XP for water intake (per 250ml)
  static Future<void> awardWaterIntake(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpWaterIntake);
  }

  /// Award XP for sleep logged
  static Future<void> awardSleepLogged(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpSleepLogged);
  }

  /// Award XP for goal completed
  static Future<void> awardGoalCompleted(WidgetRef ref) async {
    await ref.read(authProvider.notifier).addXP(xpGoalCompleted);
  }

  /// Calculate level from XP
  static int calculateLevel(int xp) {
    // 100 XP per level
    return (xp / 100).floor() + 1;
  }

  /// Calculate XP needed for next level
  static int xpForNextLevel(int currentLevel, int currentXP) {
    final xpForCurrentLevel = (currentLevel - 1) * 100;
    final xpForNextLevel = currentLevel * 100;
    return xpForNextLevel - currentXP;
  }
}

