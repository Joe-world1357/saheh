import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/appointment.dart';
import '../models/caregiver_booking.dart';

class AppointmentRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _appointments =>
      _db.collection('appointments');

  CollectionReference<Map<String, dynamic>> get _caregiverBookings =>
      _db.collection('caregiver_bookings');

  /// Get appointments for a user
  Future<List<Appointment>> getUserAppointments(
    String userId,
  ) async {
    final snapshot = await _appointments
        .where('user_id', isEqualTo: userId)
        .orderBy('appointment_date', descending: true)
        .get();

    return snapshot.docs
        .map((d) => Appointment.fromMap(d.data(), d.id))
        .toList();
  }

  /// Create or update appointment
  Future<void> saveAppointment(
    Appointment appointment,
  ) async {
    await _appointments.doc(appointment.id).set(
          appointment.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Get caregiver bookings for a user
  Future<List<CaregiverBooking>> getUserCaregiverBookings(
    String userId,
  ) async {
    final snapshot = await _caregiverBookings
        .where('user_id', isEqualTo: userId)
        .orderBy('booking_date', descending: true)
        .get();

    return snapshot.docs
        .map(
          (d) => CaregiverBooking.fromMap(d.data(), d.id),
        )
        .toList();
  }

  /// Create or update caregiver booking
  Future<void> saveCaregiverBooking(
    CaregiverBooking booking,
  ) async {
    await _caregiverBookings.doc(booking.id).set(
          booking.toMap(),
          SetOptions(merge: true),
        );
  }
}
