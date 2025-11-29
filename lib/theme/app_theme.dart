import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  static const Color background = Color(0xFF121418); // Deep charcoal/midnight
  static const Color surface = Color(0xFF1E2026);
  static const Color textPrimary = Color(0xFFE0E0E0); // Soft off-white
  static const Color textSecondary = Color(0xFFA0A0A0);
  static const Color accentFire = Color(0xFFFF5722);
  static const Color accentDestruction = Color(0xFFCF6679);

  static ThemeData get darkTheme {
    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      scaffoldBackgroundColor: background,
      primaryColor: surface,
      colorScheme: const ColorScheme.dark(
        primary: surface,
        secondary: accentFire,
        surface: surface,
        onSurface: textPrimary,
      ),
      textTheme: TextTheme(
        displayLarge: GoogleFonts.outfit(
          fontSize: 32,
          fontWeight: FontWeight.w300,
          color: textPrimary,
        ),
        bodyLarge: GoogleFonts.outfit(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: textPrimary,
          height: 1.5,
        ),
        bodyMedium: GoogleFonts.outfit(fontSize: 16, color: textSecondary),
      ),
      inputDecorationTheme: InputDecorationTheme(
        border: InputBorder.none,
        hintStyle: GoogleFonts.outfit(
          fontSize: 18,
          color: textSecondary.withAlpha(128),
        ),
      ),
    );
  }
}
