import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/password_input.dart';

class LoginPage extends StatefulWidget {
  //final VoidCallback show;
  // LoginPage({super.key, required this.show});
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              loginImage(),
              SizedBox(height: 20),
              BasicInput(
                hintText: "Email",
                linesNumber: 1,
                prefixIcon: Icons.email,
                controller: emailController,
              ),
              SizedBox(height: 16),
              PasswordInput(controller: passwordController),
              SizedBox(height: 16),
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blueAccent,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 4,
                    shadowColor: Colors.blueAccent.withOpacity(0.4),
                    textStyle: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  onPressed: () {
                    // TODO: handle login action
                  },
                  child: const Text("Login"),
                ),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Don't you have an account?",
                    style: TextStyle(color: Colors.grey[700], fontSize: 14),
                  ),
                  SizedBox(width: 5),
                  GestureDetector(
                    child: Text(
                      'Sign up',
                      style: TextStyle(
                        color: Colors.blueAccent,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget loginImage() {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15),
    child: Container(
      width: double.infinity,
      height: 300,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage('images/support-ticket.png'),
          fit: BoxFit.cover,
        ),
      ),
    ),
  );
}
