import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/auth_service.dart';
import '../../services/investment_service.dart';
import '../../core/coordinator/coordinator.dart';
import 'home_service.dart';
import 'home_view_model.dart';
import 'home_view.dart';

class HomeFactory {
  static Widget create(BuildContext context) {
    final authService = Provider.of<AuthService>(context, listen: false);
    final investmentService = Provider.of<InvestmentService>(context, listen: false);
    final coordinator = Coordinator(context);
    final service = HomeService(authService, investmentService);
    final viewModel = HomeViewModel(service, coordinator);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const HomeView(),
    );
  }
}