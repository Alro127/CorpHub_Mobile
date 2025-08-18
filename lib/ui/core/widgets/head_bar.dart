import 'package:flutter/material.dart';
import 'dart:math';

class HeadBar extends StatefulWidget implements PreferredSizeWidget {
  final String title;
  const HeadBar({super.key, required this.title});

  @override
  State<HeadBar> createState() => _HeadBarState();

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}

class _HeadBarState extends State<HeadBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10), // chỉnh tốc độ xoay
    )..repeat();
    _rotation = Tween<double>(begin: 0, end: 2 * pi).animate(
      CurvedAnimation(parent: _controller, curve: Curves.linear),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        // Nền gradient xoay
        AnimatedBuilder(
          animation: _controller,
          builder: (context, child) {
            return Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [
                      HSLColor.fromAHSL(
                        1,
                        (_rotation.value * 180 / pi) % 360,
                        0.6,
                        0.6,
                      ).toColor(),
                      HSLColor.fromAHSL(
                        1,
                        ((_rotation.value * 180 / pi) + 120) % 360,
                        0.6,
                        0.6,
                      ).toColor(),
                      HSLColor.fromAHSL(
                        1,
                        ((_rotation.value * 180 / pi) + 240) % 360,
                        0.6,
                        0.6,
                      ).toColor(),
                    ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  transform: GradientRotation(_controller.value * 2 * 3.1416),
                ),
              ),
            );
          },
        ),
        // AppBar chính (trong suốt)
        AppBar(
          backgroundColor: Colors.transparent,
          elevation: 4,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(20),
            ),
          ),
          leading: Builder(
            builder: (context) => IconButton(
              onPressed: () => Scaffold.of(context).openDrawer(),
              icon: const Icon(Icons.menu, color: Colors.white),
            ),
          ),
          title: Text(
            widget.title,
            style: const TextStyle(
                fontWeight: FontWeight.bold, color: Colors.white),
          ),
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
                    const PopupMenuItem(
                        child: Text('🔔 Bạn có 1 thông báo mới!')),
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
