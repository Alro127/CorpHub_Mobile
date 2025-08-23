import 'package:flutter/material.dart';

class SignUpRow extends StatelessWidget  {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text(
          "Don't you have an account?",
          style: TextStyle(
            color: Colors.grey[700],
            fontSize: 14,
          ),
        ),
        const SizedBox(width: 5),
        GestureDetector(
          onTap: () {
            // TODO: Navigate tới SignupPage
          },
          child: const Text(
            'Sign up',
            style: TextStyle(
              color: Colors.blueAccent,
              fontWeight: FontWeight.bold,
              fontSize: 14,
            ),
          ),
        ),
      ],
    );
  }
}