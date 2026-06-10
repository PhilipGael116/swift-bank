import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key, required this.nextRoute});

  final String nextRoute;

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 3), () {
      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(widget.nextRoute);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF0369A1),
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: SvgPicture.asset(
                'lib/assets/swift-logo-loading.svg',
                width: 96,
                height: 96,
              ),
            ),
            const Positioned(
              left: 0,
              right: 0,
              bottom: 64,
              child: Center(
                child: CupertinoActivityIndicator(
                  color: CupertinoColors.white,
                  radius: 14,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
