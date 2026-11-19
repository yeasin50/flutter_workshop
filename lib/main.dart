import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(DeepLinkExample());
}

class DeepLinkExample extends StatelessWidget {
  const DeepLinkExample({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
      theme: ThemeData.dark(),
      debugShowCheckedModeBanner: false,
    );
  }
}

/// The route configuration.
final GoRouter _router = GoRouter(
  initialLocation: '/flutter_workshop',
  routes: <RouteBase>[
    GoRoute(
      path: '/flutter_workshop',
      builder: (BuildContext context, GoRouterState state) {
        return const HomeScreen();
      },
      routes: [
        GoRoute(
          path: 'product/:id',
          builder: (BuildContext context, GoRouterState state) {
            final id = int.tryParse(state.pathParameters["id"] ?? "") ?? 0;
            return ProductsScreen(productId: id);
          },
        ),
      ],
    ),
  ],
);

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Deeplink example"),
        actions: [
          IconButton(
            onPressed: () {
              final url = "https://youtu.be/bo_aObojqJc?si=0YwWWlhuJTsZZS4u";
              launchUrl(Uri.parse(url));
            },
            icon: Icon(Icons.video_library_rounded),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 16,
          children: List.generate(
            (5),
            (i) => ElevatedButton(
              onPressed: () => context.replace('/flutter_workshop/product/$i'),
              child: Text('Check product $i'),
            ),
          ),
        ),
      ),
    );
  }
}

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({super.key, required this.productId});
  final int productId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: .center,
        crossAxisAlignment: .stretch,
        children: [
          Text(
            "Product $productId",
            style: TextStyle(fontSize: 55),
            textAlign: .center,
          ),
          TextButton(onPressed: context.pop, child: Text("back")),
        ],
      ),
    );
  }
}
