// lib/models/investment.dart
enum InvestmentType {
  bank,
  crypto,
}

abstract class Investment {
  final String id;
  final String name;
  double amount;
  final InvestmentType type;

  Investment({
    required this.id,
    required this.name,
    required this.amount,
    required this.type,
  });

  Map<String, dynamic> toJson();
  double getCurrentValue();
}