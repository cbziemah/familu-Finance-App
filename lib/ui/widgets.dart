import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../core/money.dart';
import '../data/database.dart';
import 'theme.dart';
import 'visuals.dart';

final _plain = NumberFormat('#,##0.00', 'en_US');
final _whole = NumberFormat('#,##0', 'en_US');

/// 125030 -> "1,250.30"
String amountText(int minor, {bool whole = false}) =>
    (whole ? _whole : _plain).format(minor.abs() / 100);

String signedAmount(int minor, {required bool incoming}) => '${incoming ? '+' : '−'}${amountText(minor)}';

/// The thin kente-inspired stripe across the top of green headers.
class KenteStrip extends StatelessWidget {
  const KenteStrip({super.key});

  static const _pattern = [
    (3, AppColors.gold),
    (1, AppColors.ink),
    (2, AppColors.clay),
    (1, AppColors.gold),
    (4, AppColors.kenteGreen),
    (1, AppColors.ink),
    (2, AppColors.gold),
    (1, AppColors.clay),
    (3, AppColors.kenteGreen),
  ];

  @override
  Widget build(BuildContext context) => SizedBox(
        height: 6,
        child: Row(children: [for (final (flex, color) in _pattern) Expanded(flex: flex, child: ColoredBox(color: color))]),
      );
}

class SectionCard extends StatelessWidget {
  const SectionCard({super.key, required this.child, this.padding = const EdgeInsets.all(16), this.color = AppColors.card});

  final Widget child;
  final EdgeInsets padding;
  final Color color;

  @override
  Widget build(BuildContext context) => Container(
        padding: padding,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(24),
          boxShadow: const [BoxShadow(color: Color(0x0D0F1E18), blurRadius: 2, offset: Offset(0, 1))],
        ),
        child: child,
      );
}

class SectionTitle extends StatelessWidget {
  const SectionTitle(this.text, {super.key, this.trailing});

  final String text;
  final Widget? trailing;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: Text(text, style: AppFonts.display(size: 18, weight: FontWeight.w700, color: AppColors.ink))),
          ?trailing,
        ],
      );
}

class ScreenTitle extends StatelessWidget {
  const ScreenTitle(this.text, {super.key, this.action});

  final String text;
  final Widget? action;

  @override
  Widget build(BuildContext context) => Row(
        children: [
          Expanded(child: Text(text, style: AppFonts.display(size: 30, color: AppColors.ink))),
          ?action,
        ],
      );
}

class CategoryIcon extends StatelessWidget {
  const CategoryIcon(this.iconKey, {super.key, this.size = 42});

  final String? iconKey;
  final double size;

  @override
  Widget build(BuildContext context) {
    final v = CategoryVisual.of(iconKey);
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: v.background, borderRadius: BorderRadius.circular(size / 3)),
      child: Icon(v.icon, color: v.foreground, size: size * 0.5),
    );
  }
}

class AccountMonogram extends StatelessWidget {
  const AccountMonogram(this.account, {super.key, this.size = 40});

  final Account account;
  final double size;

  @override
  Widget build(BuildContext context) {
    final v = AccountVisual.of(account);
    return Container(
      width: size,
      height: size,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: v.background,
        borderRadius: BorderRadius.circular(size / 3),
        border: v.background == Colors.white ? Border.all(color: AppColors.chip) : null,
      ),
      child: account.type == 'cash'
          ? Icon(Icons.payments_rounded, size: size * 0.5, color: AppColors.ink)
          : Text(v.monogram, style: TextStyle(fontSize: size * 0.28, fontWeight: FontWeight.w800, color: v.foreground)),
    );
  }
}

/// Small rounded label such as "CONFIRM" or "KOFI".
class Tag extends StatelessWidget {
  const Tag(this.text, {super.key, this.background = AppColors.goldSoft, this.foreground = AppColors.goldText});

  final String text;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(8)),
        child: Text(text, style: TextStyle(fontSize: 11, fontWeight: FontWeight.w800, color: foreground)),
      );
}

/// Segmented control matching the mockup (white pill on a grey track).
class Segmented<T> extends StatelessWidget {
  const Segmented({super.key, required this.options, required this.selected, required this.onChanged, this.dark = false});

  final List<(T, String)> options;
  final T selected;
  final ValueChanged<T> onChanged;

