import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

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
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
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
      appBar: AppBar(title: Text("Deeplink example")),
      body: Center(
        child: Column(
          mainAxisAlignment: .center,
          spacing: 16,
          children: List.generate(
            (5),
            (i) => ElevatedButton(
              onPressed: () => context.replace('/product/$i'),
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
