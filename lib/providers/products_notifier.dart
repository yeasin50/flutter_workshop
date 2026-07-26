import 'dart:collection';

import 'package:flutter/material.dart';
import './mock_data_repo.dart';
import '../models/item.dart';

class ProductsNotifier extends ChangeNotifier {
  ProductsNotifier({
    required this.repo,
  }) : _isLoading = false;

  final MockDataRepo repo;

  final List<Item> _items = [];
  List<Item> get items => UnmodifiableListView(_items);

  bool _isLoading;
  bool get isLoading => _isLoading;

  String _error = "";
  bool get hasErr => _error.isNotEmpty;
  String get error => _error;

  Future<void> fetchProducts({bool refresh = false}) async {
    if (isLoading) return;
    _isLoading = true;
    _error = "";
    notifyListeners();

    try {
      final result = await repo.fetchItems();

      if (refresh) _items.clear();
      _items.addAll(result);
      _error = "";
    } catch (e) {
      _error = "failed to load";
    }

    _isLoading = false;
    notifyListeners();
  }
}
