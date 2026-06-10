import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);

class SendBankAccountScreen extends StatefulWidget {
  const SendBankAccountScreen({super.key});

  @override
  State<SendBankAccountScreen> createState() => _SendBankAccountScreenState();
}

class _SendBankAccountScreenState extends State<SendBankAccountScreen> {
  final _accountController = TextEditingController();
  final _bankController = TextEditingController();
  final _beneficiaryController = TextEditingController();

  bool _isValid = false;
  bool _isLoading = false;

  static const _banks = [
    'United Bank for Africa',
    'Carbon',
    'FCMB',
    'Ecobank',
    'First Bank',
    'Access Bank',
    'Heritage Bank',
  ];

  @override
  void initState() {
    super.initState();
    _accountController.addListener(_check);
    _bankController.addListener(_check);
    _beneficiaryController.addListener(_check);
  }

  @override
  void dispose() {
    _accountController.dispose();
    _bankController.dispose();
    _beneficiaryController.dispose();
    super.dispose();
  }

  void _check() {
    final valid = _accountController.text.trim().isNotEmpty &&
        _bankController.text.trim().isNotEmpty &&
        _beneficiaryController.text.trim().isNotEmpty;
    if (valid != _isValid) {
      setState(() => _isValid = valid);
    }
  }

  Future<void> _handleContinue() async {
    setState(() => _isLoading = true);
    // TODO: friend wires Firebase / payment processor here
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacementNamed(
      '/transfer-complete',
      arguments: {
        'amount': 'FCFA 5,000.00',
        'bank': _bankController.text,
        'account': _accountController.text,
      },
    );
  }

  void _showBankPicker() {
    showModalBottomSheet<void>(
      context: context,
      backgroundColor: Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (_) => SafeArea(
        child: ListView(
          shrinkWrap: true,
          children: [
            const Padding(
              padding: EdgeInsets.all(16),
              child: Text(
                'Select Bank',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: _kInkPrimary,
                ),
              ),
            ),
            const Divider(height: 1, color: _kFieldBorder),
            for (final bank in _banks)
              ListTile(
                title: Text(
                  bank,
                  style: const TextStyle(
                    fontSize: 14,
                    color: _kInkPrimary,
                  ),
                ),
                onTap: () {
                  _bankController.text = bank;
                  Navigator.of(context).pop();
                },
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBrandBlue,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 4,
                    vertical: 8,
                  ),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(
                          Icons.arrow_back_ios_new,
                          size: 18,
                          color: _kInkPrimary,
                        ),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      const Expanded(
                        child: Center(
                          child: Text(
                            'Send to Bank Account',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _kInkPrimary,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 48),
                    ],
                  ),
                ),
                const Divider(height: 1, color: _kFieldBorder),
                Expanded(
                  child: SingleChildScrollView(
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _BalanceCard(),
                        const SizedBox(height: 28),
                        _UnderlineField(
                          controller: _accountController,
                          hint: 'Account Number',
                          keyboardType: TextInputType.number,
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          controller: _bankController,
                          hint: 'Bank',
                          readOnly: true,
                          onTap: _showBankPicker,
                          suffixIcon: const Icon(
                            Icons.keyboard_arrow_down,
                            color: _kInkMuted,
                          ),
                        ),
                        const SizedBox(height: 18),
                        _UnderlineField(
                          controller: _beneficiaryController,
                          hint: "Beneficiary's Name",
                        ),
                        const SizedBox(height: 32),
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed: _isValid && !_isLoading
                                ? _handleContinue
                                : null,
                            style: FilledButton.styleFrom(
                              backgroundColor: _kBrandBlue,
                              disabledBackgroundColor: _kInkMuted,
                              disabledForegroundColor: Colors.white,
                              shape: const StadiumBorder(),
                              textStyle: const TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            child: _isLoading
                                ? const SizedBox(
                                    width: 20,
                                    height: 20,
                                    child: CircularProgressIndicator(
                                      strokeWidth: 2.5,
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                        Colors.white,
                                      ),
                                    ),
                                  )
                                : const Text('Continue'),
                          ),
                        ),
                      ],
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

class _BalanceCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        color: _kBrandBlue,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: SvgPicture.asset(
                'lib/assets/Frame.svg',
                fit: BoxFit.cover,
                alignment: Alignment.bottomCenter,
                colorFilter: ColorFilter.mode(
                  Colors.white.withValues(alpha: 0.35),
                  BlendMode.srcIn,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Total Balance',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
                const SizedBox(height: 6),
                const Text(
                  'FCFA 20,000,00.00',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 6),
                Text(
                  'Last updated 2 mins ago.',
                  style: TextStyle(
                    fontSize: 11,
                    color: Colors.white.withValues(alpha: 0.65),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _UnderlineField extends StatelessWidget {
  const _UnderlineField({
    required this.controller,
    required this.hint,
    this.keyboardType,
    this.readOnly = false,
    this.onTap,
    this.suffixIcon,
  });

  final TextEditingController controller;
  final String hint;
  final TextInputType? keyboardType;
  final bool readOnly;
  final VoidCallback? onTap;
  final Widget? suffixIcon;

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      readOnly: readOnly,
      onTap: onTap,
      style: const TextStyle(fontSize: 15, color: _kInkPrimary),
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(fontSize: 15, color: _kInkMuted),
        contentPadding: const EdgeInsets.symmetric(vertical: 12),
        suffixIcon: suffixIcon,
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _kFieldBorder),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: _kBrandBlue, width: 1.5),
        ),
      ),
    );
  }
}
