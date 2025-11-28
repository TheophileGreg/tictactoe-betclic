import 'package:flutter/material.dart';

/// Application theme configuration.
///
/// Provides a consistent color scheme and typography throughout the app.
class AppTheme {
  /// Private constructor to prevent instantiation.
  const AppTheme._();

  /// Primary color for X player.
  static const Color playerXColor = Color(0xFF6366F1); // Indigo

  /// Primary color for O player.
  static const Color playerOColor = Color(0xFFEC4899); // Pink

  /// Background color.
  static const Color backgroundColor = Color(0xFFF8FAFC);

  /// Surface color for cards/containers.
  static const Color surfaceColor = Colors.white;

  /// Grid line color.
  static const Color gridColor = Color(0xFFE2E8F0);

  /// Text color primary.
  static const Color textPrimary = Color(0xFF0F172A);

  /// Text color secondary.
  static const Color textSecondary = Color(0xFF64748B);

  /// Success color (for wins).
  static const Color successColor = Color(0xFF10B981);

  /// Creates the light theme for the app.
  static ThemeData get lightTheme {
    return ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: playerXColor,
        brightness: Brightness.light,
      ),
      scaffoldBackgroundColor: backgroundColor,
      cardTheme: CardThemeData(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        color: surfaceColor,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          elevation: 2,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
      ),
      appBarTheme: const AppBarTheme(
        centerTitle: true,
        elevation: 0,
        backgroundColor: backgroundColor,
        foregroundColor: textPrimary,
      ),
    );
  }

  /// Animation duration for transitions.
  static const Duration animationDuration = Duration(milliseconds: 300);

  /// Animation curve for most transitions.
  static const Curve animationCurve = Curves.easeInOut;
}

