import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/helpers/basic_input_decoration.dart';

class BasicInput extends StatelessWidget {
  final String hintText;
  final IconData? icon;
  final int linesNumber;
  final TextEditingController controller;

  const BasicInput({
    super.key,
    required this.hintText,
    this.icon,
    required this.linesNumber,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: linesNumber,
      controller: controller,
      decoration: BasicInputDecorations.build(
        label: hintText,
        icon: icon,
        multiline: linesNumber > 1,
      ),
    );
  }
}
