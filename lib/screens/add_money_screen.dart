import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class AddMoneyScreen extends StatelessWidget {
  const AddMoneyScreen({super.key});

  static const _accountNumber = '8085472417';

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
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
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
                              'Add Money',
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: _kInkPrimary,
                              ),
                            ),
                          ),
                        ),
                        IconButton(
                          icon: const Icon(
                            Icons.chat_bubble_outline,
                            size: 22,
                            color: _kInkPrimary,
                          ),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                  const Divider(height: 1, color: _kFieldBorder),
                  Expanded(
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.fromLTRB(20, 16, 20, 24),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          _OptionRow(
                            icon: Icons.account_balance_outlined,
                            title: 'Bank Transfer',
                            subtitle: 'Add money via mobile or internet banking',
                            onTap: () {},
                          ),
                          const SizedBox(height: 16),
                          const Divider(height: 1, color: _kFieldBorder),
                          const SizedBox(height: 20),
                          const Text(
                            'Swift Pay Account Number',
                            style: TextStyle(fontSize: 13, color: _kInkMuted),
                          ),
                          const SizedBox(height: 4),
                          const Text(
                            _accountNumber,
                            style: TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: _kInkPrimary,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Row(
                            children: [
                              Expanded(
                                child: _SecondaryButton(
                                  label: 'Copy Number',
                                  onPressed: () => _copyToClipboard(context),
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: _PrimaryButton(
                                  label: 'Share Info',
                                  onPressed: () {},
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),
                          const _OrDivider(),
                          const SizedBox(height: 16),
                          _OptionRow(
                            icon: Icons.credit_card_outlined,
                            title: 'Top-up using Card',
                            subtitle: 'Add money directly from your bank card',
                            onTap: () =>
                                Navigator.of(context).pushNamed('/topup-card'),
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

  void _copyToClipboard(BuildContext context) {
    Clipboard.setData(const ClipboardData(text: _accountNumber));
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Account number copied'),
        duration: Duration(seconds: 2),
      ),
    );
  }
}

class _OptionRow extends StatelessWidget {
  const _OptionRow({
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
      onTap: onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 12),
        child: Row(
          children: [
            Container(
              width: 40,
              height: 40,
              decoration: const BoxDecoration(
                color: _kChipBg,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, size: 20, color: _kInkPrimary),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
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
            const Icon(Icons.chevron_right, size: 22, color: _kInkMuted),
          ],
        ),
      ),
    );
  }
}

class _OrDivider extends StatelessWidget {
  const _OrDivider();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Expanded(child: Divider(color: _kFieldBorder, thickness: 1)),
        SizedBox(width: 12),
        Text(
          'OR',
          style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w500,
            color: _kInkMuted,
            letterSpacing: 0.5,
          ),
        ),
        SizedBox(width: 12),
        Expanded(child: Divider(color: _kFieldBorder, thickness: 1)),
      ],
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
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: _kBrandBlue,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({required this.label, required this.onPressed});

  final String label;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: FilledButton(
        onPressed: onPressed,
        style: FilledButton.styleFrom(
          backgroundColor: _kChipBg,
          foregroundColor: _kInkPrimary,
          shape: const StadiumBorder(),
          textStyle: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
        ),
        child: Text(label),
      ),
    );
  }
}
