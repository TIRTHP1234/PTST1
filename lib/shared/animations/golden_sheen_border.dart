import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../../core/constants/app_colors.dart';

/// GoldenSheenBorder — Luxury traveling golden light beam around card borders.
///
/// Features:
/// - Smooth traveling golden metallic glint along the rounded border perimeter
/// - Lightweight GPU shader sweep gradient (zero CPU lag)
/// - Automatic RepaintBoundary isolation for 60-120 FPS
class GoldenSheenBorder extends StatefulWidget {
  const GoldenSheenBorder({
    super.key,
    required this.child,
    this.borderRadius = 16.0,
    this.strokeWidth = 1.6,
    this.duration = const Duration(seconds: 4),
    this.sheenColors = const [
      Colors.transparent,
      Colors.transparent,
      Color(0xFFC9A94E),
      Color(0xFFFFE082),
      Colors.white,
      Color(0xFFFFD54F),
      Color(0xFFC9A94E),
      Colors.transparent,
      Colors.transparent,
    ],
  });

  final Widget child;
  final double borderRadius;
  final double strokeWidth;
  final Duration duration;
  final List<Color> sheenColors;

  @override
  State<GoldenSheenBorder> createState() => _GoldenSheenBorderState();
}

class _GoldenSheenBorderState extends State<GoldenSheenBorder>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

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
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, child) {
          return CustomPaint(
            foregroundPainter: _GoldenSheenPainter(
              progress: _controller.value,
              borderRadius: widget.borderRadius,
              strokeWidth: widget.strokeWidth,
              colors: widget.sheenColors,
            ),
            child: child,
          );
        },
        child: widget.child,
      ),
    );
  }
}

class _GoldenSheenPainter extends CustomPainter {
  final double progress;
  final double borderRadius;
  final double strokeWidth;
  final List<Color> colors;

  _GoldenSheenPainter({
    required this.progress,
    required this.borderRadius,
    required this.strokeWidth,
    required this.colors,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final rect = Offset.zero & size;
    final rrect = RRect.fromRectAndRadius(
      rect.deflate(strokeWidth / 2),
      Radius.circular(borderRadius),
    );

    final angle = progress * 2 * math.pi;
    final paint = Paint()
      ..style = PaintingStyle.stroke
      ..strokeWidth = strokeWidth
      ..shader = SweepGradient(
        center: Alignment.center,
        startAngle: 0.0,
        endAngle: 2 * math.pi,
        transform: GradientRotation(angle),
        colors: colors,
        stops: const [
          0.0,
          0.65,
          0.72,
          0.78,
          0.82,
          0.86,
          0.90,
          0.95,
          1.0,
        ],
      ).createShader(rect);

    canvas.drawRRect(rrect, paint);
  }

  @override
  bool shouldRepaint(covariant _GoldenSheenPainter oldDelegate) {
    return oldDelegate.progress != progress;
  }
}
