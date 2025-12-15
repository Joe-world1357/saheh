import 'package:flutter/material.dart';
import 'password_changed_screen.dart';

class CreateNewPasswordScreen extends StatefulWidget {
  const CreateNewPasswordScreen({super.key});

  @override
  State<CreateNewPasswordScreen> createState() => _CreateNewPasswordScreenState();
}

class _CreateNewPasswordScreenState extends State<CreateNewPasswordScreen> {
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

              const SizedBox(height: 30),

              // TITLE
              const Center(
                child: Text(
                  "Create new password",
                  style: TextStyle(
                    color: Color(0xFF1A2A2C),
                    fontSize: 26,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // SUBTITLE
              const Center(
                child: Text(
                  "Your new password must be unique\nfrom those previously used.",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Color(0xFF687779),
                    fontSize: 15,
                  ),
                ),
              ),

              const SizedBox(height: 40),

              // NEW PASSWORD FIELD
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
                    hintText: "New Password",
                    hintStyle: const TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass1 ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF687779),
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
                    hintText: "Confirm Password",
                    hintStyle: const TextStyle(color: Color(0xFF687779)),
                    border: InputBorder.none,
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass2 ? Icons.visibility_off : Icons.visibility,
                        color: const Color(0xFF687779),
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

              // RESET PASSWORD BUTTON
              ElevatedButton(
                onPressed: () {
                    Navigator.push(
                      context,
                        MaterialPageRoute(builder: (_) => const PasswordChangedScreen()),
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
                  "Reset Password",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
