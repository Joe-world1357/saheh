import 'package:flutter/material.dart';
import 'package:idk/main.dart';

class PasswordChangedScreen extends StatelessWidget {
  const PasswordChangedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // SUCCESS IMAGE
                Image.asset(
                  "assets/Success.png",   
                  height: 160,
                ),

                const SizedBox(height: 30),

                // TITLE
                const Text(
                  "Password Changed!",
                  style: TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),

                const SizedBox(height: 10),

                // SUBTEXT
                const Text(
                  "Your password has been\nchanged successfully.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF687779),
                    fontSize: 15,
                  ),
                ),

                const SizedBox(height: 40),

                // BACK TO LOGIN BUTTON
                ElevatedButton(
                  onPressed: () {
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (_) => const WelcomeScreen()),
                      (route) => false,
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: primary,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: const BorderSide(color: Colors.black, width: 1),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 50),
                  ),
                  child: const Text(
                    "Back to Login",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
