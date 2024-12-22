// ignore_for_file: avoid_positional_boolean_parameters

import 'package:rh_host/src/core/system/storage/storage_keys.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeStorage {
  static const String _modeKey = '${StorageKeys.prefix}theme_mode';
  static const String _useSeedKey = '${StorageKeys.prefix}use_seed_colors';

  static Future<(String, bool)> loadThemePreferences() async {
    final prefs = await SharedPreferences.getInstance();
    final themeMode = prefs.getString(_modeKey) ?? 'system';
    final useSeed = prefs.getBool(_useSeedKey) ?? false;
    return (themeMode, useSeed);
  }

  static Future<void> saveThemeMode(String mode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_modeKey, mode);
  }

  static Future<void> saveUseSeedColors(bool useSeed) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_useSeedKey, useSeed);
  }
}