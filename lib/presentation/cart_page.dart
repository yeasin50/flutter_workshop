import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/providers/carts_notifier.dart';
import 'widgets/item_view.dart';
import 'widgets/checkout_card_view.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Cart items"), backgroundColor: Colors.lightGreen.shade300),
      bottomNavigationBar: ProxyProvider<CartsNotifier, CheckoutData>(
        update: (contex, t, v) {
          final cart = Provider.of<CartsNotifier>(context);
          return CheckoutData(totalAmount: cart.calucatePrice());
        },
        child: CheckoutCardView(), // should I clear it , task for std :)
      ),
      body: Consumer<CartsNotifier>(
        builder: (context, data, _) {
          final items = data.items;
          if (items.isEmpty) return Center(child: Text("No item has been added"));

          return GridView.builder(
            itemCount: items.length,
            padding: EdgeInsetsDirectional.all(8),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
            ),
            itemBuilder: (context, index) {
              final item = items.elementAt(index);
              return ItemView(
                item: item,
                onRemove: () {
                  context.read<CartsNotifier>().remove(item);
                },
              );
            },
          );
        },
      ),
    );
  }
}
