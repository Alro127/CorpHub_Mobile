import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/core/helpers/datetime_helper.dart';
import 'package:ticket_helpdesk/ui/core/helpers/ticket_color_helper.dart';
import 'package:ticket_helpdesk/ui/ticket/widgets/view_update_ticket.dart';

class TicketItem extends StatelessWidget {
  final TicketResponse ticket;
  const TicketItem({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: () {
        Navigator.of(context).push(
          PageRouteBuilder(
            opaque: false,
            barrierColor: Colors.black54,
            pageBuilder: (_, __, ___) => ViewUpdateTicket(ticket: ticket),
            transitionDuration: const Duration(milliseconds: 300),
          ),
        );
      },
      child: Hero(
        tag: "ticket_${ticket.id}",
        child: Card(
          elevation: 3,
          color: Colors.grey[50],
          margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
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
                      "#${ticket.id.substring(0, 6)}",
                      style: textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.grey[800],
                      ),
                    ),
                    _statusChip(ticket, textTheme),
                  ],
                ),

                Divider(),
                const SizedBox(height: 8),

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

                const SizedBox(height: 12),

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

                const SizedBox(height: 14),

                Divider(),
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
                        Icon(Icons.update, size: 16, color: Colors.grey[600]),
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
        ),
      ),
    );
  }

  Widget _statusChip(TicketResponse ticket, TextTheme textTheme) {
    final color = TicketColorHelper.getStatusColor(ticket.status);
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 2, horizontal: 8),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Text(
        ticket.status.name,
        style: textTheme.labelSmall?.copyWith(
          color: color,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _highlightInfo(IconData icon, String text, TextTheme textTheme) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2), // giảm khoảng cách
      child: Row(
        children: [
          Icon(icon, size: 16, color: Colors.grey[700]), // đổi màu icon nhẹ hơn
          const SizedBox(width: 6),
          Expanded(
            child: Text(
              text,
              style: textTheme.bodySmall?.copyWith(
                // giảm size xuống bodySmall
                fontWeight: FontWeight.w500, // hạ từ w600 -> w500
                color: Colors.grey[800], // đổi màu chữ thành xám đậm vừa phải
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
        color: color.withOpacity(0.12),
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
