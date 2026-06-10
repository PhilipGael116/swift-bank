import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';

import 'quiz_screen.dart';

const _kBrandBlue = Color(0xFF0369A1);
const _kInkPrimary = Color(0xFF111827);
const _kInkMuted = Color(0xFF9CA3AF);
const _kFieldBorder = Color(0xFFE5E7EB);
const _kChipBg = Color(0xFFF3F4F6);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, this.userName = 'Victor Jimoh'});

  final String userName;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _currentTab = 0;
  bool _balanceHidden = false;

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
        body: _currentTab == 4
            ? const QuizScreen()
            : Container(
                color: _kBrandBlue,
                child: Stack(
                  children: [
                    Positioned(
                      top: -220,
                      left: 0,
                      right: 0,
                      child: IgnorePointer(
                        child: SvgPicture.asset(
                          'lib/assets/Frame.svg',
                          fit: BoxFit.fitWidth,
                          colorFilter: ColorFilter.mode(
                            Colors.white.withValues(alpha: 0.5),
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                    ),
                    SafeArea(
                      bottom: false,
                      child: Column(
                        children: [
                          _Header(
                            userName: widget.userName,
                            balanceHidden: _balanceHidden,
                            onToggleBalance: () =>
                                setState(() => _balanceHidden = !_balanceHidden),
                          ),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.symmetric(horizontal: 16),
                              decoration: const BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.vertical(
                                  top: Radius.circular(24),
                                ),
                              ),
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: const [
                                    SizedBox(height: 24),
                                    _QuickActionsRow(),
                                    SizedBox(height: 24),
                                    Divider(
                                      height: 1,
                                      color: _kFieldBorder,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    SizedBox(height: 20),
                                    _GetStartedSection(),
                                    SizedBox(height: 12),
                                    Divider(
                                      height: 1,
                                      color: _kFieldBorder,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    SizedBox(height: 20),
                                    _QuickAccessSection(),
                                    SizedBox(height: 20),
                                    Divider(
                                      height: 1,
                                      color: _kFieldBorder,
                                      indent: 20,
                                      endIndent: 20,
                                    ),
                                    SizedBox(height: 16),
                                    _TodaySection(),
                                    SizedBox(height: 24),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
        bottomNavigationBar: _BottomNav(
          current: _currentTab,
          onTap: (i) => setState(() => _currentTab = i),
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({
    required this.userName,
    required this.balanceHidden,
    required this.onToggleBalance,
  });

  final String userName;
  final bool balanceHidden;
  final VoidCallback onToggleBalance;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 30, 20, 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.person_outline,
                  color: Colors.white,
                  size: 22,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Hi, $userName 👋🏻',
                      style: const TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w700,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'Welcome, lets start making payments',
                      style: TextStyle(
                        fontSize: 9,
                        color: Colors.white.withValues(alpha: 0.7),
                      ),
                    ),
                  ],
                ),
              ),
              IconButton(
                icon: Icon(
                  balanceHidden
                      ? Icons.visibility_off_outlined
                      : Icons.visibility_outlined,
                  color: Colors.white,
                  size: 23,
                ),
                onPressed: onToggleBalance,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              ),
              IconButton(
                icon: const Icon(
                  Icons.logout_outlined,
                  color: Colors.white,
                  size: 23,
                ),
                onPressed: () {},
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
                constraints: const BoxConstraints(minWidth: 28, minHeight: 28),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Text(
            'Total Balance',
            style: TextStyle(
              fontSize: 13,
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
          const SizedBox(height: 4),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Text(
                  balanceHidden ? 'FCFA ••••••••' : 'FCFA 20,000,00.00',
                  style: const TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ),
              Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Icons.more_horiz,
                  color: Colors.white,
                  size: 20,
                ),
              ),
            ],
          ),
          const SizedBox(height: 6),
          Text(
            'Last updated 2 mins ago.',
            style: TextStyle(
              fontSize: 12,
              color: Colors.white.withValues(alpha: 0.65),
            ),
          ),
        ],
      ),
    );
  }
}

class _QuickActionsRow extends StatelessWidget {
  const _QuickActionsRow();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          _ActionTile(
            icon: Icons.add,
            label: 'Add money',
            onTap: () => Navigator.of(context).pushNamed('/add-money'),
          ),
          _ActionTile(
            icon: Icons.credit_card_outlined,
            label: 'My cards',
            onTap: () => Navigator.of(context).pushNamed('/topup-card'),
          ),
          _ActionTile(
            icon: Icons.send_outlined,
            label: 'Send money',
            onTap: () =>
                Navigator.of(context).pushNamed('/send-bank-account'),
          ),
        ],
      ),
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({required this.icon, required this.label, this.onTap});

  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 56,
            height: 56,
            decoration: const BoxDecoration(
              color: _kChipBg,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 22, color: _kInkPrimary),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _kInkPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _GetStartedSection extends StatelessWidget {
  const _GetStartedSection();

  @override
  Widget build(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Get started',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
            ),
          ),
          SizedBox(height: 8),
          _GetStartedItem(
            title: 'Add Money',
            subtitle: 'Get more from your account',
          ),
          _GetStartedItem(
            title: 'Create a debit card',
            subtitle: 'Get more from your account',
          ),
          _GetStartedItem(
            title: 'Earn FCFA 2,000 for inviting friends to Sw...',
            subtitle: 'Get more from your account',
          ),
        ],
      ),
    );
  }
}

class _GetStartedItem extends StatelessWidget {
  const _GetStartedItem({required this.title, required this.subtitle});

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/Frame 427319589.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
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
          const Icon(Icons.chevron_right, color: _kInkMuted, size: 22),
        ],
      ),
    );
  }
}

