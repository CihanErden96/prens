import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

// Define custom TextThemes
class AppTextStyles {
  static final TextStyle titleLarge = GoogleFonts.inter(
    fontSize: 22,
    fontWeight: FontWeight.bold,
    // color will be applied from theme
  );

  static final TextStyle bodyMedium = GoogleFonts.inter(
    fontSize: 16,
    // color will be applied from theme
  );

  static final TextStyle titleMedium = GoogleFonts.inter(
    fontSize: 14,
    // color will be applied from theme
  );

  // Styles derived from screen usage
  static final TextStyle appBarSubtitleStyle = GoogleFonts.inter(
    fontSize: 14,
    color: Colors.white,
  );

  static final TextStyle appBarTitleStyle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: Colors.white,
  );

  static final TextStyle alertDialogTitleStyle = GoogleFonts.inter(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    // color will be applied from theme
  );

  static final TextStyle alertDialogContentStyle = GoogleFonts.inter(
    fontSize: 16,
    // color will be applied from theme
  );

  static final TextStyle alertDialogButtonTextStyle = GoogleFonts.inter(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    // color will be applied from theme
  );

   // Style for Login Screen TextField label
  static final TextStyle textFieldLabelStyle = GoogleFonts.inter(
    fontSize: 16,
    // Color will be applied from inputDecorationTheme
  );

   // Style for Login Screen TextField hint
  static final TextStyle textFieldHintStyle = GoogleFonts.inter(
    fontSize: 14,
    // Color will be applied from inputDecorationTheme
  );

  // Add other text styles as needed
}