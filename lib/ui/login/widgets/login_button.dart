import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/my_tickets/view/my_tickets_page.dart';
import 'package:ticket_helpdesk/ui/login/view_model/login_view_model.dart';

class LoginButton extends StatelessWidget {
  final LoginViewModel vm;
  const LoginButton(this.vm, {super.key});
  @override
  Widget build(BuildContext context) {
    return SizedBox(
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
          shadowColor: Colors.blueAccent.withValues(alpha: 0.4),
          textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        onPressed: () async {
          final success = await vm.login(); // gọi hàm login trong ViewModel

          if (!context.mounted) return;

          if (success) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (_) => const MyTicketsPage()),
            );
          } else {
            ScaffoldMessenger.of(context).showSnackBar(
              const SnackBar(content: Text("Sai email hoặc mật khẩu")),
            );
          }
        },
        child: const Text("Login"),
      ),
    );
  }
}
