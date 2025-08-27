import 'package:flutter/material.dart';

class BasicInputDecorations {
  static InputDecoration build({
    required String label,
    IconData? prefixIcon,
    IconData? suffixIcon,
    bool multiline = false,
  }) {
    return InputDecoration(
      prefixIcon: prefixIcon != null
          ? Icon(prefixIcon, color: Colors.grey[500])
          : null,

      suffixIcon: suffixIcon != null
          ? Icon(suffixIcon, color: Colors.grey[500])
          : null,
      alignLabelWithHint: multiline,
      labelText: label,
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(vertical: 16, horizontal: 12),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
    );
  }
}
