import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/data/dto/login_response.dart';
import 'package:ticket_helpdesk/data/repositories/auth_repository.dart';

class LoginUseCase {
  final AuthRepository repository;
  LoginUseCase(this.repository);

  Future<LoginResponse> login(LoginRequest loginRequest) => repository.login(loginRequest);
}