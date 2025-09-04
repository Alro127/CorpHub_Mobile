import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/core/view_model/user_view_model.dart';
import 'package:ticket_helpdesk/ui/login/view/login_page.dart';

void main() {
  setupLocator();
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => getIt<UserViewModel>()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.light(
          primary: Colors.blueAccent,
          primaryContainer: Color(0xFF4C4CBF), // xanh tím
          secondary: Color(0xFF7F4CBF), // tím
          secondaryContainer: Color(0xFFB04CBF), // tím hồng
          surface: Colors.white, // card, dialog
          onPrimary: Colors.white,
          onSecondary: Colors.white,
          onSurface: Color(0xFF1E1E1E),
          error: Color(0xFFF44336),
          onError: Colors.white,
          outline: Colors.grey.shade400,
          outlineVariant: Colors.grey.shade300,
        ),

        scaffoldBackgroundColor: Color(0xFFF9FAFB), // nền chính của app
        useMaterial3: true,
      ),

      home: const LoginPage(),
    );
  }
}
