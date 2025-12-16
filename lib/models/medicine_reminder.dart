class MedicineReminder {
  final String id;          // Firestore document ID
  final String userId;      // FK → users
  final String medicineId;  // FK → medicines
  final DateTime reminderTime;
  final bool repeatDaily;

  MedicineReminder({
    required this.id,
    required this.userId,
    required this.medicineId,
    required this.reminderTime,
    required this.repeatDaily,
  });

  factory MedicineReminder.fromMap(
      Map<String, dynamic> data, String id) {
    return MedicineReminder(
      id: id,
      userId: data['user_id'],
      medicineId: data['medicine_id'],
      reminderTime: DateTime.parse(data['reminder_time']),
      repeatDaily: data['repeat_daily'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'medicine_id': medicineId,
      'reminder_time': reminderTime.toIso8601String(),
      'repeat_daily': repeatDaily,
    };
  }
}
