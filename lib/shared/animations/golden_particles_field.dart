import 'dart:math' as math;
import 'package:flutter/material.dart';

/// GoldenParticlesField — Ambient floating golden dust/sparks animation.
///
/// Creates a soothing, transcendent atmosphere for spiritual reading.
class GoldenParticlesField extends StatefulWidget {
  const GoldenParticlesField({
    super.key,
    this.numberOfParticles = 24,
    this.color = const Color(0xFFC9A94E),
  });

  final int numberOfParticles;
  final Color color;

  @override
  State<GoldenParticlesField> createState() => _GoldenParticlesFieldState();
}

class _GoldenParticlesFieldState extends State<GoldenParticlesField>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final List<_Particle> _particles;
  final math.Random _random = math.Random();

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 12),
    )..repeat();

    _particles = List.generate(widget.numberOfParticles, (index) {
      return _Particle(
        x: _random.nextDouble(),
        y: _random.nextDouble(),
        size: 1.5 + _random.nextDouble() * 3.5,
        speed: 0.05 + _random.nextDouble() * 0.12,
        opacity: 0.15 + _random.nextDouble() * 0.45,
        swing: _random.nextDouble() * 0.05,
      );
    });
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
        return CustomPaint(
          size: Size.infinite,
          painter: _ParticlePainter(
            particles: _particles,
            progress: _controller.value,
            color: widget.color,
          ),
        );
      },
    );
  }
}

class _Particle {
  _Particle({
    required this.x,
    required this.y,
    required this.size,
    required this.speed,
    required this.opacity,
    required this.swing,
  });

  final double x;
  final double y;
  final double size;
  final double speed;
  final double opacity;
  final double swing;
}

class _ParticlePainter extends CustomPainter {
  const _ParticlePainter({
    required this.particles,
    required this.progress,
    required this.color,
  });

  final List<_Particle> particles;
  final double progress;
  final Color color;

  @override
  void paint(Canvas canvas, Size size) {
    for (final p in particles) {
      // Calculate floating upward motion
      final curY = (p.y - progress * p.speed) % 1.0;
      final curX = p.x + math.sin((progress * 2 * math.pi) + p.y * 10) * p.swing;

      final px = curX * size.width;
      final py = curY * size.height;

      final paint = Paint()
        ..color = color.withOpacity(p.opacity)
        ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 1.5);

      canvas.drawCircle(Offset(px, py), p.size, paint);
    }
  }

  @override
  bool shouldRepaint(covariant _ParticlePainter oldDelegate) => true;
}
