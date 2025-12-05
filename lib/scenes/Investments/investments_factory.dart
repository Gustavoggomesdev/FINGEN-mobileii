import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../services/investment_service.dart';
import '../../services/crypto_api_service.dart';
import '../../services/bank_data_service.dart';
import '../../core/coordinator/coordinator.dart';
import 'investments_service.dart';
import 'investments_view_model.dart';
import 'investments_view.dart';

class InvestmentsFactory {
  static Widget create(BuildContext context) {
    final investmentService = Provider.of<InvestmentService>(context, listen: false);
    final cryptoService = Provider.of<CryptoApiService>(context, listen: false);
    final bankService = Provider.of<BankDataService>(context, listen: false);
    final coordinator = Coordinator(context);
    final service = InvestmentsService(investmentService, cryptoService, bankService);
    final viewModel = InvestmentsViewModel(service, coordinator);

    return ChangeNotifierProvider.value(
      value: viewModel,
      child: const InvestmentsView(),
    );
  }
}