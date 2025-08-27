import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/domain/usecases/user_usecases.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/password_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/rotating_gradient_background.dart';
import 'package:ticket_helpdesk/ui/login/view_model/login_view_model.dart';
import 'package:ticket_helpdesk/ui/login/widgets/login_button.dart';
import 'package:ticket_helpdesk/ui/login/widgets/login_image.dart';
import 'package:ticket_helpdesk/ui/login/widgets/sign_up_row.dart';
import 'package:flutter/foundation.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) =>
          LoginViewModel(loginUseCase: getIt(), storageService: getIt()),
      child: Consumer<LoginViewModel>(
        builder: (context, vm, _) {
          return Stack(
            children: [
              RotatingGradient(),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Align(
                  alignment: Alignment.center,
                  child: Material(
                    color: Colors.transparent,
                    child: ConstrainedBox(
                      constraints: BoxConstraints(maxWidth: 400, minWidth: 300),
                      child: Container(
                        padding: const EdgeInsets.all(32),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black26,
                              blurRadius: 8,
                              offset: Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Text(
                              "Login",
                              style: TextStyle(
                                fontSize: 40,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            SignUpRow(),
                            SizedBox(height: 32),
                            BasicInput(
                              hintText: "Email",
                              linesNumber: 1,
                              prefixIcon: Icons.email,
                              controller: vm.emailController,
                            ),
                            const SizedBox(height: 16),
                            PasswordInput(controller: vm.passwordController),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                Checkbox(
                                  value: vm.rememberMe,
                                  onChanged: vm.setRememberMe,
                                  materialTapTargetSize:
                                      MaterialTapTargetSize.shrinkWrap,
                                ),
                                Expanded(
                                  child: Text(
                                    "Ghi nhớ đăng nhập",

                                    overflow:
                                        TextOverflow.ellipsis, // tránh tràn
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // TODO: Navigate tới SignupPage
                                  },
                                  child: const Text(
                                    'Forgot Password?',
                                    style: TextStyle(
                                      color: Colors.blueAccent,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14,
                                    ),
                                  ),
                                ),
                              ],
                            ),

                            const SizedBox(height: 8),

                            LoginButton(vm),
                            const SizedBox(height: 16),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                top: MediaQuery.of(context).size.height / (kIsWeb ? 15 : 10),
                left: 0,
                right: 0,
                child: Center(child: LoginImage()),
              ),
            ],
          );
        },
      ),
    );
  }
}
