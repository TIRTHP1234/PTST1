import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Reusable section header with classic spiritual typography and golden "see all" link.
class SectionHeader extends StatelessWidget {
  const SectionHeader({
    super.key,
    required this.title,
    this.isHindi,
    this.onSeeAllTap,
    this.showSeeAll = true,
  });

  final String title;
  final bool? isHindi;
  final VoidCallback? onSeeAllTap;
  final bool showSeeAll;

  @override
  Widget build(BuildContext context) {
    final hindi = isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ── Title with classic spiritual symbol accent ──
          Expanded(
            child: Row(
              children: [
                Container(
                  width: 3.5,
                  height: 16,
                  decoration: BoxDecoration(
                    color: AppColors.antiqueGold,
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    title,
                    style: hindi
                        ? const TextStyle(
                            fontFamily: 'NotoSansDevanagari',
                            color: AppColors.deepMaroon,
                            fontWeight: FontWeight.w700,
                            fontSize: 16.5,
                            letterSpacing: 0.3,
                          )
                        : GoogleFonts.cinzel(
                            color: AppColors.deepMaroon,
                            fontWeight: FontWeight.w700,
                            fontSize: 15.5,
                            letterSpacing: 0.6,
                          ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),

          // ── See All Link ──
          if (showSeeAll)
            GestureDetector(
              onTap: onSeeAllTap,
              child: Text(
                hindi ? 'सभी देखें →' : 'View All →',
                style: GoogleFonts.cormorantGaramond(
                  color: AppColors.antiqueGold,
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
