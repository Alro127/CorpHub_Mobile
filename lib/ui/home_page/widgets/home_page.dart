import 'package:flutter/material.dart';
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
      status: "In Progress",
      priority: "High",
      requester: "Nguyễn Văn A",
      technician: "Trần Thị B",
      createdDate: "12/08/2025",
      deadline: "Còn 3h",
      attachments: 1,
    ),
    Ticket(
      ticketId: "TCK-002",
      title: "Máy in không hoạt động",
      status: "New",
      priority: "Medium",
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
      appBar: AppBar(
        leading: Builder(
          builder: (context) => IconButton(
            onPressed: () => Scaffold.of(context).openDrawer(),
            icon: Icon(Icons.menu, color: Colors.white),
          ),
        ),
        title: Text(
          'HomePage',
          style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
        ),
        backgroundColor: Colors.blueAccent,
        actions: [
          IconButton(
            icon: const Icon(Icons.notifications, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                'Account Name',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              accountEmail: Text('accountEmail@gmail.com'),
              currentAccountPicture: const CircleAvatar(
                backgroundImage: AssetImage('images/support-ticket.png'),
              ),
              decoration: BoxDecoration(color: Colors.blueAccent),
            ),
            ListTile(
              leading: Icon(Icons.home),
              title: Text('Home Page'),
              onTap: () {
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: const Icon(Icons.add),
              title: const Text('New ticket'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.list),
              title: const Text('My tickets'),
              onTap: () {},
            ),
            const Divider(),
            ListTile(
              leading: const Icon(Icons.settings),
              title: const Text('Setting'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.logout),
              title: const Text('Logout'),
              onTap: () {},
            ),
          ],
        ),
      ),
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
                    Expanded( // 🔹 Chiếm toàn bộ không gian còn lại của màn hình
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
              )
          ),
        ],
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
