import 'package:flutter/material.dart';

class HeadBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const HeadBar({super.key, required this.title});

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
          onPressed: () async {
            final RenderBox button = context.findRenderObject() as RenderBox;
            final RenderBox overlay =
                Overlay.of(context).context.findRenderObject() as RenderBox;

            final Offset bottomRight = button.localToGlobal(
              Offset(button.size.width, button.size.height),
              ancestor: overlay,
            );

            final RelativeRect position = RelativeRect.fromLTRB(
              bottomRight.dx, // left
              bottomRight.dy - 10, //top
              overlay.size.width - bottomRight.dx, // right
              overlay.size.height - bottomRight.dy, // bottom
            );

            await showMenu(
              context: context,
              position: position,
              items: [
                const PopupMenuItem(child: Text('🔔 Bạn có 1 thông báo mới!')),
              ],
            );
          },
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
