import 'package:flutter/material.dart';

class ThemeSwitcher extends ValueNotifier<ThemeMode> {
  ThemeSwitcher([super.value = ThemeMode.light]);

  void toggle() {
    value = value == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
  }
}
