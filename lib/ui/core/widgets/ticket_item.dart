import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/core/helpers/ticket_color_helper.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/view_update_ticket.dart';

class TicketItem extends StatelessWidget {
  final TicketResponse ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black54,
            pageBuilder: (_, __, ___) => ViewUpdateTicket(ticket: ticket),
            transitionDuration: const Duration(milliseconds: 500),
          ),
        );
      },
      child: Hero(
        tag: "ticket_${ticket.id}",
        child: Container(
          constraints: BoxConstraints(minHeight: 270, maxWidth: 400),
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
                        "#Ticket",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      Chip(
                        label: Text(ticket.status.name),
                        backgroundColor: TicketColorHelper.getStatusColor(
                          ticket.status,
                        ).withValues(alpha: 0.15),
                        labelStyle: TextStyle(
                          color: TicketColorHelper.getStatusColor(
                            ticket.status,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                    ],
                  ),

                  const SizedBox(height: 6),

                  // Title
                  Text(
                    ticket.title,
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
                    "Created: ${ticket.createdAt}",
                  ),
                  _infoItem(Icons.update, "Updated: ${ticket.updatedAt}"),
                  _infoItem(
                    Icons.person,
                    "Requester: ${ticket.requester.fullName}",
                  ),
                  _infoItem(
                    Icons.engineering,
                    "Assigned to: ${ticket.assignee?.fullName ?? 'Chưa phân công'}",
                  ),

                  const Divider(),

                  // Footer chips
                  Row(
                    children: [
                      Chip(
                        label: Text(ticket.priority.name),
                        backgroundColor: TicketColorHelper.getPriorityColor(
                          ticket.priority,
                        ).withValues(alpha: 0.15),
                        labelStyle: TextStyle(
                          color: TicketColorHelper.getPriorityColor(
                            ticket.priority,
                          ),
                          fontWeight: FontWeight.w500,
                        ),
                        visualDensity: VisualDensity.compact,
                      ),
                      const SizedBox(width: 8),
                      Chip(
                        label: Text(ticket.category.categoryName),
                        backgroundColor: Colors.pinkAccent.withValues(
                          alpha: 0.15,
                        ),
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
