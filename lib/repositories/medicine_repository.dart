import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/medicine.dart';
import '../models/medicine_reminder.dart';
import '../models/user_medical_condition.dart';

class MedicineRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _medicines =>
      _db.collection('medicines');

  CollectionReference<Map<String, dynamic>> get _reminders =>
      _db.collection('medicine_reminders');

  CollectionReference<Map<String, dynamic>> get _conditions =>
      _db.collection('user_medical_conditions');

  /// Get all medicines for a user
  Future<List<Medicine>> getUserMedicines(String userId) async {
    final snapshot = await _medicines
        .where('user_id', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map((d) => Medicine.fromMap(d.data(), d.id))
        .toList();
  }

  /// Add or update a medicine
  Future<void> saveMedicine(Medicine medicine) async {
    await _medicines.doc(medicine.id).set(
          medicine.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Delete a medicine
  Future<void> deleteMedicine(String medicineId) async {
    await _medicines.doc(medicineId).delete();
  }

  /// Get all reminders for a user
  Future<List<MedicineReminder>> getUserReminders(
    String userId,
  ) async {
    final snapshot = await _reminders
        .where('user_id', isEqualTo: userId)
        .orderBy('reminder_time')
        .get();

    return snapshot.docs
        .map((d) => MedicineReminder.fromMap(d.data(), d.id))
        .toList();
  }

  /// Save a reminder
  Future<void> saveReminder(
    MedicineReminder reminder,
  ) async {
    await _reminders.doc(reminder.id).set(
          reminder.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Delete a reminder
  Future<void> deleteReminder(String reminderId) async {
    await _reminders.doc(reminderId).delete();
  }

  /// Get medical conditions for a user
  Future<List<UserMedicalCondition>> getUserConditions(
    String userId,
  ) async {
    final snapshot = await _conditions
        .where('user_id', isEqualTo: userId)
        .get();

    return snapshot.docs
        .map(
          (d) => UserMedicalCondition.fromMap(d.data(), d.id),
        )
        .toList();
  }

  /// Save a medical condition
  Future<void> saveCondition(
    UserMedicalCondition condition,
  ) async {
    await _conditions.doc(condition.id).set(
          condition.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Delete a medical condition
  Future<void> deleteCondition(String conditionId) async {
    await _conditions.doc(conditionId).delete();
  }
}
