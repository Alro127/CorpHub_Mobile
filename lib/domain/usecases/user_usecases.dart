import 'package:ticket_helpdesk/data/repositories/user_repository.dart';
import 'package:ticket_helpdesk/data/dto/name_info.dart';

class UserUseCases {
  final UserRepository repository;
  UserUseCases(this.repository);

  Future<List<NameInfo>> fetchUsersNameInfo() =>
      repository.fetchUsersNameInfo();

  Future fetchMyUser() => repository.fetchMyUser();
}
