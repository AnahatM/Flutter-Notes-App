// Light Mode
import 'package:flutter/material.dart';

ThemeData lightMode = ThemeData(
  brightness: Brightness.light,
  colorScheme: ColorScheme.light(
    surface: Colors.grey.shade300,
    primary: Colors.grey.shade200,
    secondary: Colors.grey.shade400,
    inversePrimary: Colors.grey.shade800,
  ),
);

// Dark Mode
ThemeData darkMode = ThemeData(
  brightness: Brightness.dark,
  colorScheme: ColorScheme.dark(
    surface: const Color.fromARGB(255, 18, 18, 18),
    primary: const Color.fromARGB(255, 31, 31, 31),
    secondary: Colors.grey.shade700,
    inversePrimary: Colors.grey.shade400,
  ),
);
