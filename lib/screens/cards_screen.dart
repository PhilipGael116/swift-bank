import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kFieldBorder = Color(0xFFE5E7EB);

class CardsScreen extends StatelessWidget {
  const CardsScreen({super.key});

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
                        'My Cards',
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
                          _CardPreviewTile(
                            title: 'Swift Virtual Card',
                            amount: 'FCFA 20,000,00.00',
                            cardType: 'Virtual',
                            gradientColors: const [
                              Color(0xFF0369A1),
                              Color(0xFF0EA5E9),
                            ],
                            accent: const Color(0xFF0EA5E9),
                            onTap: () =>
                                Navigator.of(context).pushNamed('/topup-card'),
                          ),
                          const SizedBox(height: 16),
                          _CardPreviewTile(
                            title: 'Swift Physical Card',
                            amount: 'Not activated',
                            cardType: 'Physical',
                            gradientColors: const [
                              Color(0xFF334155),
                              Color(0xFF0F172A),
                            ],
                            accent: const Color(0xFF94A3B8),
                            onTap: () => ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text(
                                  'Physical card activation is coming soon'),
                            )),
                          ),
                          const SizedBox(height: 24),
                          SizedBox(
                            width: double.infinity,
                            height: 52,
                            child: FilledButton(
                              onPressed: () => Navigator.of(context)
                                  .pushNamed('/topup-card'),
                              style: FilledButton.styleFrom(
                                backgroundColor: _kBrandBlue,
                                shape: const StadiumBorder(),
                                textStyle: const TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              child: const Text('Top-up using Card'),
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
      ),
    );
  }
}

class _CardPreviewTile extends StatelessWidget {
  const _CardPreviewTile({
    required this.title,
    required this.amount,
    required this.cardType,
    required this.gradientColors,
    required this.accent,
    required this.onTap,
  });

  final String title;
  final String amount;
  final String cardType;
  final List<Color> gradientColors;
  final Color accent;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(18),
          gradient: LinearGradient(
            colors: gradientColors,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.12),
              blurRadius: 14,
              offset: const Offset(0, 8),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(18),
          child: Stack(
            children: [
              Positioned.fill(
                child: Opacity(
                  opacity: 0.5,
                  child: SvgPicture.asset(
                    'lib/assets/Frame.svg',
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                  decoration: BoxDecoration(
                    color: accent.withValues(alpha: 0.18),
                    borderRadius: BorderRadius.circular(999),
                  ),
                  child: Text(
                    cardType,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    amount,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  const SizedBox(height: 18),
                  const Row(
                    children: [
                      Icon(Icons.credit_card, color: Colors.white70, size: 18),
                      SizedBox(width: 6),
                      Text(
                        'Tap to manage this card',
                        style: TextStyle(
                          color: Colors.white70,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
