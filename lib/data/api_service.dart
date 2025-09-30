// lib/data/services/api_service.dart
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ticket_helpdesk/config/api_config.dart';
import 'package:ticket_helpdesk/data/dto/api_response.dart';
import 'package:ticket_helpdesk/main.dart';
import 'package:ticket_helpdesk/ui/login/view/login_page.dart';

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
    if (response.statusCode == 401 || response.statusCode == 403) {
      navigatorKey.currentState?.pushAndRemoveUntil(
        MaterialPageRoute(builder: (_) => const LoginPage()),
        (route) => false,
      );
    }
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? json.decode(response.body) : response;
    } else {
      final Map<String, dynamic> jsonBody = json.decode(response.body);
      final apiResponse = ApiResponse.fromJson(jsonBody);
      throw ApiException(response.statusCode, apiResponse);
    }
  }
}

class ApiException implements Exception {
  final int statusCode;
  final ApiResponse body;

  ApiException(this.statusCode, this.body);
  String get message => body.message ?? 'Lỗi không xác định';

  @override
  String toString() => message;
}
