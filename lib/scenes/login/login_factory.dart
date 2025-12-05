import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../core/coordinator/coordinator.dart';
import 'login_service.dart';
import 'login_view_model.dart';
import 'login_view.dart';

class LoginFactory {
  static Widget create(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final coordinator = Coordinator(context);
    final service = LoginService(authService);
    final viewModel = LoginViewModel(service, coordinator);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const LoginView(),
    );
  }
}