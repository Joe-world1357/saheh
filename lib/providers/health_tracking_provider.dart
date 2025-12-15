import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/health_tracking_model.dart';
import '../database/database_helper.dart';

class HealthTrackingNotifier extends Notifier<Map<String, dynamic>> {
  final _db = DatabaseHelper.instance;

  @override
  Map<String, dynamic> build() => {};

  Future<void> saveSleep(SleepTrackingModel sleep) async {
    await _db.insertSleepTracking(sleep);
  }

  Future<SleepTrackingModel?> getSleepForDate(DateTime date) async {
    return await _db.getSleepByDate(date);
  }

  Future<void> saveWaterIntake(WaterIntakeModel water) async {
    await _db.insertWaterIntake(water);
  }

  Future<int> getWaterForDate(DateTime date) async {
    return await _db.getTotalWaterByDate(date);
  }

  Future<void> addHealthGoal(HealthGoalModel goal) async {
    await _db.insertHealthGoal(goal);
  }

  Future<List<HealthGoalModel>> getAllGoals() async {
    return await _db.getAllHealthGoals();
  }

  Future<void> deleteGoal(int id) async {
    await _db.deleteHealthGoal(id);
  }
}

final healthTrackingProvider = NotifierProvider<HealthTrackingNotifier, Map<String, dynamic>>(() {
  return HealthTrackingNotifier();
});

