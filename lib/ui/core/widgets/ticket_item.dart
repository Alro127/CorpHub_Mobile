import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_response.dart';

class TicketItem extends StatefulWidget {
  final TicketResponse ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  State<TicketItem> createState() => _State();
}

class _State extends State<TicketItem> {
  Color getStatusColor() {
    switch (widget.ticket.status) {
      case 'in_progress':
        return Colors.orange;
      case 'resolved':
        return Colors.green;
      case 'closed':
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Color getPriorityColor() {
    switch (widget.ticket.priority) {
      case 'urgent':
        return Colors.red;
      case 'high':
        return Colors.orange;
      case 'low':
        return Colors.green;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20)),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Mã ticket + trạng thái + ưu tiên
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  widget.ticket.id.toString(),
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                  ),
                ),
                Row(
                  children: [
                    Chip(
                      label: Text(widget.ticket.status),
                      backgroundColor: getStatusColor().withAlpha(20),
                      labelStyle: TextStyle(color: getStatusColor()),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Divider(),
            Text(
              widget.ticket.title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Divider(),
            // Thời gian
            Row(
              children: [
                Icon(Icons.calendar_month, color: Colors.blue),
                const SizedBox(width: 6),
                Text(
                  "Created at: ${widget.ticket.createdAt}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.hourglass_bottom, color: Colors.yellow),
                const SizedBox(width: 6),
                Text(
                  "Updated at: ${widget.ticket.updatedAt}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.person),
                Text(
                  "Requester: ${widget.ticket.requester.fullName}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            Row(
              children: [
                Icon(Icons.engineering),
                Text(
                  "Assigned to: ${widget.ticket.assignedTo?.fullName ?? 'Chưa phân công'}",
                  style: const TextStyle(fontSize: 12),
                ),
              ],
            ),
            const Divider(),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Chip(
                      label: Text(widget.ticket.priority),
                      backgroundColor: getPriorityColor().withAlpha(20),
                      labelStyle: TextStyle(color: getStatusColor()),
                    ),
                    SizedBox(width: 6),
                    Chip(
                      label: Text(widget.ticket.category.categoryName),
                      backgroundColor: Colors.pinkAccent.withAlpha(20),
                      labelStyle: TextStyle(
                        color: getPriorityColor(),
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
