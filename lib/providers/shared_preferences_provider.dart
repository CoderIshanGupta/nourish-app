import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  // Variables to store settings
  bool _isDarkMode = false;
  String _preferredLanguage = 'en';

  bool get isDarkMode => _isDarkMode;
  String get preferredLanguage => _preferredLanguage;

  // Load settings from SharedPreferences
  Future<void> loadSettings() async {
    final prefs = await SharedPreferences.getInstance();
    
    // Load theme preference
    _isDarkMode = prefs.getBool('isDarkMode') ?? false; // Default is false (light mode)
    
    // Load language preference
    _preferredLanguage = prefs.getString('preferredLanguage') ?? 'en'; // Default is 'en'
    
    notifyListeners(); // Notify listeners that settings are loaded
  }

  // Toggle dark mode and save the setting
  Future<void> toggleDarkMode() async {
    _isDarkMode = !_isDarkMode;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isDarkMode', _isDarkMode);
    
    notifyListeners(); // Notify listeners to rebuild the UI
  }

  // Set preferred language and save the setting
  Future<void> setPreferredLanguage(String language) async {
    _preferredLanguage = language;
    
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('preferredLanguage', language);
    
    notifyListeners(); // Notify listeners to rebuild the UI
  }
}
