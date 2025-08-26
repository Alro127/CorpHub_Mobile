import 'dart:convert';

class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8080';
  //static const String baseUrl = 'http://localhost:8080/api';

  static String? jwtToken; // Lưu token sau khi login

  static Map<String, String> get headers {
    return {
      'Content-Type': 'application/json',
      if (jwtToken != null) 'Authorization': 'Bearer $jwtToken',
    };
  }
}
