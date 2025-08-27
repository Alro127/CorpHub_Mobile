import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  const LoginImage({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: 200,
        height: 100,
        child: Image.asset('images/corpHubv2.png', fit: BoxFit.cover),
      ),
    );
  }
}
