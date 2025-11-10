import 'package:flutter/material.dart';
import 'shared_preferences_provider.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;
  SharedPreferencesProvider? _sp;
  bool _syncedOnce = false;

  ThemeMode get themeMode => _themeMode;

  // Called by ProxyProvider to connect to SharedPreferencesProvider
  void attach(SharedPreferencesProvider sp) {
    _sp = sp;
    final modeFromPrefs = sp.isDarkMode ? ThemeMode.dark : ThemeMode.light;

    if (!_syncedOnce || modeFromPrefs != _themeMode) {
      _syncedOnce = true;
      _themeMode = modeFromPrefs;
      notifyListeners();
    }
  }

  Future<void> toggleTheme() async {
    final newMode = _themeMode == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    await setThemeMode(newMode);
  }

  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;
    _themeMode = mode;
    notifyListeners();

    final sp = _sp;
    if (sp != null) {
      await sp.setDarkMode(mode == ThemeMode.dark);
    }
  }
}