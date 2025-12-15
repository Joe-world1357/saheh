import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine_reminder_model.dart';
import '../database/database_helper.dart';

class RemindersNotifier extends Notifier<List<MedicineReminderModel>> {
  final _db = DatabaseHelper.instance;

  @override
  List<MedicineReminderModel> build() {
    _loadReminders();
    return [];
  }

  Future<void> _loadReminders() async {
    final reminders = await _db.getAllMedicineReminders();
    state = reminders;
  }

  Future<void> addReminder(MedicineReminderModel reminder) async {
    await _db.insertMedicineReminder(reminder);
    await _loadReminders();
  }

  Future<void> deleteReminder(int id) async {
    await _db.deleteMedicineReminder(id);
    await _loadReminders();
  }
}

final remindersProvider = NotifierProvider<RemindersNotifier, List<MedicineReminderModel>>(() {
  return RemindersNotifier();
});

