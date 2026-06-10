import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kSurface = Color(0xFFF3F4F6);
const _kFieldBorder = Color(0xFFE5E7EB);

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _obscurePassword = true;
  bool _isSubmitting = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    final name = _nameController.text.trim();
    final email = _emailController.text.trim();
    final password = _passwordController.text;

    if (name.isEmpty || email.isEmpty || password.isEmpty) {
      _showError('Please fill in your name, email and password.');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      final credential = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      await credential.user?.updateDisplayName(name);

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/home');
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Sign up failed. Please try again.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  void _handleGoToSignIn() {
    if (Navigator.of(context).canPop()) {
      Navigator.of(context).pop();
    } else {
      Navigator.of(context).pushReplacementNamed('/signin');
    }
  }

  void _handleGoogleSignIn() {
    // TODO: friend wires Firebase Google auth here
  }

  void _handleForgotPassword() {
    Navigator.of(context).pushNamed('/forgot-password');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(child: Image.asset('lib/assets/Logomark.png', height: 56)),
              const SizedBox(height: 16),
              const Center(
                child: Text(
                  'Sign Up for swiftbank',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: _kInkPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 48),
              const _FieldLabel('Full Name'),
              const SizedBox(height: 8),
              _TextInput(
                controller: _nameController,
                hintText: 'Enter your full name...',
                prefixIcon: Icons.person_outline,
                keyboardType: TextInputType.name,
              ),
              const SizedBox(height: 20),
              const _FieldLabel('Email Address'),
              const SizedBox(height: 8),
              _TextInput(
                controller: _emailController,
                hintText: 'Enter your email address...',
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              const _FieldLabel('Password'),
              const SizedBox(height: 8),
              _TextInput(
                controller: _passwordController,
                hintText: 'Enter your password...',
                prefixIcon: Icons.lock_outline,
                obscureText: _obscurePassword,
                suffixIcon: GestureDetector(
                  onTap: () =>
                      setState(() => _obscurePassword = !_obscurePassword),
                  child: Icon(
                    _obscurePassword
                        ? Icons.visibility_outlined
                        : Icons.visibility_off_outlined,
                    size: 20,
                    color: _kInkMuted,
                  ),
                ),
              ),
              const SizedBox(height: 24),
              _PrimaryButton(
                label: _isSubmitting ? 'Signing Up...' : 'Sign Up',
                onPressed: _isSubmitting ? null : _handleSignUp,
              ),
              const SizedBox(height: 12),
              _OutlineButton(
                label: 'Sign In',
                onPressed: _isSubmitting ? null : _handleGoToSignIn,
              ),
              const SizedBox(height: 28),
              Center(
                child: GestureDetector(
                  onTap: _handleForgotPassword,
                  child: const Text(
                    'Forgot Password',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: _kBrandBlue,
                      decoration: TextDecoration.underline,
                      decorationColor: _kBrandBlue,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Center(
                child: _GoogleSignInButton(onPressed: _handleGoogleSignIn),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _FieldLabel extends StatelessWidget {
  const _FieldLabel(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: _kInkPrimary,
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(32);
    return TextField(
      controller: controller,
      obscureText: obscureText,
      keyboardType: keyboardType,
      style: const TextStyle(fontSize: 14, color: _kInkPrimary),
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(fontSize: 14, color: _kInkMuted),
        prefixIcon: Padding(
          padding: const EdgeInsets.only(left: 20, right: 12),
          child: Icon(prefixIcon, size: 20, color: _kInkMuted),
        ),
        prefixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        suffixIcon: suffixIcon == null
            ? null
            : Padding(
                padding: const EdgeInsets.only(left: 8, right: 20),
                child: suffixIcon,
              ),
        suffixIconConstraints: const BoxConstraints(minWidth: 0, minHeight: 0),
        filled: true,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.symmetric(vertical: 18),
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: _kFieldBorder),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: _kFieldBorder),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: const BorderSide(color: _kBrandBlue, width: 1.4),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: _kBrandBlue,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 52,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: _kBrandBlue,
          backgroundColor: Colors.white,
          side: const BorderSide(color: _kBrandBlue, width: 1.4),
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

class _GoogleSignInButton extends StatelessWidget {
  const _GoogleSignInButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: const CircleBorder(side: BorderSide(color: _kFieldBorder)),
      child: InkWell(
        onTap: onPressed,
        customBorder: const CircleBorder(),
        child: SizedBox(
          width: 48,
          height: 48,
          child: Center(
            child: Image.asset('lib/assets/google.png', width: 24, height: 24),
          ),
        ),
      ),
    );
  }
}
