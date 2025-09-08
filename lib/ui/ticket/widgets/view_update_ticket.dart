import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/dto/ticket_response.dart';
import 'package:ticket_helpdesk/ui/core/helpers/ticket_color_helper.dart';

class ViewUpdateTicket extends StatelessWidget {
  final TicketResponse ticket;
  const ViewUpdateTicket({super.key, required this.ticket});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black.withValues(alpha: 0.1),
      body: Center(
        child: Hero(
          tag: "ticket_${ticket.id}",
          child: Material(
            color: Colors.transparent,
            child: Card(
              elevation: 8,
              margin: const EdgeInsets.symmetric(vertical: 60, horizontal: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: buildContent(context),
              ),
            ),
          ),
        ),
      ),
    );
  }

  SingleChildScrollView buildContent(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header: Mã ticket + Trạng thái
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "# ${ticket.id.substring(0, 6)}" ,
                style: Theme.of(context).textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
              ),
              Row(
                children: [
                  Chip(
                    label: Text(ticket.status.name),
                    backgroundColor: TicketColorHelper.getStatusColor(
                      ticket.status,
                    ).withValues(alpha: 0.1),
                    labelStyle: TextStyle(
                      color: TicketColorHelper.getStatusColor(ticket.status),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () => Navigator.pop(context),
                  ),
                ],
              ),
            ],
          ),

          const SizedBox(height: 12),

          // Tiêu đề
          Text(
            ticket.title,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w600),
          ),

          const SizedBox(height: 16),

          // Thông tin thời gian & người liên quan
          Row(
            children: [
              const Icon(Icons.calendar_month, color: Colors.blue, size: 18),
              const SizedBox(width: 8),
              Text(
                "Created: ${ticket.createdAt}",
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
                "Updated: ${ticket.updatedAt}",
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
                "Requester: ${ticket.requester.fullName}",
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
                "Assigned: ${ticket.assignee?.fullName ?? 'Chưa phân công'}",
                style: const TextStyle(fontSize: 13, color: Colors.black87),
              ),
            ],
          ),

          const Divider(height: 32),

          // Priority & Category
          Row(
            children: [
              Chip(
                label: Text("Priority: ${ticket.priority.name}"),
                backgroundColor: TicketColorHelper.getPriorityColor(
                  ticket.priority,
                ).withValues(alpha: 0.1),
                labelStyle: TextStyle(
                  color: TicketColorHelper.getPriorityColor(ticket.priority),
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(width: 8),
              Chip(
                label: Text("Category: ${ticket.category.categoryName}"),
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
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 4),
          Text(
            ticket.description,
            maxLines: 3, // Giới hạn hiển thị 3 dòng
            overflow: TextOverflow.ellipsis, // Nếu dài thì hiển thị ...
            style: Theme.of(
              context,
            ).textTheme.bodyMedium?.copyWith(fontSize: 14),
          ),

          const SizedBox(height: 20),

          // File đính kèm
          Text(
            "Attachments",
            style: Theme.of(
              context,
            ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text("File đính kèm sẽ hiển thị ở đây..."),
          // ... sau phần Attachments
          const SizedBox(height: 20),

          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              // Nút Reject
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: gọi API từ chối ticket
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ticket bị từ chối")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.redAccent,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.close),
                label: const Text("Reject"),
              ),
              const SizedBox(width: 12),

              // Nút Accept
              ElevatedButton.icon(
                onPressed: () {
                  // TODO: gọi API xác nhận ticket
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text("Ticket đã được xác nhận")),
                  );
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: Colors.green,

                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),
                icon: const Icon(Icons.check),
                label: const Text("Accept"),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
