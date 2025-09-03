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
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const LoginPage(),
    );
  }
}
