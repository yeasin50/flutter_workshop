import 'dart:collection';
import 'package:collection/collection.dart';
import 'package:flutter/material.dart';

import '../models/item.dart';
import '../models/user.dart';
import 'mock_data_repo.dart';

/// somehow I need to show with Map,List but when
class CartsNotifier extends ChangeNotifier {
  CartsNotifier({required this.repo}) : _isLoading = true;

  final MockDataRepo repo;
  final Set<Item> _items = {};
  Set<Item> get items => UnmodifiableSetView(_items);

  int get count => _items.length;

  bool _isLoading;
  bool get isLoading => _isLoading;

  void add(Item item) {
    final existing = _items.firstWhereOrNull((e) => e.id == item.id);
    if (existing != null) {
      _items
        ..remove(existing)
        ..add(existing.copyWith(quantity: existing.quantity + 1));
    } else {
      _items.add(item.copyWith(quantity: 1));
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

  int calucatePrice() {
    return items.fold(0, (pre, e) => pre + (e.price * e.quantity));
  }
}
