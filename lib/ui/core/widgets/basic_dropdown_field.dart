import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/helpers/basic_input_decoration.dart';

class BasicDropdownField<T> extends StatelessWidget {
  final String label;
  final IconData icon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;

  const BasicDropdownField({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField<T>(
      value: value,
      decoration: BasicInputDecorations.build(label: label, icon: icon),
      items: items,
      onChanged: onChanged,
      isExpanded: true,
    );
  }
}
