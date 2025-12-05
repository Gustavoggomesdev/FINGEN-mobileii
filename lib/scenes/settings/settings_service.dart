// ============ SETTINGS SERVICE ============
// lib/scenes/settings/settings_service.dart
import '../../services/auth_service.dart';
import '../../models/user.dart';

class SettingsService {
  final AuthService _authService;

  SettingsService(this._authService);

  User? get currentUser => _authService.currentUser;

  Future<void> updateUserName(String newName) async {
    await _authService.updateUserName(newName);
  }

  Future<void> logout() async {
    await _authService.logout();
  }
}