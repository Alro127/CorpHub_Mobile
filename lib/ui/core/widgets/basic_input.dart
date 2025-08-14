import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/helpers/basic_input_decoration.dart';

class BasicInput extends StatelessWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int linesNumber;
  final TextEditingController controller;
  final bool? obscureText;

  const BasicInput({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.linesNumber,
    required this.controller,
    this.obscureText,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: linesNumber,
      controller: controller,
      obscureText: obscureText ?? false,
      decoration: BasicInputDecorations.build(
        label: hintText,
        prefixIcon: prefixIcon,
        suffixIcon: suffixIcon,
        multiline: linesNumber > 1,
      ),
    );
  }
}
