import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:ticket_helpdesk/data/dto/login_request.dart';
import 'package:ticket_helpdesk/domain/usecases/login_usecase.dart';

class LoginViewModel extends ChangeNotifier {
  final LoginUseCase _loginUseCase;

  LoginViewModel({
    required LoginUseCase loginUseCase
  }) : _loginUseCase = loginUseCase;

  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  final storage = const FlutterSecureStorage();

  void setRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  Future<bool> login() async {
    final LoginRequest loginRequest = LoginRequest(
        email: emailController.text,
        password: passwordController.text
    );
    await _loginUseCase.login(loginRequest);
    // Đoạn dưới đang để tạm
    if (emailController.text == "test" && passwordController.text == "1234") {
      if (rememberMe) {
        await storage.write(key: 'is_logged_in', value: 'true');
      }

      return true;
    }
    return false;
  }
}
