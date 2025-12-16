class CaregiverBooking {
  final String id;           // Firestore document ID
  final String userId;       // FK → users
  final String caregiverId;  // FK → caregivers
  final DateTime bookingDate;
  final int durationHours;
  final String status;

  CaregiverBooking({
    required this.id,
    required this.userId,
    required this.caregiverId,
    required this.bookingDate,
    required this.durationHours,
    required this.status,
  });

  factory CaregiverBooking.fromMap(
      Map<String, dynamic> data, String id) {
    return CaregiverBooking(
      id: id,
      userId: data['user_id'],
      caregiverId: data['caregiver_id'],
      bookingDate: DateTime.parse(data['booking_date']),
      durationHours: data['duration_hours'],
      status: data['status'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'caregiver_id': caregiverId,
      'booking_date': bookingDate.toIso8601String(),
      'duration_hours': durationHours,
      'status': status,
    };
  }
}
