import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../core/coordinator/coordinator.dart';
import 'settings_service.dart';
import 'settings_view_model.dart';
import 'settings_view.dart';

class SettingsFactory {
  static Widget create(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final coordinator = Coordinator(context);
    final service = SettingsService(authService);
    final viewModel = SettingsViewModel(service, coordinator);
    viewModel.initializeUserData();

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const SettingsView(),
    );
  }
}