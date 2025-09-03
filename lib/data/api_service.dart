// lib/data/services/api_service.dart
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticket_helpdesk/config/ApiConfig.dart';

class ApiService {
  final String baseUrl;
  final ApiConfig api;

  ApiService(this.api, {String? baseUrlOverride})
    : baseUrl = baseUrlOverride ?? ApiConfig.baseUrl;

  Future<dynamic> get(String endpoint) async {
    print(Uri.parse('$baseUrl$endpoint'));
    final response = await http.get(
      Uri.parse('$baseUrl$endpoint'),
      headers: await api.getHeaders(true),
    );
    return _processResponse(response);
  }

  Future<dynamic> post(String endpoint, dynamic body, bool isAuth) async {
    final response = await http.post(
      Uri.parse('$baseUrl$endpoint'),
      headers: await api.getHeaders(isAuth),
      body: json.encode(body),
    );
    print(response.body);
    return _processResponse(response);
  }

  Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('$baseUrl$endpoint'),
      headers: await api.getHeaders(true),
    );
    print(response.body);
    return _processResponse(response);
  }

  dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? json.decode(response.body) : null;
    } else {
      throw ApiException(response.statusCode, response.body);
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final String body;

  ApiException(this.statusCode, this.body);

  @override
  String toString() => 'ApiException($statusCode): $body';
}
