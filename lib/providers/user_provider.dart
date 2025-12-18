import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'dart:io' show Platform;
import '../models/user_model.dart';
import '../database/database_helper.dart';
import '../core/storage/auth_storage.dart';
import '../core/services/xp_service.dart';
import '../core/notifications/notification_service.dart';
import 'auth_provider.dart';
import 'user_preferences_provider.dart';
import 'achievements_provider.dart';

class UserNotifier extends Notifier<UserModel?> {
  final _db = DatabaseHelper.instance;

  @override
  UserModel? build() {
    // Watch authProvider to auto-update when auth state changes
    final authState = ref.watch(authProvider);
    
    // If authenticated, use the user from auth state
    if (authState.isAuthenticated && authState.user != null) {
      // Also sync with database in the background
      _syncUserFromDatabase(authState.user!.email);
      return authState.user;
    }
    
    return null;
  }

  /// Sync user data from database (may have updated XP/level)
  Future<void> _syncUserFromDatabase(String email) async {
    final dbUser = await _db.getUserByEmail(email);
    if (dbUser != null && state != null) {
      // If database has newer XP/level, update state
      if (dbUser.xp != state!.xp || dbUser.level != state!.level) {
        state = dbUser;
        // Also update Hive storage
        await AuthStorage.updateUser(dbUser);
      }
    }
  }

  /// Reload user from current auth context
  Future<void> refresh() async {
    final currentEmail = AuthStorage.getCurrentUserId();
    if (currentEmail != null) {
      final dbUser = await _db.getUserByEmail(currentEmail);
      if (dbUser != null) {
        state = dbUser;
        await AuthStorage.updateUser(dbUser);
      }
    }
  }

  Future<void> createUser(UserModel user) async {
    await _db.insertUser(user);
    state = user;
  }

  Future<void> updateUser(UserModel user) async {
    // Update in database
    final result = await _db.updateUserByEmail(user);
    if (result == 0) {
      // User doesn't exist in DB, insert instead
      await _db.insertUser(user);
    }
    // Update in Hive
    await AuthStorage.updateUser(user);
    state = user;
    
    // Also update auth provider state
    ref.read(authProvider.notifier).updateUser(user);
  }

  Future<void> addXP(int amount) async {
    if (state == null) return;
    
    // Prevent negative XP
    final currentXP = (state!.xp + amount).clamp(0, double.infinity).toInt();
    final oldLevel = state!.level;
    final newLevel = _calculateLevel(currentXP);
    final levelUp = newLevel > oldLevel;
    
    final updatedUser = state!.copyWith(
      xp: currentXP,
      level: newLevel,
      updatedAt: DateTime.now(),
    );
    await updateUser(updatedUser);
    
    // Show level-up notification if enabled
    if (levelUp) {
      try {
        final prefs = ref.read(userPreferencesProvider);
        if (prefs.xpNotifications && Platform.isAndroid) {
          await NotificationService.instance.showXPEarnedNotification(
            xpAmount: amount,
            totalXP: currentXP,
            level: newLevel,
            levelUp: true,
          );
        }
      } catch (e) {
        // Handle error silently
      }
    }
    
    // Check for achievements after XP change
    try {
      await ref.read(achievementsProvider.notifier).checkAndUnlockAchievements();
    } catch (e) {
      // Handle error silently
    }
  }

  int _calculateLevel(int xp) {
    // Use XP service for exponential progression
    return XPService.calculateLevel(xp);
  }
}

final userProvider = NotifierProvider<UserNotifier, UserModel?>(() {
  return UserNotifier();
});

