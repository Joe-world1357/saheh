class AppointmentModel {
  final int? id;
  final String type; // clinic, lab_test, home_health
  final String providerName;
  final String specialty;
  final DateTime appointmentDate;
  final String time;
  final String status; // upcoming, completed, cancelled
  final String? notes;
  final DateTime createdAt;
  final DateTime? updatedAt;

  AppointmentModel({
    this.id,
    required this.type,
    required this.providerName,
    required this.specialty,
    required this.appointmentDate,
    required this.time,
    this.status = 'upcoming',
    this.notes,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'type': type,
      'provider_name': providerName,
      'specialty': specialty,
      'appointment_date': appointmentDate.toIso8601String(),
      'time': time,
      'status': status,
      'notes': notes,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory AppointmentModel.fromMap(Map<String, dynamic> map) {
    return AppointmentModel(
      id: map['id'] as int?,
      type: map['type'] as String,
      providerName: map['provider_name'] as String,
      specialty: map['specialty'] as String,
      appointmentDate: DateTime.parse(map['appointment_date'] as String),
      time: map['time'] as String,
      status: map['status'] as String? ?? 'upcoming',
      notes: map['notes'] as String?,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }
}

