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

  factory Appointment.fromMap(
      Map<String, dynamic> data, String id) {
    return Appointment(
      id: id,
      userId: data['user_id'],
      doctorId: data['doctor_id'],
      appointmentDate:
          DateTime.parse(data['appointment_date']),
      status: data['status'],
    );
  }

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
