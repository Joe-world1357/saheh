class Appointment {
  final String id;        // Firestore document ID
  final String userId;    // FK → users
  final String doctorId;  // FK → doctors
  final DateTime appointmentDate;
  final String status;

  Appointment({
    required this.id,
    required this.userId,
    required this.doctorId,
    required this.appointmentDate,
    required this.status,
  });

  // 🔒 SAFE fromMap
  factory Appointment.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Appointment(
      id: id,

      // required refs (safe fallback)
      userId: map['user_id'] as String? ?? '',
      doctorId: map['doctor_id'] as String? ?? '',

      // Firestore / cache safe date handling
      appointmentDate: map['appointment_date'] != null
          ? DateTime.tryParse(
                map['appointment_date'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),

      // safe status
      status: map['status'] as String? ?? 'pending',
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'doctor_id': doctorId,
      'appointment_date':
          appointmentDate.toIso8601String(),
      'status': status,
    };
  }
}
