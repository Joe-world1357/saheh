import 'package:flutter/material.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import 'splash_screen.dart';
import 'guest_navbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Health App',
      theme: ThemeData(
        useMaterial3: true,
        scaffoldBackgroundColor: const Color(0xFFF5FAFA),
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF20C6B7),
          brightness: Brightness.light,
        ),
      ),

      // Start with splash animation
      home: const AnimatedSplash(),
    );
  }
}

// ===================================================================
//                       WELCOME SCREEN (INSIDE MAIN)
// ===================================================================

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

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
                        color: Color(0xFF1A2A2C),
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 8),
                    Text(
                      'journey starts here',
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
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
                  backgroundColor: primary,
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
                      color: Color(0xFF20C6B7),
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
