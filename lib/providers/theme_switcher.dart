import 'package:flutter/material.dart';
import 'package:flutter_workshop/providers/key_value_db.dart';

class ThemeNotifier extends ValueNotifier<ThemeMode> {
  ThemeNotifier({required this.preferences, ThemeMode? mode}) : super(mode ?? ThemeMode.dark);

  final AppPreferences preferences;

  void toggle() {
    value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    preferences.setThemeMode(value);
  }

  Future<void> load() async {
    final mode = await preferences.themeMode;
    await Future.delayed(Duration(seconds: 3));
    value = mode ?? ThemeMode.dark;
  }
}
