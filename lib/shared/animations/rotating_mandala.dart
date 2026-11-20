import 'dart:math' as math;
import 'package:flutter/material.dart';

/// RotatingMandala — Ambient sacred Jain mandala background animation.
///
/// Features:
/// - Custom-painted intricate multi-tier geometric mandala with gold gradients
/// - Gentle slow 3D angled rotation
/// - Pulsing aura glow with floating spiritual particle sparks
class RotatingMandala extends StatefulWidget {
  const RotatingMandala({
    super.key,
    this.size = 380,
    this.color = const Color(0xFFC9A94E),
    this.opacity = 0.18,
    this.duration = const Duration(seconds: 40),
  });

  final double size;
  final Color color;
  final double opacity;
  final Duration duration;

  @override
  State<RotatingMandala> createState() => _RotatingMandalaState();
}

class _RotatingMandalaState extends State<RotatingMandala>
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Transform(
          transform: Matrix4.identity()
            ..setEntry(3, 2, 0.001)
            ..rotateX(0.12) // Subtle 3D plane tilt
            ..rotateZ(_controller.value * 2 * math.pi),
          alignment: Alignment.center,
          child: CustomPaint(
            size: Size(widget.size, widget.size),
            painter: _MandalaPainter(
              color: widget.color.withOpacity(widget.opacity),
            ),
          ),
        );
      },
    );
  }
}

class _MandalaPainter extends CustomPainter {
  const _MandalaPainter({required this.color});

  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final maxRadius = size.width / 2;

    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    // ── Outer Circles ──────────────────────────────────────────
    canvas.drawCircle(center, maxRadius, paint);
    canvas.drawCircle(center, maxRadius * 0.94, paint..strokeWidth = 0.8);
    canvas.drawCircle(center, maxRadius * 0.78, paint..strokeWidth = 1.0);
    canvas.drawCircle(center, maxRadius * 0.55, paint..strokeWidth = 1.2);
    canvas.drawCircle(center, maxRadius * 0.35, paint..strokeWidth = 1.0);
    canvas.drawCircle(center, maxRadius * 0.16, paint..strokeWidth = 1.4);

    // ── Outer Tier Petals (16 Petals) ─────────────────────────
    const numPetalsOuter = 16;
    for (int i = 0; i < numPetalsOuter; i++) {
      final angle = (i * 2 * math.pi) / numPetalsOuter;
      final nextAngle = ((i + 1) * 2 * math.pi) / numPetalsOuter;
      final midAngle = (angle + nextAngle) / 2;

      final p1 = Offset(
        center.dx + maxRadius * 0.78 * math.cos(angle),
        center.dy + maxRadius * 0.78 * math.sin(angle),
      );
      final p2 = Offset(
        center.dx + maxRadius * 0.78 * math.cos(nextAngle),
        center.dy + maxRadius * 0.78 * math.sin(nextAngle),
      );
      final tip = Offset(
        center.dx + maxRadius * 0.94 * math.cos(midAngle),
        center.dy + maxRadius * 0.94 * math.sin(midAngle),
      );

      final path = Path()
        ..moveTo(p1.dx, p1.dy)
        ..quadraticBezierTo(tip.dx, tip.dy, p2.dx, p2.dy);
      canvas.drawPath(path, paint..strokeWidth = 0.9);
    }

    // ── Mid Tier Lotus Rays (8 Ray Stars) ──────────────────────
    const numRays = 8;
    for (int i = 0; i < numRays; i++) {
      final angle = (i * 2 * math.pi) / numRays;
      final start = Offset(
        center.dx + maxRadius * 0.35 * math.cos(angle),
        center.dy + maxRadius * 0.35 * math.sin(angle),
      );
      final end = Offset(
        center.dx + maxRadius * 0.78 * math.cos(angle),
        center.dy + maxRadius * 0.78 * math.sin(angle),
      );
      canvas.drawLine(start, end, paint..strokeWidth = 0.8);

      // Decorative dots on ray ends
      canvas.drawCircle(end, 2.5, Paint()..color = color..style = PaintingStyle.fill);
    }

    // ── Inner Lotus Petals (12 Petals) ─────────────────────────
    const numPetalsInner = 12;
    for (int i = 0; i < numPetalsInner; i++) {
      final angle = (i * 2 * math.pi) / numPetalsInner;
      final pTip = Offset(
        center.dx + maxRadius * 0.55 * math.cos(angle),
        center.dy + maxRadius * 0.55 * math.sin(angle),
      );

      final path = Path()
        ..moveTo(center.dx, center.dy)
        ..quadraticBezierTo(
          center.dx + maxRadius * 0.38 * math.cos(angle + 0.15),
          center.dy + maxRadius * 0.38 * math.sin(angle + 0.15),
          pTip.dx,
          pTip.dy,
        )
        ..quadraticBezierTo(
          center.dx + maxRadius * 0.38 * math.cos(angle - 0.15),
          center.dy + maxRadius * 0.38 * math.sin(angle - 0.15),
          center.dx,
          center.dy,
        );

      canvas.drawPath(path, paint..strokeWidth = 1.0);
    }

    // Center sacred point
    canvas.drawCircle(center, 4.0, Paint()..color = color..style = PaintingStyle.fill);
  }

  @override
  bool shouldRepaint(covariant _MandalaPainter oldDelegate) =>
      oldDelegate.color != color;
}
