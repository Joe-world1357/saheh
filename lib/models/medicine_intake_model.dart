class MedicineIntakeModel {
  final int? id;
  final String userEmail; // User isolation
  final String medicineName;
  final String dosage;
  final DateTime intakeDate;
  final String intakeTime; // HH:mm format
  final bool isTaken;
  final DateTime createdAt;

  MedicineIntakeModel({
    this.id,
    required this.userEmail,
    required this.medicineName,
    required this.dosage,
    required this.intakeDate,
    required this.intakeTime,
    this.isTaken = false,
    DateTime? createdAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'user_email': userEmail,
      'medicine_name': medicineName,
      'dosage': dosage,
      'intake_date': intakeDate.toIso8601String(),
      'intake_time': intakeTime,
      'is_taken': isTaken ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }

  factory MedicineIntakeModel.fromMap(Map<String, dynamic> map) {
    return MedicineIntakeModel(
      id: map['id'] as int?,
      userEmail: map['user_email'] as String? ?? '',
      medicineName: map['medicine_name'] as String,
      dosage: map['dosage'] as String,
      intakeDate: DateTime.parse(map['intake_date'] as String),
      intakeTime: map['intake_time'] as String,
      isTaken: (map['is_taken'] as int? ?? 0) == 1,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
    );
  }

  MedicineIntakeModel copyWith({
    int? id,
    String? userEmail,
    String? medicineName,
    String? dosage,
    DateTime? intakeDate,
    String? intakeTime,
    bool? isTaken,
    DateTime? createdAt,
  }) {
    return MedicineIntakeModel(
      id: id ?? this.id,
      userEmail: userEmail ?? this.userEmail,
      medicineName: medicineName ?? this.medicineName,
      dosage: dosage ?? this.dosage,
      intakeDate: intakeDate ?? this.intakeDate,
      intakeTime: intakeTime ?? this.intakeTime,
      isTaken: isTaken ?? this.isTaken,
      createdAt: createdAt ?? this.createdAt,
    );
  }
}

