import 'package:flutter/material.dart';

class LoginImage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: SizedBox(
        width: double.infinity,
        height: 300,
        child: Image.asset(
          'images/support-ticket.png',
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}