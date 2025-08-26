import 'package:ticket_helpdesk/config/ApiConfig.dart';
import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/data/dto/login_response.dart';

class AuthRepository {
  final ApiService api;

  AuthRepository(this.api);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final jsonResponse = await api.post('/auth/login', loginRequest.toJson());
      final data = jsonResponse?['data'] ?? [];
      ApiConfig.jwtToken = data['token'] ?? '';
      print(data['token']);
      return LoginResponse.fromJson(data);
    } catch (e) {
      // Log hoặc throw tiếp nếu muốn ViewModel xử lý
      rethrow;
    }
  }
}
