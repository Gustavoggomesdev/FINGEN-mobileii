import 'package:flutter/material.dart';
import 'home_service.dart';
import '../../core/coordinator/coordinator.dart';
import '../../models/user.dart';
import '../../models/investment.dart';

class HomeViewModel extends ChangeNotifier {
  final HomeService _service;
  final Coordinator _coordinator;

  HomeViewModel(this._service, this._coordinator) {
    _loadData();
  }

  bool _isLoading = true;
  bool get isLoading => _isLoading;

  bool _isRefreshing = false;
  bool get isRefreshing => _isRefreshing;

  User? get currentUser => _service.currentUser;
  List<Investment> get investments => _service.investments;
  double get totalInvested => _service.totalInvested;

  Future<void> _loadData() async {
    _isLoading = true;
    notifyListeners();

    await _service.loadData();

    _isLoading = false;
    notifyListeners();
  }

  Future<void> refreshBalances() async {
    _isRefreshing = true;
    notifyListeners();

    await _service.refreshBalances();
    await _service.loadData();

    _isRefreshing = false;
    notifyListeners();

    _coordinator.showSnackBar('Saldos atualizados com sucesso!');
  }

  Future<void> addBalance(double amount) async {
    await _service.addBalance(amount);
    notifyListeners();
    _coordinator.showSnackBar('Saldo adicionado com sucesso!');
  }

  Future<void> removeBalance(double amount) async {
    final available = currentUser?.totalBalance ?? 0;
    if (amount > available) {
      _coordinator.showSnackBar('Saldo insuficiente', isError: true);
      return;
    }
    await _service.removeBalance(amount);
    notifyListeners();
    _coordinator.showSnackBar('Saldo removido com sucesso!');
  }
}