import 'package:flutter/material.dart';
import '../../features/context/data/services/context_preferences.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.system;
  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;
  bool get isSystemMode => _themeMode == ThemeMode.system;

  /// تحميل الوضع المحفوظ
  Future<void> load() async {
    final saved = await ContextPreferences.loadThemeMode();
    if (saved == null) return;

    _themeMode = _fromString(saved);
    notifyListeners();
  }

  /// تغيير الوضع وحفظه
  Future<void> setThemeMode(ThemeMode mode) async {
    if (_themeMode == mode) return;

    _themeMode = mode;
    notifyListeners();
    await ContextPreferences.saveThemeMode(_toString(mode));
  }

  String _toString(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'light',
    ThemeMode.dark => 'dark',
    ThemeMode.system => 'system',
  };

  ThemeMode _fromString(String value) => switch (value) {
    'light' => ThemeMode.light,
    'dark' => ThemeMode.dark,
    _ => ThemeMode.system,
  };
}