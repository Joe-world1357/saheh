import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/medicine_intake_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class MedicineIntakeNotifier extends Notifier<List<MedicineIntakeModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  List<MedicineIntakeModel> build() {
    _loadIntakesForToday();
    return [];
  }

  Future<void> _loadIntakesForToday() async {
    final today = DateTime.now();
    final intakes = await _db.getMedicineIntakesByDate(today, userEmail: _userEmail);
    state = intakes;
  }

  Future<void> loadIntakesForDate(DateTime date) async {
    final intakes = await _db.getMedicineIntakesByDate(date, userEmail: _userEmail);
    state = intakes;
  }

  Future<void> markAsTaken(MedicineIntakeModel intake) async {
    final updatedIntake = intake.copyWith(isTaken: true);
    await _db.updateMedicineIntake(updatedIntake);
    await _loadIntakesForToday();
  }

  Future<void> markAsNotTaken(MedicineIntakeModel intake) async {
    final updatedIntake = intake.copyWith(isTaken: false);
    await _db.updateMedicineIntake(updatedIntake);
    await _loadIntakesForToday();
  }

  Future<void> deleteIntake(int id) async {
    final userEmail = _userEmail;
    if (userEmail != null) {
      await _db.deleteMedicineIntake(id, userEmail);
      await _loadIntakesForToday();
    }
  }

  Future<void> createIntakeFromReminder({
    required String medicineName,
    required String dosage,
    required String time,
    required DateTime date,
    required String userEmail,
  }) async {
    final intake = MedicineIntakeModel(
      userEmail: userEmail,
      medicineName: medicineName,
      dosage: dosage,
      intakeDate: date,
      intakeTime: time,
      isTaken: false,
    );
    await _db.insertMedicineIntake(intake);
    await _loadIntakesForToday();
  }

  Future<Map<String, int>> getIntakeStatsForDate(DateTime date) async {
    final taken = await _db.getTakenCountForDate(date, userEmail: _userEmail);
    final total = await _db.getTotalCountForDate(date, userEmail: _userEmail);
    return {'taken': taken, 'total': total};
  }
}

final medicineIntakeProvider = NotifierProvider<MedicineIntakeNotifier, List<MedicineIntakeModel>>(() {
  return MedicineIntakeNotifier();
});

