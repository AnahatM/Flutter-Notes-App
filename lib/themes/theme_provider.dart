import 'package:flutter/material.dart';
import 'package:minimalist_notes_app/themes/theme.dart';

class ThemeProvider with ChangeNotifier {
  // Initially, theme is light mode
  ThemeData _themeData = lightMode;

  // Getter for theme data
  ThemeData get themeData => _themeData;

  // Getter for dark mode
  bool get isDarkMode => _themeData == darkMode;

  // Setter for theme data
  set themeData(ThemeData themeData) {
    _themeData = themeData;
    notifyListeners();
  }

  // Function to toggle theme
  void toggleTheme() {
    _themeData = isDarkMode ? lightMode : darkMode;
    notifyListeners();
  }
}
