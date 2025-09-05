import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/helpers/basic_input_decoration.dart';

class BasicDropdownField<T> extends StatefulWidget {
  final String label;
  final IconData icon;
  final T? value;
  final List<DropdownMenuItem<T>> items;
  final ValueChanged<T?> onChanged;
  final FocusNode? focusNode;
  final bool hasError;

  const BasicDropdownField({
    super.key,
    required this.label,
    required this.icon,
    required this.value,
    required this.items,
    required this.onChanged,
    this.focusNode,
    this.hasError = false,
  });

  @override
  State<BasicDropdownField<T>> createState() => _BasicDropdownFieldState<T>();
}

class _BasicDropdownFieldState<T> extends State<BasicDropdownField<T>> {
  @override
  void initState() {
    super.initState();
    widget.focusNode?.addListener(_onFocusChange);
  }

  void _onFocusChange() {
    if (!mounted) return;
    setState(() {}); // rebuild khi focus thay đổi
  }

  @override
  void dispose() {
    widget.focusNode?.removeListener(_onFocusChange);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isFocused = Focus.of(context).hasFocus;
    return DropdownButtonFormField<T>(
      value: widget.value,
      focusNode: widget.focusNode,

      decoration: BasicInputDecorations.build(
        context: context,
        label: widget.label,
        prefixIcon: widget.icon,
        hasError: widget.hasError,
        isFocused: isFocused,
      ),
      items: widget.items,
      onChanged: widget.onChanged,
      isExpanded: true,
    );
  }
}
