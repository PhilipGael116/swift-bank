import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkSecondary = Color(0xFF4B5563);
const _kSurface = Color(0xFFF3F4F6);

class PasswordResetSentScreen extends StatelessWidget {
  const PasswordResetSentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 60, 24, 24),
          child: Column(
            children: [
              Image.asset('lib/assets/Frame (1).png', height: 240),
              const SizedBox(height: 40),
              const Text(
                'Password Reset Sent.',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  color: _kInkPrimary,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Please check your email in a few minutes -\nwe've sent you an email containing password\nrecovery link.",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  color: _kInkSecondary,
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 32),
              _PrimaryButton(
                label: 'Open Email App',
                onPressed: () {
                  // TODO: launch the device's default email app via
                  // url_launcher (e.g. launchUrl(Uri.parse('mailto:'))).
                  Navigator.of(context).pushNamedAndRemoveUntil(
                    '/signin',
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

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
