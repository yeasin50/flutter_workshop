import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CheckoutData {
  const CheckoutData({
    this.totalAmount = 0,
    this.discountPercent = 0,
  });

  final int totalAmount;
  final double discountPercent;
}

class CheckoutCardView extends StatelessWidget {
  const CheckoutCardView({super.key});

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
        child: Column(
          mainAxisSize: .min,
          crossAxisAlignment: .stretch,
          spacing: 12,
          children: [
            Row(
              spacing: 32,
              mainAxisAlignment: .end,
              children: [
                Text(
                  "total",
                  style: TextTheme.of(context).titleLarge,
                ),
                Text(
                  context.watch<CheckoutData>().totalAmount.toString(),
                  style: TextTheme.of(context).titleLarge,
                ),
              ],
            ),
            ElevatedButton(
              onPressed: () {},
              child: Text("Buy now"),
            ),
          ],
        ),
      ),
    );
  }
}
