import 'dart:collection';

import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/user.dart';
import 'mock_data_repo.dart';

class CartsNotifier extends ChangeNotifier {
  CartsNotifier({
    required this.repo,
  }) : _isLoading = true;

  final MockDataRepo repo;
  final Set<Item> _items = {};
  Set<Item> get items => UnmodifiableSetView(_items);

  bool _isLoading;
  bool get isLoading => _isLoading;

  void add(Item item) {
    final existing = _items.lookup(item);

    if (existing != null) {
      _items
        ..remove(existing)
        ..add(existing.copyWith(quantity: existing.quantity + 1));
    } else {
      _items.add(item);
    }

    notifyListeners();
  }

  Future<void> checkout(User user) async {
    _isLoading = true;
    notifyListeners();
    await Future.delayed(Duration(seconds: 4));
    try {
      await repo.checkout(user, items);
      _items.clear();
    } catch (_) {}

    _isLoading = false;
    notifyListeners();
  }

  void remove(Item item) {
    _items.remove(item);
    notifyListeners();
  }
}
