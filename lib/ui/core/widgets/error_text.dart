import 'package:flutter/material.dart';

class ErrorText extends StatelessWidget {
  final String error;

  const ErrorText({super.key, required this.error});

  @override
  Widget build(BuildContext context) {
    if (error.isEmpty) {
      return const SizedBox.shrink();
    }

    return Text(
      error,
      style: TextStyle(
        color: Theme.of(context).colorScheme.error,
        fontSize: 12,
        fontWeight: FontWeight.w500,
      ),
    );
  }
}
