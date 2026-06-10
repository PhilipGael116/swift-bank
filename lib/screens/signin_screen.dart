import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kSurface = Color(0xFFF3F4F6);
const _kFieldBorder = Color(0xFFE5E7EB);

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  bool _rememberMe = true;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _handleSignIn() {
    Navigator.of(context).pushReplacementNamed('/home');
  }

  void _handleCreateAccount() {
    Navigator.of(context).pushNamed('/signup');
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
                  'Sign In to swiftbank',
                  style: TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    color: _kInkPrimary,
                  ),
                ),
              ),
              const SizedBox(height: 48),
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
              const SizedBox(height: 18),
              _RememberMeRow(
                checked: _rememberMe,
                onChanged: (v) => setState(() => _rememberMe = v),
              ),
              const SizedBox(height: 24),
              _PrimaryButton(label: 'Sign In', onPressed: _handleSignIn),
              const SizedBox(height: 12),
              _OutlineButton(
                label: 'Create New Account',
                onPressed: _handleCreateAccount,
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

class _RememberMeRow extends StatelessWidget {
  const _RememberMeRow({required this.checked, required this.onChanged});

  final bool checked;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: () => onChanged(!checked),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 150),
            width: 22,
            height: 22,
            decoration: BoxDecoration(
              color: checked ? _kBrandBlue : Colors.transparent,
              shape: BoxShape.circle,
              border: Border.all(
                color: checked ? _kBrandBlue : _kInkMuted,
                width: 1.5,
              ),
            ),
            child: checked
                ? const Icon(Icons.check, size: 14, color: Colors.white)
                : null,
          ),
          const SizedBox(width: 10),
          const Text(
            'Remember for 30 days',
            style: TextStyle(fontSize: 14, color: _kInkPrimary),
          ),
        ],
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

class _OutlineButton extends StatelessWidget {
  const _OutlineButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

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
