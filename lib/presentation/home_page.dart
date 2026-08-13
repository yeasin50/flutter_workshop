import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/carts_notifier.dart';
import '/providers/products_notifier.dart';
import '/presentation/product_search_page.dart';
import '/presentation/widgets/search_field.dart';

import './profile_page.dart';
import 'cart_page.dart';
import 'widgets/item_view.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final items = [
    BottomNavigationBarItem(
      label: "Home",
      icon: Icon(Icons.home),
      activeIcon: Icon(Icons.home_filled),
    ),

    BottomNavigationBarItem(
      label: "Profile",
      icon: Icon(Icons.person),
      activeIcon: Icon(Icons.person),
    ),
  ];

  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    scheduleMicrotask(() {
      context.read<ProductsNotifier>().fetchProducts(refresh: true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: selectedIndex,
        children: [
          ItemListView(),
          ProfilePage(),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: items,
        currentIndex: selectedIndex,
        onTap: (i) {
          setState(() => selectedIndex = i);
        },
      ),
    );
  }
}

/// ...
class ItemListView extends StatelessWidget {
  const ItemListView({super.key});

  @override
  Widget build(BuildContext context) {
    int totalItem = context.select<CartsNotifier, int>((value) {
      return value.count;
    });

    return Column(
      crossAxisAlignment: .stretch,
      children: [
        AppBar(
          title: Text("Products"),
          actionsPadding: EdgeInsetsGeometry.only(right: 24),
          actions: [
            IconButton(
              onPressed: () {
                final cartNotifier = context.read<CartsNotifier>();
                final route = MaterialPageRoute(
                  builder: (context) => ChangeNotifierProvider.value(
                    value: cartNotifier,
                    child: CartPage(),
                  ),
                );
                Navigator.of(context).push(route);
              },
              icon: Row(
                spacing: 4,
                mainAxisSize: .min,
                children: [
                  Icon(Icons.shopping_basket_outlined),
                  Text(totalItem.toString()),
                ],
              ),
            ),
          ],
        ),
        SearchField(
          onTap: (query) {
            final route = ProductSearchPage.route(query, context.read<CartsNotifier>());
            Navigator.of(context).push(route);
          },
        ),
        Consumer<ProductsNotifier>(
          builder: (context, data, _) {
            if (data.isLoading) return Center(child: CircularProgressIndicator());
            if (data.hasErr) return Center(child: Text(data.error));

            return Expanded(
              child: GridView.builder(
                padding: EdgeInsetsDirectional.all(8),
                gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                  maxCrossAxisExtent: 250,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                ),
                itemCount: data.items.length,
                itemBuilder: (context, index) {
                  final item = data.items[index];
                  return ItemView(
                    item: item,
                    onAdd: () {
                      context.read<CartsNotifier>().add(item);
                    },
                  );
                },
              ),
            );
          },
        ),
      ],
    );
  }
}
