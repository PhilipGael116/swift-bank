import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class InvestScreen extends StatelessWidget {
  const InvestScreen({super.key});

  static const _options = [
    _InvestOption(
      icon: Icons.savings_outlined,
      title: 'Fixed Savings',
      subtitle: 'Lock funds and earn up to 12% p.a.',
      accent: Color(0xFF0369A1),
    ),
    _InvestOption(
      icon: Icons.show_chart,
      title: 'Mutual Funds',
      subtitle: 'Grow your money with managed funds',
      accent: Color(0xFF16A34A),
    ),
    _InvestOption(
      icon: Icons.account_balance_outlined,
      title: 'Treasury Bills',
      subtitle: 'Low-risk government-backed returns',
      accent: Color(0xFFCA8A04),
    ),
    _InvestOption(
      icon: Icons.trending_up,
      title: 'Stocks',
      subtitle: 'Buy shares in your favorite companies',
      accent: Color(0xFF7C3AED),
    ),
  ];

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
                        'Invest',
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
                          Container(
                            width: double.infinity,
                            padding: const EdgeInsets.all(20),
                            decoration: BoxDecoration(
                              color: _kBrandBlue,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'Total Invested',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withValues(alpha: 0.75),
                                  ),
                                ),
                                const SizedBox(height: 6),
                                const Text(
                                  'FCFA 0.00',
                                  style: TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  'Start growing your money today',
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.white.withValues(alpha: 0.7),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 24),
                          const Text(
                            'Investment plans',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _kInkPrimary,
                            ),
                          ),
                          const SizedBox(height: 12),
                          for (final option in _options) ...[
                            _InvestOptionTile(option: option),
                            const SizedBox(height: 12),
                          ],
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

class _InvestOption {
  const _InvestOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.accent,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final Color accent;
}

class _InvestOptionTile extends StatelessWidget {
  const _InvestOptionTile({required this.option});

  final _InvestOption option;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(14),
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('${option.title} is coming soon')),
        );
      },
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
              decoration: BoxDecoration(
                color: option.accent.withValues(alpha: 0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(option.icon, color: option.accent, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    option.title,
                    style: const TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: _kInkPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    option.subtitle,
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
