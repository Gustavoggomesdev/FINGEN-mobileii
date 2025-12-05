// lib/services/investment_service.dart
import 'dart:convert';
import '../core/storage/secure_storage.dart';
import '../models/investment.dart';
import '../models/bank_investment.dart';
import '../models/crypto_investment.dart';
import 'auth_service.dart';

class InvestmentService {
  final AuthService _authService;
  final _storage = SecureStorage();
  List<Investment> _investments = [];

  InvestmentService(this._authService);

  List<Investment> get investments => _investments;

  double get totalInvested {
    return _investments.fold(0, (sum, inv) => sum + inv.amount);
  }

  double get availableBalance {
    final user = _authService.currentUser;
    if (user == null) return 0;
    return user.totalBalance - totalInvested;
  }

  Future<void> loadInvestments() async {
    final data = await _storage.read('investments_${_authService.currentUser?.id}');
    if (data != null) {
      final List<dynamic> jsonList = json.decode(data);
      _investments = jsonList.map((json) {
        if (json['type'] == 'bank') {
          return BankInvestment.fromJson(json);
        } else {
          return CryptoInvestment.fromJson(json);
        }
      }).toList();
    }
  }

  Future<void> addInvestment(Investment investment) async {
    _investments.add(investment);
    await _saveInvestments();
  }

  Future<void> updateInvestment(String id, double newAmount) async {
    final index = _investments.indexWhere((inv) => inv.id == id);
    if (index != -1) {
      _investments[index].amount = newAmount;
      await _saveInvestments();
    }
  }

  Future<void> removeInvestment(String id) async {
    _investments.removeWhere((inv) => inv.id == id);
    await _saveInvestments();
  }

  Future<void> _saveInvestments() async {
    final jsonList = _investments.map((inv) => inv.toJson()).toList();
    await _storage.write(
      'investments_${_authService.currentUser?.id}',
      json.encode(jsonList),
    );
  }

  Investment? getInvestmentById(String id) {
    try {
      return _investments.firstWhere((inv) => inv.id == id);
    } catch (e) {
      return null;
    }
  }
}