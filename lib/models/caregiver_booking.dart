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

  // 🔒 SAFE fromMap
  factory CaregiverBooking.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return CaregiverBooking(
      id: id,

      // required refs (safe fallback)
      userId: map['user_id'] as String? ?? '',
      caregiverId: map['caregiver_id'] as String? ?? '',

      // Firestore / offline safe date
      bookingDate: map['booking_date'] != null
          ? DateTime.tryParse(
                map['booking_date'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),

      // duration must NEVER crash
      durationHours: (map['duration_hours'] as num?)?.toInt() ?? 0,

      // logical default
      status: map['status'] as String? ?? 'pending',
    );
  }

  // 🧼 CLEAN toMap
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
