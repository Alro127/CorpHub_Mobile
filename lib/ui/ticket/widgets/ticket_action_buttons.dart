import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/config/service_locator.dart';
import 'package:ticket_helpdesk/ui/my_tickets/view_model/my_tickets_view_model.dart';
import 'package:ticket_helpdesk/ui/ticket/view_model/add_ticket_view_model.dart';

class TicketActionButtons extends StatelessWidget {
  final AddTicketViewModel vm;

  const TicketActionButtons({super.key, required this.vm});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: ElevatedButton(
            onPressed: () async {
              final success = await vm.saveTicketAction(context);

              if (!context.mounted) return;

              if (success) {
                final MyTicketsViewModel myTicketsViewModel =
                    getIt<MyTicketsViewModel>();
                showDialog(
                  context: context,
                  barrierDismissible: false,
                  builder: (_) =>
                      const Center(child: CircularProgressIndicator()),
                );
                await myTicketsViewModel.fetchTickets();

                if (!context.mounted) return;
                Navigator.pop(context, true);
                Navigator.pop(context, true);
              }
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blueAccent,
              foregroundColor: Colors.white,
            ),
            child: const Text("OK"),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: OutlinedButton(
            onPressed: () => Navigator.pop(context),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.blueAccent),
            ),
            child: const Text("Cancel"),
          ),
        ),
      ],
    );
  }
}
