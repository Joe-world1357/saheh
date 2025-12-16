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

  // 🔒 SAFE fromMap
  factory MedicineReminder.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return MedicineReminder(
      id: id,

      // required FKs
      userId: map['user_id'] as String? ?? '',
      medicineId: map['medicine_id'] as String? ?? '',

      // Firestore / offline safe date
      reminderTime: map['reminder_time'] != null
          ? DateTime.tryParse(
                map['reminder_time'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),

      // safe boolean
      repeatDaily: map['repeat_daily'] as bool? ?? false,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'medicine_id': medicineId,
      'reminder_time': reminderTime.toIso8601String(),
      'repeat_daily': repeatDaily,
    };
  }
}