class _QuickAccessSection extends StatelessWidget {
  const _QuickAccessSection();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            'Quick access',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
            ),
          ),
        ),
        const SizedBox(height: 12),
        SizedBox(
          height: 44,
          child: ListView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            children: const [
              _Chip(icon: Icons.phone_outlined, label: 'Airtime'),
              SizedBox(width: 8),
              _Chip(icon: Icons.sports_soccer, label: 'Betting'),
              SizedBox(width: 8),
              _Chip(icon: Icons.swap_vert, label: 'Data Bundle'),
              SizedBox(width: 8),
              _Chip(icon: Icons.receipt_long_outlined, label: 'Bills'),
              SizedBox(width: 8),
              _Chip(icon: Icons.account_balance_outlined, label: 'Loans'),
              SizedBox(width: 8),
              _Chip(icon: Icons.bolt_outlined, label: 'Top Up'),
            ],
          ),
        ),
      ],
    );
  }
}

class _Chip extends StatelessWidget {
  const _Chip({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: _kChipBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 16, color: _kInkPrimary),
          const SizedBox(width: 6),
          Text(
            label,
            style: const TextStyle(
              fontSize: 13,
              fontWeight: FontWeight.w500,
              color: _kInkPrimary,
            ),
          ),
        ],
      ),
    );
  }
}

class _Transaction {
  const _Transaction({
    required this.name,
    required this.time,
    required this.amount,
  });

  final String name;
  final String time;
  final double amount;
}

class _TodaySection extends StatelessWidget {
  const _TodaySection();

  static const _transactions = [
    _Transaction(name: 'Ngozi Uche', time: '12:35 PM', amount: -2500),
    _Transaction(name: 'Oluwaseun Adeyemi', time: '11:37 AM', amount: -78643),
    _Transaction(name: 'Ahmed Ibrahim', time: '11:22 AM', amount: -20430),
    _Transaction(
      name: 'Glo Ng vTU 2348085472417',
      time: '10:54 AM',
      amount: -2000,
    ),
    _Transaction(name: 'Umaru Abubakar', time: '9:23 AM', amount: 2000),
  ];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'TODAY',
            style: TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w700,
              color: _kInkPrimary,
              letterSpacing: 0.5,
            ),
          ),
          const SizedBox(height: 4),
          for (int i = 0; i < _transactions.length; i++) ...[
            _TransactionRow(transaction: _transactions[i]),
            if (i < _transactions.length - 1)
              const Divider(height: 1, color: _kFieldBorder),
          ],
        ],
      ),
    );
  }
}

class _TransactionRow extends StatelessWidget {
  const _TransactionRow({required this.transaction});

  final _Transaction transaction;

  @override
  Widget build(BuildContext context) {
    final isInflow = transaction.amount >= 0;
    final amountText =
        '${isInflow ? '+' : '-'} FCFA ${_formatAmount(transaction.amount.abs())}';
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        children: [
          ClipOval(
            child: Image.asset(
              'lib/assets/Frame 427319569.png',
              width: 40,
              height: 40,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  transaction.name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: _kInkPrimary,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  transaction.time,
                  style: const TextStyle(fontSize: 12, color: _kInkMuted),
                ),
              ],
            ),
          ),
          Text(
            amountText,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: _kInkPrimary,
            ),
          ),
        ],
      ),
    );
  }

  static String _formatAmount(double amount) {
    final whole = amount.toStringAsFixed(2);
    final parts = whole.split('.');
    final intWithCommas = parts[0].replaceAllMapped(
      RegExp(r'(\d)(?=(\d{3})+(?!\d))'),
      (m) => '${m[1]},',
    );
    return '$intWithCommas.${parts[1]}';
  }
}

class _BottomNav extends StatelessWidget {
  const _BottomNav({required this.current, required this.onTap});

  final int current;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: current,
      onTap: onTap,
      type: BottomNavigationBarType.fixed,
      backgroundColor: Colors.white,
      selectedItemColor: _kBrandBlue,
      unselectedItemColor: _kInkMuted,
      selectedFontSize: 11,
      unselectedFontSize: 11,
      items: const [
        BottomNavigationBarItem(
          icon: _TabIcon(icon: Icons.home_outlined, active: false),
          activeIcon: _TabIcon(icon: Icons.home, active: true),
          label: 'Home',
        ),
        BottomNavigationBarItem(
          icon: _TabIcon(icon: Icons.send_outlined, active: false),
          activeIcon: _TabIcon(icon: Icons.send, active: true),
          label: 'Send',
        ),
        BottomNavigationBarItem(
          icon: _TabIcon(icon: Icons.bar_chart_outlined, active: false),
          activeIcon: _TabIcon(icon: Icons.bar_chart, active: true),
          label: 'Invest',
        ),
        BottomNavigationBarItem(
          icon: _TabIcon(icon: Icons.credit_card_outlined, active: false),
          activeIcon: _TabIcon(icon: Icons.credit_card, active: true),
          label: 'Cards',
        ),
        BottomNavigationBarItem(
          icon: _TabIcon(icon: Icons.quiz_outlined, active: false),
          activeIcon: _TabIcon(icon: Icons.quiz, active: true),
          label: 'Quiz',
        ),
      ],
    );
  }
}

class _TabIcon extends StatelessWidget {
  const _TabIcon({required this.icon, required this.active});

  final IconData icon;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Container(
          width: 22,
          height: 3,
          decoration: BoxDecoration(
            color: active ? _kBrandBlue : Colors.transparent,
            borderRadius: BorderRadius.circular(2),
          ),
        ),
        const SizedBox(height: 6),
        Icon(icon, size: 22),
      ],
    );
  }
}
