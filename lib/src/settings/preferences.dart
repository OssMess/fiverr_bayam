import 'package:bayam/src/tools.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Preferences {
  static const onboarding = 'onboarding';
  static const locale = 'locale';
  static const theme = 'theme';
  static const listRecentContacts = 'recent';
  static const discussionsLastGet = 'discussion last get';
  static const showHowAppWork = 'show how app work';

  static final Future<SharedPreferences> _prefs =
      SharedPreferences.getInstance();

  static Future<bool> getShowOnboarding() async {
    final SharedPreferences prefs = await _prefs;
    final showOnboarding = prefs.getBool(onboarding);
    return showOnboarding ?? true;
  }

  static Future<void> setShowOnboarding(bool show) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(onboarding, show);
  }

  static Future<bool> getShowHowAppWork() async {
    final SharedPreferences prefs = await _prefs;
    final result = prefs.getBool(showHowAppWork);
    return result ?? true;
  }

  static Future<void> setShowHowAppWork(bool show) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setBool(showHowAppWork, show);
  }

  static Future<DateTime> getDiscussionLastGet() async {
    final SharedPreferences prefs = await _prefs;
    return prefs.getString(discussionsLastGet) != null
        ? DateTimeUtils.parseDateTime(prefs.getString(discussionsLastGet))!
        : DateTime.now();
  }

  static Future<void> setDiscussionLastGet() async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(discussionsLastGet, DateTime.now().toString());
  }

  static Future<void> setLocale(Locale loc) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(locale, loc.languageCode);
  }

  static Future<Locale> getLocale() async {
    final SharedPreferences prefs = await _prefs;
    final loc = prefs.getString(locale);
    return loc == null ? const Locale('en', '') : Locale(loc, '');
  }

  static Future<void> setThemeMode(ThemeMode themeMode) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString(theme, themeMode.name);
  }

  static Future<ThemeMode> getThemeMode() async {
    final SharedPreferences prefs = await _prefs;
    final themeMode = prefs.getString(theme);
    switch (themeMode) {
      case 'system':
        return ThemeMode.system;
      case 'light':
        return ThemeMode.light;
      case 'dark':
        return ThemeMode.dark;
      default:
        return ThemeMode.light;
    }
  }

  static Future<List<String>> getListRecentContacts() async {
    final SharedPreferences prefs = await _prefs;
    final list = prefs.getStringList(listRecentContacts);
    return list ?? [];
  }

  static Future<void> setListRecentContacts(List<String> listRecent) async {
    if (listRecent.length > 5) {
      listRecent = listRecent.sublist(0, 4);
    }
    final SharedPreferences prefs = await _prefs;
    prefs.setStringList(listRecentContacts, listRecent);
  }
}
