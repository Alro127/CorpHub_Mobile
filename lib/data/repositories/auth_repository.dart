import 'package:ticket_helpdesk/config/ApiConfig.dart';
import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/data/dto/login_response.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';

class AuthRepository {
  final ApiService api;
  final SecureStorageService secureStorageService;

  AuthRepository(this.api, this.secureStorageService);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      print("hello");
      final jsonResponse = await api.post(
        '/auth/login',
        loginRequest.toJson(),
        false,
      );
      final data = jsonResponse?['data'] ?? [];
      print(data);
      secureStorageService.saveToken(data['token']);
      return LoginResponse.fromJson(data);
    } catch (e) {
      // Log hoặc throw tiếp nếu muốn ViewModel xử lý
      rethrow;
    }
  }
}
