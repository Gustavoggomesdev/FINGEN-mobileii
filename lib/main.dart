import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'app/app.dart';
import 'services/auth_service.dart';
import 'services/investment_service.dart';
import 'services/crypto_api_service.dart';
import 'services/bank_data_service.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        Provider<AuthService>(create: (_) => AuthService()),
        Provider<CryptoApiService>(create: (_) => CryptoApiService()),
        Provider<BankDataService>(create: (_) => BankDataService()),
        ProxyProvider<AuthService, InvestmentService>(
          update: (_, auth, __) => InvestmentService(auth),
        ),
      ],
      child: const MyApp(),
    ),
  );
}