import 'package:material_ui/material_ui.dart';
import 'package:collection/collection.dart';

import 'package:go_router/go_router.dart';

class PathQeury extends StatelessWidget {
  const PathQeury({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      debugShowCheckedModeBanner: false,
    );
  }
}

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

            final bool isAscending = state.uri.queryParameters["sort"] == "asc";

            return DetailsScreen(
              selectedItem: id,
              isAscending: isAscending,
            );
          },

          onExit: (BuildContext context, GoRouterState state) async {
            final bool? confirmed = await showDialog<bool>(
              context: context,
              builder: (_) {
                return AlertDialog(
                  content: const Text('Are you sure to leave this page?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Confirm'),
                    ),
                  ],
                );
              },
            );
            return confirmed ?? false;
          },
        ),
      ],
    ),
  ],
);

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int? selectedId;
  bool isAscending = true;
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

            SegmentedButton(
              selected: {isAscending},
              segments: [
                ButtonSegment(value: true, label: Text("asc")),
                ButtonSegment(value: false, label: Text("desc")),
              ],
              onSelectionChanged: (v) {
                isAscending = (v.contains(true));
                setState(() {});
              },
            ),
            ElevatedButton(
              onPressed: () {
                context.go(
                  '/details/$selectedId?sort=${isAscending ? "asc" : "desc"}',
                );
              },
              child: Text.rich(
                TextSpan(
                  text: "/details",
                  style: TextStyle(fontSize: 24),
                  children:
                      ["/$selectedId", "?sort=${isAscending ? "asc " : "desc"}"]
                          .mapIndexed(
                            (i, e) => TextSpan(
                              text: e,
                              style: TextStyle(
                                color: i == 0
                                    ? Colors.redAccent
                                    : Colors.blueAccent,
                              ),
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
  const DetailsScreen({
    super.key,
    required this.selectedItem,
    required this.isAscending,
  });
  final int selectedItem;
  final bool isAscending;

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
    if (!isAscending) children = children.reversed.toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Details Screen')),
      body: Center(child: Wrap(spacing: 24, children: children)),
    );
  }
}
