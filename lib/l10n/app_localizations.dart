import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:flutter/services.dart';

class AppLocalizations {
  late Map<String, String> _localizedStrings;

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  Future<bool> load(Locale locale) async {
    String jsonString = await rootBundle
        .loadString('assets/l10n/${locale.languageCode}.json');
    final jsonMap = json.decode(jsonString);
    _localizedStrings = jsonMap.cast<String, String>();
    return true;
  }

  String translate(String key) => _localizedStrings[key] ?? key;

  static AppLocalizations of(BuildContext context) =>
      Localizations.of<AppLocalizations>(context, AppLocalizations)!;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'ar', 'fr'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations();
    await localizations.load(locale);
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) =>
      false;
}
