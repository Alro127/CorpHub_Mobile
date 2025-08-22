import 'package:get_it/get_it.dart';
import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/data/repositories/user_repository.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';
import 'package:ticket_helpdesk/domain/usecases/user_usecases.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {

  // 1) Services / infra
  // ApiService:
  getIt.registerLazySingleton<ApiService>(() => ApiService());

  // 2) Repositories
  getIt.registerLazySingleton<TicketRepository>(() => TicketRepository(getIt<ApiService>()));
  getIt.registerLazySingleton<UserRepository>(() => UserRepository(getIt<ApiService>()));

  // 3) UseCases (bundle or individual usecases)
  getIt.registerLazySingleton<TicketUseCase>(() => TicketUseCase(getIt<TicketRepository>()));
  getIt.registerLazySingleton<UserUseCases>(() => UserUseCases(getIt<UserRepository>())
  );

  // 4) ViewModels (factory: tạo mới mỗi lần lấy)
  getIt.registerFactory<AddTicketViewModel>(() => AddTicketViewModel(
    ticketUseCase: getIt<TicketUseCase>(),
    userUseCases: getIt<UserUseCases>(),
  ));
}
