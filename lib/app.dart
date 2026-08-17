import 'dart:ui';

import 'package:flutter/material.dart';
import 'providers/key_value_db.dart';
import 'providers/theme_switcher.dart';
import 'package:provider/provider.dart';

import '../models/user.dart';
import '../providers/auth_service.dart';
import '../providers/mock_data_repo.dart';
import '/providers/carts_notifier.dart';
import '/providers/products_notifier.dart';

import 'presentation/home_page.dart';
import 'presentation/login_page.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider(create: (context) => MockDataRepo()),
        Provider<AppPreferences>(create: (context) => SharedPreferencesAppPreferences()),
        Provider(create: (context) => AuthService(context.read<MockDataRepo>())),
        ListenableProvider(create: (context) => ThemeNotifier(preferences: context.read<AppPreferences>())),
      ],
      builder: (context, _) {
        print("rebuilding");
        return FutureBuilder(
          future: context.read<ThemeNotifier>().load(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              scrollBehavior: ScrollBehavior().copyWith(dragDevices: PointerDeviceKind.values.toSet()),
              themeMode: context.watch<ThemeNotifier>().value,
              theme: ThemeData.light(),
              darkTheme: ThemeData.dark(),
              home: StreamProvider<User?>(
                initialData: null,
                create: (_) => context.read<AuthService>().authStateChanges,
                builder: (context, child) => Consumer<User?>(
                  builder: (context, st, c) {
                    //NOTE: to read something,we need one down context, not the same.
                    // You might use AuthGuard something like a new widget
                    if (st == null) {
                      return const LoginPage();
                    }
                    return MultiProvider(
                      providers: [
                        ChangeNotifierProvider(
                          create: (context) => ProductsNotifier(repo: context.read<MockDataRepo>()),
                        ),
                        ChangeNotifierProvider(create: (context) => CartsNotifier(repo: context.read<MockDataRepo>())),
                      ],
                      child: const HomePage(),
                    );
                  },
                ),
              ),
            );
          },
        );
      },
    );
  }
}
