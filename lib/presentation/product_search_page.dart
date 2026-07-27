import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:state_management_example_yt/models/item.dart';

import '../providers/mock_data_repo.dart';
import 'widgets/item_view.dart';

class ProductSearchPage extends StatefulWidget {
  const ProductSearchPage._(this.query);
  final String query;

  static MaterialPageRoute route(String query) {
    return MaterialPageRoute(
      builder: (context) {
        return FutureProvider<List<Item>>(
          initialData: [],
          create: (context) {
            //NOTE: I don't prefer using FutureProvider for not having loading & error flexibility
            // use ChangeNotifier or even FutureBuilder just works fine but have to pass down the data
            return context.read<MockDataRepo>().search(query: query);
          },
          child: ProductSearchPage._(query),
          builder: (context, child) {
            return child!;
          },
        );
      },
    );
  }

  @override
  State<ProductSearchPage> createState() => _ProductSearchPageState();
}

class _ProductSearchPageState extends State<ProductSearchPage> {
  @override
  Widget build(BuildContext context) {
    final items = context.watch<List<Item>>();
    return Scaffold(
      appBar: AppBar(title: Text(widget.query)),
      body: items.isEmpty
          ? Center(child: Text("No product found"))
          : GridView.builder(
              padding: EdgeInsetsDirectional.all(8),
              gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                mainAxisSpacing: 16,
                crossAxisSpacing: 16,
              ),
              itemCount: items.length,
              itemBuilder: (context, index) {
                final item = items[index];
                return ItemView(
                  item: item,
                  onAdd: () {
                    //TODO: add to cart on provider DO  IT :)
                  },
                );
              },
            ),
    );
  }
}
