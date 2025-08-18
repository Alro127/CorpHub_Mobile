import 'package:flutter/material.dart';
import 'dart:math';

class AuroraBackground extends StatefulWidget {
  final double width;
  final double height;
  final Duration duration;

  const AuroraBackground({
    super.key,
    required this.width,
    required this.height,
    this.duration = const Duration(seconds: 10),
  });

  @override
  State<AuroraBackground> createState() => _AuroraBackgroundState();
}

class _AuroraBackgroundState extends State<AuroraBackground>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _rotation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
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

  Color _hslColor(double hue) =>
      HSLColor.fromAHSL(1, hue % 360, 0.6, 0.6).toColor();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        final double hue = _rotation.value * 180 / pi;
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                _hslColor(hue),
                _hslColor(hue + 120),
                _hslColor(hue + 240),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              transform: GradientRotation(_controller.value * 2 * pi),
            ),
          ),
        );
      },
    );
  }
}
