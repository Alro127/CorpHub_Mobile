import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/api_service.dart';
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

  /// State
  LoginResponse? userResponse;
  UserDto? user;
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  FocusNode focusNodeEmail = FocusNode();
  FocusNode focusNodePassword = FocusNode();

  bool rememberMe = false;
  String? error;

  /// Khởi tạo dữ liệu đã lưu trong secure storage
  Future<void> _initRememberedUser() async {
    final savedEmail = await _storageService.getEmail();
    final savedPassword = await _storageService.getPassword();
    final savedRememberMe = await _storageService.getRememberMe();

    rememberMe = savedRememberMe;
    if (savedEmail != null) emailController.text = savedEmail;
    if (savedPassword != null) passwordController.text = savedPassword;

    notifyListeners();
  }

  /// Set trạng thái "Ghi nhớ đăng nhập"
  void setRememberMe(bool? value) {
    rememberMe = value ?? false;
    notifyListeners();
  }

  /// Login logic
  Future<bool> login() async {
    error = null; // reset error trước mỗi lần login
    final LoginRequest loginRequest = LoginRequest(
      email: emailController.text.trim(),
      password: passwordController.text,
    );

    try {
      userResponse = await _loginUseCase.login(loginRequest);

      if (rememberMe) {
        await _storageService.saveEmail(emailController.text.trim());
        await _storageService.savePassword(passwordController.text);
      } else {
        await _storageService.deleteEmail();
        await _storageService.deletePassword();
      }
      await _storageService.saveRememberMe(rememberMe);

      if (userResponse != null) {
        await _storageService.saveMyId(userResponse!.id);
        await _storageService.saveToken(userResponse!.token);
        await _storageService.saveFullName(userResponse!.fullName);
        return true;
      } else {
        error = "Login failed: response is null";
        notifyListeners();
        return false;
      }
    } catch (e) {
      error = e.toString();
      notifyListeners();
      return false;
    }
  }

  /// Dọn dẹp controller tránh memory leak
  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    focusNodeEmail.dispose();
    focusNodePassword.dispose();
    super.dispose();
  }
}
