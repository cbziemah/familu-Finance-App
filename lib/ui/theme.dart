import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Colours from the approved mockup.
class AppColors {
  AppColors._();

  static const ground = Color(0xFFF2F4EF);
  static const card = Colors.white;
  static const ink = Color(0xFF0F1E18);
  static const muted = Color(0xFF5A6A62);
  static const line = Color(0xFFEEF1EC);
  static const forest = Color(0xFF0B3B2E);
  static const forestTile = Color(0xFF134C3B);
  static const mint = Color(0xFFCDEBD9);
  static const mintText = Color(0xFFBFE3D0);
  static const green = Color(0xFF0B6B4C);
  static const gold = Color(0xFFF2B33D);
  static const goldSoft = Color(0xFFFDF0D3);
  static const goldText = Color(0xFF6B4700);
  static const clay = Color(0xFFC8452F);
  static const kenteGreen = Color(0xFF1E7A55);
  static const navInactive = Color(0xFFA9B8B0);
  static const chip = Color(0xFFE3E8E1);
}

class AppFonts {
  AppFonts._();

  /// Tests switch this off so no font download is attempted.
  static bool useGoogleFonts = true;

  /// Locally loaded families used when [useGoogleFonts] is off (screenshots).
  static String? localDisplayFamily;
  static String? localBodyFamily;

  static TextStyle display({double size = 18, FontWeight weight = FontWeight.w800, Color? color, double? letterSpacing}) {
    final base = TextStyle(
      fontFamily: useGoogleFonts ? null : localDisplayFamily,
      fontSize: size,
      fontWeight: weight,
      color: color,
      letterSpacing: letterSpacing ?? (size >= 26 ? -0.6 : null),
      fontFeatures: const [FontFeature.tabularFigures()],
      height: 1.1,
    );
    return useGoogleFonts ? GoogleFonts.bricolageGrotesque(textStyle: base) : base;
  }

  static TextTheme body(TextTheme base) {
    if (!useGoogleFonts) return localBodyFamily == null ? base : base.apply(fontFamily: localBodyFamily);
    return GoogleFonts.manropeTextTheme(base);
  }
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.forest,
      primary: AppColors.forest,
      secondary: AppColors.gold,
      surface: AppColors.ground,
    ),
    scaffoldBackgroundColor: AppColors.ground,
  );
  final text = AppFonts.body(base.textTheme).apply(bodyColor: AppColors.ink, displayColor: AppColors.ink);
  final rounded = RoundedRectangleBorder(borderRadius: BorderRadius.circular(16));
  return base.copyWith(
    textTheme: text,
    appBarTheme: const AppBarTheme(backgroundColor: AppColors.ground, foregroundColor: AppColors.ink, elevation: 0, scrolledUnderElevation: 0),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.forest,
        foregroundColor: Colors.white,
        minimumSize: const Size(48, 50),
        shape: rounded,
        textStyle: text.labelLarge!.copyWith(fontWeight: FontWeight.w800, fontSize: 15),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.ink,
        minimumSize: const Size(48, 50),
        side: const BorderSide(color: Color(0xFFD9DFD8), width: 1.5),
        shape: rounded,
        textStyle: text.labelLarge!.copyWith(fontWeight: FontWeight.w700, fontSize: 15),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(14), borderSide: BorderSide.none),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
    ),
    bottomSheetTheme: const BottomSheetThemeData(
      backgroundColor: AppColors.ground,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(28))),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(foregroundColor: AppColors.green, textStyle: text.labelLarge!.copyWith(fontWeight: FontWeight.w800, fontSize: 14)),
    ),
    snackBarTheme: const SnackBarThemeData(behavior: SnackBarBehavior.floating),
  );
}
