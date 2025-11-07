import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  // Default theme mode is light
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  ThemeProvider() {
    _loadTheme(); // Load the saved theme from SharedPreferences
  }

  // Load the theme from SharedPreferences
  Future<void> _loadTheme() async {
    final prefs = await SharedPreferences.getInstance();
    final savedTheme = prefs.getString('themeMode');
    if (savedTheme != null) {
      _themeMode = savedTheme == 'dark' ? ThemeMode.dark : ThemeMode.light;
    }
    notifyListeners();
  }

  // Toggle between light and dark mode
  void toggleTheme() async {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    // Save the selected theme to SharedPreferences
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('themeMode', _themeMode == ThemeMode.dark ? 'dark' : 'light');
    notifyListeners(); // Notify listeners to rebuild with the new theme
  }
}