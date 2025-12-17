import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/appointment_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class AppointmentsNotifier extends Notifier<List<AppointmentModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  List<AppointmentModel> build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    if (authState.isAuthenticated && authState.user != null) {
      _loadAppointments();
    }
    return [];
  }

  Future<void> _loadAppointments() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }
    final appointments = await _db.getAllAppointments(userEmail: userEmail);
    state = appointments;
  }

  Future<void> refresh() async {
    await _loadAppointments();
  }

  Future<void> addAppointment(AppointmentModel appointment) async {
    await _db.insertAppointment(appointment);
    await _loadAppointments();
  }
}

final appointmentsProvider = NotifierProvider<AppointmentsNotifier, List<AppointmentModel>>(() {
  return AppointmentsNotifier();
});
