import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' show Platform;
import '../models/achievement_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';
import '../core/services/xp_service.dart';
import '../core/notifications/notification_service.dart';
import 'user_preferences_provider.dart';
import 'user_provider.dart';

/// Achievement definitions
class AchievementDefinition {
  final String id;
  final String title;
  final String description;
  final int xpReward;
  final String category;
  final bool Function(Map<String, dynamic> stats) checkCondition;

  AchievementDefinition({
    required this.id,
    required this.title,
    required this.description,
    required this.xpReward,
    required this.category,
    required this.checkCondition,
  });
}

class AchievementsNotifier extends Notifier<List<AchievementModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  // Achievement definitions
  static final List<AchievementDefinition> _definitions = [
    AchievementDefinition(
      id: 'first_workout',
      title: 'First Steps',
      description: 'Complete your first workout',
      xpReward: 50,
      category: 'workout',
      checkCondition: (stats) => (stats['total_workouts'] as int? ?? 0) >= 1,
    ),
    AchievementDefinition(
      id: 'week_warrior',
      title: 'Week Warrior',
      description: 'Complete 7 workouts in a week',
      xpReward: 200,
      category: 'workout',
      checkCondition: (stats) => (stats['weekly_workouts'] as int? ?? 0) >= 7,
    ),
    AchievementDefinition(
      id: 'hydration_hero',
      title: 'Hydration Hero',
      description: 'Drink 2L of water for 7 days',
      xpReward: 150,
      category: 'water',
      checkCondition: (stats) => (stats['water_streak'] as int? ?? 0) >= 7,
    ),
    AchievementDefinition(
      id: 'nutrition_pro',
      title: 'Nutrition Pro',
      description: 'Log meals for 30 days',
      xpReward: 250,
      category: 'nutrition',
      checkCondition: (stats) => (stats['meal_log_days'] as int? ?? 0) >= 30,
    ),
    AchievementDefinition(
      id: 'xp_milestone_100',
      title: 'XP Milestone',
      description: 'Reach 100 total XP',
      xpReward: 25,
      category: 'xp',
      checkCondition: (stats) => (stats['total_xp'] as int? ?? 0) >= 100,
    ),
    AchievementDefinition(
      id: 'xp_milestone_500',
      title: 'XP Champion',
      description: 'Reach 500 total XP',
      xpReward: 100,
      category: 'xp',
      checkCondition: (stats) => (stats['total_xp'] as int? ?? 0) >= 500,
    ),
    AchievementDefinition(
      id: 'xp_milestone_1000',
      title: 'XP Master',
      description: 'Reach 1000 total XP',
      xpReward: 250,
      category: 'xp',
      checkCondition: (stats) => (stats['total_xp'] as int? ?? 0) >= 1000,
    ),
    AchievementDefinition(
      id: 'level_5',
      title: 'Level Up!',
      description: 'Reach level 5',
      xpReward: 150,
      category: 'xp',
      checkCondition: (stats) => (stats['level'] as int? ?? 0) >= 5,
    ),
    AchievementDefinition(
      id: 'level_10',
      title: 'Elite Level',
      description: 'Reach level 10',
      xpReward: 500,
      category: 'xp',
      checkCondition: (stats) => (stats['level'] as int? ?? 0) >= 10,
    ),
  ];

  @override
  List<AchievementModel> build() {
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return [];
    }
    _loadAchievements();
    return [];
  }

  Future<void> _loadAchievements() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }

    try {
      // Initialize all achievements if they don't exist
      await _initializeAchievements(userEmail);
      
      // Load from database
      final achievements = await _db.getAchievements(userEmail);
      state = achievements;
    } catch (e) {
      state = [];
    }
  }

  Future<void> _initializeAchievements(String userEmail) async {
    for (final def in _definitions) {
      final existing = await _db.getAchievement(userEmail, def.id);
      if (existing == null) {
        // Create achievement entry
        final achievement = AchievementModel(
          userEmail: userEmail,
          achievementId: def.id,
          title: def.title,
          description: def.description,
          xpReward: def.xpReward,
          category: def.category,
          isUnlocked: false,
        );
        await _db.insertAchievement(achievement);
      }
    }
  }

  /// Check and unlock achievements based on current stats
  Future<void> checkAndUnlockAchievements() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      final user = ref.read(userProvider);
      if (user == null) return;

      // Get stats
      final stats = await _getUserStats(userEmail, user);

      // Check each achievement
      for (final def in _definitions) {
        final achievement = await _db.getAchievement(userEmail, def.id);
        if (achievement != null && !achievement.isUnlocked) {
          if (def.checkCondition(stats)) {
            await unlockAchievement(def.id);
          }
        }
      }
    } catch (e) {
      // Handle error
    }
  }

  Future<Map<String, dynamic>> _getUserStats(String userEmail, user) async {
    // Get workout stats
    final workoutStats = await _db.getMenWorkoutStats(userEmail);
    final weeklyWorkouts = workoutStats['weekly']?['weekly_workouts'] as int? ?? 0;
    final totalWorkouts = workoutStats['total']?['total_workouts'] as int? ?? 0;

    // Get user XP and level
    final totalXP = user.xp;
    final level = user.level;

    // TODO: Get water streak, meal log days from database
    // For now, use placeholder values
    final waterStreak = 0;
    final mealLogDays = 0;

    return {
      'total_workouts': totalWorkouts,
      'weekly_workouts': weeklyWorkouts,
      'water_streak': waterStreak,
      'meal_log_days': mealLogDays,
      'total_xp': totalXP,
      'level': level,
    };
  }

  Future<void> unlockAchievement(String achievementId) async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) return;

    try {
      final achievement = await _db.getAchievement(userEmail, achievementId);
      
      // Validation: Prevent duplicate unlocks
      if (achievement == null) {
        debugPrint('Achievement $achievementId not found');
        return;
      }
      
      if (achievement.isUnlocked) {
        debugPrint('Achievement $achievementId already unlocked');
        return; // Already unlocked, prevent duplicate
      }

      // Unlock in database
      await _db.unlockAchievement(userEmail, achievementId);

      // Award XP (validation happens in addXP)
      await ref.read(userProvider.notifier).addXP(achievement.xpReward);

      // Show notification if enabled
      final prefs = ref.read(userPreferencesProvider);
      if (prefs.achievementNotifications && Platform.isAndroid) {
        try {
          await NotificationService.instance.showAchievementNotification(
            title: achievement.title,
            body: achievement.description,
          );
        } catch (e) {
          debugPrint('Error showing achievement notification: $e');
        }
      }

      // Reload achievements
      await _loadAchievements();
    } catch (e) {
      debugPrint('Error unlocking achievement: $e');
    }
  }

  Future<void> refresh() async {
    await _loadAchievements();
    await checkAndUnlockAchievements();
  }
}

final achievementsProvider = NotifierProvider<AchievementsNotifier, List<AchievementModel>>(() {
  return AchievementsNotifier();
});

