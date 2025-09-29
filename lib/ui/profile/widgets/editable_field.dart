import 'package:flutter/material.dart';

class EditableField extends StatelessWidget {
  final IconData? icon;
  final String? label;
  final TextEditingController controller;
  final bool isEditing;

  const EditableField({
    super.key,
    this.icon,
    this.label,
    required this.controller,
    required this.isEditing,
  });

  @override
  Widget build(BuildContext context) {
    final hasIcon = icon != null;
    final hasLabel = label != null && label!.isNotEmpty;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (hasIcon) ...[
            Icon(icon, color: Colors.blueGrey, size: 28),
            const SizedBox(width: 16),
          ],
          Expanded(
            child: isEditing
                ? TextField(
                    controller: controller,
                    decoration: InputDecoration(
                      labelText: hasLabel ? label : null,
                      border: InputBorder.none,
                      isDense: true,
                      contentPadding: EdgeInsets.zero, // gọn hơn
                    ),
                    style: const TextStyle(fontSize: 16),
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      if (hasLabel)
                        Text(
                          label!,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      if (hasLabel) const SizedBox(height: 4),
                      Text(
                        controller.text,
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
          ),
        ],
      ),
    );
  }
}
