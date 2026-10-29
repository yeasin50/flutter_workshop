import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: "root_nav");

final GoRouter _router = GoRouter(
  initialLocation: "/a",
  navigatorKey: _rootNavigatorKey,
  routes: <RouteBase>[
    ShellRoute(
      builder: (context, state, child) {
        return ScaffoldWithNavBar(child: child);
      },
      routes: [
        GoRoute(
          path: "/a",
          builder: (context, state) => ScreenA(),
          routes: [
            GoRoute(
              path: "details",
              builder: (context, state) => DetailsScreen(label: "A"),
            ),
          ],
        ),
        GoRoute(
          path: "/b",
          builder: (context, state) => ScreenB(),
          routes: [
            GoRoute(
              path: "details",
              parentNavigatorKey: _rootNavigatorKey,
              builder: (context, state) => DetailsScreen(label: "B"),
            ),
          ],
        ),
      ],
    ),
  ],
);

class ShellRouteExampleApp extends StatelessWidget {
  const ShellRouteExampleApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GoRouter Shellroute ',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      routerConfig: _router,
    );
  }
}

class ScaffoldWithNavBar extends StatelessWidget {
  const ScaffoldWithNavBar({required this.child, super.key});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'A Screen'),
          BottomNavigationBarItem(
            icon: Icon(Icons.business),
            label: 'B Screen',
          ),
        ],
        currentIndex: _calculateSelectedIndex(context),
        onTap: (int index) {
          switch (index) {
            case 0:
              GoRouter.of(context).go('/a');
            case 1:
              GoRouter.of(context).go('/b');
          }
        },
      ),
    );
  }

  int _calculateSelectedIndex(BuildContext context) {
    final routePath = GoRouterState.of(context).uri.path;

    if (routePath.startsWith("/a")) return 0;
    if (routePath.startsWith("/b")) return 1;

    return 0;
  }
}

class ScreenA extends StatefulWidget {
  const ScreenA({super.key});

  @override
  State<ScreenA> createState() => _ScreenAState();
}

class _ScreenAState extends State<ScreenA> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.red.shade100,
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        spacing: 24,
        children: <Widget>[
          InkWell(
            onTap: () {
              counter++;
              setState(() {});
            },
            child: Text(
              'Screen A\n $counter',
              textAlign: .center,
              style: .new(fontSize: 45),
            ),
          ),

          TextButton(
            onPressed: () {
              GoRouter.of(context).go('/a/details');
            },
            child: const Text('View A details'),
          ),
        ],
      ),
    );
  }
}

class ScreenB extends StatefulWidget {
  const ScreenB({super.key});

  @override
  State<ScreenB> createState() => _ScreenBState();
}

class _ScreenBState extends State<ScreenB> {
  int counter = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Colors.greenAccent.shade100,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: .stretch,
          spacing: 24,
          children: <Widget>[
            InkWell(
              onTap: () {
                counter++;
                setState(() {});
              },
              child: Text(
                'Screen B\n $counter',
                textAlign: .center,
                style: .new(fontSize: 45),
              ),
            ),

            TextButton(
              onPressed: () {
                GoRouter.of(context).go('/b/details');
              },
              child: const Text('View B details'),
            ),
          ],
        ),
      ),
    );
  }
}

class DetailsScreen extends StatelessWidget {
  const DetailsScreen({required this.label, super.key});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(
        child: Text(
          'Details for $label',
          style: Theme.of(context).textTheme.headlineMedium,
        ),
      ),
    );
  }
}
