// lib/data/repositories/user_repository.dart
import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/domain/models/name_info.dart';

class UserRepository {
  final ApiService api;

  UserRepository(this.api);

  /// Lấy danh sách thông tin tên user
  Future<List<NameInfo>> fetchUsersNameInfo() async {
    try {
      final response = await api.get("/user/name-info");
      final List<dynamic> data = response?['data'] ?? [];

      return data.map((json) => NameInfo.fromJson(json)).toList();
    } catch (e) {
      // Log hoặc rethrow để ViewModel xử lý
      rethrow;
    }
  }
}
