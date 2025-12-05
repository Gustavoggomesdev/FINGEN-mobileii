import 'package:flutter/material.dart';
import 'investments_service.dart';
import '../../core/coordinator/coordinator.dart';
import '../../models/bank_investment.dart';
import '../../models/crypto_investment.dart';

class InvestmentsViewModel extends ChangeNotifier {
  final InvestmentsService _service;
  final Coordinator _coordinator;

  InvestmentsViewModel(this._service, this._coordinator) {
    _loadData();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  List<BankInvestment> _banks = [];
  List<BankInvestment> get banks => _banks;

  List<CryptoInvestment> _cryptos = [];
  List<CryptoInvestment> get cryptos => _cryptos;

  double get availableBalance => _service.availableBalance;

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    _banks = _service.getAvailableBanks();
    _cryptos = await _service.getAvailableCryptos();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> addInvestment(
    String id,
    double amount,
    bool isCrypto,
  ) async {
    if (amount > availableBalance) {
      _coordinator.showSnackBar('Saldo insuficiente', isError: true);
      return;
    }

    await _service.addInvestment(id, amount, isCrypto);
    await _loadData();
    _coordinator.showSnackBar('Investimento adicionado com sucesso!');
  }

  Future<void> removeInvestment(String id, double amount) async {
    await _service.removeInvestment(id, amount);
    await _loadData();
    _coordinator.showSnackBar('Investimento removido com sucesso!');
  }

  Future<void> refresh() async {
    await _loadData();
  }
}