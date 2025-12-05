// lib/services/auth_service.dart
import 'dart:convert';
import '../core/storage/secure_storage.dart';
import '../models/user.dart';

class AuthService {
  final _storage = SecureStorage();
  User? _currentUser;

  User? get currentUser => _currentUser;
  bool get isAuthenticated => _currentUser != null;

  Future<bool> login(String email, String password) async {
    await Future.delayed(const Duration(seconds: 2)); // Simula API

    // Simulação de login
    if (email.isNotEmpty && password.length >= 6) {
      _currentUser = User(
        id: '1',
        name: email.split('@')[0],
        email: email,
        totalBalance: 10000.0,
      );

      await _storage.writeSecure('user', json.encode(_currentUser!.toJson()));
      return true;
    }
    return false;
  }

  Future<void> logout() async {
    _currentUser = null;
    await _storage.clearSecure();
  }

  Future<bool> loadUser() async {
    final userData = await _storage.readSecure('user');
    if (userData != null) {
      _currentUser = User.fromJson(json.decode(userData));
      return true;
    }
    return false;
  }

  Future<void> updateUser(User user) async {
    _currentUser = user;
    await _storage.writeSecure('user', json.encode(user.toJson()));
  }

  Future<void> updateUserName(String newName) async {
    if (_currentUser != null) {
      _currentUser = _currentUser!.copyWith(name: newName);
      await _storage.writeSecure('user', json.encode(_currentUser!.toJson()));
    }
  }
}