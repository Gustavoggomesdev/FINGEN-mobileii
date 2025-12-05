// ============ INVESTMENTS SERVICE ============
// lib/scenes/investments/investments_service.dart
import '../../services/investment_service.dart';
import '../../services/crypto_api_service.dart';
import '../../services/bank_data_service.dart';
import '../../models/bank_investment.dart';
import '../../models/crypto_investment.dart';

class InvestmentsService {
  final InvestmentService _investmentService;
  final CryptoApiService _cryptoService;
  final BankDataService _bankService;

  InvestmentsService(
    this._investmentService,
    this._cryptoService,
    this._bankService,
  );

  double get availableBalance => _investmentService.availableBalance;

  List<BankInvestment> getAvailableBanks() {
    final banks = _bankService.getAvailableBanks();
    return banks.map((bank) {
      final existing = _investmentService.getInvestmentById(bank.id);
      if (existing != null) {
        return bank.copyWith(amount: existing.amount);
      }
      return bank;
    }).toList();
  }

  Future<List<CryptoInvestment>> getAvailableCryptos() async {
    final cryptos = [
      {'id': 'bitcoin', 'name': 'Bitcoin', 'symbol': 'BTC'},
      {'id': 'ethereum', 'name': 'Ethereum', 'symbol': 'ETH'},
      {'id': 'binancecoin', 'name': 'Binance Coin', 'symbol': 'BNB'},
      {'id': 'cardano', 'name': 'Cardano', 'symbol': 'ADA'},
      {'id': 'solana', 'name': 'Solana', 'symbol': 'SOL'},
    ];

    final prices = await _getCryptoPrices(
      cryptos.map((e) => e['id'] as String).toList(),
    );

    return cryptos.map((crypto) {
      final id = crypto['id'] as String;
      final price = prices[id] ?? 0.0;
      final existing = _investmentService.getInvestmentById(id);

      return CryptoInvestment(
        id: id,
        name: crypto['name'] as String,
        amount: existing?.amount ?? 0,
        symbol: crypto['symbol'] as String,
        currentPrice: price,
        purchasePrice: price,
      );
    }).toList();
  }

  Future<Map<String, double>> _getCryptoPrices(List<String> ids) async {
    final response = await _cryptoService.getCryptoPrices(ids);
    if (response.isSuccess && response.data != null) {
      return response.data!;
    }
    return _cryptoService.getMockPrices();
  }

  Future<void> addInvestment(String id, double amount, bool isCrypto) async {
    final existing = _investmentService.getInvestmentById(id);
    
    if (existing != null) {
      // Soma o novo valor ao investimento existente
      final newAmount = existing.amount + amount;
      await _investmentService.updateInvestment(id, newAmount);
    } else {
      if (isCrypto) {
        final cryptos = await getAvailableCryptos();
        final crypto = cryptos.firstWhere((c) => c.id == id);
        final newCrypto = crypto.copyWith(amount: amount);
        await _investmentService.addInvestment(newCrypto);
      } else {
        final banks = getAvailableBanks();
        final bank = banks.firstWhere((b) => b.id == id);
        final newBank = bank.copyWith(amount: amount);
        await _investmentService.addInvestment(newBank);
      }
    }
  }

  Future<void> removeInvestment(String id, double amount) async {
    final existing = _investmentService.getInvestmentById(id);
    
    if (existing != null) {
      final newAmount = existing.amount - amount;
      if (newAmount <= 0) {
        await _investmentService.removeInvestment(id);
      } else {
        await _investmentService.updateInvestment(id, newAmount);
      }
    }
  }
}