import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../core/services/google_fit_service.dart';
import '../core/services/wearable_service.dart';
import '../providers/auth_provider.dart';

/// Wearable connection state
class WearableConnectionState {
  final bool isGoogleFitConnected;
  final bool isWearableConnected;
  final String? connectedDeviceName;
  final String? connectedAccountEmail;
  final DateTime? lastSyncTime;
  final bool isSyncing;
  final String? error;

  const WearableConnectionState({
    this.isGoogleFitConnected = false,
    this.isWearableConnected = false,
    this.connectedDeviceName,
    this.connectedAccountEmail,
    this.lastSyncTime,
    this.isSyncing = false,
    this.error,
  });

  WearableConnectionState copyWith({
    bool? isGoogleFitConnected,
    bool? isWearableConnected,
    String? connectedDeviceName,
    String? connectedAccountEmail,
    DateTime? lastSyncTime,
    bool? isSyncing,
    String? error,
    bool clearError = false,
  }) {
    return WearableConnectionState(
      isGoogleFitConnected: isGoogleFitConnected ?? this.isGoogleFitConnected,
      isWearableConnected: isWearableConnected ?? this.isWearableConnected,
      connectedDeviceName: connectedDeviceName ?? this.connectedDeviceName,
      connectedAccountEmail: connectedAccountEmail ?? this.connectedAccountEmail,
      lastSyncTime: lastSyncTime ?? this.lastSyncTime,
      isSyncing: isSyncing ?? this.isSyncing,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

/// Wearable connection provider
class WearableConnectionNotifier extends Notifier<WearableConnectionState> {
  final _googleFitService = GoogleFitService();
  final _wearableService = WearableService();

  @override
  WearableConnectionState build() {
    _checkConnectionStatus();
    return const WearableConnectionState();
  }

  /// Check current connection status
  Future<void> _checkConnectionStatus() async {
    final googleFitConnected = _googleFitService.isConnected;
    final wearableConnected = _wearableService.isConnected;
    final deviceName = _wearableService.connectedDeviceName;
    final accountEmail = _googleFitService.connectedAccountEmail;
    final lastSync = _googleFitService.lastSyncTime ?? _wearableService.lastSyncTime;

    state = state.copyWith(
      isGoogleFitConnected: googleFitConnected,
      isWearableConnected: wearableConnected,
      connectedDeviceName: deviceName,
      connectedAccountEmail: accountEmail,
      lastSyncTime: lastSync,
    );
  }

  /// Connect to Google Fit
  Future<bool> connectGoogleFit() async {
    state = state.copyWith(isSyncing: true, clearError: true);

    try {
      final success = await _googleFitService.initialize();
      
      state = state.copyWith(
        isGoogleFitConnected: success,
        isSyncing: false,
        error: success ? null : 'Failed to connect to Google Fit',
      );

      if (success) {
        // Auto-sync today's data
        await syncGoogleFitData();
      }

      return success;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        error: 'Error connecting to Google Fit: $e',
      );
      return false;
    }
  }

  /// Disconnect from Google Fit
  Future<void> disconnectGoogleFit() async {
    await _googleFitService.disconnect();
    state = state.copyWith(
      isGoogleFitConnected: false,
      lastSyncTime: null,
    );
  }

  /// Sync data from Google Fit
  Future<Map<String, dynamic>> syncGoogleFitData({DateTime? date}) async {
    final authState = ref.read(authProvider);
    final userEmail = authState.user?.email;
    
    if (userEmail == null) {
      return {'success': false, 'error': 'User not logged in'};
    }

    state = state.copyWith(isSyncing: true, clearError: true);

    try {
      final syncDate = date ?? DateTime.now();
      final results = await _googleFitService.syncAllData(
        syncDate,
        userEmail: userEmail,
        ref: ref as dynamic,
      );

      state = state.copyWith(
        isSyncing: false,
        lastSyncTime: DateTime.now(),
        error: results['success'] == false ? results['error'] : null,
      );

      return results;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        error: 'Error syncing data: $e',
      );
      return {'success': false, 'error': e.toString()};
    }
  }

  /// Connect to wearable device
  Future<bool> connectWearable(String deviceId) async {
    state = state.copyWith(isSyncing: true, clearError: true);

    try {
      // This would require device-specific implementation
      // For now, return false as placeholder
      state = state.copyWith(
        isSyncing: false,
        error: 'Wearable connection requires device-specific SDK',
      );
      return false;
    } catch (e) {
      state = state.copyWith(
        isSyncing: false,
        error: 'Error connecting to wearable: $e',
      );
      return false;
    }
  }

  /// Disconnect from wearable
  Future<void> disconnectWearable() async {
    await _wearableService.disconnect();
    state = state.copyWith(
      isWearableConnected: false,
      connectedDeviceName: null,
      lastSyncTime: null,
    );
  }

  /// Refresh connection status
  Future<void> refreshStatus() async {
    await _checkConnectionStatus();
  }
}

final wearableConnectionProvider = NotifierProvider<WearableConnectionNotifier, WearableConnectionState>(
  WearableConnectionNotifier.new,
);

