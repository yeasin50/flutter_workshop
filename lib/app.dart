import 'package:go_router_yt/home_page.dart';
import 'package:material_ui/material_ui.dart';

import 'package:go_router/go_router.dart';

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: GoRouter(
        initialLocation: "/",
        routes: [
          GoRoute(
            path: "/",
            builder: (context, state) => HomePage(),
            routes: [
              GoRoute(
                path: "details",
                builder: ((context, state) => DetailsPage()),
              ),
            ],
          ),

          GoRoute(
            path: "/setting",
            builder: (context, state) => SettingPage(),
          ),
        ],
      ),
    );
  }
}
