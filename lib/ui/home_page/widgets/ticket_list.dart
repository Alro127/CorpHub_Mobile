import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/core/widgets/ticket_item.dart';

class TicketList extends StatelessWidget {
  final List<TicketResponse> tickets;
  final Future<bool> Function(int) onDelete;

  const TicketList({required this.tickets, required this.onDelete, super.key});

  @override
  Widget build(BuildContext context) {
    if (tickets.isEmpty) {
      return const Center(child: Text('No tickets found.'));
    }

    return ListView.builder(
      padding: const EdgeInsets.all(8.0),
      itemCount: tickets.length,
      itemBuilder: (context, index) {
        final ticket = tickets[index];
        return Slidable(
          key: ValueKey(ticket.id),
          endActionPane: ActionPane(
            motion: const ScrollMotion(),
            extentRatio: 0.25,
            children: [
              SlidableAction(
                onPressed: (context) async {
                  final confirm = await showDialog<bool>(
                    context: context,
                    builder: (_) => AlertDialog(
                      title: Text("Xác nhận"),
                      content: Text(
                          "Bạn có chắc muốn xoá ticket '${ticket.title}'?"),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context, false),
                          child: Text("Hủy"),
                        ),
                        TextButton(
                          onPressed: () => Navigator.pop(context, true),
                          child: Text("Xóa", style: TextStyle(color: Colors.red)),
                        ),
                      ],
                    ),
                  );

                  if (confirm == true) {
                    final success = await onDelete(ticket.id);
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(success
                            ? "Đã xoá '${ticket.title}'"
                            : "Xoá thất bại, vui lòng thử lại"),
                      ),
                    );
                  }
                },
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Xóa',
              ),
            ],
          ),
          child: TicketItem(ticket: ticket),
        );
      },
    );
  }
}
