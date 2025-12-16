import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
<<<<<<< HEAD
<<<<<<< HEAD
import 'core/theme/app_colors.dart';
import 'features/auth/view/login_screen.dart';
import 'features/auth/view/register_screen.dart';
import 'features/auth/view/splash_screen.dart';
import 'features/home/view/guest_navbar.dart';

void main() {
=======
=======
import 'dart:io' show Platform;
import 'package:sqflite_common_ffi/sqflite_ffi.dart';
>>>>>>> ae69bd0 (Initial commit)
import 'core/theme/app_theme.dart';
import 'core/storage/auth_storage.dart';
import 'providers/theme_provider.dart';
import 'providers/auth_provider.dart';
import 'features/auth/view/login_screen.dart';
import 'features/auth/view/register_screen.dart';
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
  
<<<<<<< HEAD
>>>>>>> 11527b2 (Initial commit)
=======
  // Optional: Test database connection
  // Uncomment to test database on startup:
  // try {
  //   await DatabaseTest.testDatabase();
  // } catch (e) {
  //   debugPrint('Database initialization warning: $e');
  // }
  
>>>>>>> ae69bd0 (Initial commit)
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

<<<<<<< HEAD
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: AppColors.background,
        colorScheme: ColorScheme.fromSeed(
          seedColor: AppColors.primary,
          brightness: Brightness.light,
        ),
      ),

      // Start with splash animation
      home: const AnimatedSplash(),
=======
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeState = ref.watch(themeProvider);
    final authState = ref.watch(authProvider);
    
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
      title: 'Sehati Health App',
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: themeState.themeMode,
      home: home,
>>>>>>> 11527b2 (Initial commit)
    );
  }
}

<<<<<<< HEAD
// ===================================================================
//                       WELCOME SCREEN (INSIDE MAIN)
// ===================================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 80),

              // LOGO
              Center(
                child: SizedBox(
                  height: 200,
                  child: Image.asset('assets/Logo.png'),
                ),
              ),

              const SizedBox(height: 40),

              // TEXT
              Center(
                child: Column(
                  children: const [
                    Text(
                      'Your health',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'journey starts here',
                      style: TextStyle(
                        color: AppColors.textPrimary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              // LOGIN BUTTON
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Login',
                  style: TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 12),

              // REGISTER BUTTON
              ElevatedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  'Register',
                  style: TextStyle(color: Colors.black),
                ),
              ),

              const SizedBox(height: 18),

              // GOOGLE BUTTON
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: Colors.white,
                      child: ClipOval(
                        child: Image.asset(
                          'assets/Google.png',
                          width: 20,
                          height: 20,
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    const Text(
                      'Continue with Google',
                      style: TextStyle(color: Colors.black),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 18),

              // GUEST
              Center(
                child: TextButton(
                  onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(builder: (_) => const GuestNavbar()),
                      );
                    },
                  child: const Text(
                    'Continue as a guest',
                    style: TextStyle(
                      decoration: TextDecoration.underline,
                      color: AppColors.primary,
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 18),
            ],
          ),
        ),
      ),
    );
  }
}
=======
>>>>>>> 11527b2 (Initial commit)
