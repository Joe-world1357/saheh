import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
import 'core/localization/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'core/storage/auth_storage.dart';
import 'core/notifications/notification_service.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'providers/user_preferences_provider.dart';
import 'features/auth/view/splash_screen.dart';
import 'features/auth/view/welcome_screen.dart';
import 'features/home/view/guest_navbar.dart';
// import 'database/database_test.dart'; // Uncomment to test database

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Initialize sqflite for Linux/Desktop platforms
  if (Platform.isLinux || Platform.isWindows || Platform.isMacOS) {
    sqfliteFfiInit();
    databaseFactory = databaseFactoryFfi;
  }
  
  // Initialize Hive for local storage
  await AuthStorage.init();
  
  // Initialize Notification Service
  if (Platform.isAndroid) {
    await NotificationService.instance.initialize();
  }
  
  // Optional: Test database connection
  // Uncomment to test database on startup:
  // try {
  //   await DatabaseTest.testDatabase();
  // } catch (e) {
  //   debugPrint('Database initialization warning: $e');
  // }
  
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);
    final userPrefs = ref.watch(userPreferencesProvider);
    
    // Get locale from user preferences
    final locale = userPrefs.language == 'ar' 
        ? const Locale('ar')
        : const Locale('en');
    
    // Check if user is authenticated and navigate accordingly
    Widget home = const AnimatedSplash();
    
    // If authenticated, go to main app, otherwise show splash
    if (authState.isAuthenticated && !authState.isLoading) {
      home = const GuestNavbar();
    } else if (!authState.isLoading && !authState.isAuthenticated) {
      // Will be handled by splash screen navigation
      home = const AnimatedSplash();
    }
    
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Saheeh',
      theme: AppTheme.light,
      darkTheme: AppTheme.dark,
      themeMode: themeState.themeMode,
      locale: locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('en'),
        Locale('ar'),
      ],
      builder: (context, child) {
        // Apply RTL direction based on locale
        final locale = Localizations.maybeLocaleOf(context) ?? const Locale('en');
        return Directionality(
          textDirection: locale.languageCode == 'ar' ? TextDirection.rtl : TextDirection.ltr,
          child: child!,
        );
      },
      home: home,
    );
  }
}
