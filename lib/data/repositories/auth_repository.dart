import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/data/dto/login_response.dart';
import 'package:ticket_helpdesk/data/dto/api_response.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';

class AuthRepository {
  final ApiService api;
  final SecureStorageService secureStorageService;

  AuthRepository(this.api, this.secureStorageService);

  Future<LoginResponse> login(LoginRequest loginRequest) async {
    try {
      final jsonResponse = await api.post(
        '/auth/login',
        loginRequest.toJson(),
        false,
      );

      // backend trả về {"status":200,"message":"OK","timestamp":"...","data":{...}}
      final data = jsonResponse?['data'];
      if (data == null) {
        throw Exception("Không có dữ liệu trả về từ server");
      }

      // lưu token vào secure storage
      await secureStorageService.saveToken(data['token']);

      return LoginResponse.fromJson(data);
    } catch (e) {
      if (e is ApiException) {
        rethrow;
      }
      // nếu là lỗi khác (network, parse)
      throw Exception("Lỗi kết nối server hoặc dữ liệu không hợp lệ");
    }
  }
}
