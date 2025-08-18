import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HeadBar(title: "Profile"),
      drawer: SideBar(),
      body: Column(
        children: [
          Center(
            child: Hero(
              tag: "profileAvatar",
              child: const CircleAvatar(
                radius: 80, // 🔹 phóng to avatar
                backgroundImage: AssetImage('images/support-ticket.png'),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
