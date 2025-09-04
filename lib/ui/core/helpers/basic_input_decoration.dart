import 'package:flutter/material.dart';

class BasicInputDecorations {
  static InputDecoration build({
    required BuildContext context,
    required String label,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool multiline = false,
    bool hasError = false,
    FocusNode? focusNode,
  }) {
    final borderRadius = BorderRadius.circular(12);
    final errorColor = Theme.of(context).colorScheme.error;
    final normalBorderColor = Colors.grey;
    final focusedColor = Theme.of(context).colorScheme.primary;

    Color getColor() {
      if (hasError) return errorColor;
      if (focusNode != null && focusNode.hasFocus) return focusedColor;
      return Colors.grey[500]!;
    }

    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: getColor())
          : null,
      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: getColor())
          : null,
      alignLabelWithHint: multiline,
      labelText: label,
      labelStyle: TextStyle(color: getColor()),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      border: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: hasError ? errorColor : normalBorderColor,
          width: 1,
        ),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: hasError ? errorColor : normalBorderColor,
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: borderRadius,
        borderSide: BorderSide(
          color: hasError ? errorColor : focusedColor,
          width: 1.5,
        ),
      ),
    );
  }
}
