import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import 'package:banking_app/screens/splash_screen.dart';

void main() {
  testWidgets('SplashScreen renders without crashing', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: SplashScreen(nextRoute: '/onboarding')),
    );

    expect(find.byType(SplashScreen), findsOneWidget);
  });
}
