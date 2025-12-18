import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import '../models/appointment_model.dart';
import '../database/database_helper.dart';
import 'auth_provider.dart';

class AppointmentsState {
  final List<AppointmentModel> appointments;
  final bool isLoading;
  final String? error;

  AppointmentsState({
    required this.appointments,
    this.isLoading = false,
    this.error,
  });

  AppointmentsState copyWith({
    List<AppointmentModel>? appointments,
    bool? isLoading,
    String? error,
  }) {
    return AppointmentsState(
      appointments: appointments ?? this.appointments,
      isLoading: isLoading ?? this.isLoading,
      error: error ?? this.error,
    );
  }
}

class AppointmentsNotifier extends Notifier<AppointmentsState> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  AppointmentsState build() {
    final authState = ref.watch(authProvider);
    if (!authState.isAuthenticated || authState.user == null) {
      return AppointmentsState(appointments: []);
    }

    // Load appointments when provider is initialized
    SchedulerBinding.instance.addPostFrameCallback((_) {
      loadAppointments();
    });

    return AppointmentsState(appointments: []);
  }

  Future<void> loadAppointments() async {
    if (_userEmail == null) return;

    state = state.copyWith(isLoading: true, error: null);

    try {
      final appointments = await _db.getAllAppointments(userEmail: _userEmail);
      state = state.copyWith(
        appointments: appointments,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  Future<bool> bookAppointment(AppointmentModel appointment) async {
    if (_userEmail == null) return false;

    try {
      state = state.copyWith(isLoading: true);
      
      final appointmentWithEmail = AppointmentModel(
        userEmail: _userEmail!,
        type: appointment.type,
        providerName: appointment.providerName,
        specialty: appointment.specialty,
        appointmentDate: appointment.appointmentDate,
        time: appointment.time,
        status: appointment.status,
        notes: appointment.notes,
      );

      await _db.insertAppointment(appointmentWithEmail);
      await loadAppointments();
      
      return true;
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
      return false;
    }
  }

  Future<void> cancelAppointment(int appointmentId) async {
    if (_userEmail == null) return;

    try {
      state = state.copyWith(isLoading: true);
      await _db.updateAppointmentStatus(appointmentId, 'cancelled');
      await loadAppointments();
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  List<AppointmentModel> getUpcomingAppointments() {
    final now = DateTime.now();
    return state.appointments
        .where((apt) =>
            apt.status == 'upcoming' &&
            apt.appointmentDate.isAfter(now))
        .toList()
      ..sort((a, b) => a.appointmentDate.compareTo(b.appointmentDate));
  }

  List<AppointmentModel> getAppointmentsByType(String type) {
    return state.appointments
        .where((apt) => apt.type == type)
        .toList()
      ..sort((a, b) => b.appointmentDate.compareTo(a.appointmentDate));
  }
}

final appointmentsProvider =
    NotifierProvider<AppointmentsNotifier, AppointmentsState>(() {
  return AppointmentsNotifier();
});
