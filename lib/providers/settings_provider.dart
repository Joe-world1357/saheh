import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsNotifier extends Notifier<SettingsState> {
  @override
  SettingsState build() {
    _loadSettings();
    return SettingsState();
  }

  Future<void> _loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    state = SettingsState(
      language: prefs.getString('language') ?? 'English',
      darkMode: prefs.getBool('darkMode') ?? false,
      notificationsEnabled: prefs.getBool('notificationsEnabled') ?? true,
      autoSync: prefs.getBool('autoSync') ?? true,
      syncOnWiFiOnly: prefs.getBool('syncOnWiFiOnly') ?? false,
    );
  }

  Future<void> setLanguage(String language) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language', language);
    state = state.copyWith(language: language);
  }

  Future<void> setDarkMode(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('darkMode', enabled);
    state = state.copyWith(darkMode: enabled);
  }

  Future<void> setNotificationsEnabled(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('notificationsEnabled', enabled);
    state = state.copyWith(notificationsEnabled: enabled);
  }

  Future<void> setAutoSync(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('autoSync', enabled);
    state = state.copyWith(autoSync: enabled);
  }

  Future<void> setSyncOnWiFiOnly(bool enabled) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('syncOnWiFiOnly', enabled);
    state = state.copyWith(syncOnWiFiOnly: enabled);
  }
}

class SettingsState {
  final String language;
  final bool darkMode;
  final bool notificationsEnabled;
  final bool autoSync;
  final bool syncOnWiFiOnly;

  SettingsState({
    this.language = 'English',
    this.darkMode = false,
    this.notificationsEnabled = true,
    this.autoSync = true,
    this.syncOnWiFiOnly = false,
  });

  SettingsState copyWith({
    String? language,
    bool? darkMode,
    bool? notificationsEnabled,
    bool? autoSync,
    bool? syncOnWiFiOnly,
  }) {
    return SettingsState(
      language: language ?? this.language,
      darkMode: darkMode ?? this.darkMode,
      notificationsEnabled: notificationsEnabled ?? this.notificationsEnabled,
      autoSync: autoSync ?? this.autoSync,
      syncOnWiFiOnly: syncOnWiFiOnly ?? this.syncOnWiFiOnly,
    );
  }
}

final settingsProvider = NotifierProvider<SettingsNotifier, SettingsState>(() {
  return SettingsNotifier();
});

