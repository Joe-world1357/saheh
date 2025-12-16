import 'package:flutter/material.dart';
<<<<<<< HEAD
import 'login_screen.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
=======
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';
import '../../../core/theme/app_colors.dart';
import '../../home/view/guest_navbar.dart';
import 'login_screen.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  final _phoneController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
>>>>>>> 11527b2 (Initial commit)
  bool _obscurePass1 = true;
  bool _obscurePass2 = true;

  @override
<<<<<<< HEAD
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
=======
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    final authNotifier = ref.read(authProvider.notifier);
    final success = await authNotifier.register(
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      password: _passwordController.text,
      phone: _phoneController.text.trim().isEmpty
          ? null
          : _phoneController.text.trim(),
    );

    if (mounted) {
      if (success) {
        // Navigate to main app
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const GuestNavbar()),
          (route) => false,
        );
      } else {
        // Show error message
        final error = ref.read(authProvider).error;
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(error ?? 'Registration failed'),
            backgroundColor: AppColors.error,
            behavior: SnackBarBehavior.floating,
          ),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final authState = ref.watch(authProvider);
    final primary = theme.colorScheme.primary;

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                const SizedBox(height: 16),

                // BACK BUTTON
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: Icon(
                      Icons.arrow_back_ios,
                      color: theme.colorScheme.onSurface,
                    ),
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
                Center(
                  child: Text(
                    "Hello! Register to get\nstarted",
                    textAlign: TextAlign.center,
                    style: theme.textTheme.displaySmall,
                  ),
                ),

                const SizedBox(height: 40),

                // USERNAME FIELD
                TextFormField(
                  controller: _nameController,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Full Name",
                    prefixIcon: Icon(Icons.person_outlined, color: primary),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your name';
                    }
                    if (value.length < 2) {
                      return 'Name must be at least 2 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // EMAIL FIELD
                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Email",
                    prefixIcon: Icon(Icons.email_outlined, color: primary),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter your email';
                    }
                    if (!value.contains('@')) {
                      return 'Please enter a valid email';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // PHONE FIELD (Optional)
                TextFormField(
                  controller: _phoneController,
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Phone (Optional)",
                    prefixIcon: Icon(Icons.phone_outlined, color: primary),
                  ),
                ),

                const SizedBox(height: 20),

                // PASSWORD FIELD
                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePass1,
                  textInputAction: TextInputAction.next,
                  decoration: InputDecoration(
                    hintText: "Password",
                    prefixIcon: Icon(Icons.lock_outlined, color: primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass1 ? Icons.visibility_off : Icons.visibility,
                        color: theme.colorScheme.onSurfaceVariant,
>>>>>>> 11527b2 (Initial commit)
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePass1 = !_obscurePass1;
                        });
                      },
                    ),
                  ),
<<<<<<< HEAD
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
=======
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please enter a password';
                    }
                    if (value.length < 6) {
                      return 'Password must be at least 6 characters';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 20),

                // CONFIRM PASSWORD FIELD
                TextFormField(
                  controller: _confirmPasswordController,
                  obscureText: _obscurePass2,
                  textInputAction: TextInputAction.done,
                  onFieldSubmitted: (_) => _handleRegister(),
                  decoration: InputDecoration(
                    hintText: "Confirm password",
                    prefixIcon: Icon(Icons.lock_outlined, color: primary),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePass2 ? Icons.visibility_off : Icons.visibility,
                        color: theme.colorScheme.onSurfaceVariant,
>>>>>>> 11527b2 (Initial commit)
                      ),
                      onPressed: () {
                        setState(() {
                          _obscurePass2 = !_obscurePass2;
                        });
                      },
                    ),
                  ),
<<<<<<< HEAD
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
=======
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Please confirm your password';
                    }
                    if (value != _passwordController.text) {
                      return 'Passwords do not match';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 40),

                // REGISTER BUTTON
                ElevatedButton(
                  onPressed: authState.isLoading ? null : _handleRegister,
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(32),
                      side: BorderSide(
                        color: theme.brightness == Brightness.dark
                            ? primary
                            : Colors.black,
                        width: 1,
                      ),
                    ),
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  child: authState.isLoading
                      ? const SizedBox(
                          height: 20,
                          width: 20,
                          child: CircularProgressIndicator(strokeWidth: 2),
                        )
                      : Text(
                          "Register",
                          style: theme.textTheme.labelLarge?.copyWith(
                            color: theme.brightness == Brightness.dark
                                ? theme.colorScheme.onPrimary
                                : Colors.white,
                          ),
                        ),
                ),

                const SizedBox(height: 20),

                // LOGIN LINK
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: theme.textTheme.bodyMedium,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (_) => const LoginScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Login Now",
                        style: TextStyle(color: primary),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),
              ],
            ),
>>>>>>> 11527b2 (Initial commit)
          ),
        ),
      ),
    );
  }
}
