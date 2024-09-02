import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
    appBarTheme: AppBarTheme(
        backgroundColor: Colors.grey.shade400, foregroundColor: Colors.white),
    colorScheme: ColorScheme.light(
        // onPrimary: Colors.white,
        surface: Colors.grey.shade300,
        primary: Colors.grey.shade500,
        secondary: Colors.grey.shade200,
        tertiary: Colors.white,
        onSecondary: Colors.grey.shade700,
        inversePrimary: Colors.grey.shade900));

// ColorScheme lightmode = ColorScheme.light(
//     surface: Colors.grey.shade300,
//     primary: Colors.grey.shade500,
//     secondary: Colors.grey.shade200,
//     tertiary: Colors.white,
//     inversePrimary: Colors.grey.shade900);
