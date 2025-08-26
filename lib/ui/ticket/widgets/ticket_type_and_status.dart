import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/const/ticket_status.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_dropdown_field.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';

class TicketTypeAndStatus extends StatelessWidget {
  final AddTicketViewModel vm;

  const TicketTypeAndStatus({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: BasicDropdownField(
            label: "Ticket type",
            icon: Icons.type_specimen,
            value: vm.ticketType,
            items: const [
              DropdownMenuItem(value: "Request", child: Text("Request")),
              DropdownMenuItem(value: "Software", child: Text("Software")),
            ],
            onChanged: (value) => vm.setTicketType(value!),
          ),
        ),
        const SizedBox(width: 16),
      ],
    );
  }
}
