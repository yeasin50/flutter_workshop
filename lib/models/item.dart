class Item {
  const Item({
    required this.id,
    required this.name,
    required this.price,
    required this.image,
    this.quantity = 0,
  });

  final int id;
  final String name;
  final int price;
  final String image;
  final int quantity;

  static Item ui = Item(id: 0, name: "Banana", price: 10, image: "");

  @override
  String toString() {
    return "Item(name: $name, price$price, image:$image, quantity: $quantity)";
  }

  // better would have using equality
  Item copyWith({String? name, int? quantity}) {
    return Item(
      id: id,
      name: name ?? this.name,
      quantity: quantity ?? this.quantity,
      price: price,
      image: image,
    );
  }
}
