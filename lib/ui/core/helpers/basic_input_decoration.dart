import 'package:flutter/material.dart';

class BasicInputDecorations {
  static InputDecoration build({
    required String label,
    IconData? icon,
    bool multiline = false,
  }) {
    return InputDecoration(
      prefixIcon: icon != null ? Icon(icon, color: Colors.grey[700]) : null,
      alignLabelWithHint: multiline,
      labelText: label,
      labelStyle: const TextStyle(fontWeight: FontWeight.bold),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      filled: true,
      fillColor: Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.grey, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: Colors.blue, width: 1.5),
      ),
    );
  }
}
