import 'package:flutter/material.dart';

class AppTheme{
  static ThemeData get light{
    final colorScheme = ColorScheme.light(
      primary: const Color(0xFF2F5233),        // verde bosque
      secondary: const Color(0xFFE8A33D),      // mostaza
      surface: const Color(0xFFFFFFFF),
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAFAF7),
    );
  }
}