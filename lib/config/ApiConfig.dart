import 'dart:convert';

class ApiConfig {
  static const String baseUrl = 'http://10.0.2.2:8080/api';
  //static const String baseUrl = 'http://localhost:8080/api';

  static const String username = 'admin';
  static const String password = 'admin';

  // Header cơ bản
  static Map<String, String> get headers {
    String basicAuth =
        'Basic ${base64Encode(utf8.encode('$username:$password'))}';
    return {'Content-Type': 'application/json', 'Authorization': basicAuth};
  }
}
