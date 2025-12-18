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

  /// Calculate level from XP using exponential progression
  /// Level 1: 0-99 XP (100 XP needed)
  /// Level 2: 100-249 XP (150 XP needed, total 250)
  /// Level 3: 250-499 XP (250 XP needed, total 500)
  /// Level 4: 500-999 XP (500 XP needed, total 1000)
  /// Level 5: 1000-1749 XP (750 XP needed, total 1750)
  /// Formula: Progressive exponential growth
  static int calculateLevel(int xp) {
    if (xp < 0) return 1;
    if (xp == 0) return 1;
    
    int level = 1;
    int xpRequired = 0;
    
    while (xpRequired <= xp) {
      final xpForThisLevel = _getXPRequiredForLevel(level);
      if (xpRequired + xpForThisLevel > xp) {
        break;
      }
      xpRequired += xpForThisLevel;
      level++;
      
      // Safety: prevent infinite loop
      if (level > 100) break;
    }
    
    return level;
  }

  /// Get XP required for a specific level
  static int _getXPRequiredForLevel(int level) {
    if (level <= 1) return 100;
    // Progressive exponential: 100, 150, 250, 500, 750, 1000, 1500...
    if (level == 2) return 150;
    if (level == 3) return 250;
    if (level == 4) return 500;
    // For higher levels, use formula: base * multiplier^(level-4)
    final base = 500;
    final multiplier = 1.5;
    return (base * (multiplier * (level - 4))).round();
  }

  /// Calculate XP needed for next level
  static int xpForNextLevel(int currentLevel, int currentXP) {
    final totalXPForCurrentLevel = _getTotalXPForLevel(currentLevel);
    final xpInCurrentLevel = currentXP - totalXPForCurrentLevel;
    final xpRequiredForNextLevel = _getXPRequiredForLevel(currentLevel);
    final xpNeeded = xpRequiredForNextLevel - xpInCurrentLevel;
    return xpNeeded > 0 ? xpNeeded : 0;
  }

  /// Get total XP required to reach a specific level
  static int _getTotalXPForLevel(int level) {
    if (level <= 1) return 0;
    int total = 0;
    for (int i = 1; i < level; i++) {
      total += _getXPRequiredForLevel(i);
    }
    return total;
  }

  /// Get current level progress (0.0 to 1.0)
  static double getLevelProgress(int currentLevel, int currentXP) {
    final totalXPForCurrentLevel = _getTotalXPForLevel(currentLevel);
    final xpInCurrentLevel = currentXP - totalXPForCurrentLevel;
    final xpRequiredForNextLevel = _getXPRequiredForLevel(currentLevel);
    if (xpRequiredForNextLevel == 0) return 1.0;
    return (xpInCurrentLevel / xpRequiredForNextLevel).clamp(0.0, 1.0);
  }
}

