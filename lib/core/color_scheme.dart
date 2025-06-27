import 'package:flutter/material.dart';

final ColorScheme lightColorScheme = ColorScheme.fromSeed(
  seedColor: Color(0xFFE31C24),
  primary: Color(0xFFE31C24),
  secondary: const Color(0xFFE65100),
  surface:Color(0xFFFFF8E1),
  onPrimary: Color(0xFFFFF8E1),
  onSecondary: Color(0xFFFFF8E1),
  onSurface: Colors.black,
  brightness: Brightness.light,
);

final ColorScheme darkColorScheme = ColorScheme.fromSeed(
  seedColor:Color.fromARGB(255, 177, 11, 17), 
  primary: Color.fromARGB(255, 6, 4, 4), 
  secondary:Color.fromARGB(255, 6, 4, 4), 
  surface:Color.fromARGB(255, 6, 4, 4),
  onPrimary: Color.fromARGB(255, 177, 11, 17),
  onSecondary: Color.fromARGB(255, 6, 4, 4),
  onSurface:Color.fromARGB(255, 6, 4, 4),
  brightness: Brightness.dark,
);


