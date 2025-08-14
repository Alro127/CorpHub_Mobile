import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/add_new_ticket/widgets/add_new_ticket.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/ticket_item.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/dashboard_stats.dart';
import 'package:ticket_helpdesk/domain/models/ticket.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Ticket> tickets = [
    Ticket(
      ticketId: "TCK-001",
      title: "Lỗi không thể kết nối VPN",
      status: 1,
      priority: 0,
      type: 'Request',
      category: 'Software',
      requester: "Nguyễn Văn A",
      technician: "Trần Thị B",
      createdDate: "12/08/2025",
      deadline: "Còn 3h",
      attachments: 1,
    ),
    Ticket(
      ticketId: "TCK-002",
      title: "Máy in không hoạt động",
      status: 1,
      priority: 2,
      type: 'Request',
      category: 'Hardware',
      requester: "Lê Văn C",
      technician: "Nguyễn Văn D",
      createdDate: "12/08/2025",
      deadline: "Còn 5h",
      attachments: 0,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeadBar(title: "Home Page"),
      drawer: SideBar(),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SearchBarWidget(),
          DashboardStats(),
          Divider(),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Recent tickets',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Expanded(
                    // 🔹 Chiếm toàn bộ không gian còn lại của màn hình
                    child: ListView.builder(
                      itemCount: tickets.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        return TicketItem(ticket: tickets[index]);
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(
            context,
          ).push(MaterialPageRoute(builder: (context) => AddNewTicket()));
        },
        backgroundColor: Colors.blueAccent,
        foregroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.all(Radius.circular(50)),
        ),
        child: Icon(Icons.add),
      ),
    );
  }

  Widget SearchBarWidget() {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: TextField(
        decoration: InputDecoration(
          prefixIcon: Icon(Icons.search),
          hintText: 'Search ticket...',
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          filled: true,
          fillColor: Colors.grey[200],
        ),
        onChanged: (value) {},
      ),
    );
  }
}


