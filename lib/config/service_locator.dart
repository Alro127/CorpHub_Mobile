import 'package:get_it/get_it.dart';
import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/data/repositories/user_repository.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // Đăng ký các repository
  getIt.registerLazySingleton<UserRepository>(() => UserRepository());
  getIt.registerLazySingleton<TicketRepository>(() => TicketRepository());
}
