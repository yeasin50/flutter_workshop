import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../models/item.dart';

class ItemView extends StatelessWidget {
  const ItemView({
    super.key,
    required this.item,
    this.onAdd,
    this.onRemove,
  });
  final Item item;
  final VoidCallback? onAdd;
  final VoidCallback? onRemove;

  @override
  Widget build(BuildContext context) {
    final textStyle = TextTheme.of(context);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          spacing: 6,
          crossAxisAlignment: .stretch,
          children: [
            Expanded(
              child: CachedNetworkImage(imageUrl: item.image, fit: BoxFit.cover),
            ),
            Text(item.name, style: textStyle.bodyMedium),
            Row(
              spacing: 16,
              mainAxisSize: .min,
              children: [
                Text(
                  "\$${item.price} ${item.quantity == 0 ? "" : "x ${item.quantity}"}",
                  style: textStyle.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
                ),
                Spacer(),
                if (onAdd != null)
                  IconButton.filledTonal(
                    onPressed: onAdd,
                    icon: Icon(Icons.add),
                  ),

                if (onRemove != null)
                  IconButton.filledTonal(
                    onPressed: onRemove,
                    icon: Icon(Icons.remove),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
