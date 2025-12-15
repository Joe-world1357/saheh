import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/user_model.dart';
import '../database/database_helper.dart';

class UserNotifier extends Notifier<UserModel?> {
  final _db = DatabaseHelper.instance;

  @override
  UserModel? build() {
    _loadUser();
    return null;
  }

  Future<void> _loadUser() async {
    final user = await _db.getUser();
    state = user;
  }

  Future<void> createUser(UserModel user) async {
    await _db.insertUser(user);
    state = user;
  }

  Future<void> updateUser(UserModel user) async {
    await _db.updateUser(user);
    state = user;
  }

  Future<void> addXP(int amount) async {
    if (state == null) return;
    final currentXP = state!.xp + amount;
    final newLevel = _calculateLevel(currentXP);
    final updatedUser = state!.copyWith(xp: currentXP, level: newLevel);
    await updateUser(updatedUser);
  }

  int _calculateLevel(int xp) {
    // Simple level calculation: 100 XP per level
    return (xp / 100).floor() + 1;
  }
}

final userProvider = NotifierProvider<UserNotifier, UserModel?>(() {
  return UserNotifier();
});

