import 'package:material_ui/material_ui.dart';
import 'package:collection/collection.dart';

import 'package:go_router/go_router.dart';

class PathParamterApp extends StatelessWidget {
  const PathParamterApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'details/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.tryParse(state.pathParameters["id"] ?? "") ?? -1;
            return DetailsScreen(selectedItem: id);
          },
        ),
      ],
    ),
  ],

  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: TextButton(
        onPressed: () {
          context.go("/");
        },
        child: Text("back to home"),
      ),
    ),
  ),
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home Screen')),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          mainAxisSize: .min,
          spacing: 24,
          children: <Widget>[
            Row(
              mainAxisAlignment: .center,
              spacing: 8,
              children: [
                for (int i = -1; i < 5; i++)
                  Material(
                    color: Colors.redAccent.withAlpha(
                      selectedId == i ? 170 : 10,
                    ),
                    child: InkWell(
                      onTap: () => setState(() {
                        selectedId = i;
                      }),
                      child: Padding(
                        padding: const .all(8.0),
                        child: Text('$i', style: TextStyle(fontSize: 24)),
                      ),
                    ),
                  ),
              ],
            ),

            Text("context.go('/details/$selectedId')"),

            ElevatedButton(
              onPressed: () {
                context.go('/details/$selectedId');
              },
              child: Text.rich(
                TextSpan(
                  text: "/details",
                  style: TextStyle(fontSize: 24),
                  children: ["/$selectedId"]
                      .mapIndexed(
                        (i, e) => TextSpan(
                          text: e,
                          style: TextStyle(color: Colors.redAccent),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// The details screen
class DetailsScreen extends StatelessWidget {
  /// Constructs a [DetailsScreen]
  const DetailsScreen({super.key, required this.selectedItem});
  final int selectedItem;

  @override
  Widget build(BuildContext context) {
    List<Widget> children = [
      for (int i = 0; i < 5; i++)
        Material(
          shape: CircleBorder(),
          color: i == selectedItem ? Colors.green : Colors.transparent,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              "$i",
              style: TextStyle(fontSize: 44),
              textAlign: .center,
            ),
          ),
        ),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(child: Wrap(spacing: 24, children: children)),
    );
  }
}
