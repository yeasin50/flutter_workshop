import 'package:flutter/material.dart';
import '/providers/mock_data_repo.dart';

import '../models/item.dart';
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
    return Column(
      crossAxisAlignment: .stretch,
      children: [
        AppBar(
          title: Text("Products"),
          actionsPadding: EdgeInsetsGeometry.only(right: 24),
          actions: [
            IconButton(
              onPressed: () {
                final route = MaterialPageRoute(builder: (context) => CartPage());
                Navigator.of(context).push(route);
              },
              icon: Row(
                spacing: 4,
                mainAxisSize: .min,
                children: [
                  Icon(Icons.shopping_basket_outlined),
                  Text("3"), //TODO: update total cart ite
                ],
              ),
            ),
          ],
        ),
        Expanded(
          child: GridView.builder(
            padding: EdgeInsetsDirectional.all(8),
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
              maxCrossAxisExtent: 250,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemCount: mockItems.length, //TODO: replace with repo
            itemBuilder: (context, index) {
              final item = mockItems[index];
              return ItemView(item: item, onAdd: () {});
            },
          ),
        ),
      ],
    );
  }
}
