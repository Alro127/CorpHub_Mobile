import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/data/dto/login_response.dart';


class AuthRepository {
  final ApiService api;

  AuthRepository(this.api);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final jsonResponse = await api.post('/auth/login', loginRequest.toJson());
      final List<dynamic> data = jsonResponse?['data'] ?? [];
      return LoginResponse.fromJson(jsonResponse);
    } catch (e) {
      // Log hoặc throw tiếp nếu muốn ViewModel xử lý
      rethrow;
    }
  }
}