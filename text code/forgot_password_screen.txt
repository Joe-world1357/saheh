import 'package:flutter/material.dart';
import 'otp_screen.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const SizedBox(height: 16),

              // BACK BUTTON
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Color(0xFF1A2A2C)),
                  onPressed: () => Navigator.pop(context),
                ),
              ),

              const SizedBox(height: 20),

              // LOGO
              Center(
                child: Image.asset(
                  "assets/Logo.png",
                  height: 120,
                ),
              ),

              const SizedBox(height: 30),

              // TITLE
              const Center(
                child: Text(
                  "Forgot Password?",
                  style: TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // SUBTITLE
              const Center(
                child: Text(
                  "Enter your email and we will send\nyou a reset link.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF687779),
                    fontSize: 16,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // EMAIL FIELD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: primary, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  keyboardType: TextInputType.emailAddress,
                  style: TextStyle(color: Color(0xFF1A2A2C)),
                  decoration: InputDecoration(
                    hintText: "Enter your email",
                    hintStyle: TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // SEND BUTTON
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const OtpScreen()),
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
                  "Send Reset Link",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
