import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class TransferSuccessScreen extends StatelessWidget {
  const TransferSuccessScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final amount =
        ModalRoute.of(context)?.settings.arguments as String? ??
        'FCFA 5,000.00';

    return Scaffold(
      backgroundColor: _kBrandBlue,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.only(top: 50),
          child: Container(
            width: double.infinity,
            decoration: const BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.vertical(top: Radius.circular(10)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        size: 22,
                        color: _kInkPrimary,
                      ),
                      onPressed: () => Navigator.of(
                        context,
                      ).pushNamedAndRemoveUntil('/home', (r) => false),
                    ),
                  ),
                ),
                const Divider(height: 1, color: _kFieldBorder),
                const SizedBox(height: 60),
                Center(
                  child: Container(
                    width: 72,
                    height: 72,
                    decoration: const BoxDecoration(
                      color: _kBrandBlue,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 36,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 24),
                const Center(
                  child: Text(
                    'Transfer successful!',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: _kInkPrimary,
                    ),
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 50),
                  child: Text.rich(
                    TextSpan(
                      style: const TextStyle(fontSize: 13, color: _kInkMuted),
                      children: [
                        TextSpan(
                          text: amount,
                          style: const TextStyle(
                            color: _kInkPrimary,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const TextSpan(
                          text: '  has been added to your account.',
                        ),
                      ],
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                const SizedBox(height: 28),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 52,
                    child: FilledButton.icon(
                      onPressed: () {
                        // TODO: share receipt via share_plus
                      },
                      icon: const Icon(
                        Icons.ios_share,
                        size: 18,
                        color: _kInkPrimary,
                      ),
                      label: const Text('Share Receipt'),
                      style: FilledButton.styleFrom(
                        backgroundColor: _kChipBg,
                        foregroundColor: _kInkPrimary,
                        shape: const StadiumBorder(),
                        textStyle: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
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
