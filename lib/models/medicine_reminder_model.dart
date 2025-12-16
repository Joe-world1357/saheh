class MedicineReminderModel {
  final int? id;
  final String userEmail; // User isolation
  final String medicineName;
  final String dosage;
  final List<int> daysOfWeek; // 0=Sunday, 1=Monday, etc.
  final String time; // HH:mm format
  final bool isActive;
  final DateTime createdAt;
  final DateTime? updatedAt;

  MedicineReminderModel({
    this.id,
    required this.userEmail,
    required this.medicineName,
    required this.dosage,
    required this.daysOfWeek,
    required this.time,
    this.isActive = true,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'medicine_name': medicineName,
      'dosage': dosage,
      'days_of_week': daysOfWeek.join(','),
      'time': time,
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory MedicineReminderModel.fromMap(Map<String, dynamic> map) {
    return MedicineReminderModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String? ?? '',
      medicineName: map['medicine_name'] as String,
      dosage: map['dosage'] as String,
      daysOfWeek: (map['days_of_week'] as String)
              .split(',')
              .map((e) => int.parse(e))
              .toList() ??
          [],
      time: map['time'] as String,
      isActive: (map['is_active'] as int? ?? 1) == 1,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
}