  /// On the green header: mint pill on a dark green track.
  final bool dark;

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(4),
        decoration: BoxDecoration(color: dark ? AppColors.forestTile : AppColors.chip, borderRadius: BorderRadius.circular(14)),
        child: Row(
          children: [
            for (final (value, label) in options)
              Expanded(
                child: Semantics(
                  selected: value == selected,
                  button: true,
                  child: GestureDetector(
                    onTap: () => onChanged(value),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 180),
                      height: 38,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: value == selected ? (dark ? AppColors.mint : Colors.white) : Colors.transparent,
                        borderRadius: BorderRadius.circular(11),
                        boxShadow: value == selected && !dark ? const [BoxShadow(color: Color(0x1F0F1E18), blurRadius: 3, offset: Offset(0, 1))] : null,
                      ),
                      child: Text(
                        label,
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: value == selected ? FontWeight.w800 : FontWeight.w600,
                          color: dark ? (value == selected ? AppColors.forest : const Color(0xFFDCEFE5)) : (value == selected ? AppColors.ink : const Color(0xFF3B4A43)),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      );
}

class ChoiceChipPill extends StatelessWidget {
  const ChoiceChipPill({super.key, required this.label, required this.selected, required this.onTap, this.leading, this.dark = true});

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Widget? leading;

  /// Filled dark when selected (filters); false gives the outlined style.
  final bool dark;

  @override
  Widget build(BuildContext context) => Semantics(
        selected: selected,
        button: true,
        child: Material(
          color: selected && dark ? AppColors.ink : Colors.white,
          shape: StadiumBorder(side: BorderSide(color: selected && !dark ? AppColors.forest : Colors.transparent, width: 2)),
          child: InkWell(
            customBorder: const StadiumBorder(),
            onTap: onTap,
            child: Container(
              height: 40,
              padding: const EdgeInsets.symmetric(horizontal: 14),
              child: Row(mainAxisSize: MainAxisSize.min, children: [
                if (leading != null) ...[leading!, const SizedBox(width: 8)],
                Text(label,
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: selected ? FontWeight.w800 : FontWeight.w600,
                      color: selected && dark ? Colors.white : AppColors.ink,
                    )),
              ]),
            ),
          ),
        ),
      );
}

class DonutSegment {
  const DonutSegment(this.value, this.color);

  final double value;
  final Color color;
}

class DonutChart extends StatelessWidget {
  const DonutChart({super.key, required this.segments, this.size = 132, this.stroke = 16, required this.center, required this.semanticLabel});

  final List<DonutSegment> segments;
  final double size;
  final double stroke;
  final Widget center;
  final String semanticLabel;

  @override
  Widget build(BuildContext context) => Semantics(
        label: semanticLabel,
        child: SizedBox(
          width: size,
          height: size,
          child: CustomPaint(
            painter: _DonutPainter(segments, stroke),
            child: Center(child: center),
          ),
        ),
      );
}

class _DonutPainter extends CustomPainter {
  _DonutPainter(this.segments, this.stroke);

  final List<DonutSegment> segments;
  final double stroke;

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset(stroke / 2, stroke / 2) & Size(size.width - stroke, size.height - stroke);
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = stroke;
    canvas.drawArc(rect, 0, math.pi * 2, false, paint..color = AppColors.line);
    final total = segments.fold<double>(0, (s, e) => s + e.value);
    if (total <= 0) return;
    const gap = 0.035;
    var start = -math.pi / 2;
    for (final s in segments) {
      final sweep = s.value / total * math.pi * 2;
      final drawn = segments.length == 1 ? sweep : math.max(sweep - gap, 0.01);
      canvas.drawArc(rect, start, drawn, false, paint..color = s.color);
      start += sweep;
    }
  }

  @override
  bool shouldRepaint(_DonutPainter old) => old.segments != segments;
}

class EmptyState extends StatelessWidget {
  const EmptyState({super.key, required this.icon, required this.title, required this.message, this.action});

  final IconData icon;
  final String title;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) => SectionCard(
        padding: const EdgeInsets.all(20),
        child: Column(children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(color: AppColors.mint, borderRadius: BorderRadius.circular(18)),
            child: Icon(icon, color: AppColors.forest),
          ),
          const SizedBox(height: 12),
          Text(title, style: AppFonts.display(size: 17, weight: FontWeight.w700, color: AppColors.ink), textAlign: TextAlign.center),
          const SizedBox(height: 6),
          Text(message, textAlign: TextAlign.center, style: const TextStyle(color: AppColors.muted, fontSize: 13)),
          if (action != null) ...[const SizedBox(height: 14), action!],
        ]),
      );
}

/// Date pill used in "Coming up" rows.
class DatePill extends StatelessWidget {
  const DatePill(this.date, {super.key, this.background = const Color(0xFFE4F2EA), this.foreground = AppColors.forest});

  final DateTime date;
  final Color background;
  final Color foreground;

  @override
  Widget build(BuildContext context) => Container(
        width: 46,
        height: 50,
        decoration: BoxDecoration(color: background, borderRadius: BorderRadius.circular(14)),
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Text(DateFormat('dd').format(date), style: AppFonts.display(size: 18, color: foreground)),
          Text(DateFormat('MMM').format(date).toUpperCase(),
              style: TextStyle(fontSize: 10, fontWeight: FontWeight.w800, letterSpacing: 0.6, color: foreground)),
        ]),
      );
}

String moneyLabel(int minor, String currency) => Money.format(minor, currency: currency);

String friendlyDay(DateTime d) {
  final today = DateTime.now();
  final day = DateTime(d.year, d.month, d.day);
  final diff = DateTime(today.year, today.month, today.day).difference(day).inDays;
  if (diff == 0) return 'Today';
  if (diff == 1) return 'Yesterday';
  return DateFormat(d.year == today.year ? 'EEE d MMM' : 'd MMM yyyy').format(d);
}
