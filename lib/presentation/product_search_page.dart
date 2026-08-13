import 'package:flutter/material.dart';

import '../providers/mock_data_repo.dart';
import 'widgets/item_view.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage._(this.query);
  final String query;

  static MaterialPageRoute route(String query) {
    //TODO: create providedr and fetch with  `query`
    return MaterialPageRoute(
      builder: (context) {
        return ProductSearchPage._(query);
      },
    );
  }

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.query)),
      body: GridView.builder(
        padding: EdgeInsetsDirectional.all(8),
        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 250,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
        ),
        itemCount: mockItems.length, //TODO: replace with repo
        itemBuilder: (context, index) {
          final item = mockItems[index];
          return ItemView(
            item: item,
            onAdd: () {
              //TODO: add to cart on provider
            },
          );
        },
      ),
    );
  }
}
