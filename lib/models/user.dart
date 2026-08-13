class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.avatar,
    required this.address,
    this.isDark = true,
  });

  final String id;
  final String name;
  final String email;
  final String avatar;
  final String address;
  final bool isDark;

  static const User ui = User(
    id: 'u_000',
    name: 'Rose',
    email: 'rose.ui@example.com',
    avatar: 'https://randomuser.me/api/portraits/women/44.jpg',
    address: '123 Floral Street, Garden City, NY',
    isDark: false,
  );

  @override
  String toString() {
    return 'User(id: $id, name: $name, email: $email, isDark: $isDark, address: $address)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        other is User &&
            id == other.id &&
            name == other.name &&
            email == other.email &&
            avatar == other.avatar &&
            address == other.address &&
            isDark == other.isDark;
  }

  @override
  int get hashCode => Object.hash(
    id,
    name,
    email,
    avatar,
    address,
    isDark,
  );
}
