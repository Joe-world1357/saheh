import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/health_tracking_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class HealthTrackingNotifier extends Notifier<Map<String, dynamic>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  Map<String, dynamic> build() {
    // Watch auth provider to clear data when user changes
    ref.watch(authProvider);
    return {};
  }

  Future<void> saveSleep(SleepTrackingModel sleep) async {
    await _db.insertSleepTracking(sleep);
  }

  Future<SleepTrackingModel?> getSleepForDate(DateTime date) async {
    final userEmail = _userEmail;
    return await _db.getSleepByDate(date, userEmail: userEmail);
  }

  Future<void> saveWaterIntake(WaterIntakeModel water) async {
    await _db.insertWaterIntake(water);
  }

  Future<int> getWaterForDate(DateTime date) async {
    final userEmail = _userEmail;
    return await _db.getTotalWaterByDate(date, userEmail: userEmail);
  }

  Future<void> addHealthGoal(HealthGoalModel goal) async {
    await _db.insertHealthGoal(goal);
  }

  Future<List<HealthGoalModel>> getAllGoals() async {
    final userEmail = _userEmail;
    return await _db.getAllHealthGoals(userEmail: userEmail);
  }

  Future<void> deleteGoal(int id) async {
    final userEmail = _userEmail;
    await _db.deleteHealthGoal(id, userEmail: userEmail);
  }
}

final healthTrackingProvider = NotifierProvider<HealthTrackingNotifier, Map<String, dynamic>>(() {
  return HealthTrackingNotifier();
});
