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

final List<User> mockUserList = [
  User(
    id: '1',
    name: 'Eleanor Shellstrop',
    email: 'eleanor@example.com',
    avatar: 'https://randomuser.me/api/portraits/women/68.jpg',
    address: '321 Fake St, Phoenix, AZ',
    isDark: true,
  ),
  User(
    id: '2',
    name: 'Chidi Anagonye',
    email: 'chidi.a@example.com',
    avatar: 'https://randomuser.me/api/portraits/men/32.jpg',
    address: '456 Ethics Blvd, Paris, France',
    isDark: false,
  ),
  User(
    id: '3',
    name: 'Tahani Al-Jamil',
    email: 'tahani@example.com',
    avatar: 'https://randomuser.me/api/portraits/women/12.jpg',
    address: '101 Mansion Lane, London, UK',
    isDark: true,
  ),
  User(
    id: 'u_004',
    name: 'Jason Mendoza',
    email: 'jason.bortles@example.com',
    avatar: 'https://randomuser.me/api/portraits/men/46.jpg',
    address: '789 Swamp Road, Jacksonville, FL',
    isDark: true,
  ),
  User(
    id: 'u_005',
    name: 'Janet Della-Denunzio',
    email: 'janet.void@example.com',
    avatar: 'https://randomuser.me/api/portraits/women/90.jpg',
    address: 'The Void, Neutral Zone',
    isDark: false,
  ),
];
