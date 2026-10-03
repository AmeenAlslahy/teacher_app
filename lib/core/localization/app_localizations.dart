import 'package:flutter/material.dart';
class AppLocalizations {
static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}
class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
const _AppLocalizationsDelegate();
@override bool isSupported(Locale locale) => true;
@override Future<AppLocalizations> load(Locale locale) async => AppLocalizations();
@override bool shouldReload(_AppLocalizationsDelegate old) => false;
}