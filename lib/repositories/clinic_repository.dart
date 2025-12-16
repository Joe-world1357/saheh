import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/clinic.dart';
import '../models/doctor.dart';
import '../models/caregiver.dart';

class ClinicRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _clinics =>
      _db.collection('clinics');

  CollectionReference<Map<String, dynamic>> get _doctors =>
      _db.collection('doctors');

  CollectionReference<Map<String, dynamic>> get _caregivers =>
      _db.collection('caregivers');

  /// Get all clinics
  Future<List<Clinic>> getClinics() async {
    final snapshot = await _clinics.get();

    return snapshot.docs
        .map((d) => Clinic.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get doctors for a clinic
  Future<List<Doctor>> getDoctorsByClinic(
    String clinicId,
  ) async {
    final snapshot = await _doctors
        .where('clinic_id', isEqualTo: clinicId)
        .get();

    return snapshot.docs
        .map((d) => Doctor.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get all caregivers
  Future<List<Caregiver>> getCaregivers() async {
    final snapshot = await _caregivers.get();

    return snapshot.docs
        .map((d) => Caregiver.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get a single clinic by ID
  Future<Clinic?> getClinicById(String clinicId) async {
    final doc = await _clinics.doc(clinicId).get();

    if (!doc.exists || doc.data() == null) {
      return null;
    }

    return Clinic.fromMap(doc.data(), doc.id);
  }
}