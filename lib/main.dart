import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'firebase_options.dart';
import 'screens/account_success_screen.dart';
import 'screens/add_money_screen.dart';
import 'screens/forgot_password_screen.dart';
import 'screens/home_screen.dart';
import 'screens/onboarding_screen.dart';
import 'screens/password_reset_sent_screen.dart';
import 'screens/quiz_screen.dart';
import 'screens/signin_screen.dart';
import 'screens/signup_screen.dart';
import 'screens/send_bank_account_screen.dart';
import 'screens/splash_screen.dart';
import 'screens/topup_card_confirm_screen.dart';
import 'screens/topup_card_screen.dart';
import 'screens/transfer_complete_screen.dart';
import 'screens/transfer_success_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const BankingApp());
}

class BankingApp extends StatelessWidget {
  const BankingApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Swift',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: const Color(0xFFF3F4F6),
        primaryColor: const Color(0xFF0369A1),
        textTheme: GoogleFonts.poppinsTextTheme(),
        useMaterial3: true,
      ),
      initialRoute: '/',
      routes: <String, WidgetBuilder>{
        '/': (_) => const _AuthGate(),
        '/onboarding': (_) => const OnboardingScreen(nextRoute: '/signin'),
        '/signin': (_) => const SignInScreen(),
        '/signup': (_) => const SignUpScreen(),
        '/forgot-password': (_) => const ForgotPasswordScreen(),
        '/password-reset-sent': (_) => const PasswordResetSentScreen(),
        '/account-success': (_) => const AccountSuccessScreen(),
        '/home': (_) => const HomeScreen(),
        '/add-money': (_) => const AddMoneyScreen(),
        '/send-bank-account': (_) => const SendBankAccountScreen(),
        '/topup-card': (_) => const TopUpCardScreen(),
        '/quiz': (_) => const QuizScreen(),
        '/topup-card-confirm': (_) => const TopUpCardConfirmScreen(),
        '/transfer-success': (_) => const TransferSuccessScreen(),
        '/transfer-complete': (_) => const TransferCompleteScreen(),
      },
    );
  }
}

/// Decides where to send the user once the splash animation finishes:
/// straight to `/home` if already signed in, otherwise the onboarding flow.
class _AuthGate extends StatelessWidget {
  const _AuthGate();

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        final nextRoute = snapshot.data != null ? '/home' : '/onboarding';
        return SplashScreen(nextRoute: nextRoute);
      },
    );
  }
}
