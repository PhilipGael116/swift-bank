import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkSecondary = Color(0xFF4B5563);
const _kInkMuted = Color(0xFF9CA3AF);
const _kSurface = Color(0xFFF3F4F6);
const _kFieldBorder = Color(0xFFE5E7EB);

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _emailController = TextEditingController();
  bool _isSubmitting = false;

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  Future<void> _handleContinue() async {
    final email = _emailController.text.trim();
    if (email.isEmpty) {
      _showError('Please enter your email address.');
      return;
    }

    setState(() => _isSubmitting = true);
    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: email);

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed('/password-reset-sent');
    } on FirebaseAuthException catch (e) {
      _showError(e.message ?? 'Could not send reset email. Please try again.');
    } finally {
      if (mounted) setState(() => _isSubmitting = false);
    }
  }

  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
          child: Column(
            children: [
              Image.asset('lib/assets/Group.png', height: 104),
              const SizedBox(height: 40),
              const Text(
                'Forgot Password',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: _kInkPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                'Please enter your email address to reset your\npassword.',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: _kInkSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _TextInput(
                controller: _emailController,
                hintText: 'Enter your email address...',
                prefixIcon: Icons.mail_outline,
                keyboardType: TextInputType.emailAddress,
              ),
              const SizedBox(height: 20),
              _PrimaryButton(
                label: _isSubmitting ? 'Sending...' : 'Continue',
                onPressed: _isSubmitting ? null : _handleContinue,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TextInput extends StatelessWidget {
  const _TextInput({
    required this.controller,
    required this.hintText,
    required this.prefixIcon,
    this.keyboardType,
  });

  final TextEditingController controller;
  final String hintText;
  final IconData prefixIcon;
  final TextInputType? keyboardType;

  @override
  Widget build(BuildContext context) {
    final radius = BorderRadius.circular(32);
    return TextField(
      controller: controller,
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
