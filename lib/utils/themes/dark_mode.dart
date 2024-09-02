import 'package:flutter/material.dart';

ThemeData darkMode = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade400, foregroundColor: Colors.white),
    colorScheme: ColorScheme.dark(
        // onPrimary: Colors.white,
        surface: Colors.grey.shade900,
        primary: Colors.grey.shade600,
        secondary: Colors.grey.shade800,
        tertiary: Colors.grey.shade800,
        onSecondary: Colors.grey.shade700,
        inversePrimary: Colors.grey.shade300));

// ColorScheme lightmode = ColorScheme.light(
//     surface: Colors.grey.shade300,
//     primary: Colors.grey.shade500,
//     secondary: Colors.grey.shade200,
//     tertiary: Colors.white,
//     inversePrimary: Colors.grey.shade900);
