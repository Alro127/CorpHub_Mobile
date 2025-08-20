import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/domain/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/view_update_ticket.dart';

class TicketItem extends StatefulWidget {
  final TicketResponse ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  State<TicketItem> createState() => _TicketItemState();
}

class _TicketItemState extends State<TicketItem> {
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
            pageBuilder: (_, __, ___) =>
                ViewUpdateTicket(ticket: widget.ticket),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Hero(
        tag: "ticket_${widget.ticket.id}",
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
                      "#${widget.ticket.id}",
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    Chip(
                      label: Text(widget.ticket.status),
                      backgroundColor: getStatusColor().withOpacity(0.15),
                      labelStyle: TextStyle(
                        color: getStatusColor(),
                        fontWeight: FontWeight.w500,
                      ),
                      visualDensity: VisualDensity.compact,
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
                _infoItem(
                  Icons.calendar_month,
                  "Created: ${widget.ticket.createdAt}",
                ),
                _infoItem(Icons.update, "Updated: ${widget.ticket.updatedAt}"),
                _infoItem(
                  Icons.person,
                  "Requester: ${widget.ticket.requester.fullName}",
                ),
                _infoItem(
                  Icons.engineering,
                  "Assigned to: ${widget.ticket.assignedTo?.fullName ?? 'Chưa phân công'}",
                ),

                const Divider(),

                // Footer chips
                Row(
                  children: [
                    Chip(
                      label: Text(widget.ticket.priority),
                      backgroundColor: getPriorityColor().withOpacity(0.15),
                      labelStyle: TextStyle(
                        color: getPriorityColor(),
                        fontWeight: FontWeight.w500,
                      ),
                      visualDensity: VisualDensity.compact,
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text(widget.ticket.category.categoryName),
                      backgroundColor: Colors.pinkAccent.withOpacity(0.15),
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 18, color: Colors.grey[700]),
          const SizedBox(width: 8),
          Text(
            text,
            style: const TextStyle(fontSize: 13, color: Colors.black87),
          ),
        ],
      ),
    );
  }
}
