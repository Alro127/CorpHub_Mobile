import 'package:flutter/material.dart';

class HeadBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HeadBar({
    super.key,
    required this.title
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: Builder(
        builder: (context) => IconButton(
          onPressed: () => Scaffold.of(context).openDrawer(),
          icon: Icon(Icons.menu, color: Colors.white),
        ),
      ),
      title: Text(
        title,
        style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white),
      ),
      backgroundColor: Colors.blueAccent,
      actions: [
        IconButton(
          icon: const Icon(Icons.notifications, color: Colors.white),
          onPressed: () {},
        ),
      ],
    );
  }
  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}