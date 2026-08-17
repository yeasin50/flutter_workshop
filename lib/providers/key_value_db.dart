import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract interface class AppPreferences {
  Future<ThemeMode?> get themeMode;
  Future<bool?> get isFirstLaunch;
  Future<String?> get username;

  Future<void> setThemeMode(ThemeMode value);
  Future<void> setIsFirstLaunch(bool value);
  Future<void> setUsername(String value);
}

final class SharedPreferencesAppPreferences implements AppPreferences {
  final SharedPreferencesAsync _prefs;

  SharedPreferencesAppPreferences() : _prefs = SharedPreferencesAsync();

  @override
  Future<ThemeMode?> get themeMode async {
    final value = await _prefs.getInt('themeMode');
    if (value == null || value < 0 || value >= ThemeMode.values.length) {
      return null;
    }

    return ThemeMode.values[value];
  }

  @override
  Future<bool?> get isFirstLaunch {
    return _prefs.getBool('isFirstLaunch');
  }

  @override
  Future<String?> get username {
    return _prefs.getString('username');
  }

  @override
  Future<void> setThemeMode(ThemeMode value) {
    return _prefs.setInt('themeMode', value.index);
  }

  @override
  Future<void> setIsFirstLaunch(bool value) {
    return _prefs.setBool('isFirstLaunch', value);
  }

  @override
  Future<void> setUsername(String value) {
    return _prefs.setString('username', value);
  }
}
