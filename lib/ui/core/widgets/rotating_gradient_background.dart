import 'package:flutter/material.dart';
import 'dart:math';

class RotatingGradient extends StatefulWidget {
  final List<Color> colors;
  final Duration duration;

  const RotatingGradient({
    super.key,
    this.colors = const [Colors.blueAccent, Colors.purpleAccent],
    this.duration = const Duration(seconds: 10)
  });

  @override
  State<RotatingGradient> createState() => _RotatingGradientState();
}

class _RotatingGradientState extends State<RotatingGradient> with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.duration,
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: widget.colors,
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