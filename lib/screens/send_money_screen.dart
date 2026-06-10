import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class SendMoneyScreen extends StatelessWidget {
  const SendMoneyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: const SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        statusBarIconBrightness: Brightness.light,
        statusBarBrightness: Brightness.dark,
      ),
      child: Scaffold(
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
                  const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child: Text(
                        'Send Money',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: _kInkPrimary,
                        ),
                      ),
                    ),
                  ),
                  const Divider(height: 1, color: _kFieldBorder),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Text(
                            'Where do you want to send money?',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _kInkPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          _SendOptionTile(
                            icon: Icons.account_balance_outlined,
                            title: 'Send to Bank Account',
                            subtitle: 'Transfer to any local bank account',
                            onTap: () => Navigator.of(context)
                                .pushNamed('/send-bank-account'),
                          ),
                          const SizedBox(height: 12),
                          _SendOptionTile(
                            icon: Icons.qr_code_2_outlined,
                            title: 'Send via QR Code',
                            subtitle: 'Scan a Swift user QR code to pay',
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('QR transfers are coming soon'),
                            )),
                          ),
                          const SizedBox(height: 12),
                          _SendOptionTile(
                            icon: Icons.contacts_outlined,
                            title: 'Send to Swift Contact',
                            subtitle: 'Pay another Swift user instantly',
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content:
                                  Text('Sending to contacts is coming soon'),
                            )),
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
      ),
    );
  }
}

class _SendOptionTile extends StatelessWidget {
  const _SendOptionTile({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: _kChipBg,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: const BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: _kBrandBlue, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kInkPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(fontSize: 12, color: _kInkMuted),
                  ),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: _kInkMuted, size: 22),
          ],
        ),
      ),
    );
  }
}
