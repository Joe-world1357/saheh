import 'package:flutter/material.dart';
<<<<<<< HEAD
import '../../../main.dart';

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({super.key});

  @override
  State<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../home/view/guest_navbar.dart';
import 'welcome_screen.dart';

class AnimatedSplash extends ConsumerStatefulWidget {
  const AnimatedSplash({super.key});

  @override
  ConsumerState<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends ConsumerState<AnimatedSplash>
>>>>>>> 11527b2 (Initial commit)
    with SingleTickerProviderStateMixin {

  late AnimationController _controller;
  late Animation<double> _fade;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    _fade = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeIn),
    );

    _controller.forward();

<<<<<<< HEAD
    // After 3 sec go to WelcomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
=======
    // After 3 sec navigate based on auth state
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        final authState = ref.read(authProvider);
        if (authState.isAuthenticated) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const GuestNavbar()),
          );
        } else {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (_) => const WelcomeScreen()),
          );
        }
      }
>>>>>>> 11527b2 (Initial commit)
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor, // use your teal or gradient later
      body: Center(
        child: FadeTransition(
          opacity: _fade,
          child: Image.asset(
            "assets/Logo.png",  // 🔥 your generated splash with glow
            width: 200,
          ),
        ),
      ),
    );
  }
}
