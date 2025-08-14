import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/const/constants.dart';
import 'package:ticket_helpdesk/domain/models/ticket.dart';

class TicketItem extends StatefulWidget {
  final Ticket ticket;
  const TicketItem({
    super.key,
    required this.ticket,
  });

  @override
  State<TicketItem> createState() => _State();
}

class _State extends State<TicketItem> {

  Color getStatusColor() {
    switch (widget.ticket.status) {
      case 1:
        return Colors.orange;
      case 2:
        return Colors.green;
      case 3:
        return Colors.red;
      default:
        return Colors.blue;
    }
  }

  Color getPriorityColor() {
    switch (widget.ticket.priority) {
      case 0:
        return Colors.red;
      case 1:
        return Colors.orange;
      case 3:
        return Colors.green;
      default:
        return Colors.amber;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      margin: const EdgeInsets.symmetric(
        vertical: 8,
        horizontal: 12
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(20))
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
                  widget.ticket.ticketId,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 16
                  ),
                ),
                Row(
                  children: [
                    Chip(
                      label: Text(ticketStatuses[widget.ticket.status]),
                      backgroundColor: getStatusColor().withAlpha(20),
                      labelStyle: TextStyle(
                        color: getStatusColor()
                      ),
                    ),
                    SizedBox(width: 6,),
                    Chip(
                      label: Text(ticketPriorities[widget.ticket.priority]),
                      backgroundColor: getPriorityColor().withAlpha(20),
                      labelStyle:
                      TextStyle(
                          color: getPriorityColor(),
                          fontSize: 12),
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(height: 6),
            const Divider(),
            Text(
              widget.ticket.title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500
              ),
            ),
            const Divider(),
            // Thời gian
            Row(
              children: [
                Icon(
                  Icons.calendar_month,
                  color: Colors.blue,
                ),
                const SizedBox(width: 6,),
                Text(
                  "Thời gian tạo: " + widget.ticket.createdDate,
                  style: const TextStyle(
                    fontSize: 12,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Icon(
                  Icons.hourglass_bottom,
                  color: Colors.yellow,
                ),
                const SizedBox(width: 6,),
                Text(
                    "Thời gian còn lại: " + widget.ticket.deadline,
                    style: const TextStyle(
                      fontSize: 12,
                    )
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.person),
                Text(
                  "Người yêu cầu: " + widget.ticket.requester,
                  style: const TextStyle(
                    fontSize: 12,
                  )
                )
              ],
            ),
            Row(
              children: [
                Icon(Icons.engineering),
                Text(
                  "Kỹ thuật viên: " + widget.ticket.technician,
                  style: const TextStyle(
                    fontSize: 12,
                  )
                )
              ],
            ),
            const Divider(),
          ],
        ),
      )
    );
  }
}
