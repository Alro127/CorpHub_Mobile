import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/domain/models/department_basic_info.dart';

class DepartmentRepository {
  final ApiService api;

  DepartmentRepository(this.api);

  Future<List<DepartmentBasicInfoDto>> fetchDepartment() async {
    try {
      final response = await api.get("/department/get-all");
      final List<dynamic> data = response?['data'] ?? [];

      return data.map((json) => DepartmentBasicInfoDto.fromJson(json)).toList();
    } catch (e) {
      // Log hoặc rethrow để ViewModel xử lý
      rethrow;
    }
  }
}