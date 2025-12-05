// lib/models/bank_investment.dart
import 'investment.dart';

class BankInvestment extends Investment {
  final String bankName;
  final double cdiPercentage;

  BankInvestment({
    required super.id,
    required super.name,
    required super.amount,
    required this.bankName,
    required this.cdiPercentage,
  }) : super(type: InvestmentType.bank);

  factory BankInvestment.fromJson(Map<String, dynamic> json) {
    return BankInvestment(
      id: json['id'] as String,
      name: json['name'] as String,
      amount: (json['amount'] as num).toDouble(),
      bankName: json['bankName'] as String,
      cdiPercentage: (json['cdiPercentage'] as num).toDouble(),
    );
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'amount': amount,
      'bankName': bankName,
      'cdiPercentage': cdiPercentage,
      'type': 'bank',
    };
  }

  @override
  // ======== CÁLCULO DE RENDIMENTO - PROJEÇÃO EM 1 ANO ========
  // Fórmula: amount * (1 + (cdiPercentage / 100))
  // 
  // Exemplo: 
  // - amount = 1000
  // - cdiPercentage = 100
  // - Cálculo: 1000 * (1 + (100 / 100)) = 1000 * (1 + 1) = 1000 * 2 = 2000
  // - Resultado: R$ 2.000 (rendimento de R$ 1.000)
  //
  // Cada percentual adicional ao CDI aumenta o rendimento
  // Se CDI = 110%, então: 1000 * (1 + 1.10) = 2100
  double getCurrentValue() {
    return amount * (1 + (cdiPercentage / 100));
  }

  BankInvestment copyWith({
    String? id,
    String? name,
    double? amount,
    String? bankName,
    double? cdiPercentage,
  }) {
    return BankInvestment(
      id: id ?? this.id,
      name: name ?? this.name,
      amount: amount ?? this.amount,
      bankName: bankName ?? this.bankName,
      cdiPercentage: cdiPercentage ?? this.cdiPercentage,
    );
  }
}