import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ticket_helpdesk/ui/attendance/widgets/attendance_page.dart';
import 'package:ticket_helpdesk/ui/core/view_model/user_view_model.dart';
import 'package:ticket_helpdesk/ui/core/widgets/rotating_gradient_background.dart';
import 'package:ticket_helpdesk/ui/my_projects/view/my_projects_page.dart';
import 'package:ticket_helpdesk/ui/my_tickets/view/my_tickets_page.dart';
import 'package:ticket_helpdesk/ui/login/view/login_page.dart';
import 'package:ticket_helpdesk/ui/profile/profile_page.dart';

class SideBar extends StatelessWidget {
  const SideBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UserViewModel>(
      builder: (context, vm, _) => Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Stack(
              children: [
                const Positioned.fill(
                  // bắt RotatingGradient full size
                  child: RotatingGradient(),
                ),
                UserAccountsDrawerHeader(
                  accountName: Text(
                    vm.fullname ?? 'User Name',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  accountEmail: Text(vm.email ?? 'Email'),
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
                        backgroundImage: AssetImage(
                          'images/support-ticket.png',
                        ),
                      ),
                    ),
                  ),
                  decoration: const BoxDecoration(color: Colors.transparent),
                ),
              ],
            ),
            ListTile(
              leading: Icon(Icons.confirmation_num),
              title: Text('My Tickets'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyTicketsPage()),
                );
              },
            ),
            ListTile(
              leading: Icon(Icons.work_outline),
              title: Text('My Projects'),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => MyProjectsPage()),
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
              leading: const Icon(Icons.task),
              title: const Text('Tasks'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.calendar_month),
              title: const Text('Calendar'),
              onTap: () {},
            ),
            ListTile(
              leading: const Icon(Icons.chat),
              title: const Text('Chat'),
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
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => LoginPage()),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
