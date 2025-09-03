import 'package:get_it/get_it.dart';
import 'package:ticket_helpdesk/config/api_config.dart';
import 'package:ticket_helpdesk/data/api_service.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';
import 'package:ticket_helpdesk/data/repositories/auth_repository.dart';
import 'package:ticket_helpdesk/data/repositories/department_repository.dart';
import 'package:ticket_helpdesk/data/repositories/ticket_repository.dart';
import 'package:ticket_helpdesk/data/repositories/user_repository.dart';
import 'package:ticket_helpdesk/domain/usecases/department_usecase.dart';
import 'package:ticket_helpdesk/domain/usecases/login_usecase.dart';
import 'package:ticket_helpdesk/domain/usecases/ticket_usecases.dart';
import 'package:ticket_helpdesk/domain/usecases/user_usecases.dart';
import 'package:ticket_helpdesk/ui/core/view_model/user_view_model.dart';
import 'package:ticket_helpdesk/ui/my_tickets/view_model/my_tickets_view_model.dart';
import 'package:ticket_helpdesk/ui/login/view_model/login_view_model.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';

final GetIt getIt = GetIt.instance;

void setupLocator() {
  // 1) Services / infra
  // ApiService:
  getIt.registerLazySingleton<SecureStorageService>(
    () => SecureStorageService(),
  );
  getIt.registerLazySingleton<ApiConfig>(
    () => ApiConfig(getIt<SecureStorageService>()),
  );
  getIt.registerLazySingleton<ApiService>(() => ApiService(getIt<ApiConfig>()));

  // 2) Repositories
  getIt.registerLazySingleton<TicketRepository>(
    () => TicketRepository(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<UserRepository>(
    () => UserRepository(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<DepartmentRepository>(
    () => DepartmentRepository(getIt<ApiService>()),
  );
  getIt.registerLazySingleton<AuthRepository>(
    () => AuthRepository(getIt<ApiService>(), getIt<SecureStorageService>()),
  );

  // 3) UseCases (bundle or individual usecases)
  getIt.registerLazySingleton<TicketUseCase>(
    () => TicketUseCase(getIt<TicketRepository>()),
  );
  getIt.registerLazySingleton<UserUseCases>(
    () => UserUseCases(getIt<UserRepository>()),
  );
  getIt.registerLazySingleton<DepartmentUsecase>(
    () => DepartmentUsecase(getIt<DepartmentRepository>()),
  );
  getIt.registerLazySingleton<LoginUseCase>(
    () => LoginUseCase(getIt<AuthRepository>()),
  );

  // 4) ViewModels (factory: tạo mới mỗi lần lấy)
  getIt.registerFactory<AddTicketViewModel>(
    () => AddTicketViewModel(
      ticketUseCase: getIt<TicketUseCase>(),
      departmentUsecase: getIt<DepartmentUsecase>(),
    ),
  );
  getIt.registerFactory<MyTicketsViewModel>(
    () => MyTicketsViewModel(
      ticketUseCase: getIt<TicketUseCase>(),
      secureStorageService: getIt<SecureStorageService>(),
    ),
  );
  getIt.registerFactory<LoginViewModel>(
    () => LoginViewModel(
      loginUseCase: getIt<LoginUseCase>(),
      storageService: getIt<SecureStorageService>(),
    ),
  );
  getIt.registerFactory<UserViewModel>(
    () => UserViewModel(storageService: getIt<SecureStorageService>()),
  );
}
