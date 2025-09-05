import 'package:flutter/material.dart';

import 'package:ticket_helpdesk/ui/core/widgets/rotating_gradient_background.dart';

class HeadBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const HeadBar({super.key, required this.title});

  @override
  State<HeadBar> createState() => _HeadBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeadBarState extends State<HeadBar> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Nền gradient xoay
        RotatingGradient(),
        // AppBar chính (trong suốt)
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
          ),
          leading: Builder(
            builder: (context) {
              final scaffoldState = Scaffold.maybeOf(context);
              final hasDrawer =
                  scaffoldState != null && scaffoldState.hasDrawer;

              return IconButton(
                icon: Icon(
                  hasDrawer ? Icons.menu : Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () {
                  if (hasDrawer) {
                    scaffoldState.openDrawer();
                  } else {
                    Navigator.of(context).maybePop();
                  }
                },
              );
            },
          ),

          title: Text(
            widget.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.notifications, color: Colors.white),
              onPressed: () async {
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
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
                    const PopupMenuItem(
                      child: Text('🔔 Bạn có 1 thông báo mới!'),
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      ],
    );
  }
}
