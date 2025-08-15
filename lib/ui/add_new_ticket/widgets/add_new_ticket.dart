import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/data/models/ticket_api.dart';
import 'package:ticket_helpdesk/domain/models/ticket.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_dropdown_field.dart';
import 'package:ticket_helpdesk/ui/core/widgets/basic_input.dart';
import 'package:ticket_helpdesk/ui/core/widgets/datetime_input.dart';

class AddNewTicket extends StatefulWidget {
  const AddNewTicket({super.key});

  @override
  State<AddNewTicket> createState() => _AddNewTicketState();
}

class _AddNewTicketState extends State<AddNewTicket> {
  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _dateTimeController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  late String _priority = 'low';
  late String _status = 'open';
  late int _category = 0;
  late String _ticket_type = "Request";
  late int _assigned_to = 0;
  late final DateTime _deadline = DateTime.now();

  Future<void> _saveTicket() async {
    final ticket = Ticket(
      ticketId: null,
      title: _titleController.text,
      description: _descriptionController.text,
      priority: _priority,
      status: _status,
      categoryId: _category,
      requesterId: 1,
      assignedTo: _assigned_to,
      resolvedAt: null,
      createdAt: DateTime.now().toIso8601String(),
      updatedAt: DateTime.now().toIso8601String(),
    );

    bool success = await createTicket(ticket);
    if (success) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Created ticket successfully!')));
      Navigator.pop(context);
    } else {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Error creating ticket')));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Add new ticket',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: Colors.blueAccent,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              BasicInput(
                hintText: "Ticket's name",
                prefixIcon: Icons.title_outlined,
                linesNumber: 1,
                controller: _titleController,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: BasicDropdownField(
                      label: "Category",
                      icon: Icons.category,
                      value: _category,
                      items: const [
                        DropdownMenuItem(value: 0, child: Text("Hardware")),
                        DropdownMenuItem(value: 1, child: Text("Software")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _category = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: BasicDropdownField(
                      label: "Priority",
                      icon: Icons.bar_chart,
                      value: _priority,
                      items: const [
                        DropdownMenuItem(
                          value: "urgent",
                          child: Text("Urgent"),
                        ),
                        DropdownMenuItem(value: "high", child: Text("High")),
                        DropdownMenuItem(
                          value: "medium",
                          child: Text("Medium"),
                        ),
                        DropdownMenuItem(value: "low", child: Text("Low")),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _priority = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),

              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: BasicDropdownField(
                      label: "Ticker type",
                      icon: Icons.type_specimen,
                      value: _ticket_type,
                      items: const [
                        DropdownMenuItem(
                          value: "Request",
                          child: Text("Request"),
                        ),
                        DropdownMenuItem(
                          value: "Software",
                          child: Text("Software"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _ticket_type = value!;
                        });
                      },
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: BasicDropdownField(
                      label: "Status",
                      icon: Icons.circle,
                      value: _status,
                      items: const [
                        DropdownMenuItem(value: 'open', child: Text("Open")),
                        DropdownMenuItem(
                          value: 'in_progress',
                          child: Text("In progress"),
                        ),
                        DropdownMenuItem(
                          value: 'closed',
                          child: Text("Closed"),
                        ),
                        DropdownMenuItem(
                          value: 'resolved',
                          child: Text("Resolved"),
                        ),
                      ],
                      onChanged: (value) {
                        setState(() {
                          _status = value!;
                        });
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 16),
              BasicDropdownField(
                label: "Assigned to",
                icon: Icons.person,
                value: _assigned_to,
                items: const [
                  DropdownMenuItem(value: 0, child: Text("Chọn")),
                  DropdownMenuItem(value: 1, child: Text("Nhân viên 1")),
                  DropdownMenuItem(value: 2, child: Text("Nhân viên 2")),
                  DropdownMenuItem(value: 3, child: Text("Nhân viên 3")),
                ],
                onChanged: (value) {
                  setState(() {
                    _assigned_to = value!;
                  });
                },
              ),
              SizedBox(height: 16),
              DateTimeInput(
                hintText: "Deadline",
                icon: Icons.access_time,
                controller: _dateTimeController,
                onDateTimeChanged: (dateTime) {
                  if (dateTime != null) {
                    // xử lý logic ở đây
                  }
                },
              ),
              SizedBox(height: 16),
              BasicInput(
                hintText: "Description",
                linesNumber: 5,
                controller: _descriptionController,
              ),
              SizedBox(height: 16),
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _saveTicket,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.blueAccent,
                        foregroundColor: Colors.white,
                      ),
                      child: const Text("OK"),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      style: OutlinedButton.styleFrom(
                        side: const BorderSide(color: Colors.blueAccent),
                      ),
                      child: const Text("Cancel"),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
