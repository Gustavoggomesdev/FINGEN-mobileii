import 'package:flutter/material.dart';
import 'settings_service.dart';
import '../../core/coordinator/coordinator.dart';
import '../../models/user.dart';

class SettingsViewModel extends ChangeNotifier {
  final SettingsService _service;
  final Coordinator _coordinator;

  SettingsViewModel(this._service, this._coordinator);

  final nameController = TextEditingController();

  User? get currentUser => _service.currentUser;

  void initializeUserData() {
    if (currentUser != null) {
      nameController.text = currentUser!.name;
    }
  }

  Future<void> updateName() async {
    final newName = nameController.text.trim();
    
    if (newName.isEmpty) {
      _coordinator.showSnackBar('Digite um nome válido', isError: true);
      return;
    }

    await _service.updateUserName(newName);
    notifyListeners();
    _coordinator.showSnackBar('Nome atualizado com sucesso!');
  }

  Future<void> logout() async {
    await _service.logout();
    _coordinator.logout();
  }

  @override
  void dispose() {
    nameController.dispose();
    super.dispose();
  }
}