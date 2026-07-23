import 'package:flutter/material.dart';

class AppTheme {
  static ThemeData light(Color colorPrimario) {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: colorPrimario,
      brightness: Brightness.light,
      secondary: const Color(0xFFE8A33D), // si quieres mantener tu mostaza fijo, puedes seguir forzándolo aparte
    );

    return ThemeData(
      colorScheme: colorScheme,
      useMaterial3: true,
      scaffoldBackgroundColor: const Color(0xFFFAFAF7),
    );
  }
}