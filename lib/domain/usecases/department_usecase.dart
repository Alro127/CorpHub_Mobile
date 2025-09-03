import 'package:ticket_helpdesk/data/repositories/department_repository.dart';
import 'package:ticket_helpdesk/data/dto/department_dto.dart';

class DepartmentUsecase {
  final DepartmentRepository repository;
  DepartmentUsecase(this.repository);

  Future<List<DepartmentDto>> fetchDepartment() => repository.fetchDepartment();
}
