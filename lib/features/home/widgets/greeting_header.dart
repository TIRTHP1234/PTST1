import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Greeting header showing personalized greeting and formatted date
/// dynamically respecting Hindi & English language selection.
/// Classic spiritual styling with pure vector iconography (no emojis).
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({super.key, this.userName, this.isHindi});

  final String? userName;
  final bool? isHindi;

  String _formattedDate(BuildContext context, bool hindi) {
    final now = DateTime.now();

    if (!hindi) {
      return DateFormat('EEEE, d MMMM y').format(now);
    }

    const months = [
      'जनवरी',
      'फरवरी',
      'मार्च',
      'अप्रैल',
      'मई',
      'जून',
      'जुलाई',
      'अगस्त',
      'सितंबर',
      'अक्टूबर',
      'नवंबर',
      'दिसंबर',
    ];
    const days = [
      'सोमवार',
      'मंगलवार',
      'बुधवार',
      'गुरुवार',
      'शुक्रवार',
      'शनिवार',
      'रविवार',
    ];
    final dayName = days[now.weekday - 1];
    final month = months[now.month - 1];
    return '$dayName, ${now.day} $month ${now.year}';
  }

  @override
  Widget build(BuildContext context) {
    final hindi =
        isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');
    final defaultName = hindi ? 'साधर्मी भाई' : 'Sadharmik Brother';
    final displayName = userName ?? defaultName;
    final greeting = hindi ? 'जय जिनेन्द्र, $displayName' : 'Jai Jinendra, $displayName';

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFFDF8), Color(0xFFFAF3E6)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          border: Border.all(
            color: AppColors.antiqueGold.withValues(alpha: 0.35),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: AppColors.deepMaroon.withValues(alpha: 0.06),
              blurRadius: 14,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Greeting Row ──
            Row(
              children: [
                Expanded(
                  child: Text(
                    greeting,
                    style: hindi
                        ? const TextStyle(
                            fontFamily: 'NotoSansDevanagari',
                            color: AppColors.deepMaroon,
                            fontWeight: FontWeight.w700,
                            fontSize: 19.5,
                            letterSpacing: 0.3,
                          )
                        : GoogleFonts.cinzel(
                            color: AppColors.deepMaroon,
                            fontWeight: FontWeight.w700,
                            fontSize: 18,
                            letterSpacing: 0.5,
                          ),
                  ),
                ),
                // Sacred Lotus Emblem (Pure vector symbol, NO emoji)
                Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.antiqueGold.withValues(alpha: 0.15),
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: AppColors.antiqueGold.withValues(alpha: 0.4),
                      width: 1,
                    ),
                  ),
                  child: const Icon(
                    Icons.spa_rounded,
                    size: 19,
                    color: AppColors.antiqueGold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 6),

            // ── Formatted Date ──
            Row(
              children: [
                const Icon(
                  Iconsax.calendar_1,
                  size: 13,
                  color: AppColors.antiqueGold,
                ),
                const SizedBox(width: 5),
                Text(
                  _formattedDate(context, hindi),
                  style: GoogleFonts.cormorantGaramond(
                    color: AppColors.royalBurgundy.withValues(alpha: 0.75),
                    fontWeight: FontWeight.w600,
                    fontSize: 13.5,
                    letterSpacing: 0.4,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

