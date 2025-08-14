import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/helpers/basic_input_decoration.dart';

class DateTimeInput extends StatefulWidget {
  final String hintText;
  final IconData icon;
  final TextEditingController controller;
  final void Function(DateTime?)? onDateTimeChanged;

  const DateTimeInput({
    super.key,
    required this.hintText,
    required this.icon,
    required this.controller,
    this.onDateTimeChanged,
  });

  @override
  _DateTimeInputState createState() => _DateTimeInputState();
}

class _DateTimeInputState extends State<DateTimeInput> {
  DateTime? selectedDateTime;

  Future<void> _pickDateTime() async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: selectedDateTime ?? DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );

    if (pickedDate != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: selectedDateTime != null
            ? TimeOfDay(
                hour: selectedDateTime!.hour,
                minute: selectedDateTime!.minute,
              )
            : TimeOfDay.now(),
      );

      if (pickedTime != null) {
        setState(() {
          selectedDateTime = DateTime(
            pickedDate.year,
            pickedDate.month,
            pickedDate.day,
            pickedTime.hour,
            pickedTime.minute,
          );

          widget.controller.text =
              "${selectedDateTime!.day.toString().padLeft(2, '0')}/"
              "${selectedDateTime!.month.toString().padLeft(2, '0')}/"
              "${selectedDateTime!.year} "
              "${selectedDateTime!.hour.toString().padLeft(2, '0')}:"
              "${selectedDateTime!.minute.toString().padLeft(2, '0')}";

          // Gọi callback nếu có
          widget.onDateTimeChanged?.call(selectedDateTime);
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return TextField(
      controller: widget.controller,
      readOnly: true,
      onTap: _pickDateTime,
      decoration: BasicInputDecorations.build(
        label: widget.hintText,
        icon: widget.icon,
      ),
    );
  }
}
