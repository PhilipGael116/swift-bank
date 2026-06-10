import 'dart:math' as math;

import 'package:flutter/material.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkSecondary = Color(0xFF4B5563);
const _kInkMuted = Color(0xFF9CA3AF);
const _kSurface = Color(0xFFF3F4F6);
const _kGoldCard = Color(0xFFE9B949);
const _kSuccess = Color(0xFF16A34A);

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key, this.nextRoute});

  final String? nextRoute;

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _controller = PageController();
  int _currentPage = 0;
  static const int _pageCount = 3;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < _pageCount - 1) {
      _controller.nextPage(
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOut,
      );
    } else if (widget.nextRoute != null) {
      Navigator.of(context).pushReplacementNamed(widget.nextRoute!);
    }
  }

  void _goBack() {
    if (_currentPage == 0) return;
    _controller.previousPage(
      duration: const Duration(milliseconds: 320),
      curve: Curves.easeOut,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kSurface,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: const [
                  _SlideOne(),
                  _SlideTwo(),
                  _SlideThree(),
                ],
              ),
            ),
            _BottomNav(
              currentPage: _currentPage,
              pageCount: _pageCount,
              onBack: _currentPage > 0 ? _goBack : null,
              onNext: _goNext,
            ),
            const SizedBox(height: 24),
          ],
        ),
      ),
    );
  }
}

class _SlideOne extends StatelessWidget {
  const _SlideOne();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 40),
          const Text(
            'Instant Transactions\nWith Digital Card',
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Image.asset(
                    'lib/assets/Credit Card.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const _RecentTransactionsCard(),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Make fast, secure payments with your\ndigital card, available instantly.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                color: _kInkSecondary,
                height: 1.5,
              ),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SlideTwo extends StatelessWidget {
  const _SlideTwo();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Credit & Loans Made\nEasy For All',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Image.asset(
                    'lib/assets/MockUp.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _CreditScoreCard(score: 780, maxScore: 850),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Get quick access to tailored credit and\nloan solutions designed to fit your need.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: _kInkSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _CreditScoreCard extends StatelessWidget {
  const _CreditScoreCard({required this.score, required this.maxScore});

  final int score;
  final int maxScore;

  @override
  Widget build(BuildContext context) {
    final progress = (score / maxScore).clamp(0.0, 1.0);
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 18, 20, 14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          AspectRatio(
            aspectRatio: 2,
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                CustomPaint(
                  size: Size.infinite,
                  painter: _GaugePainter(progress: progress),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 6),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Text(
                            'Doing Great',
                            style: TextStyle(
                              fontSize: 13,
                              fontWeight: FontWeight.w600,
                              color: _kInkPrimary,
                            ),
                          ),
                          const SizedBox(width: 6),
                          Container(
                            width: 16,
                            height: 16,
                            decoration: const BoxDecoration(
                              color: Color(0xFFDBEAFE),
                              shape: BoxShape.circle,
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.info_outline,
                                size: 11,
                                color: _kBrandBlue,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        '$score',
                        style: const TextStyle(
                          fontSize: 40,
                          fontWeight: FontWeight.w700,
                          color: _kInkPrimary,
                          height: 1,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 6),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                '0',
                style: TextStyle(fontSize: 12, color: _kInkMuted),
              ),
              const Text(
                'Next update: 3d',
                style: TextStyle(fontSize: 12, color: _kInkMuted),
              ),
              Text(
                '$maxScore',
                style: const TextStyle(fontSize: 12, color: _kInkMuted),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _GaugePainter extends CustomPainter {
  _GaugePainter({required this.progress});

  final double progress;

  static const _trackColor = Color(0xFFE5E7EB);
  static const _fillColor = Color(0xFF15803D);
  static const _strokeWidth = 14.0;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height);
    final radius = math.min(
      (size.width - _strokeWidth) / 2,
      size.height - _strokeWidth / 2,
    );
    final rect = Rect.fromCircle(center: center, radius: radius);

    final track = Paint()
      ..color = _trackColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, math.pi, math.pi, false, track);

    final fill = Paint()
      ..color = _fillColor
      ..style = PaintingStyle.stroke
      ..strokeWidth = _strokeWidth
      ..strokeCap = StrokeCap.round;
    canvas.drawArc(rect, math.pi, math.pi * progress, false, fill);

    final tipAngle = math.pi + math.pi * progress;
    final tip = Offset(
      center.dx + radius * math.cos(tipAngle),
      center.dy + radius * math.sin(tipAngle),
    );
    final dot = Paint()
      ..color = _fillColor
      ..style = PaintingStyle.fill;
    canvas.drawCircle(tip, 9, dot);
  }

  @override
  bool shouldRepaint(covariant _GaugePainter old) => old.progress != progress;
}

class _SlideThree extends StatelessWidget {
  const _SlideThree();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        children: [
          const SizedBox(height: 40),
          const Text(
            'Your Money is Always\nProtected, Period.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 28,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 48),
          Expanded(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 12),
                  child: Image.asset(
                    'lib/assets/MockUp.png',
                    fit: BoxFit.contain,
                  ),
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: _SecurityCard(),
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            'Rest easy knowing your funds are\nsecure with our advanced encryption.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 14,
              color: _kInkSecondary,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }
}

class _SecurityCard extends StatelessWidget {
  const _SecurityCard();

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 24),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withValues(alpha: 0.06),
                  blurRadius: 24,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: const [
                SizedBox(height: 16),
                _SecurityRow(
                  icon: Icons.vpn_key_outlined,
                  label: '2-Step Verification',
                  enabled: false,
                ),
                Divider(height: 1, color: Color(0xFFE5E7EB)),
                _SecurityRow(
                  icon: Icons.face_outlined,
                  label: 'Face ID Security',
                  enabled: true,
                ),
                Divider(height: 1, color: Color(0xFFE5E7EB)),
                _SecurityRow(
                  icon: Icons.password_outlined,
                  label: '256bit Encryptions',
                  enabled: false,
                ),
              ],
            ),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          top: 0,
          child: Center(
            child: Container(
              width: 48,
              height: 48,
              decoration: const BoxDecoration(
                color: _kBrandBlue,
                shape: BoxShape.circle,
              ),
              child: const Icon(
                Icons.lock_outline,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _SecurityRow extends StatelessWidget {
  const _SecurityRow({
    required this.icon,
    required this.label,
    required this.enabled,
  });

  final IconData icon;
  final String label;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          Icon(icon, size: 22, color: _kBrandBlue),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: _kInkPrimary,
              ),
            ),
          ),
          _Toggle(value: enabled),
        ],
      ),
    );
  }
}

