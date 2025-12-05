import 'package:flutter/material.dart';
import 'login_service.dart';
import '../../core/coordinator/coordinator.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginService _service;
  final Coordinator _coordinator;

  LoginViewModel(this._service, this._coordinator);

  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  bool _isLoading = false;
  bool get isLoading => _isLoading;

  bool _obscurePassword = true;
  bool get obscurePassword => _obscurePassword;

  void togglePasswordVisibility() {
    _obscurePassword = !_obscurePassword;
    notifyListeners();
  }

  Future<void> login() async {
    final email = emailController.text.trim();
    final password = passwordController.text;

    if (email.isEmpty || password.isEmpty) {
      _coordinator.showSnackBar('Preencha todos os campos', isError: true);
      return;
    }

    _isLoading = true;
    notifyListeners();

    final success = await _service.login(email, password);

    _isLoading = false;
    notifyListeners();

    if (success) {
      _coordinator.navigateToHome();
    } else {
      _coordinator.showSnackBar('Email ou senha inválidos', isError: true);
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}