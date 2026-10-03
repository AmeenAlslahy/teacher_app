import 'package:flutter/material.dart';
import '../../../app/database/app_database.dart';
import '../../../core/state/base_provider.dart';
import '../../context/data/services/context_preferences.dart';

class SettingsProvider extends BaseProvider {
  // ignore: unused_field
  final AppDatabase _database;

  Locale _locale = const Locale('ar');
  Locale get locale => _locale;

  SettingsProvider(this._database);

  /// تحميل اللغة المحفوظة
  Future<void> load() async {
    final saved = await ContextPreferences.loadLocale();
    if (saved == null) return;

    _locale = Locale(saved);
    notifyListeners();
  }

  /// تغيير اللغة وحفظها
  Future<void> setLocale(Locale locale) async {
    if (_locale == locale) return;

    _locale = locale;
    notifyListeners();
    await ContextPreferences.saveLocale(locale.languageCode);
  }
}