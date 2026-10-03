import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/theme/app_spacing.dart';
import '../../../../core/theme/theme_provider.dart';
import '../../providers/settings_provider.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('الإعدادات')),
      body: ListView(
        padding: const EdgeInsets.all(AppSpacing.md),
        children: const [
          _AppearanceSection(),
          SizedBox(height: AppSpacing.lg),
          _LanguageSection(),
          SizedBox(height: AppSpacing.lg),
          _AboutSection(),
        ],
      ),
    );
  }
}

// ============================================================
// المظهر
// ============================================================

class _AppearanceSection extends StatelessWidget {
  const _AppearanceSection();

  @override
  Widget build(BuildContext context) {
    final theme = context.watch<ThemeProvider>();

    return Card(
      child: Column(
        children: [
          ListTile(
            leading: const Icon(Icons.palette_outlined),
            title: const Text('المظهر'),
            subtitle: Text(_label(theme.themeMode)),
          ),
          const Divider(height: 1),
          RadioGroup<ThemeMode>(
            groupValue: theme.themeMode,
            onChanged: (v) {
              if (v != null) theme.setThemeMode(v);
            },
            child: const Column(
              children: [
                RadioListTile<ThemeMode>(
                  value: ThemeMode.system,
                  title: Text('حسب النظام'),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.light,
                  title: Text('فاتح'),
                ),
                RadioListTile<ThemeMode>(
                  value: ThemeMode.dark,
                  title: Text('داكن'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _label(ThemeMode mode) => switch (mode) {
    ThemeMode.light => 'فاتح',
    ThemeMode.dark => 'داكن',
    ThemeMode.system => 'حسب النظام',
  };
}

// ============================================================
// اللغة
// ============================================================

class _LanguageSection extends StatelessWidget {
  const _LanguageSection();

  @override
  Widget build(BuildContext context) {
    final settings = context.watch<SettingsProvider>();

    return Card(
      child: Column(
        children: [
          const ListTile(
            leading: Icon(Icons.language),
            title: Text('اللغة'),
          ),
          const Divider(height: 1),
          RadioGroup<String>(
            groupValue: settings.locale.languageCode,
            onChanged: (v) {
              if (v != null) settings.setLocale(Locale(v));
            },
            child: const Column(
              children: [
                RadioListTile<String>(
                  value: 'ar',
                  title: Text('العربية'),
                ),
                RadioListTile<String>(
                  value: 'en',
                  title: Text('English'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ============================================================
// حول التطبيق
// ============================================================

class _AboutSection extends StatelessWidget {
  const _AboutSection();

  @override
  Widget build(BuildContext context) {
    return const Card(
      child: Column(
        children: [
          ListTile(
            leading: Icon(Icons.info_outline),
            title: Text('حول التطبيق'),
          ),
          Divider(height: 1),
          ListTile(
            title: Text('الإصدار'),
            trailing: Text('1.0.0'),
          ),
          ListTile(
            title: Text('الوصف'),
            subtitle: Text('تطبيق لإدارة الاختبارات والطلاب للمدرسين'),
          ),
        ],
      ),
    );
  }
}