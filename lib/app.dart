import 'dart:ui';

import 'package:flutter/material.dart';

import 'presentation/home_page.dart';
import 'presentation/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      scrollBehavior: ScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
      home: LoginPage(),
    );
  }
}
