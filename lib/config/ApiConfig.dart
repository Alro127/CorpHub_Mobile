import 'dart:convert';

import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';

class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8080';
  //static const String baseUrl = 'http://localhost:8080/api';

  final SecureStorageService secureStorageService;

  ApiConfig(this.secureStorageService);

  Future<Map<String, String>> getHeaders(isAuth) async {
    final token = await secureStorageService.getToken();

    return {
      'Content-Type': 'application/json',
      if (isAuth) 'Authorization': 'Bearer $token',
    };
  }
}
