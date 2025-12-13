import 'package:flutter/material.dart';
import 'main.dart';

class AnimatedSplash extends StatefulWidget {
  const AnimatedSplash({super.key});

  @override
  State<AnimatedSplash> createState() => _AnimatedSplashState();
}

class _AnimatedSplashState extends State<AnimatedSplash>
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

    // After 3 sec go to WelcomeScreen
    Future.delayed(const Duration(seconds: 3), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (_) => const WelcomeScreen()),
      );
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
      backgroundColor: const Color(0xFFF5FAFA), // use your teal or gradient later
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
