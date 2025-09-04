import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/helpers/basic_input_decoration.dart';

class BasicInput extends StatefulWidget {
  final String hintText;
  final IconData? prefixIcon;
  final IconData? suffixIcon;
  final int linesNumber;
  final TextEditingController controller;
  final bool? obscureText;
  final bool hasError;
  final FocusNode? focusNode;

  const BasicInput({
    super.key,
    required this.hintText,
    this.prefixIcon,
    this.suffixIcon,
    required this.linesNumber,
    required this.controller,
    this.obscureText,
    this.hasError = false,
    this.focusNode,
  });

  @override
  State<BasicInput> createState() => _BasicInputState();
}

class _BasicInputState extends State<BasicInput> {
  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    setState(() {}); // rebuild khi focus thay đổi
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      maxLines: widget.linesNumber,
      controller: widget.controller,
      obscureText: widget.obscureText ?? false,
      focusNode: widget.focusNode,
      decoration: BasicInputDecorations.build(
        context: context,
        label: widget.hintText,
        prefixIcon: widget.prefixIcon,
        suffixIcon: widget.suffixIcon,
        multiline: widget.linesNumber > 1,
        hasError: widget.hasError,
        focusNode: widget.focusNode,
      ),
    );
  }
}