class _Toggle extends StatelessWidget {
  const _Toggle({required this.value});

  final bool value;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      width: 42,
      height: 24,
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        color: value ? _kBrandBlue : const Color(0xFFD1D5DB),
        borderRadius: BorderRadius.circular(20),
      ),
      child: AnimatedAlign(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        alignment: value ? Alignment.centerRight : Alignment.centerLeft,
        child: Container(
          width: 20,
          height: 20,
          decoration: const BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Color(0x1A000000),
                blurRadius: 2,
                offset: Offset(0, 1),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _RecentTransactionsCard extends StatelessWidget {
  const _RecentTransactionsCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 24,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                'Recent Transactions',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 14,
                  color: _kInkPrimary,
                ),
              ),
              _DateChip(label: 'Dec 2026'),
            ],
          ),
          const SizedBox(height: 14),
          const _TransactionRow(
            cardColor: _kBrandBlue,
            chipColor: Color(0xFFEF4444),
            vendor: 'swiftbank  ••8871',
            cardType: 'Platinum Phsical Card',
            amount: 'FCFA 2,115.00',
          ),
          const Divider(height: 20, color: Color(0xFFE5E7EB)),
          const _TransactionRow(
            cardColor: _kGoldCard,
            chipColor: Color(0xFFEF4444),
            vendor: 'swiftbank  ••8871',
            cardType: 'Gold Virtual Card',
            amount: 'FCFA 148.25',
          ),
          const Divider(height: 20, color: Color(0xFFE5E7EB)),
          TextButton(
            onPressed: () {},
            style: TextButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 4),
              minimumSize: const Size(0, 32),
              tapTargetSize: MaterialTapTargetSize.shrinkWrap,
            ),
            child: const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'View All Transactions',
                  style: TextStyle(
                    color: _kBrandBlue,
                    fontWeight: FontWeight.w600,
                    fontSize: 14,
                  ),
                ),
                SizedBox(width: 6),
                Icon(Icons.arrow_forward, size: 16, color: _kBrandBlue),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _DateChip extends StatelessWidget {
  const _DateChip({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const Icon(Icons.calendar_today_outlined, size: 14, color: _kBrandBlue),
        const SizedBox(width: 6),
        Text(
          label,
          style: const TextStyle(
            fontWeight: FontWeight.w500,
            fontSize: 13,
            color: _kInkPrimary,
          ),
        ),
        const Icon(Icons.keyboard_arrow_down, size: 18, color: _kInkPrimary),
      ],
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({
    required this.cardColor,
    required this.chipColor,
    required this.vendor,
    required this.cardType,
    required this.amount,
  });

  final Color cardColor;
  final Color chipColor;
  final String vendor;
  final String cardType;
  final String amount;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _MiniCard(color: cardColor, chipColor: chipColor),
        const SizedBox(width: 12),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                vendor,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 13,
                  color: _kInkPrimary,
                ),
              ),
              const SizedBox(height: 2),
              Text(
                cardType,
                style: const TextStyle(
                  fontSize: 12,
                  color: _kInkMuted,
                ),
              ),
            ],
          ),
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            Text(
              amount,
              style: const TextStyle(
                fontWeight: FontWeight.w700,
                fontSize: 13,
                color: _kInkPrimary,
              ),
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(Icons.check_circle, size: 14, color: _kSuccess),
                SizedBox(width: 4),
                Text(
                  'Done',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: _kSuccess,
                  ),
                ),
              ],
            ),
          ],
        ),
      ],
    );
  }
}

