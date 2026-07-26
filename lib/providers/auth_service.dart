import 'dart:async';

import './mock_data_repo.dart';
import '../models/user.dart';

class AuthService {
  AuthService(this.repo) {
    authStateChanges.listen((event) {
      print("STREAM: $event");
    });
  }
  final MockDataRepo repo;

  final _controller = StreamController<User?>.broadcast();
  Stream<User?> get authStateChanges => _controller.stream;

  Future<String?> login(String pin) async {
    try {
      final result = await repo.login(pin: pin);
      _controller.add(result);
      return null;
    } catch (_) {
      _controller.add(null);
      return "failed to login";
    }
  }

  Future<void> logout() async {
    _controller.add(null);
  }
}
