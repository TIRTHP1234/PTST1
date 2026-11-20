import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';

/// DharmaPath-Inspired Luxury Spiritual Onboarding Screen.
/// Exactly matches the user's design reference:
/// - Top: Classic dual-line typography ("Welcome to" / "DharmaPath - PTST")
/// - Subtitle description
/// - Page indicator + Circular saffron arrow action button
/// - Bottom: Spiritual Pandit / Guru with radiant mandala halo, saffron robes,
///   meditation posture, sacred shastras, and quill writing!
/// - ZERO emojis, pure vector spiritual symbolism.
class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  static const _slides = [
    _SlideData(
      preTitleHi: 'स्वागतम्',
      preTitleEn: 'Welcome to',
      titleHi: 'पंडित टोडरमल ट्रस्ट!',
      titleEn: 'DharmaPath — PTST!',
      subtitleHi:
          'प्राचीन जैन आगम, पूजन, विधान, प्रवचन एवं आध्यात्मिक ज्ञान का पावन डिजिटल संगम।',
      subtitleEn:
          'Explore sacred texts, rituals, festivals, and connect with your spiritual roots in one place.',
    ),
    _SlideData(
      preTitleHi: 'अनुभव करें',
      preTitleEn: 'Discover',
      titleHi: 'आध्यात्मिकता!',
      titleEn: 'Spirituality!',
      subtitleHi:
          'मोक्षमार्ग प्रकाशक, समयसार, दैनिक स्वाध्याय एवं ध्यान द्वारा आत्म-कल्याण का पावन पथ।',
      subtitleEn:
          'Access ancient scriptures, daily prayers, and sacred chants in one single tap.',
    ),
    _SlideData(
      preTitleHi: 'सीखें एवं जुड़ें',
      preTitleEn: 'Learn & Grow',
      titleHi: 'जैन संस्कार शिक्षा!',
      titleEn: 'Sacred Wisdom!',
      subtitleHi:
          'सर्टिफिकेट कोर्स, प्रश्नोत्तरी, विद्वानों के प्रवचन एवं तत्त्व-ज्ञान की सहज प्राप्ति।',
      subtitleEn:
          'Deepen your inner wisdom through shastras, quizzes, and divine discourses by revered scholars.',
    ),
  ];

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_currentPage < _slides.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeInOutCubic,
      );
    } else {
      context.go('/language');
    }
  }

  void _skip() => context.go('/language');

  @override
  Widget build(BuildContext context) {
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Scaffold(
      backgroundColor: const Color(0xFFFBF6EE), // Sacred warm ivory cream
      body: Stack(
        children: [
          // ── Swipeable PageView ──
          PageView.builder(
            controller: _pageController,
            itemCount: _slides.length,
            onPageChanged: (index) => setState(() => _currentPage = index),
            itemBuilder: (context, index) {
              final slide = _slides[index];
              return _OnboardingSlide(
                slide: slide,
                pageIndex: index,
                isHindi: isHindi,
                pageController: _pageController,
              );
            },
          ),

          // ── Top Navigation Bar: Language Switcher & Skip ──
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
                vertical: AppDimensions.paddingS,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Classic Language Switcher Pill
                  Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => ref.read(localeProvider.notifier).toggleLocale(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: AppColors.deepMaroon.withValues(alpha: 0.08),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.antiqueGold.withValues(alpha: 0.45),
                            width: 1.1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(
                              Icons.translate_rounded,
                              size: 14,
                              color: AppColors.deepMaroon,
                            ),
                            const SizedBox(width: 5),
                            Text(
                              isHindi ? 'English' : 'हिन्दी',
                              style: const TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                                color: AppColors.deepMaroon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  // Skip Link
                  TextButton(
                    onPressed: _skip,
                    child: Text(
                      isHindi ? 'छोड़ें' : 'Skip',
                      style: GoogleFonts.poppins(
                        fontSize: 14.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.deepMaroon.withValues(alpha: 0.7),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ── Floating Action Row: Indicator + Circular Arrow Button ──
          Positioned(
            left: AppDimensions.paddingXl,
            right: AppDimensions.paddingXl,
            top: MediaQuery.of(context).padding.top + 215,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Minimalist Page Indicator (Pill + Dots matching design)
                Row(
                  children: List.generate(_slides.length, (i) {
                    final isActive = _currentPage == i;
                    return AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: const EdgeInsets.only(right: 6),
                      height: 4,
                      width: isActive ? 22 : 6,
                      decoration: BoxDecoration(
                        color: isActive
                            ? const Color(0xFF2D2522)
                            : const Color(0xFF2D2522).withValues(alpha: 0.25),
                        borderRadius: BorderRadius.circular(2),
                      ),
                    );
                  }),
                ),

                // Circular Saffron Orange Next Action Button
                GestureDetector(
                  onTap: _nextPage,
                  child: Container(
                    width: 54,
                    height: 54,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFFF58A1F), Color(0xFFE67300)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFF58A1F).withValues(alpha: 0.38),
                          blurRadius: 16,
                          offset: const Offset(0, 6),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Icon(
                        Icons.arrow_forward_rounded,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _SlideData {
  final String preTitleHi;
  final String preTitleEn;
  final String titleHi;
  final String titleEn;
  final String subtitleHi;
  final String subtitleEn;

  const _SlideData({
    required this.preTitleHi,
    required this.preTitleEn,
    required this.titleHi,
    required this.titleEn,
    required this.subtitleHi,
    required this.subtitleEn,
  });
}

/// Single slide displaying top classic typography and bottom custom spiritual Pandit illustration.
class _OnboardingSlide extends StatelessWidget {
  final _SlideData slide;
  final int pageIndex;
  final bool isHindi;
  final PageController pageController;

  const _OnboardingSlide({
    required this.slide,
    required this.pageIndex,
    required this.isHindi,
    required this.pageController,
  });

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Padding(
      padding: EdgeInsets.only(top: topPadding + 55),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ── 1. Top Typography Block (Matching DharmaPath Design) ──
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingXl),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Light prefix title
                Text(
                  isHindi ? slide.preTitleHi : slide.preTitleEn,
                  style: GoogleFonts.poppins(
                    fontSize: 21,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF4A3E39),
                    letterSpacing: 0.3,
                  ),
                ),
                const SizedBox(height: 2),

                // Bold hero title
                Text(
                  isHindi ? slide.titleHi : slide.titleEn,
                  style: isHindi
                      ? const TextStyle(
                          fontFamily: 'NotoSansDevanagari',
                          fontSize: 31,
                          fontWeight: FontWeight.w800,
                          color: Color(0xFF1E1412),
                          height: 1.2,
                        )
                      : GoogleFonts.cinzel(
                          fontSize: 29,
                          fontWeight: FontWeight.w800,
                          color: const Color(0xFF1E1412),
                          letterSpacing: 0.5,
                          height: 1.2,
                        ),
                ),
                const SizedBox(height: 10),

                // Subtitle description
                Text(
                  isHindi ? slide.subtitleHi : slide.subtitleEn,
                  style: GoogleFonts.poppins(
                    fontSize: 13.5,
                    fontWeight: FontWeight.w400,
                    color: const Color(0xFF6E5F58),
                    height: 1.5,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 70), // Spacing for floating indicator row

          // ── 2. Bottom Spiritual Pandit & Mandala Illustration ──
          Expanded(
            child: Stack(
              alignment: Alignment.bottomCenter,
              children: [
                // Mandala Halo Aura
                Positioned(
                  bottom: -20,
                  child: CustomPaint(
                    size: const Size(360, 360),
                    painter: _MandalaHaloPainter(),
                  ),
                ),

                // Spiritual Guru / Pandit Vector Artwork
                Positioned(
                  bottom: 10,
                  child: CustomPaint(
                    size: const Size(320, 310),
                    painter: _GuruIllustrationPainter(slideIndex: pageIndex),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// Custom Painter rendering the sacred ornamental mandala halo behind the Pandit.
class _MandalaHaloPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paintRing = Paint()
      ..color = const Color(0xFFE89A3C).withValues(alpha: 0.3)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.2;

    final paintDotted = Paint()
      ..color = const Color(0xFFE89A3C).withValues(alpha: 0.22)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;

    // Outer subtle rings
    canvas.drawCircle(center, size.width * 0.46, paintRing);
    canvas.drawCircle(center, size.width * 0.38, paintRing);
    canvas.drawCircle(center, size.width * 0.28, paintDotted);

    // Decorative radiating rays / petals
    const petalCount = 16;
    final petalPaint = Paint()
      ..color = const Color(0xFFF58A1F).withValues(alpha: 0.16)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    for (int i = 0; i < petalCount; i++) {
      final angle = (i * 2 * pi) / petalCount;
      final x1 = center.dx + size.width * 0.28 * cos(angle);
      final y1 = center.dy + size.height * 0.28 * sin(angle);
      final x2 = center.dx + size.width * 0.44 * cos(angle);
      final y2 = center.dy + size.height * 0.44 * sin(angle);
      canvas.drawLine(Offset(x1, y1), Offset(x2, y2), petalPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

/// Custom vector illustration of the revered Jain Pandit / Guru
/// matching the exact aesthetic of DharmaPath in `media_1795168484937_60d218a5.jpg`.
class _GuruIllustrationPainter extends CustomPainter {
  final int slideIndex;
  _GuruIllustrationPainter({required this.slideIndex});

  @override
  void paint(Canvas canvas, Size size) {
    final cx = size.width / 2;
    final bottom = size.height;

    // ── Lotus / Meditation Mat (Turquoise & Gold) ──
    final matPaint = Paint()..color = const Color(0xFF0F9B98);
    final matBorder = Paint()
      ..color = const Color(0xFF0B7A77)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    final matRect = Rect.fromCenter(
      center: Offset(cx, bottom - 15),
      width: 250,
      height: 38,
    );
    canvas.drawRRect(RRect.fromRectAndRadius(matRect, const Radius.circular(19)), matPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(matRect, const Radius.circular(19)), matBorder);

    // Mat golden fringe pattern
    final fringePaint = Paint()
      ..color = const Color(0xFFFFD54F)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    for (double x = cx - 100; x <= cx + 100; x += 14) {
      canvas.drawLine(Offset(x, bottom - 20), Offset(x + 7, bottom - 10), fringePaint);
    }

    // ── Meditating Pandit Body & Saffron Robes ──
    final saffronBody = Paint()..color = const Color(0xFFEE7600);
    final saffronFold = Paint()
      ..color = const Color(0xFFCC6400)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2.5;
    final skinPaint = Paint()..color = const Color(0xFFFFD4B2);
    final hairPaint = Paint()..color = Colors.white;

    // Lower crossed legs (Padmasana)
    final legsPath = Path()
      ..moveTo(cx - 100, bottom - 20)
      ..quadraticBezierTo(cx - 110, bottom - 60, cx - 60, bottom - 65)
      ..quadraticBezierTo(cx, bottom - 75, cx + 60, bottom - 65)
      ..quadraticBezierTo(cx + 110, bottom - 60, cx + 100, bottom - 20)
      ..close();
    canvas.drawPath(legsPath, saffronBody);
    canvas.drawPath(legsPath, saffronFold);

    // Bare feet peeking out
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 75, bottom - 25), width: 28, height: 16), skinPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 75, bottom - 25), width: 28, height: 16), skinPaint);

    // Torso (Saffron dhoti & angavastra draped over left shoulder)
    final torsoPath = Path()
      ..moveTo(cx - 45, bottom - 65)
      ..lineTo(cx - 40, bottom - 155)
      ..quadraticBezierTo(cx, bottom - 165, cx + 40, bottom - 155)
      ..lineTo(cx + 45, bottom - 65)
      ..close();
    canvas.drawPath(torsoPath, skinPaint);

    // Saffron Robe Draped across torso
    final robePath = Path()
      ..moveTo(cx - 40, bottom - 155)
      ..lineTo(cx + 35, bottom - 95)
      ..lineTo(cx + 45, bottom - 65)
      ..lineTo(cx - 45, bottom - 65)
      ..close();
    canvas.drawPath(robePath, saffronBody);
    canvas.drawPath(robePath, saffronFold);

    // Sacred Mala Beads around neck
    final malaPaint = Paint()
      ..color = const Color(0xFF4A2A1A)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 3;
    canvas.drawArc(
      Rect.fromCenter(center: Offset(cx, bottom - 145), width: 44, height: 50),
      0,
      pi,
      false,
      malaPaint,
    );

    // ── Head & Sacred Beard ──
    // Head oval
    canvas.drawOval(Rect.fromCenter(center: Offset(cx, bottom - 180), width: 48, height: 56), skinPaint);

    // White flowing beard and hair bun
    final beardPath = Path()
      ..moveTo(cx - 24, bottom - 175)
      ..quadraticBezierTo(cx - 30, bottom - 130, cx, bottom - 105)
      ..quadraticBezierTo(cx + 30, bottom - 130, cx + 24, bottom - 175)
      ..close();
    canvas.drawPath(beardPath, hairPaint);

    // White Hair on head & top knot bun (Jata)
    final hairTopPath = Path()
      ..moveTo(cx - 24, bottom - 185)
      ..quadraticBezierTo(cx, bottom - 215, cx + 24, bottom - 185)
      ..close();
    canvas.drawPath(hairTopPath, hairPaint);
    canvas.drawCircle(Offset(cx, bottom - 212), 12, hairPaint); // Top knot

    // Peaceful closed eyes & tilak
    final featurePaint = Paint()
      ..color = const Color(0xFF6E4230)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 2;
    canvas.drawArc(Rect.fromCenter(center: Offset(cx - 9, bottom - 180), width: 10, height: 6), 0, pi, false, featurePaint);
    canvas.drawArc(Rect.fromCenter(center: Offset(cx + 9, bottom - 180), width: 10, height: 6), 0, pi, false, featurePaint);

    // Sacred Tilak
    final tilakPaint = Paint()..color = const Color(0xFFD32F2F);
    canvas.drawLine(Offset(cx, bottom - 198), Offset(cx, bottom - 188), tilakPaint..strokeWidth = 2.5);

    // ── Hands (Slide-Specific Pose) ──
    if (slideIndex == 1) {
      // Screen 2: Pandit writing on scripture parchment with quill
      final paperPaint = Paint()..color = Colors.white;
      final paperBorder = Paint()
        ..color = const Color(0xFFD4C2B0)
        ..style = PaintingStyle.stroke
        ..strokeWidth = 1.2;
      final paperRect = Rect.fromCenter(center: Offset(cx + 25, bottom - 75), width: 90, height: 55);
      canvas.drawRRect(RRect.fromRectAndRadius(paperRect, const Radius.circular(6)), paperPaint);
      canvas.drawRRect(RRect.fromRectAndRadius(paperRect, const Radius.circular(6)), paperBorder);

      // Sacred text lines on paper
      final textLinePaint = Paint()
        ..color = const Color(0xFFB09880)
        ..strokeWidth = 1.5;
      for (double y = bottom - 90; y <= bottom - 60; y += 8) {
        canvas.drawLine(Offset(cx - 10, y), Offset(cx + 60, y), textLinePaint);
      }

      // White Feather Quill in right hand
      final quillPaint = Paint()..color = Colors.white;
      final quillPath = Path()
        ..moveTo(cx - 15, bottom - 95)
        ..quadraticBezierTo(cx - 40, bottom - 145, cx - 10, bottom - 140)
        ..lineTo(cx - 15, bottom - 95)
        ..close();
      canvas.drawPath(quillPath, quillPaint);
      canvas.drawPath(quillPath, Paint()..color = const Color(0xFFC0A890)..style = PaintingStyle.stroke..strokeWidth = 1);
    } else {
      // Screen 1 & 3: Right hand raised in blessing (Abhaya Mudra)
      canvas.drawCircle(Offset(cx - 55, bottom - 125), 14, skinPaint);
      final fingerPaint = Paint()
        ..color = const Color(0xFFFFD4B2)
        ..strokeCap = StrokeCap.round
        ..strokeWidth = 6;
      canvas.drawLine(Offset(cx - 55, bottom - 125), Offset(cx - 55, bottom - 142), fingerPaint);
      canvas.drawLine(Offset(cx - 49, bottom - 125), Offset(cx - 49, bottom - 140), fingerPaint);

      // Left hand resting calmly on lap
      canvas.drawOval(Rect.fromCenter(center: Offset(cx + 15, bottom - 65), width: 22, height: 14), skinPaint);
    }

    // ── Sacred Foliage / Lotus Leaves at Base ──
    final leafPaint = Paint()..color = const Color(0xFF4A7C59);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 115, bottom - 50), width: 34, height: 18), leafPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx + 125, bottom - 70), width: 30, height: 16), leafPaint);
    canvas.drawOval(Rect.fromCenter(center: Offset(cx - 115, bottom - 45), width: 32, height: 16), leafPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
