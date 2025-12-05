// lib/scenes/home/home_service.dart
import '../../services/auth_service.dart';
import '../../services/investment_service.dart';
import '../../models/user.dart';
import '../../models/investment.dart';

class HomeService {
  final AuthService _authService;
  final InvestmentService _investmentService;

  HomeService(this._authService, this._investmentService);

  User? get currentUser => _authService.currentUser;
  List<Investment> get investments => _investmentService.investments;
  double get totalInvested => _investmentService.totalInvested;

  Future<void> loadData() async {
    await _investmentService.loadInvestments();
  }

  Future<void> addBalance(double amount) async {
    final user = _authService.currentUser;
    if (user != null) {
      final updatedUser = user.copyWith(
        totalBalance: user.totalBalance + amount,
      );
      await _authService.updateUser(updatedUser);
    }
  }

  Future<void> removeBalance(double amount) async {
    final user = _authService.currentUser;
    if (user != null && user.totalBalance >= amount) {
      final updatedUser = user.copyWith(
        totalBalance: user.totalBalance - amount,
      );
      await _authService.updateUser(updatedUser);
    }
  }

  Future<void> refreshBalances() async {
    await _investmentService.loadInvestments();
    
    double totalCurrent = 0;
    for (var investment in investments) {
      totalCurrent += investment.getCurrentValue();
    }

    final user = _authService.currentUser;
    if (user != null) {
      final availableBalance = user.totalBalance - totalInvested;
      final newTotal = availableBalance + totalCurrent;
      final updatedUser = user.copyWith(totalBalance: newTotal);
      await _authService.updateUser(updatedUser);
    }
  }
}