// lib/models/crypto_investment.dart
import 'investment.dart';

class CryptoInvestment extends Investment {
  final String symbol;
  double currentPrice;
  final double purchasePrice;

  CryptoInvestment({
    required super.id,
    required super.name,
    required super.amount,
    required this.symbol,
    required this.currentPrice,
    required this.purchasePrice,
  }) : super(type: InvestmentType.crypto);

  factory CryptoInvestment.fromJson(Map<String, dynamic> json) {
    return CryptoInvestment(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      symbol: json['symbol'] as String,
      currentPrice: (json['currentPrice'] as num).toDouble(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'symbol': symbol,
      'currentPrice': currentPrice,
      'purchasePrice': purchasePrice,
      'type': 'crypto',
    };
  }

  @override
  // ======== CÁLCULO DE VALOR ATUAL - PREÇO DO MERCADO ========
  // Fórmula: (amount / purchasePrice) * currentPrice
  //
  // Passo 1: Calcular quantidade de moedas
  // quantity = amount / purchasePrice
  // 
  // Passo 2: Calcular valor atual
  // currentValue = quantity * currentPrice
  //
  // Exemplo: 
  // - amount (investimento) = 1000
  // - purchasePrice (preço de compra) = 100
  // - currentPrice (preço agora) = 200
  // - Quantidade: 1000 / 100 = 10 moedas
  // - Valor atual: 10 * 200 = 2000
  // - Resultado: R$ 2.000 (lucro de R$ 1.000)
  double getCurrentValue() {
    final quantity = amount / purchasePrice;
    return quantity * currentPrice;
  }

  // ======== CÁLCULO DE LUCRO/PREJUÍZO ABSOLUTO ========
  // Fórmula: getCurrentValue() - amount
  // Exemplo: 2000 - 1000 = 1000 (lucro de R$ 1.000)
  double getProfitLoss() {
    return getCurrentValue() - amount;
  }

  // ======== CÁLCULO DE LUCRO/PREJUÍZO PERCENTUAL ========
  // Fórmula: ((getCurrentValue() - amount) / amount) * 100
  // Exemplo: ((2000 - 1000) / 1000) * 100 = (1000 / 1000) * 100 = 100%
  double getProfitLossPercentage() {
    return ((getCurrentValue() - amount) / amount) * 100;
  }

  CryptoInvestment copyWith({
    String? id,
    String? name,
    double? amount,
    String? symbol,
    double? currentPrice,
    double? purchasePrice,
  }) {
    return CryptoInvestment(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      symbol: symbol ?? this.symbol,
      currentPrice: currentPrice ?? this.currentPrice,
      purchasePrice: purchasePrice ?? this.purchasePrice,
    );
  }
}