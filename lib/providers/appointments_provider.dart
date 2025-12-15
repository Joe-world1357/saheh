import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment_model.dart';
import '../database/database_helper.dart';

class AppointmentsNotifier extends Notifier<List<AppointmentModel>> {
  final _db = DatabaseHelper.instance;

  @override
  List<AppointmentModel> build() {
    _loadAppointments();
    return [];
  }

  Future<void> _loadAppointments() async {
    final appointments = await _db.getAllAppointments();
    state = appointments;
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    await _db.insertAppointment(appointment);
    await _loadAppointments();
  }
}

final appointmentsProvider = NotifierProvider<AppointmentsNotifier, List<AppointmentModel>>(() {
  return AppointmentsNotifier();
});

