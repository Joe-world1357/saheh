import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/user_activity_log.dart';

class ActivityRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _activities =>
      _db.collection('activity_logs');

  /// Get activity log for a specific day
  Future<UserActivityLog?> getDailyLog(
    String userId,
    DateTime date,
  ) async {
    final docId = _docIdForDay(userId, date);

    final doc = await _activities.doc(docId).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return UserActivityLog.fromMap(doc.data(), doc.id);
  }

  /// Create or update daily activity log
  Future<void> saveDailyLog(UserActivityLog log) async {
    await _activities.doc(log.id).set(
          log.toMap(),
          SetOptions(merge: true), // 🔒 don’t overwrite
        );
  }

  /// Get all activity logs for a user (for charts)
  Future<List<UserActivityLog>> getUserLogs(String userId) async {
    final snapshot = await _activities
        .where('user_id', isEqualTo: userId)
        .orderBy('log_date', descending: true)
        .get();

    return snapshot.docs
        .map(
          (doc) => UserActivityLog.fromMap(doc.data(), doc.id),
        )
        .toList();
  }

  /// Helper: deterministic document ID per day
  String _docIdForDay(String userId, DateTime date) {
    final day =
        '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
    return '${userId}_$day';
  }
}