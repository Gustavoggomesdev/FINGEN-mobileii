// lib/scenes/login/login_service.dart
import '../../services/auth_service.dart';

class LoginService {
  final AuthService _authService;

  LoginService(this._authService);

  Future<bool> login(String email, String password) async {
    return await _authService.login(email, password);
  }
}