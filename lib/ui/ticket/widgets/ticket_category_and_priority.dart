import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_dropdown_field.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';

class TicketCategoryAndPriority extends StatelessWidget {
  final AddTicketViewModel vm;

  const TicketCategoryAndPriority({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: vm.loadingCategories
              ? const Center(child: CircularProgressIndicator())
              : BasicDropdownField(
            label: "Ticket category",
            icon: Icons.category,
            value: vm.selectedCategoryId,
            items: vm.categories.map((category) {
              return DropdownMenuItem(
                value: category.id,
                child: Text(category.categoryName),
              );
            }).toList(),
            onChanged: (value) => vm.setCategory(value as int?),
          ),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: BasicDropdownField(
            label: "Priority",
            icon: Icons.bar_chart,
            value: vm.priority,
            items: const [
              DropdownMenuItem(value: "urgent", child: Text("Urgent")),
              DropdownMenuItem(value: "high", child: Text("High")),
              DropdownMenuItem(value: "medium", child: Text("Medium")),
              DropdownMenuItem(value: "low", child: Text("Low")),
            ],
            onChanged: (value) => vm.setPriority(value!),
          ),
        ),
      ],
    );
  }
}

