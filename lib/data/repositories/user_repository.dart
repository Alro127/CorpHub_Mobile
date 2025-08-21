import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/domain/models/name_info.dart';

class UserRepository {
  /// Lấy danh sách thông tin tên user
  Future<List<NameInfo>> fetchUsersNameInfo() async {
    try {
      final response = await ApiService.get("/user/name-info");
      final List<dynamic> data = response['data'] ?? [];

      if (data.isEmpty) {
        return [];
      }

      return data.map((json) => NameInfo.fromJson(json)).toList();
    } catch (e) {
      // Có thể log lỗi tại đây
      rethrow;
    }
  }
}

