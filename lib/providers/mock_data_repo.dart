import 'package:flutter/material.dart';
import 'package:state_management_example_yt/models/item.dart';
import 'package:state_management_example_yt/models/user.dart';

/// temp  items management
class MockDataRepo {
  Future<User> login({required String pin}) async {
    await Future.delayed(Durations.long4);
    return User.ui;
  }

  Future<List<Item>> fetchItems({int page = 0}) async {
    await Future.delayed(Durations.long4);
    return [];
  }

  Future<void> checkout() async {
    await Future.delayed(Durations.long4);
  }
}

final List<Item> mockItems = [
  Item(
    id: 1,
    name: "Apple",
    price: 10,
    image: "https://cdn.dummyjson.com/products/images/groceries/Apple/1.png",
  ),
  Item(
    id: 2,
    name: "Beef Steak",
    price: 45,
    image: "https://cdn.dummyjson.com/products/images/groceries/Beef%20Steak/1.png",
  ),
  Item(
    id: 3,
    name: "Cucumber",
    price: 12,
    image: "https://cdn.dummyjson.com/products/images/groceries/Cucumber/1.png",
  ),
  Item(
    id: 4,
    name: "Eggs",
    price: 25,
    image: "https://cdn.dummyjson.com/products/images/groceries/Eggs/1.png",
  ),
  Item(
    id: 5,
    name: "Fish Steak",
    price: 38,
    image: "https://cdn.dummyjson.com/products/images/groceries/Fish%20Steak/1.png",
  ),
  Item(
    id: 6,
    name: "Green Bell Pepper",
    price: 15,
    image: "https://cdn.dummyjson.com/products/images/groceries/Green%20Bell%20Pepper/1.png",
  ),
  Item(
    id: 7,
    name: "Green Chili Pepper",
    price: 10,
    image: "https://cdn.dummyjson.com/products/images/groceries/Green%20Chili%20Pepper/1.png",
  ),
  Item(
    id: 8,
    name: "Honey Jar",
    price: 32,
    image: "https://cdn.dummyjson.com/products/images/groceries/Honey%20Jar/1.png",
  ),
  Item(
    id: 9,
    name: "Ice Cream",
    price: 14,
    image: "https://cdn.dummyjson.com/products/images/groceries/Ice%20Cream/1.png",
  ),
  Item(
    id: 10,
    name: "Juice",
    price: 28,
    image: "https://cdn.dummyjson.com/products/images/groceries/Juice/1.png",
  ),
  Item(
    id: 11,
    name: "Kiwi",
    price: 16,
    image: "https://cdn.dummyjson.com/products/images/groceries/Kiwi/1.png",
  ),
  Item(
    id: 12,
    name: "Lemon",
    price: 8,
    image: "https://cdn.dummyjson.com/products/images/groceries/Lemon/1.png",
  ),
  Item(
    id: 13,
    name: "Milk",
    price: 22,
    image: "https://cdn.dummyjson.com/products/images/groceries/Milk/1.png",
  ),
  Item(
    id: 14,
    name: "Mulberry",
    price: 24,
    image: "https://cdn.dummyjson.com/products/images/groceries/Mulberry/1.png",
  ),
  Item(
    id: 15,
    name: "Strawberry",
    price: 30,
    image: "https://cdn.dummyjson.com/products/images/groceries/Strawberry/1.png",
  ),
  Item(
    id: 16,
    name: "Water",
    price: 5,
    image: "https://cdn.dummyjson.com/products/images/groceries/Water/1.png",
  ),
  Item(
    id: 17,
    name: "Cooking Oil",
    price: 55,
    image: "https://cdn.dummyjson.com/products/images/groceries/Cooking%20Oil/1.png",
  ),
  Item(
    id: 18,
    name: "Cat Food",
    price: 20,
    image: "https://cdn.dummyjson.com/products/images/groceries/Cat%20Food/1.png",
  ),
  Item(
    id: 19,
    name: "Chicken Meat",
    price: 18,
    image: "https://cdn.dummyjson.com/products/images/groceries/Chicken%20Meat/1.png",
  ),
  Item(
    id: 20,
    name: "Dog Food",
    price: 22,
    image: "https://cdn.dummyjson.com/products/images/groceries/Dog%20Food/1.png",
  ),
  ..._newItems,
];

final _newItems = [
  Item(
    id: 40,
    name: "Essence Mascara",
    price: 5,
    image: "https://cdn.dummyjson.com/products/images/beauty/Essence%20Mascara%20Lash%20Princess/1.png",
  ),
  Item(
    id: 41,
    name: "Eyeshadow Palette",
    price: 15,
    image: "https://cdn.dummyjson.com/products/images/beauty/Eyeshadow%20Palette%20with%20Mirror/1.png",
  ),
  Item(
    id: 42,
    name: "Powder Canister",
    price: 12,
    image: "https://cdn.dummyjson.com/products/images/beauty/Powder%20Canister/1.png",
  ),
  Item(
    id: 43,
    name: "Red Lipstick",
    price: 9,
    image: "https://cdn.dummyjson.com/products/images/beauty/Red%20Lipstick/1.png",
  ),
  Item(
    id: 46,
    name: "Dior J'adore",
    price: 89,
    image: "https://cdn.dummyjson.com/products/images/fragrances/Dior%20J'adore/1.png",
  ),
  Item(
    id: 47,
    name: "Dolce Shine Perfume",
    price: 75,
    image: "https://cdn.dummyjson.com/products/images/fragrances/Dolce%20Shine%20Eau%20de/1.png",
  ),
  Item(
    id: 48,
    name: "Gucci Bloom Perfume",
    price: 95,
    image: "https://cdn.dummyjson.com/products/images/fragrances/Gucci%20Bloom%20Eau%20de/1.png",
  ),
  Item(
    id: 49,
    name: "Colombo Bed",
    price: 1499,
    image: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Bed/1.png",
  ),
  Item(
    id: 50,
    name: "Colombo Sofa",
    price: 2499,
    image: "https://cdn.dummyjson.com/products/images/furniture/Annibale%20Colombo%20Sofa/1.png",
  ),
];
