import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';

import 'app/app.dart';
import 'app/database/app_database.dart';
import 'app/providers/app_providers.dart';
import 'core/di/injection.dart';

import 'core/theme/theme_provider.dart';
import 'features/settings/providers/settings_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ar', null);
  await initializeDateFormatting('en', null);

  await Injection.init();

  final database = getIt<AppDatabase>();

  // ✅ حمّل التفضيلات قبل تشغيل التطبيق
  final themeProvider = ThemeProvider();
  await themeProvider.load();

  final settingsProvider = SettingsProvider(database);
  await settingsProvider.load();

  runApp(
    MultiProvider(
      providers: [
        ...AppProviders.getProviders(database),
        ChangeNotifierProvider<ThemeProvider>.value(value: themeProvider),
        ChangeNotifierProvider<SettingsProvider>.value(value: settingsProvider),
      ],
      child: const TeacherExamApp(),
    ),
  );
}