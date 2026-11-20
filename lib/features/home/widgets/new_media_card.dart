import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'audio_player_dock.dart';

/// A single new-media card for audio/video items. Displays a thumbnail,
/// media-type badge, title, duration, and interactive soundwave animation.
class NewMediaCard extends ConsumerStatefulWidget {
  const NewMediaCard({
    super.key,
    required this.title,
    required this.duration,
    required this.isVideo,
    this.isHindi,
    this.onTap,
  });

  final String title;
  final String duration;
  final bool isVideo;
  final bool? isHindi;
  final VoidCallback? onTap;

  @override
  ConsumerState<NewMediaCard> createState() => _NewMediaCardState();
}

class _NewMediaCardState extends ConsumerState<NewMediaCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scale;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 150),
    );
    _scale = Tween(begin: 1.0, end: 0.95).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    final nowPlaying = ref.read(nowPlayingProvider);
    if (nowPlaying?.title == widget.title) {
      ref.read(nowPlayingProvider.notifier).togglePlayPause();
    } else {
      ref.read(nowPlayingProvider.notifier).play(
            title: widget.title,
            speaker: widget.isVideo ? 'Video Lecture' : 'Audio Pravachan',
            duration: widget.duration,
          );
    }
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    final nowPlaying = ref.watch(nowPlayingProvider);
    final isCurrent = nowPlaying?.title == widget.title;
    final isPlaying = isCurrent && (nowPlaying?.isPlaying ?? false);

    return GestureDetector(
      onTapDown: (_) => _controller.forward(),
      onTapUp: (_) {
        _controller.reverse();
        _handleTap();
      },
      onTapCancel: () => _controller.reverse(),
      child: AnimatedBuilder(
        animation: _scale,
        builder: (context, child) =>
            Transform.scale(scale: _scale.value, child: child),
        child: Container(
          width: 180,
          margin: const EdgeInsets.only(right: AppDimensions.paddingM),
          decoration: BoxDecoration(
            color: AppColors.ivory,
            borderRadius: BorderRadius.circular(AppDimensions.radiusM),
            border: Border.all(
              color: isPlaying
                  ? const Color(0xFFFFD54F)
                  : AppColors.antiqueGold.withValues(alpha: 0.25),
              width: isPlaying ? 1.4 : 0.8,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepMaroon.withValues(alpha: 0.07),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Thumbnail ──
              ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(AppDimensions.radiusM),
                ),
                child: Stack(
                  children: [
                    Container(
                      height: 100,
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: widget.isVideo
                              ? [const Color(0xFF1A0A2E), const Color(0xFF3D1E6D)]
                              : [const Color(0xFF0D3B66), const Color(0xFF1B6CA8)],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                      child: Center(
                        child: Icon(
                          widget.isVideo ? Iconsax.video : Iconsax.music,
                          size: 32,
                          color: Colors.white.withValues(alpha: 0.25),
                        ),
                      ),
                    ),

                    // Play overlay / Soundwave overlay
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          width: 36,
                          height: 36,
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.9),
                            shape: BoxShape.circle,
                          ),
                          child: Icon(
                            isPlaying
                                ? Icons.pause_rounded
                                : Icons.play_arrow_rounded,
                            color: widget.isVideo
                                ? const Color(0xFF3D1E6D)
                                : const Color(0xFF0D3B66),
                            size: 22,
                          ),
                        ),
                      ),
                    ),

                    // Soundwave bars if active
                    if (isPlaying)
                      Positioned(
                        top: 6,
                        right: 6,
                        child: Container(
                          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 3),
                          decoration: BoxDecoration(
                            color: Colors.black.withValues(alpha: 0.6),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: const SoundwaveBars(
                            height: 14,
                            barCount: 3,
                            isPlaying: true,
                          ),
                        ),
                      ),

                    // Media type badge
                    Positioned(
                      top: 6,
                      left: 6,
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 3,
                        ),
                        decoration: BoxDecoration(
                          color: widget.isVideo
                              ? AppColors.saffronOrange
                              : AppColors.antiqueGold,
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.isVideo
                              ? ((widget.isHindi ?? true) ? 'वीडियो' : 'Video')
                              : ((widget.isHindi ?? true) ? 'ऑडियो' : 'Audio'),
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w600,
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
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.black.withValues(alpha: 0.75),
                          borderRadius: BorderRadius.circular(4),
                        ),
                        child: Text(
                          widget.duration,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 9,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // ── Details ──
              Padding(
                padding: const EdgeInsets.all(AppDimensions.paddingS + 2),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.title,
                      style: const TextStyle(
                        fontSize: 12.5,
                        fontWeight: FontWeight.w600,
                        color: AppColors.textPrimaryLight,
                        height: 1.25,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                    const SizedBox(height: 4),
                    Row(
                      children: [
                        Icon(
                          widget.isVideo ? Iconsax.video_play : Iconsax.volume_high,
                          size: 11,
                          color: AppColors.antiqueGold,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          widget.isVideo ? 'Video' : 'Audio',
                          style: const TextStyle(
                            fontSize: 10.5,
                            color: AppColors.antiqueGold,
                            fontWeight: FontWeight.w600,
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
