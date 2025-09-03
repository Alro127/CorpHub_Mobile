import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/dto/department_dto.dart';

class DepartmentRepository {
  final ApiService api;

  DepartmentRepository(this.api);

  Future<List<DepartmentDto>> fetchDepartment() async {
    try {
      final response = await api.get("/api/department/get-all");
      final List<dynamic> data = response?['data'] ?? [];

      return data.map((json) => DepartmentDto.fromJson(json)).toList();
    } catch (e) {
      // Log hoặc rethrow để ViewModel xử lý
      rethrow;
    }
  }
}
