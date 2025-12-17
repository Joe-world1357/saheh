import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import 'login_screen.dart';
import 'register_screen.dart';
import '../../home/view/guest_navbar.dart';

class WelcomeScreen extends ConsumerWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
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
                  children: [
                    Text(
                      'Your health',
                      style: theme.textTheme.displayLarge,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      'journey starts here',
                      style: theme.textTheme.displayLarge,
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
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      color: isDark ? theme.colorScheme.primary : Colors.black,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Login',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: isDark 
                        ? theme.colorScheme.onPrimary 
                        : Colors.white,
                  ),
                ),
              ),

              const SizedBox(height: 12),

              // REGISTER BUTTON
              OutlinedButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const RegisterScreen()),
                  );
                },
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      color: isDark 
                          ? theme.colorScheme.primary 
                          : Colors.black,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  backgroundColor: isDark 
                      ? theme.colorScheme.surface 
                      : Colors.white,
                ),
                child: Text(
                  'Register',
                  style: theme.textTheme.labelLarge?.copyWith(
                    color: theme.colorScheme.onSurface,
                  ),
                ),
              ),

              const SizedBox(height: 18),

              // GOOGLE BUTTON
              OutlinedButton(
                onPressed: () {},
                style: OutlinedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: BorderSide(
                      color: isDark 
                          ? theme.colorScheme.primary 
                          : Colors.black,
                      width: 1,
                    ),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  backgroundColor: isDark 
                      ? theme.colorScheme.surface 
                      : Colors.white,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 12,
                      backgroundColor: isDark 
                          ? theme.colorScheme.surface 
                          : Colors.white,
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
                    Text(
                      'Continue with Google',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: theme.colorScheme.onSurface,
                      ),
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
                  child: Text(
                    'Continue as a guest',
                    style: theme.textTheme.labelLarge?.copyWith(
                      decoration: TextDecoration.underline,
                      color: theme.colorScheme.primary,
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


