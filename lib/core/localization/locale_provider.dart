import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Riverpod provider for managing the active app locale (Hindi vs English).
final localeProvider = StateNotifierProvider<LocaleNotifier, Locale>((ref) {
  return LocaleNotifier();
});

class LocaleNotifier extends StateNotifier<Locale> {
  LocaleNotifier() : super(const Locale('hi', 'IN')) {
    _loadSavedLocale();
  }

  static const String _prefKey = 'app_language';

  Future<void> _loadSavedLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final langCode = prefs.getString(_prefKey) ?? 'hi';
    state = Locale(langCode, langCode == 'hi' ? 'IN' : 'US');
  }

  Future<void> setLocale(String languageCode) async {
    final newLocale = Locale(
      languageCode,
      languageCode == 'hi' ? 'IN' : 'US',
    );
    state = newLocale;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_prefKey, languageCode);
  }

  Future<void> toggleLocale() async {
    final nextCode = state.languageCode == 'hi' ? 'en' : 'hi';
    await setLocale(nextCode);
  }

  bool get isHindi => state.languageCode == 'hi';
}
