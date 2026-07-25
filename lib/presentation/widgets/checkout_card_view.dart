import 'package:flutter/material.dart';

class CheckoutCardView extends StatelessWidget {
  const CheckoutCardView({super.key});

  @override
  Widget build(BuildContext context) {
    int total = 120;

    return Material(
      color: Colors.greenAccent.shade200,
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
                  total.toString(),
                  style: TextTheme.of(context).titleLarge,
                ),
              ],
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.black,
                foregroundColor: Colors.white,
                fixedSize: Size.fromHeight(48),
              ),
              onPressed: () {},
              child: Text("Buy now"),
            ),
          ],
        ),
      ),
    );
  }
}
