import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/scheduler.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeState {
  final ThemeMode themeMode;
  final bool isInitialized;

  ThemeState({
    this.themeMode = ThemeMode.system,
    this.isInitialized = false,
  });

  ThemeState copyWith({
    ThemeMode? themeMode,
    bool? isInitialized,
  }) {
    return ThemeState(
      themeMode: themeMode ?? this.themeMode,
      isInitialized: isInitialized ?? this.isInitialized,
    );
  }

  bool isDarkMode(BuildContext context) {
    if (themeMode == ThemeMode.system) {
      return MediaQuery.of(context).platformBrightness == Brightness.dark;
    }
    return themeMode == ThemeMode.dark;
  }
}

class ThemeNotifier extends Notifier<ThemeState> {
  @override
  ThemeState build() {
    _loadThemeMode();
    return ThemeState();
  }

  Future<void> _loadThemeMode() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final themeModeString = prefs.getString('themeMode') ?? 'system';
      
      ThemeMode mode;
      switch (themeModeString) {
        case 'light':
          mode = ThemeMode.light;
          break;
        case 'dark':
          mode = ThemeMode.dark;
          break;
        default:
          mode = ThemeMode.system;
      }
      
      state = state.copyWith(themeMode: mode, isInitialized: true);
    } catch (e) {
      debugPrint('Error loading theme mode: $e');
      state = state.copyWith(themeMode: ThemeMode.system, isInitialized: true);
    }
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (state.themeMode == mode) return;
    
    state = state.copyWith(themeMode: mode);
    
    try {
      final prefs = await SharedPreferences.getInstance();
      await prefs.setString('themeMode', mode.toString().split('.').last);
    } catch (e) {
      debugPrint('Error saving theme mode: $e');
    }
  }

  Future<void> toggleTheme() async {
    if (state.themeMode == ThemeMode.light) {
      await setThemeMode(ThemeMode.dark);
    } else if (state.themeMode == ThemeMode.dark) {
      await setThemeMode(ThemeMode.light);
    } else {
      final brightness = SchedulerBinding.instance.platformDispatcher.platformBrightness;
      if (brightness == Brightness.dark) {
        await setThemeMode(ThemeMode.light);
      } else {
        await setThemeMode(ThemeMode.dark);
      }
    }
  }
}

final themeProvider = NotifierProvider<ThemeNotifier, ThemeState>(() {
  return ThemeNotifier();
});
