import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class MainTheme {
  static ThemeData lightTheme = ThemeData(
    colorScheme: ColorScheme.fromSeed(
      seedColor: Color(0xFFE31C24),
      primary: Color(0xFFE31C24),
      secondary: Color(0xFFE65100),
      background: Color(0xFFFFF8E1),
      surface: Colors.white,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onBackground: Colors.black87,
      onSurface: Colors.black,
      brightness: Brightness.light,
    ),
    scaffoldBackgroundColor: Color(0xFFFFF8E1),
    appBarTheme: AppBarTheme(
      backgroundColor: Color(0xFFE31C24),
      foregroundColor: Colors.white,
      elevation: 2,
      titleTextStyle: GoogleFonts.inter(
  fontSize: 20,
  fontWeight: FontWeight.bold,
  color: Colors.white,
),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: Color(0xFFE31C24),
        foregroundColor: Colors.white,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        textStyle: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
      ),
    ),
        textTheme: TextTheme(
      titleLarge: TextStyle(
        fontSize: 22,
        fontWeight: FontWeight.bold,
        color: Color(0xFFE65100),
      ),
      bodyMedium: TextStyle(
        fontSize: 16,
        color: Color(0xFF424242),
      ),
      titleMedium: TextStyle(
        fontSize: 14,
        color: Color(0xFF757575),
      ),
    ),
    cardTheme: CardThemeData(
      color: Colors.white,
      elevation: 3,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: Color(0xFFFFF8E1),
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: GoogleFonts.inter(color: Color(0xFFE31C24), fontSize: 16),
      hintStyle: GoogleFonts.inter(color: Color(0xFFE31C24), fontSize: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE31C24)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE31C24)),
      ),
      disabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE31C24)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Color(0xFFE31C24)),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
    ),
  );
}