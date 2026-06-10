import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class TopUpCardScreen extends StatefulWidget {
  const TopUpCardScreen({super.key});

  @override
  State<TopUpCardScreen> createState() => _TopUpCardScreenState();
}

class _TopUpCardScreenState extends State<TopUpCardScreen> {
  final _amountController = TextEditingController();
  bool _isValid = false;

  @override
  void initState() {
    super.initState();
    _amountController.addListener(_onAmountChanged);
  }

  @override
  void dispose() {
    _amountController.removeListener(_onAmountChanged);
    _amountController.dispose();
    super.dispose();
  }

  void _onAmountChanged() {
    final hasValue = _amountController.text.trim().isNotEmpty;
    if (hasValue != _isValid) {
      setState(() => _isValid = hasValue);
    }
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
                    padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Top-up amount',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: _kInkPrimary,
                          ),
                        ),
                        const SizedBox(height: 10),
                        TextField(
                          controller: _amountController,
                          keyboardType: const TextInputType.numberWithOptions(
                            decimal: true,
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: _kInkPrimary,
                          ),
                          decoration: const InputDecoration(
                            hintText: 'Amount',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: _kInkMuted,
                            ),
                            contentPadding: EdgeInsets.symmetric(vertical: 12),
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
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 14,
                            vertical: 12,
                          ),
                          decoration: BoxDecoration(
                            color: _kChipBg,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Wrap(
                            crossAxisAlignment: WrapCrossAlignment.center,
                            children: [
                              const Text(
                                'For amount above FCFA 9,999.00 ',
                                style: TextStyle(
                                  fontSize: 12,
                                  color: _kInkMuted,
                                ),
                              ),
                              GestureDetector(
                                onTap: () => Navigator.of(context).pop(),
                                child: const Text(
                                  'use bank transfer >>',
                                  style: TextStyle(
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                    color: _kInkPrimary,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 28),
                        SizedBox(
                          height: 52,
                          child: FilledButton(
                            onPressed: _isValid ? _handleNext : null,
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
                            child: const Text('Next'),
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

  void _handleNext() {
    final amount = _amountController.text.trim();
    Navigator.of(context).pushNamed('/topup-card-confirm', arguments: amount);
  }
}