class _MiniCard extends StatelessWidget {
  const _MiniCard({required this.color, required this.chipColor});

  final Color color;
  final Color chipColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 32,
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(6),
      ),
      child: Padding(
        padding: const EdgeInsets.all(5),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: 10,
              height: 8,
              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.85),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(width: 4),
            Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: chipColor,
                shape: BoxShape.circle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({
    required this.currentPage,
    required this.pageCount,
    required this.onBack,
    required this.onNext,
  });

  final int currentPage;
  final int pageCount;
  final VoidCallback? onBack;
  final VoidCallback onNext;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      child: Row(
        children: [
          _ArrowButton(icon: Icons.arrow_back, onPressed: onBack),
          Expanded(
            child: Center(
              child: _PageDots(count: pageCount, current: currentPage),
            ),
          ),
          _ArrowButton(icon: Icons.arrow_forward, onPressed: onNext),
        ],
      ),
    );
  }
}

class _ArrowButton extends StatelessWidget {
  const _ArrowButton({required this.icon, required this.onPressed});

  final IconData icon;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    final disabled = onPressed == null;
    final color = disabled
        ? _kBrandBlue.withValues(alpha: 0.35)
        : _kBrandBlue;
    return SizedBox(
      width: 76,
      height: 48,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          shape: const StadiumBorder(),
          side: BorderSide(color: color, width: 1.4),
          padding: EdgeInsets.zero,
        ),
        child: Icon(icon, size: 20, color: color),
      ),
    );
  }
}

class _PageDots extends StatelessWidget {
  const _PageDots({required this.count, required this.current});

  final int count;
  final int current;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(count, (i) {
        final active = i == current;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOut,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 10 : 6,
          height: active ? 10 : 6,
          decoration: BoxDecoration(
            color: active ? _kBrandBlue : const Color(0xFFBFD3E5),
            shape: BoxShape.circle,
          ),
        );
      }),
    );
  }
}
