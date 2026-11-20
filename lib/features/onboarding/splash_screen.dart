import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';

/// Ultra-Premium 3D Meditating Baba / Jain Pandit Loading Animation for PTST.
///
/// Features:
/// - Exact visual match to DharmaPath Pandit/Guru artwork in `media_1795171889245_96be22ec.png`
/// - 3D Levitation physics: Baba gently floats in 3D perspective with realistic shadow tracking
/// - Multi-layered rotating sacred Mandala halo behind head
/// - Divine breathing aura & golden light rays
/// - Blessing hand (Abhaya Mudra) emitting golden energy ripples
/// - Dynamic spiritual loading progress counter with mantras & golden progress bar
/// - Zero emojis — pure classic sacred vector art & typography
class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _levitateController;
  late final AnimationController _haloController;
  late final AnimationController _auraController;
  late final AnimationController _progressController;
  late final AnimationController _mudraGlowController;

  @override
  void initState() {
    super.initState();

    // 3D Levitation & breathing oscillation
    _levitateController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3200),
    )..repeat(reverse: true);

    // Rotating Mandala Halo
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 24),
    )..repeat();

    // Divine golden aura expansion pulse
    _auraController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);

    // Mudra ripple wave
    _mudraGlowController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();

    // Spiritual loading progress
    _progressController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 3800),
    )..forward();

    _navigateAfterDelay();
  }

  Future<void> _navigateAfterDelay() async {
    await Future.delayed(const Duration(milliseconds: 4000));
    if (!mounted) return;

    final prefs = await SharedPreferences.getInstance();
    final isRegistered = prefs.getBool('is_registered') ?? false;

    if (!mounted) return;

    if (isRegistered) {
      context.go('/mpin-login');
    } else {
      context.go('/onboarding');
    }
  }

  @override
  void dispose() {
    _levitateController.dispose();
    _haloController.dispose();
    _auraController.dispose();
    _progressController.dispose();
    _mudraGlowController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFF1E0610), // Royal temple backdrop for wide screens
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Scaffold(
            backgroundColor: const Color(0xFFFAF6EE), // Sacred warm ivory parchment
            body: Stack(
              alignment: Alignment.center,
              children: [
                // ── 1. Ambient Sacred Radial Background ────────────────
                Positioned.fill(
                  child: Container(
                    decoration: const BoxDecoration(
                      gradient: RadialGradient(
                        center: Alignment(0.0, -0.2),
                        radius: 1.0,
                        colors: [
                          Color(0xFFFFFDF8),
                          Color(0xFFFBF4E7),
                          Color(0xFFF3E9D5),
                        ],
                      ),
                    ),
                  ),
                ),

                // ── 2. Concentric Golden Ripple Waves ──────────────────
                RepaintBoundary(
                  child: AnimatedBuilder(
                    animation: _auraController,
                    builder: (context, _) {
                      return CustomPaint(
                        size: const Size(400, 400),
                        painter: _GoldenAuraRaysPainter(
                          pulseValue: _auraController.value,
                        ),
                      );
                    },
                  ),
                ),

                // ── 3. Main Center Content ──────────────────────────────
                SafeArea(
                  child: Center(
                    child: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 24),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            // ── 3D Meditating Baba Scene ──
                            _build3DBabaScene(),

                            const SizedBox(height: 18),

                            // ── Hindi Main Title ──
                            const Text(
                              'पंडित टोडरमल स्मारक ट्रस्ट',
                              style: TextStyle(
                                fontSize: 25,
                                fontWeight: FontWeight.w800,
                                color: Color(0xFF7A1228),
                                letterSpacing: 0.6,
                              ),
                              textAlign: TextAlign.center,
                            )
                                .animate()
                                .fadeIn(duration: 600.ms, delay: 200.ms)
                                .slideY(
                                  begin: 0.2,
                                  end: 0,
                                  duration: 600.ms,
                                  curve: Curves.easeOutCubic,
                                ),

                            const SizedBox(height: 6),

                            // ── English Subtitle ──
                            Text(
                              'Pandit Todarmal Smarak Trust',
                              style: GoogleFonts.cinzel(
                                fontSize: 14.5,
                                fontWeight: FontWeight.w700,
                                color: const Color(0xFF8B4513).withValues(alpha: 0.85),
                                letterSpacing: 1.4,
                              ),
                              textAlign: TextAlign.center,
                            )
                                .animate()
                                .fadeIn(duration: 600.ms, delay: 400.ms)
                                .slideY(
                                  begin: 0.2,
                                  end: 0,
                                  duration: 600.ms,
                                  curve: Curves.easeOutCubic,
                                ),

                            const SizedBox(height: 18),

                            // ── Golden Tagline Pill Badge ──
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 8,
                              ),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: const Color(0xFFF5E6CC).withValues(alpha: 0.55),
                                border: Border.all(
                                  color: const Color(0xFFD4AF37).withValues(alpha: 0.45),
                                  width: 1.2,
                                ),
                                boxShadow: [
                                  BoxShadow(
                                    color: const Color(0xFFC9A94E).withValues(alpha: 0.12),
                                    blurRadius: 10,
                                    offset: const Offset(0, 3),
                                  ),
                                ],
                              ),
                              child: const Text(
                                'जैन दर्शन  |  शिक्षा  |  साहित्य',
                                style: TextStyle(
                                  fontSize: 13.5,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFFB38226),
                                  letterSpacing: 1.2,
                                ),
                              ),
                            )
                                .animate()
                                .fadeIn(duration: 700.ms, delay: 500.ms)
                                .scale(
                                  begin: const Offset(0.92, 0.92),
                                  duration: 700.ms,
                                  curve: Curves.easeOutCubic,
                                ),

                            const SizedBox(height: 28),

                            // ── Dynamic Spiritual Loading Progress ──
                            AnimatedBuilder(
                              animation: _progressController,
                              builder: (context, _) {
                                final pct =
                                    (_progressController.value * 100).toInt();
                                String mantra = 'आत्मशुद्धि (Purifying)';
                                if (pct > 35 && pct <= 70) {
                                  mantra = 'स्वाध्याय (Contemplating)';
                                } else if (pct > 70) {
                                  mantra = 'जय जिनेन्द्र (Awakening)';
                                }

                                return Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: [
                                        const Icon(
                                          Icons.spa_rounded,
                                          size: 13,
                                          color: Color(0xFFB38226),
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          'ॐ $mantra  •  $pct%',
                                          style: GoogleFonts.cormorantGaramond(
                                            fontSize: 14,
                                            fontWeight: FontWeight.w700,
                                            color: const Color(0xFF8B4513),
                                            letterSpacing: 0.8,
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 8),
                                    SizedBox(
                                      width: 160,
                                      height: 3.5,
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(2),
                                        child: LinearProgressIndicator(
                                          value: _progressController.value,
                                          backgroundColor:
                                              const Color(0xFFEADBCE),
                                          valueColor:
                                              const AlwaysStoppedAnimation<Color>(
                                            Color(0xFFC9A94E),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Builds the 3D Levitating Meditating Baba Scene:
  /// - Responsive 3D matrix perspective rotation & elevation
  /// - Ground shadow expansion/contraction synced with floating
  /// - Multi-layered rotating sacred mandala halo
  /// - High-detail Pandit Baba vector artwork matching `media_1795171889245_96be22ec.png`
  Widget _build3DBabaScene() {
    return AnimatedBuilder(
      animation: Listenable.merge([
        _levitateController,
        _haloController,
        _auraController,
        _mudraGlowController,
      ]),
      builder: (context, _) {
        final floatProgress = _levitateController.value; // 0.0 -> 1.0
        // Elevation: moves up by 14 pixels smoothly
        final levitationY = -14.0 * math.sin(floatProgress * math.pi);
        // Subtle 3D tilt: gently rocks forward and back
        final tiltX = 0.04 * math.sin(floatProgress * math.pi * 2);
        final tiltY = 0.02 * math.cos(floatProgress * math.pi * 2);

        // Ground shadow scale: smaller & softer when higher, larger & darker when lower
        final shadowScale = 1.0 - (0.22 * math.sin(floatProgress * math.pi));
        final shadowOpacity = 0.28 - (0.12 * math.sin(floatProgress * math.pi));

        return SizedBox(
          width: 280,
          height: 270,
          child: Stack(
            alignment: Alignment.center,
            children: [
              // ── 1. Ground Shadow on Floor (Responsive to Height) ──
              Positioned(
                bottom: 12,
                child: Container(
                  width: 210 * shadowScale,
                  height: 22 * shadowScale,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF6B4226).withValues(alpha: shadowOpacity),
                        blurRadius: 18 * (1.0 + (1.0 - shadowScale)),
                        spreadRadius: 2,
                      ),
                    ],
                  ),
                ),
              ),

              // ── 2. Rotating Sacred Mandala Halo behind Baba's head ──
              Positioned(
                top: 20 + levitationY * 0.4,
                child: RotationTransition(
                  turns: _haloController,
                  child: CustomPaint(
                    size: const Size(220, 220),
                    painter: _MandalaHaloPainter(),
                  ),
                ),
              ),

              // ── 3. 3D Levitating Baba Artwork ──
              Positioned(
                top: levitationY,
                child: Transform(
                  alignment: Alignment.center,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0012) // 3D perspective depth
                    ..rotateX(tiltX)
                    ..rotateY(tiltY),
                  child: CustomPaint(
                    size: const Size(260, 245),
                    painter: _BabaArtworkPainter(
                      mudraPulse: _mudraGlowController.value,
                    ),
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

/// Custom painter for radiating ambient golden light rays.
class _GoldenAuraRaysPainter extends CustomPainter {
  final double pulseValue;
  _GoldenAuraRaysPainter({required this.pulseValue});

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height * 0.42);

    final glowPaint = Paint()
      ..shader = RadialGradient(
        colors: [
          const Color(0xFFFAB945).withValues(alpha: 0.18 + 0.12 * pulseValue),
          const Color(0xFFE89518).withValues(alpha: 0.08 + 0.06 * pulseValue),
          Colors.transparent,
        ],
        stops: const [0.2, 0.55, 1.0],
      ).createShader(Rect.fromCircle(center: center, radius: 180 + 20 * pulseValue));

    canvas.drawCircle(center, 180 + 20 * pulseValue, glowPaint);
  }

  @override
  bool shouldRepaint(covariant _GoldenAuraRaysPainter oldDelegate) =>
      oldDelegate.pulseValue != pulseValue;
}

/// Custom Painter for the Sacred Mandala Halo disc.
class _MandalaHaloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;

    final ringPaint = Paint()
      ..color = const Color(0xFFE89A3C).withValues(alpha: 0.28)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final innerRingPaint = Paint()
      ..color = const Color(0xFFE89A3C).withValues(alpha: 0.20)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Outer & inner decorative concentric circles
    canvas.drawCircle(center, radius * 0.96, ringPaint);
    canvas.drawCircle(center, radius * 0.82, innerRingPaint);
    canvas.drawCircle(center, radius * 0.65, ringPaint);
    canvas.drawCircle(center, radius * 0.45, innerRingPaint);

    // Radiating petals / rays
    const rayCount = 18;
    final rayPaint = Paint()
      ..color = const Color(0xFFF58A1F).withValues(alpha: 0.18)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < rayCount; i++) {
      final angle = (i * 2 * math.pi) / rayCount;
      final x1 = center.dx + radius * 0.45 * math.cos(angle);
      final y1 = center.dy + radius * 0.45 * math.sin(angle);
      final x2 = center.dx + radius * 0.82 * math.cos(angle);
      final y2 = center.dy + radius * 0.82 * math.sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), rayPaint);
    }

    // 24 Tirthankara golden dots around outer circle
    const dotCount = 24;
    final dotPaint = Paint()..color = const Color(0xFFD4AF37);
    for (int i = 0; i < dotCount; i++) {
      final angle = (i * 2 * math.pi) / dotCount;
      final dx = center.dx + radius * 0.89 * math.cos(angle);
      final dy = center.dy + radius * 0.89 * math.sin(angle);
      canvas.drawCircle(Offset(dx, dy), 1.8, dotPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom Vector Painter for the Meditating Baba / Jain Pandit.
///
/// Accurately renders every element from `media_1795171889245_96be22ec.png`:
/// - Turquoise/Teal meditation mat with diagonal golden stitching
/// - Flanking sacred lotus leaves
/// - Padmasana crossed-leg seating posture in vibrant saffron orange dhoti
/// - Saffron robe draped gracefully over shoulder
/// - Sacred neck mala beads
/// - Peaceful meditating face with closed curved eyes and red vertical tilak
/// - Serene long white flowing beard & head top-knot (Jata bun)
/// - Raised right hand in Abhaya Mudra blessing gesture with pulsing golden ripples
/// - Left hand resting peacefully in lap
class _BabaArtworkPainter extends CustomPainter {
  final double mudraPulse;
  _BabaArtworkPainter({required this.mudraPulse});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final bottom = size.height - 12;

    // ── 1. Sacred Green Foliage / Lotus Leaves at Base ──
    final leafPaint = Paint()..color = const Color(0xFF386641);
    final leafHighlight = Paint()..color = const Color(0xFF4A7C59);

    // Left leaves
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 105, bottom - 18), width: 34, height: 18),
      leafPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 118, bottom - 28), width: 26, height: 14),
      leafHighlight,
    );

    // Right leaves
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 105, bottom - 18), width: 34, height: 18),
      leafPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 118, bottom - 28), width: 26, height: 14),
      leafHighlight,
    );

    // ── 2. Meditation Mat (Teal / Turquoise with Golden Fringe) ──
    final matPaint = Paint()..color = const Color(0xFF0F9B98);
    final matBorder = Paint()
      ..color = const Color(0xFF0B7A77)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;

    final matRect = Rect.fromCenter(
      center: Offset(cx, bottom),
      width: 220,
      height: 32,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(matRect, const Radius.circular(16)),
      matPaint,
    );
    canvas.drawRRect(
      RRect.fromRectAndRadius(matRect, const Radius.circular(16)),
      matBorder,
    );

    // Golden diagonal stitch pattern on mat
    final stitchPaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    for (double x = cx - 88; x <= cx + 88; x += 12) {
      canvas.drawLine(
        Offset(x, bottom - 6),
        Offset(x + 6, bottom + 5),
        stitchPaint,
      );
    }

    // ── 3. Meditating Body in Padmasana (Crossed Legs) ──
    final saffronBase = Paint()..color = const Color(0xFFF58A1F);
    final saffronShadow = Paint()..color = const Color(0xFFE07000);
    final saffronFold = Paint()
      ..color = const Color(0xFFC75D00)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;

    final skinPaint = Paint()..color = const Color(0xFFFFD4B2);
    final hairPaint = Paint()..color = Colors.white;

    // Crossed Legs Base Path
    final legsPath = Path()
      ..moveTo(cx - 90, bottom - 6)
      ..quadraticBezierTo(cx - 100, bottom - 42, cx - 55, bottom - 46)
      ..quadraticBezierTo(cx, bottom - 54, cx + 55, bottom - 46)
      ..quadraticBezierTo(cx + 100, bottom - 42, cx + 90, bottom - 6)
      ..close();
    canvas.drawPath(legsPath, saffronBase);
    canvas.drawPath(legsPath, saffronFold);

    // Bare feet peeking out
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx - 68, bottom - 10), width: 24, height: 14),
      skinPaint,
    );
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 68, bottom - 10), width: 24, height: 14),
      skinPaint,
    );

    // ── 4. Torso & Draped Saffron Angavastra ──
    final torsoPath = Path()
      ..moveTo(cx - 38, bottom - 46)
      ..lineTo(cx - 34, bottom - 125)
      ..quadraticBezierTo(cx, bottom - 134, cx + 34, bottom - 125)
      ..lineTo(cx + 38, bottom - 46)
      ..close();
    canvas.drawPath(torsoPath, skinPaint);

    // Saffron robe draped across torso over left shoulder
    final robePath = Path()
      ..moveTo(cx - 34, bottom - 125)
      ..lineTo(cx + 28, bottom - 72)
      ..lineTo(cx + 38, bottom - 46)
      ..lineTo(cx - 38, bottom - 46)
      ..close();
    canvas.drawPath(robePath, saffronBase);
    canvas.drawPath(robePath, saffronFold);

    // Left shoulder drape fold
    final leftShoulderFold = Path()
      ..moveTo(cx - 34, bottom - 125)
      ..lineTo(cx - 16, bottom - 128)
      ..lineTo(cx + 12, bottom - 74)
      ..lineTo(cx - 18, bottom - 74)
      ..close();
    canvas.drawPath(leftShoulderFold, saffronShadow);

    // Sacred Rudraksha / Mala beads around neck
    final malaPaint = Paint()
      ..color = const Color(0xFF4A2A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.4;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, bottom - 116), width: 36, height: 40),
      0,
      math.pi,
      false,
      malaPaint,
    );

    // ── 5. Head, Face & Sacred Facial Features ──
    // Head shape
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx, bottom - 146), width: 42, height: 48),
      skinPaint,
    );

    // White flowing beard
    final beardPath = Path()
      ..moveTo(cx - 21, bottom - 142)
      ..quadraticBezierTo(cx - 26, bottom - 102, cx, bottom - 80)
      ..quadraticBezierTo(cx + 26, bottom - 102, cx + 21, bottom - 142)
      ..close();
    canvas.drawPath(beardPath, hairPaint);
    canvas.drawPath(
      beardPath,
      Paint()
        ..color = const Color(0xFFEDE0D4)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.0,
    );

    // White Hair on head & sacred top-knot bun (Jata)
    final hairTopPath = Path()
      ..moveTo(cx - 21, bottom - 150)
      ..quadraticBezierTo(cx, bottom - 176, cx + 21, bottom - 150)
      ..close();
    canvas.drawPath(hairTopPath, hairPaint);
    // Top knot bun
    canvas.drawCircle(Offset(cx, bottom - 174), 11, hairPaint);

    // Closed serene meditating eyes
    final eyesPaint = Paint()
      ..color = const Color(0xFF6E4230)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.0;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx - 8, bottom - 147), width: 9, height: 5),
      0,
      math.pi,
      false,
      eyesPaint,
    );
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx + 8, bottom - 147), width: 9, height: 5),
      0,
      math.pi,
      false,
      eyesPaint,
    );

    // Sacred Vermilion Tilak on forehead
    final tilakPaint = Paint()..color = const Color(0xFFD32F2F);
    canvas.drawLine(
      Offset(cx, bottom - 163),
      Offset(cx, bottom - 154),
      tilakPaint..strokeWidth = 2.4,
    );

    // ── 6. Hands & Blessing Mudra ──
    // Left hand resting calmly on lap
    canvas.drawOval(
      Rect.fromCenter(center: Offset(cx + 12, bottom - 46), width: 19, height: 12),
      skinPaint,
    );

    // Right Hand in Abhaya Mudra (Raised blessing gesture)
    final mudraCenter = Offset(cx - 48, bottom - 100);

    // Pulsing Golden Energy Waves radiating from the blessing palm
    final rippleRadius = 14 + (16 * mudraPulse);
    final rippleOpacity = (1.0 - mudraPulse).clamp(0.0, 1.0);
    final ripplePaint = Paint()
      ..color = const Color(0xFFFFD54F).withValues(alpha: 0.45 * rippleOpacity)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.6;
    canvas.drawCircle(mudraCenter, rippleRadius, ripplePaint);

    // Hand palm
    canvas.drawCircle(mudraCenter, 12, skinPaint);
    // Upraised blessing fingers
    final fingerPaint = Paint()
      ..color = const Color(0xFFFFD4B2)
      ..strokeCap = StrokeCap.round
      ..strokeWidth = 5.0;
    canvas.drawLine(
      Offset(cx - 48, bottom - 100),
      Offset(cx - 48, bottom - 114),
      fingerPaint,
    );
    canvas.drawLine(
      Offset(cx - 43, bottom - 100),
      Offset(cx - 43, bottom - 112),
      fingerPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _BabaArtworkPainter oldDelegate) =>
      oldDelegate.mudraPulse != mudraPulse;
}
