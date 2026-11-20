import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Horizontal strip showing "continue reading / listening" items with progress
/// bar, thumbnail, and resume button. Supports Hindi & English.
class ContinueReadingStrip extends StatelessWidget {
  const ContinueReadingStrip({super.key, this.isHindi});

  final bool? isHindi;

  static const _items = [
    _ContinueItem(
      titleHi: 'समयसार — अध्याय ४',
      titleEn: 'Samayasara — Chapter 4',
      typeHi: 'पुस्तक',
      typeEn: 'Book',
      progress: 0.45,
      icon: Iconsax.book_1,
      isAudio: false,
    ),
    _ContinueItem(
      titleHi: 'मोक्षमार्ग प्रकाशक — प्रवचन ७',
      titleEn: 'Mokshamarga Prakashak — Discourse 7',
      typeHi: 'ऑडियो',
      typeEn: 'Audio',
      progress: 0.72,
      icon: Iconsax.music_play,
      isAudio: true,
    ),
    _ContinueItem(
      titleHi: 'प्रवचनसार — गाथा १२',
      titleEn: 'Pravachanasara — Gatha 12',
      typeHi: 'पुस्तक',
      typeEn: 'Book',
      progress: 0.28,
      icon: Iconsax.book_1,
      isAudio: false,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hindi = isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    return Padding(
      padding: const EdgeInsets.only(
        top: AppDimensions.paddingS,
        bottom: AppDimensions.paddingM,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingL,
            ),
            child: Text(
              hindi ? 'जारी रखें' : 'Continue Reading & Listening',
              style: const TextStyle(
                color: AppColors.deepMaroon,
                fontSize: 16,
                fontWeight: FontWeight.w700,
              ),
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 90,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingL,
              ),
              itemCount: _items.length,
              itemBuilder: (context, index) {
                final item = _items[index];
                return _ContinueCard(
                  title: hindi ? item.titleHi : item.titleEn,
                  type: hindi ? item.typeHi : item.typeEn,
                  progress: item.progress,
                  icon: item.icon,
                  isAudio: item.isAudio,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _ContinueItem {
  const _ContinueItem({
    required this.titleHi,
    required this.titleEn,
    required this.typeHi,
    required this.typeEn,
    required this.progress,
    required this.icon,
    required this.isAudio,
  });

  final String titleHi;
  final String titleEn;
  final String typeHi;
  final String typeEn;
  final double progress;
  final IconData icon;
  final bool isAudio;
}

class _ContinueCard extends StatelessWidget {
  const _ContinueCard({
    required this.title,
    required this.type,
    required this.progress,
    required this.icon,
    required this.isAudio,
  });

  final String title;
  final String type;
  final double progress;
  final IconData icon;
  final bool isAudio;

  @override
  Widget build(BuildContext context) {
    final pctText = '${(progress * 100).toInt()}%';

    return Container(
      width: 250,
      margin: const EdgeInsets.only(right: AppDimensions.paddingM),
      padding: const EdgeInsets.all(AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepMaroon.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isAudio
                    ? const [Color(0xFF0D3B66), Color(0xFF1B6CA8)]
                    : const [Color(0xFF800020), Color(0xFFA0334A)],
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusS),
            ),
            child: Icon(icon, color: Colors.white, size: 20),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  children: [
                    Text(
                      type,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.antiqueGold,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(width: 6),
                    Text(
                      pctText,
                      style: const TextStyle(
                        fontSize: 10,
                        color: AppColors.textSecondaryLight,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  title,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimaryLight,
                  ),
                ),
                const SizedBox(height: 6),
                ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: progress,
                    minHeight: 3.5,
                    backgroundColor: AppColors.warmBeige,
                    valueColor: const AlwaysStoppedAnimation(AppColors.antiqueGold),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: AppColors.antiqueGold.withOpacity(0.12),
              shape: BoxShape.circle,
            ),
            child: const Icon(
              Icons.play_arrow_rounded,
              size: 16,
              color: AppColors.antiqueGold,
            ),
          ),
        ],
      ),
    );
  }
}
