import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/shared/animations/tilt_3d_card.dart';
import 'audio_player_dock.dart';

/// A single featured pravachan (discourse) card with 3D tilt hover animation,
/// gradient thumbnail, glowing play button overlay, title, speaker, and duration.
/// Tapping plays the audio and triggers real-time golden soundwaves & the floating dock!
class FeaturedPravachanCard extends ConsumerWidget {
  const FeaturedPravachanCard({
    super.key,
    required this.title,
    required this.speaker,
    required this.duration,
    this.onTap,
  });

  final String title;
  final String speaker;
  final String duration;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final nowPlaying = ref.watch(nowPlayingProvider);
    final isCurrentTrack = nowPlaying?.title == title;
    final isPlaying = isCurrentTrack && (nowPlaying?.isPlaying ?? false);

    void handlePlay() {
      if (isCurrentTrack) {
        ref.read(nowPlayingProvider.notifier).togglePlayPause();
      } else {
        ref.read(nowPlayingProvider.notifier).play(
              title: title,
              speaker: speaker,
              duration: duration,
            );
      }
      onTap?.call();
    }

    return Container(
      width: 215,
      margin: const EdgeInsets.only(right: AppDimensions.paddingM),
      child: Tilt3DCard(
        maxTiltAngle: 0.14,
        glareOpacity: 0.22,
        borderRadius: AppDimensions.radiusM,
        onTap: handlePlay,
        child: Container(
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: isPlaying
                  ? const Color(0xFFFFD54F)
                  : AppColors.antiqueGold.withValues(alpha: 0.3),
              width: isPlaying ? 1.5 : 1.0,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Thumbnail with play overlay ──
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimensions.radiusM),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 115,
                      width: double.infinity,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFF6B0E23),
                            Color(0xFF800020),
                            Color(0xFF4A0012),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          Iconsax.microphone,
                          size: 40,
                          color: AppColors.antiqueGold.withValues(alpha: 0.25),
                        ),
                      ),
                    ),
                    // Sacred Om glow in background of thumbnail
                    Positioned(
                      right: 12,
                      top: 10,
                      child: Text(
                        'ॐ',
                        style: TextStyle(
                          color: AppColors.antiqueGold.withValues(alpha: 0.18),
                          fontSize: 32,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    // Soundwave animation if active
                    if (isPlaying)
                      Positioned(
                        top: 10,
                        left: 12,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const SoundwaveBars(
                            height: 16,
                            barCount: 4,
                            isPlaying: true,
                          ),
                        ),
                      ),

                    // 3D Play icon overlay
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            gradient: const RadialGradient(
                              colors: [Color(0xFFFFE082), Color(0xFFC9A94E)],
                            ),
                            shape: BoxShape.circle,
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withValues(alpha: 0.35),
                                blurRadius: 10,
                                offset: const Offset(0, 3),
                              ),
                              BoxShadow(
                                color: const Color(0xFFFFD700).withValues(alpha: 0.4),
                                blurRadius: 12,
                              ),
                            ],
                          ),
                          child: Icon(
                            isPlaying ? Icons.pause_rounded : Icons.play_arrow_rounded,
                            color: const Color(0xFF5A0016),
                            size: 26,
                          ),
                        ),
                      ),
                    ),
                    // Duration badge
                    Positioned(
                      bottom: 6,
                      right: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(4),
                          border: Border.all(
                            color: AppColors.antiqueGold.withValues(alpha: 0.5),
                            width: 0.6,
                          ),
                        ),
                        child: Text(
                          duration,
                          style: const TextStyle(
                            color: Color(0xFFFFE082),
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Info section ──
              Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: const TextStyle(
                        color: AppColors.deepMaroon,
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        height: 1.3,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: [
                        Icon(
                          Iconsax.user,
                          size: 13,
                          color: AppColors.antiqueGold.withValues(alpha: 0.8),
                        ),
                        const SizedBox(width: 4),
                        Expanded(
                          child: Text(
                            speaker,
                            style: TextStyle(
                              color: AppColors.royalBurgundy.withValues(alpha: 0.7),
                              fontSize: 11.5,
                              fontWeight: FontWeight.w500,
                            ),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
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
    );
  }
}
