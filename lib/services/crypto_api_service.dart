// lib/services/crypto_api_service.dart
import '../core/network/api_client.dart';
import '../core/network/api_response.dart';

class CryptoApiService {
  final _apiClient = ApiClient(
    baseUrl: 'https://api.coingecko.com/api/v3',
  );

 
  Future<ApiResponse<Map<String, double>>> getCryptoPrices(
    List<String> symbols,
  ) async {
    try {
      final ids = symbols.join(',');
      // Exemplo: "bitcoin,ethereum,binancecoin,cardano,solana"
      final response = await _apiClient.get(
        '/simple/price?ids=$ids&vs_currencies=brl',
      );

      if (response.isSuccess && response.data != null) {
        final prices = <String, double>{};
        final data = response.data as Map<String, dynamic>;

        // Extrai apenas o valor em BRL de cada moeda
        data.forEach((key, value) {
          if (value is Map && value.containsKey('brl')) {
            prices[key] = (value['brl'] as num).toDouble();
          }
        });

        return ApiResponse.success(prices);
      }

      return ApiResponse.error('Erro ao buscar preços');
    } catch (e) {
      return ApiResponse.error('Erro: $e');
    }
  }

  
  Map<String, double> getMockPrices() {
    return {
      'bitcoin': 485000.0,       
      'ethereum': 25000.0,       
      'binancecoin': 1850.0,     
      'cardano': 2.5,          
      'solana': 650.0,          
    };
  }
}