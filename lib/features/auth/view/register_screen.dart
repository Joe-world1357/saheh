import 'package:flutter/material.dart';
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  bool _obscurePass1 = true;
  bool _obscurePass2 = true;

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
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

              const SizedBox(height: 10),

              // LOGO
              Center(
                child: Image.asset(
                  "assets/Logo.png",
                  height: 120,
                ),
              ),

              const SizedBox(height: 20),

              // TITLE
              const Center(
                child: Text(
                  "Hello! Register to get\nstarted",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // USERNAME FIELD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: primary, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  style: TextStyle(color: Color(0xFF1A2A2C)),
                  decoration: InputDecoration(
                    hintText: "Username",
                    hintStyle: TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // EMAIL FIELD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: primary, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: const TextField(
                  style: TextStyle(color: Color(0xFF1A2A2C)),
                  decoration: InputDecoration(
                    hintText: "Email",
                    hintStyle: TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // PASSWORD FIELD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: primary, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  obscureText: _obscurePass1,
                  style: const TextStyle(color: Color(0xFF1A2A2C)),
                  decoration: InputDecoration(
                    hintText: "Password",
                    hintStyle: const TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass1 ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF687779),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePass1 = !_obscurePass1;
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // CONFIRM PASSWORD FIELD
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(32),
                  border: Border.all(color: primary, width: 1.5),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: TextField(
                  obscureText: _obscurePass2,
                  style: const TextStyle(color: Color(0xFF1A2A2C)),
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    hintStyle: const TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass2 ? Icons.visibility_off : Icons.visibility,
                        color: Color(0xFF687779),
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePass2 = !_obscurePass2;
                        });
                      },
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // REGISTER BUTTON
              ElevatedButton(
                onPressed: () {},
                style: ElevatedButton.styleFrom(
                  backgroundColor: primary,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(32),
                    side: const BorderSide(color: Colors.black, width: 1),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 16),
                ),
                child: const Text(
                  "Register",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 20),

              // ===========================
              // LOGIN LINK (fixed)
              // ===========================
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Already have an account? ",
                    style: TextStyle(color: Color(0xFF1A2A2C)),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(builder: (_) => const LoginScreen()),
                      );
                    },
                    child: const Text(
                      "Login Now",
                      style: TextStyle(color: primary),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
