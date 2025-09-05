import 'package:flutter/material.dart';

class PasswordInput extends StatefulWidget {
  final TextEditingController controller;
  final String hintText;
  final bool hasError;
  final FocusNode? focusNode;

  const PasswordInput({
    super.key,
    required this.controller,
    this.hintText = "Password",
    this.hasError = false,
    this.focusNode,
  });

  @override
  State<PasswordInput> createState() => _PasswordInputState();
}

class _PasswordInputState extends State<PasswordInput> {
  bool _obscureText = true;

  @override
  void initState() {
    super.initState();
    // add listener để rebuild khi focus thay đổi
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!mounted) return;
    setState(() {}); // rebuild khi focus thay đổi
  }

  @override
  void dispose() {
    // chỉ remove listener, không dispose nếu focusNode được truyền từ ngoài
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final borderRadius = BorderRadius.circular(12);
    final errorColor = Theme.of(context).colorScheme.error;
    final normalBorderColor = Colors.grey;
    final focusedColor = Theme.of(context).colorScheme.primary;

    Color getColor() {
      if (widget.hasError) return errorColor;
      if (widget.focusNode?.hasFocus ?? false) return focusedColor;
      return Colors.grey[500]!;
    }

    return TextField(
      controller: widget.controller,
      focusNode: widget.focusNode,
      obscureText: _obscureText,
      style: const TextStyle(color: Colors.black),
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(
          vertical: 16,
          horizontal: 12,
        ),
        labelText: widget.hintText,
        labelStyle: TextStyle(color: getColor()),
        prefixIcon: Icon(Icons.lock, color: getColor()),
        suffixIcon: IconButton(
          icon: Icon(
            _obscureText ? Icons.visibility_off : Icons.visibility,
            color: widget.hasError ? errorColor : Colors.grey[500],
          ),
          onPressed: () => setState(() => _obscureText = !_obscureText),
        ),
        filled: true,
        fillColor: Colors.white,
        border: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: widget.hasError ? errorColor : normalBorderColor,
            width: 1,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: widget.hasError ? errorColor : normalBorderColor,
            width: 1,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: borderRadius,
          borderSide: BorderSide(
            color: widget.hasError ? errorColor : focusedColor,
            width: 1.5,
          ),
        ),
      ),
    );
  }
}
