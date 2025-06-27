import 'package:flutter/material.dart';
import 'color_scheme.dart';
import 'text_styles.dart';
import 'button_styles.dart';

final ThemeData coreLightTheme = ThemeData(
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  scaffoldBackgroundColor: lightColorScheme.surface,
  appBarTheme: AppBarTheme(
    backgroundColor: lightColorScheme.primary,
    foregroundColor: lightColorScheme.onPrimary,
    elevation: 2,
    titleTextStyle: AppTextStyles.appBarTitleStyle,
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: AppButtonStyles.primaryButtonStyle.copyWith(
      backgroundColor: MaterialStateProperty.all(lightColorScheme.primary),
      foregroundColor: MaterialStateProperty.all(lightColorScheme.onPrimary),
      textStyle: MaterialStateProperty.all(AppTextStyles.alertDialogButtonTextStyle), // Use theme style for button text
    ),
  ),
  textTheme: TextTheme(
    titleLarge: AppTextStyles.titleLarge.copyWith(color: lightColorScheme.onSurface), // Apply color from scheme
    bodyMedium: AppTextStyles.bodyMedium.copyWith(color: lightColorScheme.onSurface), // Apply color from scheme
    titleMedium: AppTextStyles.titleMedium.copyWith(color: lightColorScheme.onSurface), // Apply color from scheme

    // Map styles from screen usage
    bodySmall: AppTextStyles.appBarSubtitleStyle, // Use specific app bar subtitle style
    titleSmall: AppTextStyles.appBarTitleStyle, // Use specific app bar title style

    // Map AlertDialog styles
    headlineSmall: AppTextStyles.alertDialogTitleStyle.copyWith(color: lightColorScheme.onSurface), // Apply color from scheme
    // Note: bodyMedium used for general and dialog content, might need separate style if they differ
    labelLarge: AppTextStyles.alertDialogButtonTextStyle.copyWith(color: lightColorScheme.primary), // Apply color from scheme

     // Map TextField label style
    labelMedium: AppTextStyles.textFieldLabelStyle, // Color applied in InputDecorationTheme
    // TextField hint style is applied directly in InputDecorationTheme

  ).apply(
     bodyColor: lightColorScheme.onSurface, // Apply default text color from color scheme
     displayColor: lightColorScheme.onSurface, // Apply default text color from color scheme
  ),
  cardTheme: CardThemeData(
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(16),
    ),
    elevation: 4,
  ),
  bottomSheetTheme: BottomSheetThemeData(
    backgroundColor: lightColorScheme.surface,
  ),
  inputDecorationTheme: InputDecorationTheme(
    labelStyle: AppTextStyles.textFieldLabelStyle.copyWith(color: lightColorScheme.primary), // Use theme style and color
    hintStyle: AppTextStyles.textFieldHintStyle.copyWith(color: lightColorScheme.primary.withOpacity(0.6)), // Use theme style and color
    border: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lightColorScheme.primary),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lightColorScheme.primary),
    ),
    disabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lightColorScheme.primary),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(color: lightColorScheme.primary),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
  ),
);
