import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/shared/animations/golden_sheen_border.dart';
import 'package:ptst_app/shared/animations/tilt_3d_card.dart';

/// Spiritual daily thought / quote card with 3D perspective hover,
/// golden filigree border, dynamic reflection sheen, and bilingual support.
class DailyThoughtCard extends StatelessWidget {
  const DailyThoughtCard({super.key, this.isHindi});

  final bool? isHindi;

  @override
  Widget build(BuildContext context) {
    final hindi =
        isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    final label = hindi ? 'आज का आध्यात्मिक विचार' : 'TODAY\'S SACRED THOUGHT';
    final quote = hindi
        ? '“जो आत्मा को जानता है, वही सच्चा ज्ञानी है। बाहरी संपत्ति नहीं, आंतरिक शुद्धि ही असली धन है।”'
        : '“One who knows the true nature of Soul is truly enlightened. Not external wealth, but inner purity alone is ultimate treasure.”';
    final author = hindi
        ? 'आचार्य कुन्दकुन्द — समयसार'
        : 'Acharya Kundakunda — Samayasara';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: GoldenSheenBorder(
        borderRadius: AppDimensions.radiusL,
        strokeWidth: 1.4,
        child: Tilt3DCard(
        maxTiltAngle: 0.12,
        glareOpacity: 0.28,
        glareColor: const Color(0xFFFFD54F),
        borderRadius: AppDimensions.radiusL,
        child: Container(
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFFFFFDF8),
                Color(0xFFF9F3E3),
                Color(0xFFFFFDF8),
              ],
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: AppColors.antiqueGold.withValues(alpha: 0.4),
              width: 1.2,
            ),
          ),
          child: Stack(
            children: [
              // ── Background Mandala Pattern ──
              Positioned(
                right: -25,
                bottom: -25,
                child: CustomPaint(
                  size: const Size(160, 160),
                  painter: _MandalaPainter(),
                ),
              ),

              // ── Gold accent left bar ──
              Positioned(
                left: 0,
                top: 0,
                bottom: 0,
                child: Container(
                  width: 4.5,
                  decoration: const BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        AppColors.antiqueGold,
                        Color(0xFFFFD54F),
                        AppColors.antiqueGold,
                      ],
                    ),
                    borderRadius: BorderRadius.horizontal(
                      left: Radius.circular(AppDimensions.radiusL),
                    ),
                  ),
                ),
              ),

              // ── Content ──
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingL),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header label
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            color:
                                AppColors.antiqueGold.withValues(alpha: 0.14),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Iconsax.quote_up,
                            size: 16,
                            color: AppColors.antiqueGold,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          label,
                          style: hindi
                              ? const TextStyle(
                                  color: AppColors.antiqueGold,
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                )
                              : GoogleFonts.cinzel(
                                  color: AppColors.antiqueGold,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 1.2,
                                ),
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 3),
                          decoration: BoxDecoration(
                            color: AppColors.deepMaroon.withValues(alpha: 0.06),
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(
                              color:
                                  AppColors.antiqueGold.withValues(alpha: 0.3),
                              width: 0.8,
                            ),
                          ),
                          child: Text(
                            hindi ? '३D प्रेक्षा' : '3D View',
                            style: GoogleFonts.cormorantGaramond(
                              fontSize: 11.5,
                              color: AppColors.deepMaroon,
                              fontWeight: FontWeight.w700,
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // Quote text in classic serif
                    Text(
                      quote,
                      style: hindi
                          ? const TextStyle(
                              fontFamily: 'NotoSansDevanagari',
                              color: AppColors.deepMaroon,
                              fontSize: 16,
                              fontWeight: FontWeight.w600,
                              height: 1.6,
                              fontStyle: FontStyle.italic,
                            )
                          : GoogleFonts.cormorantGaramond(
                              color: AppColors.deepMaroon,
                              fontSize: 18,
                              fontWeight: FontWeight.w700,
                              height: 1.45,
                              fontStyle: FontStyle.italic,
                              letterSpacing: 0.2,
                            ),
                    ),
                    const SizedBox(height: 12),

                    // Attribution
                    Row(
                      children: [
                        Container(
                          width: 20,
                          height: 1.5,
                          color: AppColors.antiqueGold,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          author,
                          style: hindi
                              ? TextStyle(
                                  color: AppColors.royalBurgundy
                                      .withValues(alpha: 0.8),
                                  fontSize: 13,
                                  fontWeight: FontWeight.w600,
                                )
                              : GoogleFonts.cinzel(
                                  color: AppColors.royalBurgundy
                                      .withValues(alpha: 0.85),
                                  fontSize: 11.5,
                                  fontWeight: FontWeight.w600,
                                  letterSpacing: 0.6,
                                ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 14),

                    // ── Action Buttons ──
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        _ActionIcon(
                          icon: Iconsax.share,
                          tooltip: hindi ? 'शेयर करें' : 'Share',
                          onTap: () {},
                        ),
                        const SizedBox(width: 10),
                        _ActionIcon(
                          icon: Iconsax.bookmark,
                          tooltip: hindi ? 'सहेजें' : 'Save',
                          onTap: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}

class _ActionIcon extends StatelessWidget {
  const _ActionIcon({
    required this.icon,
    required this.tooltip,
    required this.onTap,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(8),
        child: Container(
          padding: const EdgeInsets.all(7),
          decoration: BoxDecoration(
            color: AppColors.antiqueGold.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: AppColors.antiqueGold.withValues(alpha: 0.25),
              width: 0.8,
            ),
          ),
          child: Icon(
            icon,
            size: 16,
            color: AppColors.deepMaroon,
          ),
        ),
      ),
    );
  }
}

/// Mandala circular background painter.
class _MandalaPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final paint = Paint()
      ..color = AppColors.antiqueGold.withValues(alpha: 0.08)
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.0;

    // Concentric rings
    canvas.drawCircle(center, size.width * 0.45, paint);
    canvas.drawCircle(center, size.width * 0.32, paint);
    canvas.drawCircle(center, size.width * 0.18, paint);

    // 8 Radial petals
    const petalCount = 8;
    for (int i = 0; i < petalCount; i++) {
      final angle = (i * 2 * math.pi) / petalCount;
      final x = center.dx + size.width * 0.4 * math.cos(angle);
      final y = center.dy + size.height * 0.4 * math.sin(angle);
      canvas.drawLine(center, Offset(x, y), paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
