import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// Luxero design tokens — source: APP-HANDOFF.md
/// Gold #A7853B · Espresso #251A13 · Ivory #F5F1E7 · Champagne #EDE5D3
/// Light gold #D4B978 · Mid gold #C19A3F · Radii 10/20/25
/// Display: Bodoni Moda UPPERCASE tight · Body: Inter
/// Rules: no emojis · max 2 fonts · single gold CTA per screen.
class AppTheme {
  static const bg = Color(0xFFF5F1E7); // Ivory canvas
  static const ink = Color(0xFF251A13); // Espresso
  static const gold = Color(0xFFA7853B); // Brand gold
  static const champagne = Color(0xFFEDE5D3); // Soft surfaces
  static const lightGold = Color(0xFFD4B978);
  static const midGold = Color(0xFFC19A3F);
  static const espresso = Color(0xFF251A13);
  // Back-compat aliases (old code uses these names)
  static const midnight = espresso;

  static TextStyle displayLarge(BuildContext? context) =>
      GoogleFonts.bodoniModa(
        fontSize: 32, fontWeight: FontWeight.w900, color: ink,
        letterSpacing: 0.5, height: 0.95,
      );

  static TextStyle displaySmall() => GoogleFonts.bodoniModa(
        fontSize: 20, fontWeight: FontWeight.w600, color: ink, height: 1.0,
      );

  static ThemeData light() {
    final base = ThemeData(useMaterial3: true);
    final text = GoogleFonts.interTextTheme(base.textTheme).copyWith(
      displayLarge: GoogleFonts.bodoniModa(
          fontSize: 32, fontWeight: FontWeight.w900, color: ink, height: 0.95),
      displayMedium: GoogleFonts.bodoniModa(
          fontSize: 26, fontWeight: FontWeight.w600, color: ink, height: 1.0),
      titleLarge: GoogleFonts.inter(
          fontSize: 20, fontWeight: FontWeight.w700, color: ink),
    );
    final scheme = ColorScheme.fromSeed(
      seedColor: gold,
      primary: ink,
      secondary: gold,
      surface: Colors.white,
    );
    return base.copyWith(
      colorScheme: scheme,
      scaffoldBackgroundColor: bg,
      textTheme: text,
      appBarTheme: AppBarTheme(
        backgroundColor: bg,
        foregroundColor: ink,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: GoogleFonts.bodoniModa(
          fontSize: 22, fontWeight: FontWeight.w600, color: ink),
      ),
      cardTheme: CardThemeData(
        color: Colors.white,
        elevation: 0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
          side: const BorderSide(color: champagne),
        ),
      ),
      chipTheme: base.chipTheme.copyWith(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        // Single primary gold CTA per screen (handoff rule)
        style: ElevatedButton.styleFrom(
          backgroundColor: gold,
          foregroundColor: Colors.white,
          minimumSize: const Size(double.infinity, 54),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 16),
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: ink,
          minimumSize: const Size(double.infinity, 54),
          side: const BorderSide(color: gold),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          textStyle: GoogleFonts.inter(fontWeight: FontWeight.w700, fontSize: 15),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: Colors.white,
        indicatorColor: gold.withOpacity(0.15),
        labelTextStyle: WidgetStatePropertyAll(
          GoogleFonts.inter(fontSize: 12, fontWeight: FontWeight.w600),
        ),
      ),
      pageTransitionsTheme: const PageTransitionsTheme(
        builders: {
          TargetPlatform.android: PredictiveBackPageTransitionsBuilder(),
          TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
        },
      ),
    );
  }
}
