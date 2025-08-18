import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/domain/models/ticket.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/view_update_ticket.dart';

class TicketItem extends StatefulWidget {
  final Ticket ticket;
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
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black54,
            pageBuilder: (_, __, ___) => ViewUpdateTicket(ticket: widget.ticket),
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Hero(
        tag: "ticket_${widget.ticket.ticketId}",
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          child: Padding(
            padding: const EdgeInsets.all(14),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${widget.ticket.ticketId}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Chip(
                          label: Text(widget.ticket.status),
                          backgroundColor: getStatusColor().withValues(alpha: 0.15),
                          labelStyle: TextStyle(
                            color: getStatusColor(),
                            fontWeight: FontWeight.w500,
                          ),
                          visualDensity: VisualDensity.compact,
                        ),
                      ],
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Title
                Text(
                  widget.ticket.title,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),

                const SizedBox(height: 10),

                // Info section
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.blue, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Created: ${widget.ticket.createdAtFormatted}",
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.update, color: Colors.amber, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Updated: ${widget.ticket.updatedAtFormatted}",
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.person, color: Colors.grey, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Requester: ${widget.ticket.requesterId}",
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),
                const SizedBox(height: 4),
                Row(
                  children: [
                    const Icon(Icons.engineering, color: Colors.teal, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Assigned: ${widget.ticket.assignedTo ?? 'Chưa phân công'}",
                      style: const TextStyle(fontSize: 13, color: Colors.black87),
                    ),
                  ],
                ),


                const SizedBox(height: 8),

                // Tags
                Row(
                  children: [
                    Chip(
                      label: Text(widget.ticket.priority),
                      backgroundColor: getPriorityColor().withValues(alpha: 0.15),
                      labelStyle: TextStyle(
                        color: getPriorityColor(),
                        fontWeight: FontWeight.w500,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text("Category: ${widget.ticket.categoryId}"),
                      backgroundColor: Colors.pinkAccent.withValues(alpha: 0.15),
                      labelStyle: const TextStyle(
                        color: Colors.pinkAccent,
                        fontWeight: FontWeight.w500,
                        fontSize: 12,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _infoItem(IconData icon, String text) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 16, color: Colors.grey[700]),
        const SizedBox(width: 4),
        Text(
          text,
          style: const TextStyle(fontSize: 12, color: Colors.black87),
        ),
      ],
    );
  }
}
