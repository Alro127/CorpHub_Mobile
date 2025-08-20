import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/attendance/widgets/attendance_page.dart';
import 'package:ticket_helpdesk/ui/core/widgets/aurora_background.dart';
import 'package:ticket_helpdesk/ui/home_page/widgets/home_page.dart';
import 'package:ticket_helpdesk/ui/profile/profile_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          Stack(
            children: [
              AuroraBackground(width: double.infinity, height: 200),
              UserAccountsDrawerHeader(
                accountName: const Text(
                  'Account Name',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                accountEmail: const Text('accountEmail@gmail.com'),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const ProfilePage(),
                      ),
                    );
                  },
                  child: Hero(
                    tag: "profileAvatar",
                    child: const CircleAvatar(
                      backgroundImage: AssetImage('images/support-ticket.png'),
                    ),
                  ),
                ),
                decoration: const BoxDecoration(color: Colors.transparent),
              ),
            ],
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
