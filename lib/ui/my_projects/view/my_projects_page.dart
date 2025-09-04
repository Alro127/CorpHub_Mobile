import 'package:flutter/material.dart';
import 'package:ticket_helpdesk/domain/models/project.dart';
import 'package:ticket_helpdesk/ui/core/widgets/head_bar.dart';
import 'package:ticket_helpdesk/ui/core/widgets/side_bar.dart';
import 'package:ticket_helpdesk/ui/my_projects/widgets/project_item.dart';

class MyProjectsPage extends StatelessWidget {
  const MyProjectsPage({super.key});

  List<Project> get projects => [
    Project(
      title: "Pintap Project",
      date: "Wednesday 30 Nov, 2022",
      members: [
        "https://randomuser.me/api/portraits/women/1.jpg",
        "https://randomuser.me/api/portraits/men/2.jpg",
        "https://randomuser.me/api/portraits/women/3.jpg",
        "https://randomuser.me/api/portraits/men/4.jpg",
      ],
      description: "Website | Mobile App Design",
      progress: 0.4,
      comments: 5,
      timeAgo: "4 Days ago",
    ),
    Project(
      title: "Indeep Project",
      date: "Friday 02 Dec, 2022",
      members: [
        "https://randomuser.me/api/portraits/women/5.jpg",
        "https://randomuser.me/api/portraits/men/6.jpg",
        "https://randomuser.me/api/portraits/women/7.jpg",
      ],
      description: "Website | Mobile App Design",
      progress: 0.67,
      comments: 3,
      timeAgo: "7 Days ago",
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const HeadBar(title: "My Projects"),
      drawer: const SideBar(),
      body: ListView.builder(
        itemCount: projects.length,
        itemBuilder: (context, index) {
          final p = projects[index];
          return ProjectItem(
            title: p.title,
            date: p.date,
            members: p.members,
            description: p.description,
            progress: p.progress,
            comments: p.comments,
            timeAgo: p.timeAgo,
            isGradient: index % 2 != 0,
          );
        },
      ),
    );
  }
}
