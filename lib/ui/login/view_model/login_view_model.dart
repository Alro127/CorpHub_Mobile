import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/data/dto/login_response.dart';
import 'package:ticket_helpdesk/data/dto/user_dto.dart';
import 'package:ticket_helpdesk/data/local/secure_storage_service.dart';
import 'package:ticket_helpdesk/domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;
  final SecureStorageService _storageService;

  LoginViewModel({
    required LoginUseCase loginUseCase,
    required SecureStorageService storageService,
  }) : _loginUseCase = loginUseCase,
       _storageService = storageService {
    _initRememberedUser();
  }

  LoginResponse? userResponse;
  UserDto? user;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  final storage = const FlutterSecureStorage();

  Future<void> _initRememberedUser() async {
    final savedEmail = await _storageService.getEmail();
    final savedPassword = await _storageService.getPassword();
    final savedRememberMe = await _storageService.getRememberMe();

    if (savedRememberMe && savedEmail != null && savedPassword != null) {
      emailController.text = savedEmail;
      passwordController.text = savedPassword;
      rememberMe = true;
      notifyListeners();
    }
  }

  void setRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  Future<bool> login() async {
    final LoginRequest loginRequest = LoginRequest(
      email: emailController.text,
      password: passwordController.text,
    );
    try {
      userResponse = await _loginUseCase.login(loginRequest);

      if (userResponse != null) {
        if (rememberMe) {
          await _storageService.saveEmail(emailController.text);
          await _storageService.savePassword(passwordController.text);
        } else {
          await _storageService.deleteEmail();
          await _storageService.deletePassword();
        }
        await _storageService.saveRememberMe(rememberMe);
        await _storageService.saveToken(userResponse!.token);
        await _storageService.saveFullName(userResponse!.fullName);
        return true;
      }
      return false;
    } catch (e) {
      // có thể log lỗi hoặc throw lại
      print(e);
      return false;
    }
  }
}
