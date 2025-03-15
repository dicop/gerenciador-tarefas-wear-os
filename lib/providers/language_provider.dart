import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LanguageProvider extends ChangeNotifier {
  static const String _languageKey = 'languageCode';
  final SharedPreferences _prefs;
  late Locale _locale;

  LanguageProvider(this._prefs) {
    final String languageCode = _prefs.getString(_languageKey) ?? 'en';
    _locale = Locale(languageCode);
  }

  Locale get locale => _locale;

  Future<void> setLanguage(String languageCode) async {
    _locale = Locale(languageCode);
    await _prefs.setString(_languageKey, languageCode);
    notifyListeners();
  }
} 