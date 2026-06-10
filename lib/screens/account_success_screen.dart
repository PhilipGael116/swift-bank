import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

const _kBrandBlue = Color(0xFF0369A1);

class AccountSuccessScreen extends StatelessWidget {
  const AccountSuccessScreen({super.key, this.name = 'John'});

  final String name;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _kBrandBlue,
      body: Stack(
        children: [
          Positioned.fill(
            child: IgnorePointer(
              child: CustomPaint(painter: _ConfettiPainter()),
            ),
          ),
          SafeArea(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SvgPicture.asset(
                      'lib/assets/swift-logo-loading.svg',
                      width: 72,
                      height: 72,
                    ),
                    const SizedBox(height: 40),
                    Text(
                      'You have successfully opened\nyour account, $name!',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                        color: Colors.white,
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _SeeDashboardButton(
                      onPressed: () {
                        Navigator.of(context).pushNamedAndRemoveUntil(
                          '/home',
                          (route) => false,
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SeeDashboardButton extends StatelessWidget {
  const _SeeDashboardButton({required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: const Icon(
        Icons.thumb_up_alt_outlined,
        size: 18,
        color: Colors.white,
      ),
      label: const Text(
        'See Dashboard',
        style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontWeight: FontWeight.w600,
        ),
      ),
      style: OutlinedButton.styleFrom(
        shape: const StadiumBorder(),
        side: const BorderSide(color: Colors.white, width: 1.4),
        padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 14),
      ),
    );
  }
}

class _ConfettiPainter extends CustomPainter {
  static const _colors = [
    Color(0xFFF97316),
    Color(0xFFFACC15),
    Color(0xFF60A5FA),
    Color(0xFFFFFFFF),
  ];

  @override
  void paint(Canvas canvas, Size size) {
    final rand = Random(7);
    for (int i = 0; i < 70; i++) {
      final start = Offset(
        rand.nextDouble() * size.width,
        rand.nextDouble() * size.height,
      );
      final color = _colors[rand.nextInt(_colors.length)]
          .withValues(alpha: 0.85);
      _drawStreamer(canvas, start, color, rand);
    }
  }

  void _drawStreamer(Canvas canvas, Offset start, Color color, Random rand) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3
      ..strokeCap = StrokeCap.round;

    final length = 28 + rand.nextDouble() * 36;
    final angle = rand.nextDouble() * pi * 2;
    final end = Offset(
      start.dx + cos(angle) * length,
      start.dy + sin(angle) * length,
    );

    final perp = angle + pi / 2;
    final amp = 12 + rand.nextDouble() * 14;
    final cp1 = Offset(
      start.dx + cos(angle) * length * 0.3 + cos(perp) * amp,
      start.dy + sin(angle) * length * 0.3 + sin(perp) * amp,
    );
    final cp2 = Offset(
      start.dx + cos(angle) * length * 0.7 - cos(perp) * amp,
      start.dy + sin(angle) * length * 0.7 - sin(perp) * amp,
    );

    final path = Path()
      ..moveTo(start.dx, start.dy)
      ..cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, end.dx, end.dy);

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
