import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/domain/models/ticket.dart';

class ViewUpdateTicket extends StatefulWidget {
  final Ticket ticket;
  const ViewUpdateTicket({super.key, required this.ticket});

  @override
  State<ViewUpdateTicket> createState() => _ViewUpdateTicketState();
}

class _ViewUpdateTicketState extends State<ViewUpdateTicket> {
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
    return Hero(
      tag: widget.ticket.title,
      child: Card(
        elevation: 6,
        margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 24),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20),
        ),
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header: Mã ticket + Trạng thái
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "#${widget.ticket.ticketId}",
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                    Chip(
                      label: Text(widget.ticket.status),
                      backgroundColor: getStatusColor().withOpacity(0.1),
                      labelStyle: TextStyle(
                        color: getStatusColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            
                const SizedBox(height: 12),
            
                // Tiêu đề
                Text(
                  widget.ticket.title,
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),
            
                const SizedBox(height: 16),
            
                // Thông tin thời gian & người liên quan
                Row(
                  children: [
                    const Icon(Icons.calendar_month, color: Colors.blue, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Created: ${widget.ticket.createdAt}",
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.update, color: Colors.amber, size: 18),
                    const SizedBox(width: 8),
                    Text(
                      "Updated: ${widget.ticket.updatedAt}",
                      style: const TextStyle(fontSize: 13, color: Colors.black54),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
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
                const SizedBox(height: 8),
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
            
                const Divider(height: 32),
            
                // Priority & Category
                Row(
                  children: [
                    Chip(
                      label: Text("Priority: ${widget.ticket.priority}"),
                      backgroundColor: getPriorityColor().withValues(alpha: 0.1),
                      labelStyle: TextStyle(
                        color: getPriorityColor(),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Chip(
                      label: Text("Category: ${widget.ticket.categoryId}"),
                      backgroundColor: Colors.pink.withValues(alpha: 0.1),
                      labelStyle: const TextStyle(
                        color: Colors.pink,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
            
                const Divider(height: 32),
            
                // Description
                const SizedBox(height: 8),
                Text(
                  "Description",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  widget.ticket.description ?? "Không có mô tả",
                  maxLines: 3, // Giới hạn hiển thị 3 dòng
                  overflow: TextOverflow.ellipsis, // Nếu dài thì hiển thị ...
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    fontSize: 14,
                  ),
                ),
            
                const SizedBox(height: 20),
            
                // File đính kèm
                Text(
                  "Attachments",
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Text("File đính kèm sẽ hiển thị ở đây..."),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
