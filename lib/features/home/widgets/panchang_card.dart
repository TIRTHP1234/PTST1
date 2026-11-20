import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/shared/animations/golden_sheen_border.dart';
import 'package:ptst_app/shared/animations/tilt_3d_card.dart';

/// Today's Jain Panchang / Tithi info card with golden sheen border and 3D tilt.
class PanchangCard extends StatelessWidget {
  const PanchangCard({super.key, this.isHindi});

  final bool? isHindi;

  @override
  Widget build(BuildContext context) {
    final isHindiActive =
        isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingS,
      ),
      child: Tilt3DCard(
        maxTiltAngle: 0.05,
        borderRadius: AppDimensions.radiusL,
        child: GoldenSheenBorder(
          borderRadius: AppDimensions.radiusL,
          strokeWidth: 1.2,
          duration: const Duration(seconds: 5),
          child: Container(
            width: double.infinity,
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              color: AppColors.ivory,
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              border: Border.all(
                color: AppColors.antiqueGold.withValues(alpha: 0.35),
                width: 1.0,
              ),
              boxShadow: [
                BoxShadow(
                  color: AppColors.deepMaroon.withValues(alpha: 0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 3),
                ),
              ],
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ── Header Row ──
                Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: AppColors.antiqueGold.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Icon(
                        Iconsax.calendar_1,
                        size: 20,
                        color: AppColors.antiqueGold,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindiActive
                              ? 'आज का जैन पंचांग'
                              : 'Today\'s Jain Panchang',
                          style: isHindiActive
                              ? const TextStyle(
                                  color: AppColors.deepMaroon,
                                  fontSize: 14.5,
                                  fontWeight: FontWeight.w700,
                                )
                              : GoogleFonts.cinzel(
                                  color: AppColors.deepMaroon,
                                  fontSize: 14,
                                  fontWeight: FontWeight.w700,
                                  letterSpacing: 0.8,
                                ),
                        ),
                        Text(
                          isHindiActive
                              ? 'वीर निर्वाण संवत् २५५२'
                              : 'Veer Nirvana Samvat 2552',
                          style: TextStyle(
                            color: AppColors.royalBurgundy.withValues(alpha: 0.6),
                            fontSize: 11,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                    const Spacer(),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10,
                        vertical: 4,
                      ),
                      decoration: BoxDecoration(
                        color: AppColors.saffronOrange.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: AppColors.saffronOrange.withValues(alpha: 0.25),
                          width: 0.8,
                        ),
                      ),
                      child: Text(
                        isHindiActive ? 'पवित्र तिथि' : 'Sacred Day',
                        style: isHindiActive
                            ? const TextStyle(
                                color: AppColors.saffronOrange,
                                fontSize: 11,
                                fontWeight: FontWeight.w700,
                              )
                            : GoogleFonts.cormorantGaramond(
                                color: AppColors.saffronOrange,
                                fontSize: 12,
                                fontWeight: FontWeight.w700,
                              ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 14),

                // ── Tithi & Solar Timing Grid ──
                Container(
                  padding: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    color: AppColors.warmBeige.withValues(alpha: 0.35),
                    borderRadius: BorderRadius.circular(AppDimensions.radiusM),
                    border: Border.all(
                      color: AppColors.antiqueGold.withValues(alpha: 0.15),
                      width: 0.6,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _InfoItem(
                        label: isHindiActive ? 'तिथि' : 'Tithi',
                        value: isHindiActive
                            ? 'शुक्ल एकादशी'
                            : 'Shukla Ekadashi',
                        isHindi: isHindiActive,
                      ),
                      Container(
                        width: 1,
                        height: 28,
                        color: AppColors.antiqueGold.withValues(alpha: 0.3),
                      ),
                      _InfoItem(
                        label: isHindiActive ? 'सूर्योदय' : 'Sunrise',
                        value: isHindiActive ? '०६:१२ प्रातः' : '06:12 AM',
                        isHindi: isHindiActive,
                      ),
                      Container(
                        width: 1,
                        height: 28,
                        color: AppColors.antiqueGold.withValues(alpha: 0.3),
                      ),
                      _InfoItem(
                        label: isHindiActive ? 'सूर्यास्त' : 'Sunset',
                        value: isHindiActive ? '१८:२४ सायं' : '06:24 PM',
                        isHindi: isHindiActive,
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

class _InfoItem extends StatelessWidget {
  const _InfoItem({
    required this.label,
    required this.value,
    required this.isHindi,
  });

  final String label;
  final String value;
  final bool isHindi;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 10.5,
            color: AppColors.textSecondaryLight.withValues(alpha: 0.8),
            fontWeight: FontWeight.w500,
          ),
        ),
        const SizedBox(height: 3),
        Text(
          value,
          style: isHindi
              ? const TextStyle(
                  fontSize: 12.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepMaroon,
                )
              : GoogleFonts.cormorantGaramond(
                  fontSize: 13.5,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepMaroon,
                ),
        ),
      ],
    );
  }
}
