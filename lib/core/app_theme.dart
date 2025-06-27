import 'package:flutter/material.dart';
import 'package:prens/core/dark_theme.dart';
import 'light_theme.dart'; // Import the core light theme

class AppTheme {
  static ThemeData lightTheme = coreLightTheme; // Reference the core light theme

  // Keep the gradient property if it's used elsewhere or move it to a core file if preferred
  static LinearGradient redCreamGradient = const LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      Color(0xFFE31C24), // kırmızı
      Color(0xFFFFF8E1), // krem
    ],
  );
  static ThemeData darkTheme = coreDarkTheme; // Reference the core light theme

}
