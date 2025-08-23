import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/domain/usecases/login_usecase.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/password_input.dart';
import 'package:ticket_helpdesk/ui/home_page/view/home_screen.dart';
import 'package:ticket_helpdesk/ui/login/view_model/login_view_model.dart';
import 'package:ticket_helpdesk/ui/login/widgets/login_button.dart';
import 'package:ticket_helpdesk/ui/login/widgets/login_image.dart';
import 'package:ticket_helpdesk/ui/login/widgets/sign_up_row.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => LoginViewModel(loginUseCase: getIt()),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, _) {
          return Scaffold(
            body: SingleChildScrollView(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: [
                  LoginImage(),
                  const SizedBox(height: 20),

                  // Email input
                  BasicInput(
                    hintText: "Email",
                    linesNumber: 1,
                    prefixIcon: Icons.email,
                    controller: vm.emailController,
                  ),
                  const SizedBox(height: 16),

                  // Password input
                  PasswordInput(controller: vm.passwordController),
                  const SizedBox(height: 8),

                  // Remember me
                  Row(
                    children: [
                      Checkbox(
                        value: vm.rememberMe,
                        onChanged: vm.setRememberMe,
                      ),
                      const Text("Ghi nhớ đăng nhập"),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Login button
                  LoginButton(vm),

                  const SizedBox(height: 16),

                  // Sign up link
                  SignUpRow(),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

}




