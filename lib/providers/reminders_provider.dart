import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine_reminder_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class RemindersNotifier extends Notifier<List<MedicineReminderModel>> {
  final _db = DatabaseHelper.instance;

  @override
  List<MedicineReminderModel> build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    
    // Only load if user is authenticated
    if (authState.isAuthenticated && authState.user != null) {
      _loadReminders(authState.user!.email);
    } else {
      // Clear reminders if not authenticated
      return [];
    }
    
    return [];
  }

  Future<void> _loadReminders(String? userEmail) async {
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }
    final reminders = await _db.getAllMedicineReminders(userEmail: userEmail);
    state = reminders;
  }

  /// Refresh reminders for current user
  Future<void> refresh() async {
    final authState = ref.read(authProvider);
    final userEmail = authState.user?.email;
    await _loadReminders(userEmail);
  }

  Future<void> addReminder(MedicineReminderModel reminder) async {
    try {
      await _db.insertMedicineReminder(reminder);
      await refresh();
    } catch (e) {
      debugPrint('Error adding reminder: $e');
      rethrow;
    }
  }

  Future<void> deleteReminder(int id) async {
    final authState = ref.read(authProvider);
    final userEmail = authState.user?.email;
    await _db.deleteMedicineReminder(id, userEmail: userEmail);
    await refresh();
  }
}

final remindersProvider = NotifierProvider<RemindersNotifier, List<MedicineReminderModel>>(() {
  return RemindersNotifier();
});

