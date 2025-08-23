
import 'package:ticket_helpdesk/data/repositories/department_repository.dart';
import 'package:ticket_helpdesk/domain/models/department_basic_info.dart';

class DepartmentUsecase {
  final DepartmentRepository repository;
  DepartmentUsecase(this.repository);

  Future<List<DepartmentBasicInfoDto>> fetchDepartment () => repository.fetchDepartment();

}