import 'package:flutter/material.dart';

import '../data/database.dart';
import 'theme.dart';

/// Icon and soft tint for a category's iconKey.
class CategoryVisual {
  const CategoryVisual(this.icon, this.background, this.foreground, this.chart);

  final IconData icon;
  final Color background;
  final Color foreground;

  /// Stronger colour used for chart segments.
  final Color chart;

  static CategoryVisual of(String? key) => switch (key) {
        'food' => const CategoryVisual(Icons.restaurant_rounded, Color(0xFFFDF0D3), Color(0xFF7A5200), Color(0xFFF2B33D)),
        'transport' => const CategoryVisual(Icons.directions_car_rounded, Color(0xFFEEE9FE), Color(0xFF4B2FC2), Color(0xFF7A5AF8)),
        'utilities' => const CategoryVisual(Icons.bolt_rounded, Color(0xFFDDF3EB), Color(0xFF0B6B4C), Color(0xFF19A07B)),
        'housing' => const CategoryVisual(Icons.home_rounded, Color(0xFFF1E7DA), Color(0xFF6B4423), Color(0xFFB07A48)),
        'school' => const CategoryVisual(Icons.school_rounded, Color(0xFFE6ECFD), Color(0xFF1F3B8C), Color(0xFF3F6FE0)),
        'health' => const CategoryVisual(Icons.favorite_rounded, Color(0xFFFBE3E0), Color(0xFF9A2A17), Color(0xFFE2674A)),
        'shopping' => const CategoryVisual(Icons.shopping_bag_rounded, Color(0xFFFBE3EF), Color(0xFF8A1F5B), Color(0xFFE85D9B)),
        'gift' => const CategoryVisual(Icons.card_giftcard_rounded, Color(0xFFFBE3EF), Color(0xFF8A1F5B), Color(0xFFD94C8A)),
        'insurance' => const CategoryVisual(Icons.shield_rounded, Color(0xFFDDF3EB), Color(0xFF0B3B2E), Color(0xFF0B6B4C)),
        'fees' => const CategoryVisual(Icons.receipt_long_rounded, Color(0xFFECEFEA), Color(0xFF3B4A43), Color(0xFF9AA8A0)),
        'salary' => const CategoryVisual(Icons.south_rounded, Color(0xFFCDEBD9), Color(0xFF0B3B2E), Color(0xFF0B6B4C)),
        'business' => const CategoryVisual(Icons.work_rounded, Color(0xFFE6ECFD), Color(0xFF1F3B8C), Color(0xFF3F6FE0)),
        'transfer' => const CategoryVisual(Icons.swap_horiz_rounded, Color(0xFFECEFEA), Color(0xFF3B4A43), Color(0xFF9AA8A0)),
        _ => const CategoryVisual(Icons.more_horiz_rounded, Color(0xFFECEFEA), Color(0xFF3B4A43), Color(0xFFC9D1CB)),
      };
}

/// Card colours per provider, from the mockup; unknown providers fall back
/// to a colour for the account type.
class AccountVisual {
  const AccountVisual(this.background, this.foreground, this.subtle, this.monogram);

  final Color background;
  final Color foreground;
  final Color subtle;
  final String monogram;

  static AccountVisual of(Account a) {
    switch (a.providerId) {
      case 'mtn_momo':
        return const AccountVisual(Color(0xFFFFCB05), Color(0xFF1E1A00), Color(0xFF3D3400), 'MTN');
      case 'telecel_cash':
        return const AccountVisual(Color(0xFFC8102E), Colors.white, Color(0xFFFFE3E7), 'TEL');
      case 'at_money':
        return const AccountVisual(Color(0xFF1D4FA8), Colors.white, Color(0xFFDCE4FB), 'AT');
      case 'wise':
        return const AccountVisual(Color(0xFFC5F07A), Color(0xFF16300A), Color(0xFF2F4F1A), 'W');
      case 'paypal':
        return const AccountVisual(Color(0xFF1B3A8C), Colors.white, Color(0xFFDCE4FB), 'PP');
    }
    final initials = a.name.trim().isEmpty ? '?' : a.name.trim().split(RegExp(r'\s+')).take(2).map((w) => w[0].toUpperCase()).join();
    return switch (a.type) {
      'bank' => AccountVisual(AppColors.ink, Colors.white, AppColors.mintText, initials),
      'card' => AccountVisual(const Color(0xFF2C4FB8), Colors.white, const Color(0xFFDCE4FB), initials),
      'momo' => AccountVisual(const Color(0xFFFFE17A), const Color(0xFF3D3000), const Color(0xFF5A4A00), initials),
      'online_wallet' => AccountVisual(const Color(0xFFC5F07A), const Color(0xFF16300A), const Color(0xFF2F4F1A), initials),
      'savings' => AccountVisual(AppColors.forest, Colors.white, AppColors.mintText, initials),
      _ => AccountVisual(Colors.white, AppColors.ink, AppColors.muted, initials),
    };
  }
}

const accountTypeLabels = {
  'momo': 'Mobile money',
  'bank': 'Bank account',
  'card': 'Card',
  'cash': 'Cash',
  'savings': 'Savings',
  'online_wallet': 'Online wallet',
};
