import 'package:flutter/material.dart';
import 'package:state_management_example_yt/providers/mock_data_repo.dart';
import 'widgets/item_view.dart';
import '../models/item.dart';
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
      bottomNavigationBar: CheckoutCardView(),
      body: GridView.builder(
        itemCount: 8,
        padding: EdgeInsetsDirectional.all(8),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemBuilder: (context, index) {
          final items = [
            ...mockItems.sublist(5),
            ...mockItems.sublist(5).map((e) => e.copyWith(quantity: index)),
          ].toSet().toList();
          return ItemView(
            item: items[index].copyWith(quantity: index),
            onRemove: () {},
          );
        },
      ),
    );
  }
}
