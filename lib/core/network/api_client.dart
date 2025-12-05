import 'dart:convert';
import 'package:http/http.dart' as http;
import 'api_response.dart';

class ApiClient {
  final String baseUrl;
  final Duration timeout;

  ApiClient({
    required this.baseUrl,
    this.timeout = const Duration(seconds: 30),
  });

  Future<ApiResponse<T>> get<T>(
    String endpoint, {
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await http
          .get(
            Uri.parse('$baseUrl$endpoint'),
            headers: headers ?? {'Content-Type': 'application/json'},
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return ApiResponse.error('Erro de conexão: $e');
    }
  }

  Future<ApiResponse<T>> post<T>(
    String endpoint, {
    Map<String, dynamic>? body,
    Map<String, String>? headers,
    T Function(Map<String, dynamic>)? fromJson,
  }) async {
    try {
      final response = await http
          .post(
            Uri.parse('$baseUrl$endpoint'),
            headers: headers ?? {'Content-Type': 'application/json'},
            body: body != null ? json.encode(body) : null,
          )
          .timeout(timeout);

      return _handleResponse<T>(response, fromJson);
    } catch (e) {
      return ApiResponse.error('Erro de conexão: $e');
    }
  }

  ApiResponse<T> _handleResponse<T>(
    http.Response response,
    T Function(Map<String, dynamic>)? fromJson,
  ) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      try {
        final jsonData = json.decode(response.body);
        if (fromJson != null && jsonData is Map<String, dynamic>) {
          return ApiResponse.success(fromJson(jsonData));
        }
        return ApiResponse.success(jsonData as T);
      } catch (e) {
        return ApiResponse.error('Erro ao processar resposta: $e');
      }
    } else {
      return ApiResponse.error(
        'Erro ${response.statusCode}: ${response.body}',
      );
    }
  }
}