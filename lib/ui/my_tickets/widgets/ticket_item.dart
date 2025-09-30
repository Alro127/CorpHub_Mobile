import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/core/helpers/datetime_helper.dart';
import 'package:ticket_helpdesk/ui/core/helpers/ticket_color_helper.dart';
import 'package:ticket_helpdesk/ui/my_tickets/view_model/my_tickets_view_model.dart';
import 'package:ticket_helpdesk/ui/ticket/view/ticket_details_view.dart';

class TicketItem extends StatelessWidget {
  final TicketResponse ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final statusColor = TicketColorHelper.getStatusColor(ticket.status);

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () async {
        final result = await Navigator.of(context).push<bool>(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black54,
            pageBuilder: (_, __, ___) => TicketDetailsView(ticket: ticket),
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );

        if (result == true) {
          context.read<MyTicketsViewModel>().fetchTickets();
        }
      },
      child: Hero(
        tag: "ticket_${ticket.id}",
        child: Card(
          elevation: 3,
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header với màu status
              Container(
                decoration: BoxDecoration(
                  color: statusColor.withValues(alpha: 0.7),
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${ticket.id.substring(0, 6)}",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      ticket.status.name,
                      style: textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ],
                ),
              ),

              // Body
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 12,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Title
                    Text(
                      ticket.title,
                      style: textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                        color: Colors.black87,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),

                    const SizedBox(height: 10),

                    _highlightInfo(
                      Icons.person,
                      "Requester: ${ticket.requester.fullName}",
                      textTheme,
                    ),
                    _highlightInfo(
                      Icons.engineering,
                      "Assignee: ${ticket.assignee?.fullName ?? 'Chưa phân công'}",
                      textTheme,
                    ),

                    const SizedBox(height: 12),

                    // Footer row: Priority + Category | Updated
                    Row(
                      children: [
                        _iconTagChip(
                          Icons.flag,
                          ticket.priority.name,
                          TicketColorHelper.getPriorityColor(ticket.priority),
                          textTheme,
                        ),
                        const SizedBox(width: 8),
                        _iconTagChip(
                          Icons.category,
                          ticket.category.categoryName,
                          Colors.pinkAccent,
                          textTheme,
                        ),
                        const Spacer(),
                        Row(
                          children: [
                            Icon(
                              Icons.update,
                              size: 16,
                              color: Colors.grey[600],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              DateTimeHelper.format(ticket.updatedAt),
                              style: textTheme.bodySmall?.copyWith(
                                color: Colors.black87,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _highlightInfo(IconData icon, String text, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]),
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w500,
                color: Colors.grey[800],
              ),
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
      ),
    );
  }

  Widget _iconTagChip(
    IconData icon,
    String label,
    Color color,
    TextTheme textTheme,
  ) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 4),
          Text(
            label,
            style: textTheme.labelSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: color,
            ),
          ),
        ],
      ),
    );
  }
}
