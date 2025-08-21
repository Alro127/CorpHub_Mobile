import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:ticket_helpdesk/config/ApiConfig.dart';

class ApiService {
  static Future<dynamic> get(String endpoint) async {
    final response = await http.get(
      Uri.parse('${ApiConfig.baseUrl}$endpoint'),
      headers: ApiConfig.headers,
    );
    return _processResponse(response);
  }

  static Future<dynamic> post(String endpoint, dynamic body) async {
    final response = await http.post(
      Uri.parse('${ApiConfig.baseUrl}$endpoint'),
      headers: ApiConfig.headers,
      body: json.encode(body),
    );
    return _processResponse(response);
  }

  static Future<dynamic> delete(String endpoint) async {
    final response = await http.delete(
      Uri.parse('${ApiConfig.baseUrl}$endpoint'),
      headers: ApiConfig.headers,
    );
    return _processResponse(response);
  }

  static dynamic _processResponse(http.Response response) {
    if (response.statusCode >= 200 && response.statusCode < 300) {
      return response.body.isNotEmpty ? json.decode(response.body) : null;
    } else {
      throw Exception('Error ${response.statusCode}: ${response.body}');
    }
  }
}
