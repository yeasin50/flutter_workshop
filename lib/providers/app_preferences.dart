import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences_android/shared_preferences_android.dart';

abstract interface class AppPreferences {
  Future<ThemeMode?> get themeMode;
  Future<bool?> get isFirstLaunch;

  Future<void> setThemeMode(ThemeMode value);
  Future<void> setIsFirstLaunch(bool value);
}

final class SharedPreferencesAppPreferences implements AppPreferences {
  final SharedPreferencesAsync _prefs;

  SharedPreferencesAppPreferences()
    : _prefs = SharedPreferencesAsync(
        options: SharedPreferencesAsyncAndroidOptions(
          backend: SharedPreferencesAndroidBackendLibrary.SharedPreferences,
          originalSharedPreferencesOptions: AndroidSharedPreferencesStoreOptions(
            fileName: 'the_name_of_a_file',
          ),
        ),
      );

  @override
  Future<void> setThemeMode(ThemeMode value) {
    return _prefs.setInt('themeMode', value.index);
  }

  @override
  Future<ThemeMode?> get themeMode async {
    final value = await _prefs.getInt('themeMode');
    if (value == null || value < 0 || value >= ThemeMode.values.length) {
      return null;
    }

    return ThemeMode.values[value];
  }

  @override
  Future<void> setIsFirstLaunch(bool value) {
    return _prefs.setBool('isFirstLaunch', value);
  }

  @override
  Future<bool?> get isFirstLaunch {
    return _prefs.getBool('isFirstLaunch');
  }
}
