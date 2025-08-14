import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/add_new_ticket/widgets/add_new_ticket.dart';
import 'package:ticket_helpdesk/ui/attendance/widgets/attendance_page.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/home_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => HomePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.people),
            title: const Text('Attendance'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AttendancePage()),
              );
            },
          ),
          ListTile(
            leading: const Icon(Icons.add),
            title: const Text('New ticket'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddNewTicket()),
              );
            },
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
    );
  }
}