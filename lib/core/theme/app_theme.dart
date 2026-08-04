import 'package:flutter/material.dart';

/// Tesla / Geely OneOS Dark Glassmorphism Design System for Automotive Head Units.
class AppTheme {
  // Primary Dark Palette
  static const Color bgDark = Color(0xFF0B0F19);
  static const Color surfaceDark = Color(0xFF141C2E);
  static const Color cardDark = Color(0xFF1C273E);
  static const Color glassBorder = Color(0xFF2A3958);

  // Accent & Glow Colors
  static const Color accentCyan = Color(0xFF00E5FF);
  static const Color accentBlue = Color(0xFF2979FF);
  static const Color accentOrange = Color(0xFFFF9100);
  static const Color accentRed = Color(0xFFFF1744);
  static const Color accentGreen = Color(0xFF00E676);

  // Text Hierarchy
  static const Color textPrimary = Color(0xFFF0F4F8);
  static const Color textSecondary = Color(0xFF94A3B8);
  static const Color textMuted = Color(0xFF64748B);

  // Glove-friendly minimum touch target
  static const double minTouchTarget = 64.0;

  static ThemeData get darkTheme {
    return ThemeData.dark().copyWith(
      scaffoldBackgroundColor: bgDark,
      primaryColor: accentCyan,
      cardColor: cardDark,
      colorScheme: const ColorScheme.dark(
        primary: accentCyan,
        secondary: accentBlue,
        surface: surfaceDark,
        error: accentRed,
      ),
      textTheme: const TextTheme(
        headlineLarge: TextStyle(
          fontSize: 30,
          fontWeight: FontWeight.bold,
          color: textPrimary,
          letterSpacing: 0.5,
        ),
        headlineMedium: TextStyle(
          fontSize: 22,
          fontWeight: FontWeight.w600,
          color: textPrimary,
        ),
        bodyLarge: TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.normal,
          color: textPrimary,
        ),
        bodyMedium: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.normal,
          color: textSecondary,
        ),
      ),
    );
  }
}
