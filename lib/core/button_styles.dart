import 'package:flutter/material.dart';

class AppButtonStyles {
  static final ButtonStyle primaryButtonStyle = ElevatedButton.styleFrom(
    padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
    ),
    textStyle: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold), // This will be overridden by theme's textTheme if defined
    // backgroundColor and foregroundColor will be applied from theme
  );
  // Add other button styles as needed
}