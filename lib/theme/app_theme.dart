import 'package:flutter/material.dart';

class CategoryColors {
  final Color bg;
  final Color border;
  final Color text;

  const CategoryColors({
    required this.bg,
    required this.border,
    required this.text,
  });
}

class AppTheme {
  static const Color scaffoldBg = Color(0xFF0a0a0f);
  static const Color cardBg = Color(0xFF1a1a2e);
  static const Color surfaceBg = Color(0xFF16162a);
  static const Color textPrimary = Color(0xFFffffff);
  static const Color textSecondary = Color(0xFFa0a0b0);

  static const Map<String, CategoryColors> categoryColors = {
    'Story': CategoryColors(
      bg: Color(0x26FF6B6B),
      border: Color(0xFFFF6B6B),
      text: Color(0xFFFF6B6B),
    ),
    'Shot': CategoryColors(
      bg: Color(0x264ECDC4),
      border: Color(0xFF4ECDC4),
      text: Color(0xFF4ECDC4),
    ),
    'Sound': CategoryColors(
      bg: Color(0x26A984FF),
      border: Color(0xFFA984FF),
      text: Color(0xFFA984FF),
    ),
    'Color': CategoryColors(
      bg: Color(0x26FFBE0B),
      border: Color(0xFFFFBE0B),
      text: Color(0xFFFFBE0B),
    ),
    'Lens': CategoryColors(
      bg: Color(0x2648BFE3),
      border: Color(0xFF48BFE3),
      text: Color(0xFF48BFE3),
    ),
    'Framing': CategoryColors(
      bg: Color(0x26FF9671),
      border: Color(0xFFFF9671),
      text: Color(0xFFFF9671),
    ),
    'Blocking': CategoryColors(
      bg: Color(0x26F878AC),
      border: Color(0xFFF878AC),
      text: Color(0xFFF878AC),
    ),
    'VFX': CategoryColors(
      bg: Color(0x2600F5A0),
      border: Color(0xFF00F5A0),
      text: Color(0xFF00F5A0),
    ),
    'History': CategoryColors(
      bg: Color(0x26FFC857),
      border: Color(0xFFFFC857),
      text: Color(0xFFFFC857),
    ),
  };

  static const List<String> categories = [
    'All',
    'Story',
    'Shot',
    'Sound',
    'Color',
    'Lens',
    'Framing',
    'Blocking',
    'VFX',
    'History',
  ];

  static CategoryColors colorsForCategory(String category) {
    return categoryColors[category] ??
        const CategoryColors(
          bg: Color(0x26FFFFFF),
          border: Color(0xFFFFFFFF),
          text: Color(0xFFFFFFFF),
        );
  }

  static ThemeData get darkTheme {
    return ThemeData(
      brightness: Brightness.dark,
      scaffoldBackgroundColor: scaffoldBg,
      colorScheme: const ColorScheme.dark(
        surface: cardBg,
        primary: Color(0xFF4ECDC4),
        onSurface: textPrimary,
      ),
      fontFamily: 'SF Pro Display',
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
    );
  }
}
