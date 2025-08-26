import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/home_page/view/home_screen.dart';
import 'package:ticket_helpdesk/ui/login/view/login_page.dart';
import 'package:ticket_helpdesk/ui/signup/signup_page.dart';

void main() {
  setupLocator();
  runApp(const MyApp());
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
      home: const HomePage(),
    );
  }
}
