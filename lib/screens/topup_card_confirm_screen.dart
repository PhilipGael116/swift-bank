import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkSecondary = Color(0xFF4B5563);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class TopUpCardConfirmScreen extends StatefulWidget {
  const TopUpCardConfirmScreen({super.key});

  @override
  State<TopUpCardConfirmScreen> createState() => _TopUpCardConfirmScreenState();
}

class _TopUpCardConfirmScreenState extends State<TopUpCardConfirmScreen> {
  final _cvvController = TextEditingController();
  bool _isValid = false;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _cvvController.addListener(_onCvvChanged);
  }

  @override
  void dispose() {
    _cvvController.removeListener(_onCvvChanged);
    _cvvController.dispose();
    super.dispose();
  }

  void _onCvvChanged() {
    final valid = _cvvController.text.trim().length == 3;
    if (valid != _isValid) {
      setState(() => _isValid = valid);
    }
  }

  Future<void> _handleConfirm() async {
    setState(() => _isLoading = true);
    // TODO: friend wires payment processor / Firebase here
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    Navigator.of(context).pushReplacementNamed(
      '/transfer-success',
      arguments: _displayAmount(context),
    );
  }

  String _displayAmount(BuildContext context) {
    final raw = ModalRoute.of(context)?.settings.arguments as String?;
    if (raw == null || raw.isEmpty) return 'FCFA 5,000.00';
    return 'FCFA $raw';
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
                            'Top-up using Card',
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
                    padding: const EdgeInsets.fromLTRB(20, 24, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Center(
                          child: Text(
                            _displayAmount(context),
                            style: const TextStyle(
                              fontSize: 30,
                              fontWeight: FontWeight.w700,
                              color: _kInkPrimary,
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                        const Divider(height: 1, color: _kFieldBorder),
                        const SizedBox(height: 20),
                        const Text(
                          'Funding Method',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w700,
                            color: _kInkPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        _FundingMethodCard(
                          bankName: 'United Bank for Africa',
                          cardNumber: '5669996****7989',
                          onChange: () {},
                        ),
                        const SizedBox(height: 20),
                        TextField(
                          controller: _cvvController,
                          keyboardType: TextInputType.number,
                          maxLength: 3,
                          style: const TextStyle(
                            fontSize: 16,
                            color: _kInkPrimary,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'CVV',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: _kInkMuted,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
                            counterText: '',
                            enabledBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: _kFieldBorder),
                            ),
                            focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                color: _kBrandBlue,
                                width: 1.5,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 10),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: const [
                            Icon(Icons.info, size: 16, color: _kInkMuted),
                            SizedBox(width: 8),
                            Expanded(
                              child: Text(
                                'The CVV is the three-digit number at the back of your bank card.',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _kInkSecondary,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 24),
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed: _isValid && !_isLoading
                                ? _handleConfirm
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
                                : const Text('Confirm'),
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

class _FundingMethodCard extends StatelessWidget {
  const _FundingMethodCard({
    required this.bankName,
    required this.cardNumber,
    required this.onChange,
  });

  final String bankName;
  final String cardNumber;
  final VoidCallback onChange;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      decoration: BoxDecoration(
        color: _kChipBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/Frame 427319569.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  bankName,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kInkPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  cardNumber,
                  style: const TextStyle(fontSize: 12, color: _kInkMuted),
                ),
              ],
            ),
          ),
          GestureDetector(
            onTap: onChange,
            child: Row(
              children: const [
                Text(
                  'Change',
                  style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: _kInkPrimary,
                  ),
                ),
                SizedBox(width: 2),
                Icon(Icons.chevron_right, size: 16, color: _kInkPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
