import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);
const _kSuccess = Color(0xFF16A34A);

class TransferCompleteScreen extends StatelessWidget {
  const TransferCompleteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final args =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>?;
    final amount = args?['amount'] ?? 'FCFA 5,000.00';
    final bank = args?['bank'] ?? 'United Bank Of Africa';
    final account = args?['account'] ?? '2122444522';

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
                const SizedBox(height: 56),
                Center(
                  child: Container(
                    width: 80,
                    height: 80,
                    decoration: const BoxDecoration(
                      color: _kSuccess,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 40,
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
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Text(
                    'You have successfully transferred $amount\nBank Name: $bank\n$account',
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 13,
                      color: _kInkPrimary,
                      height: 1.6,
                    ),
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
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: SizedBox(
                    height: 52,
                    child: OutlinedButton.icon(
                      onPressed: () {
                        // TODO: generate + save PDF receipt
                      },
                      icon: const Icon(
                        Icons.file_download_outlined,
                        size: 18,
                        color: _kInkPrimary,
                      ),
                      label: const Text('Download receipt'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: _kInkPrimary,
                        side: const BorderSide(
                          color: _kFieldBorder,
                          width: 1.4,
                        ),
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
