// lib/services/bank_data_service.dart
import '../models/bank_investment.dart';

class BankDataService {
  // ======== BANCOS DISPONÍVEIS COM SEUS CDI ========
  // CDI (Certificado de Depósito Interbancário) é o rendimento anual
  // Quanto maior o %, maior o rendimento anual esperado
  // 
  // Cada banco oferece um % diferente do CDI
  // Exemplos com investimento de R$ 1.000:
  // - Nubank (100% CDI) → 1000 * 1.00 = R$ 2.000 em 1 ano
  // - Inter (105% CDI) → 1000 * 1.05 = R$ 2.050 em 1 ano
  // - BTG (110% CDI) → 1000 * 1.10 = R$ 2.100 em 1 ano
  List<BankInvestment> getAvailableBanks() {
    return [
      // Nubank: 100% CDI (rendimento padrão)
      BankInvestment(
        id: 'nubank',
        name: 'Nubank CDB',
        amount: 0,
        bankName: 'Nubank',
        cdiPercentage: 100.0,
      ),
      // Banco Inter: 105% CDI (5% acima do padrão)
      BankInvestment(
        id: 'inter',
        name: 'Inter CDB',
        amount: 0,
        bankName: 'Banco Inter',
        cdiPercentage: 105.0,
      ),
      // BTG Pactual: 110% CDI (10% acima do padrão - melhor rendimento)
      BankInvestment(
        id: 'btg',
        name: 'BTG Pactual CDB',
        amount: 0,
        bankName: 'BTG Pactual',
        cdiPercentage: 110.0,
      ),
      // XP Investimentos: 108% CDI
      BankInvestment(
        id: 'xp',
        name: 'XP CDB',
        amount: 0,
        bankName: 'XP Investimentos',
        cdiPercentage: 108.0,
      ),
      // Itaú: 95% CDI (5% abaixo do padrão - menor rendimento)
      BankInvestment(
        id: 'itau',
        name: 'Itaú CDB',
        amount: 0,
        bankName: 'Itaú',
        cdiPercentage: 95.0,
      ),
    ];
  }

  Map<String, String> getBankLogos() {
    return {
      'nubank': '🟣',
      'inter': '🟠',
      'btg': '⚫',
      'xp': '🔵',
      'itau': '🔶',
    };
  }
}