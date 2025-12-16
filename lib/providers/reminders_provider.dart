import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine_reminder_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class RemindersNotifier extends Notifier<List<MedicineReminderModel>> {
  final _db = DatabaseHelper.instance;

  @override
  List<MedicineReminderModel> build() {
    _loadReminders();
    return [];
  }

  Future<void> _loadReminders() async {
    final authState = ref.read(authProvider);
    final userEmail = authState.user?.email;
    final reminders = await _db.getAllMedicineReminders(userEmail: userEmail);
    state = reminders;
  }

  Future<void> addReminder(MedicineReminderModel reminder) async {
    try {
      await _db.insertMedicineReminder(reminder);
      await _loadReminders();
    } catch (e) {
      debugPrint('Error adding reminder: $e');
      rethrow; // Re-throw so caller can handle it
    }
  }

  Future<void> deleteReminder(int id) async {
    final authState = ref.read(authProvider);
    final userEmail = authState.user?.email;
    await _db.deleteMedicineReminder(id, userEmail: userEmail);
    await _loadReminders();
  }
}

final remindersProvider = NotifierProvider<RemindersNotifier, List<MedicineReminderModel>>(() {
  return RemindersNotifier();
});

