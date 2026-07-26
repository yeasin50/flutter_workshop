import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth_service.dart';
import '../providers/mock_data_repo.dart';
import 'presentation/home_page.dart';
import 'presentation/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => AuthService(MockDataRepo())),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          scrollBehavior: ScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
          home: StreamProvider<User?>(
            initialData: null,
            create: (_) => context.read<AuthService>().authStateChanges,
            builder: (context, child) => Consumer<User?>(
              builder: (context, st, c) {
                //NOTE: to read something,we need one down context, not the same
                if (st == null) {
                  return const LoginPage();
                }

                return const HomePage();
              },
            ),
          ),
        );
      },
    );
  }
}
