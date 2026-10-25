import 'package:flutter/material.dart';

import 'accounts_screen.dart';
import 'activity_screen.dart';
import 'family_screen.dart';
import 'home_screen.dart';
import 'plan_screen.dart';
import 'theme.dart';

class AppShell extends StatefulWidget {
  const AppShell({super.key});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  int _tab = 0;

  static const _tabs = [
    (Icons.home_rounded, 'Home'),
    (Icons.format_list_bulleted_rounded, 'Activity'),
    (Icons.account_balance_wallet_rounded, 'Accounts'),
    (Icons.people_alt_rounded, 'Family'),
    (Icons.shield_rounded, 'Plan'),
  ];

  void _go(int i) => setState(() => _tab = i);

  @override
  Widget build(BuildContext context) {
    final screens = [
      HomeScreen(onNavigate: _go),
      const ActivityScreen(),
      const AccountsScreen(),
      const FamilyScreen(),
      const PlanScreen(),
    ];
    return Scaffold(
      extendBody: true,
      body: IndexedStack(index: _tab, children: screens),
      bottomNavigationBar: SafeArea(
        minimum: const EdgeInsets.fromLTRB(16, 0, 16, 16),
        child: Container(
          height: 68,
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: AppColors.ink,
            borderRadius: BorderRadius.circular(24),
            boxShadow: const [BoxShadow(color: Color(0x330F1E18), blurRadius: 24, offset: Offset(0, 8))],
          ),
          child: Row(
            children: [
              for (var i = 0; i < _tabs.length; i++)
                Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Semantics(
                      selected: i == _tab,
                      button: true,
                      label: _tabs[i].$2,
                      excludeSemantics: true,
                      child: Material(
                        color: i == _tab ? AppColors.mint : Colors.transparent,
                        borderRadius: BorderRadius.circular(16),
                        child: InkWell(
                          borderRadius: BorderRadius.circular(16),
                          onTap: () => _go(i),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(_tabs[i].$1, size: 20, color: i == _tab ? AppColors.forest : AppColors.navInactive),
                              const SizedBox(height: 3),
                              Text(
                                _tabs[i].$2,
                                maxLines: 1,
                                style: TextStyle(
                                  fontSize: 11,
                                  fontWeight: i == _tab ? FontWeight.w800 : FontWeight.w600,
                                  color: i == _tab ? AppColors.forest : AppColors.navInactive,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

/// Bottom padding so content clears the floating tab bar.
const navClearance = 110.0;
