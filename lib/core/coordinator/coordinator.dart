import 'package:flutter/material.dart';

class Coordinator {
  final BuildContext context;

  Coordinator(this.context);

  // Navegação
  void navigateTo(String route, {Object? arguments}) {
    Navigator.pushNamed(context, route, arguments: arguments);
  }

  void navigateToAndRemoveUntil(String route, {Object? arguments}) {
    Navigator.pushNamedAndRemoveUntil(
      context,
      route,
      (route) => false,
      arguments: arguments,
    );
  }

  void pop([Object? result]) {
    Navigator.pop(context, result);
  }

  // Feedback
  void showSnackBar(String message, {bool isError = false}) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: isError ? Colors.red : Colors.green,
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  void showCustomDialog({
    required Widget dialog,
  }) {
    showDialog(
      context: context,
      builder: (_) => dialog,
    );
  }

  // Navegação para Home (após login)
  void navigateToHome() {
    navigateToAndRemoveUntil('/home');
  }

  // Logout
  void logout() {
    navigateToAndRemoveUntil('/');
  }
}