import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'text_styles.dart';
import 'button_styles.dart';

// Define the dark theme data
final ThemeData coreDarkTheme = ThemeData(
  brightness: Brightness.dark, // Burada belirtilmiş
  colorScheme: darkColorScheme,
  scaffoldBackgroundColor: darkColorScheme.onSurface,
  appBarTheme: AppBarTheme(
    backgroundColor: darkColorScheme.primary,
    foregroundColor: darkColorScheme.onPrimary,
    elevation: 2,
    titleTextStyle: AppTextStyles.appBarTitleStyle, // Using existing text style
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppButtonStyles.primaryButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all(darkColorScheme.primary),
      foregroundColor: MaterialStateProperty.all(darkColorScheme.onPrimary),
      textStyle: MaterialStateProperty.all(AppTextStyles.alertDialogButtonTextStyle), // Using existing text style
    ),
  ),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.titleLarge.copyWith(color: darkColorScheme.onSurface), // Apply color from scheme
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: darkColorScheme.onSurface), // Apply color from scheme
    titleMedium: AppTextStyles.titleMedium.copyWith(color: darkColorScheme.onSurface), // Apply color from scheme

    // Map styles from screen usage
    bodySmall: AppTextStyles.appBarSubtitleStyle.copyWith(color: darkColorScheme.onPrimary), // Use specific app bar subtitle style with dark theme color
    titleSmall: AppTextStyles.appBarTitleStyle.copyWith(color: darkColorScheme.onPrimary), // Use specific app bar title style with dark theme color

    // Map AlertDialog styles
    headlineSmall: AppTextStyles.alertDialogTitleStyle.copyWith(color: darkColorScheme.onSurface), // Apply color from scheme
    // Note: bodyMedium used for general and dialog content, might need separate style if they differ
    labelLarge: AppTextStyles.alertDialogButtonTextStyle.copyWith(color: darkColorScheme.primary), // Apply color from scheme

     // Map TextField label style
    labelMedium: AppTextStyles.textFieldLabelStyle.copyWith(color: darkColorScheme.onSurface), // Use theme style and color
    // TextField hint style is applied directly in InputDecorationTheme

  ).apply(
     bodyColor: darkColorScheme.onSurface, // Apply default text color from color scheme
     displayColor: darkColorScheme.onSurface, // Apply default text color from color scheme
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
    color: darkColorScheme.surface, // Card color in dark mode
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: darkColorScheme.surface, // Bottom sheet color in dark mode
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: AppTextStyles.textFieldLabelStyle.copyWith(color: darkColorScheme.onSurface), // Use theme style and color
    hintStyle: AppTextStyles.textFieldHintStyle.copyWith(color: darkColorScheme.onSurface.withOpacity(0.6)), // Use theme style and color
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.onSurface), // Using onSurface for border in dark mode
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.onSurface), // Using onSurface for border in dark mode
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.onSurface), // Using onSurface for border in dark mode
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: darkColorScheme.primary), // Primary color for focused border
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
);
