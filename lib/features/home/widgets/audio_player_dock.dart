import 'dart:math' as math;
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Currently playing track model.
class PlayingTrack {
  final String title;
  final String speaker;
  final String duration;
  final bool isPlaying;

  const PlayingTrack({
    required this.title,
    required this.speaker,
    required this.duration,
    this.isPlaying = true,
  });

  PlayingTrack copyWith({bool? isPlaying}) {
    return PlayingTrack(
      title: title,
      speaker: speaker,
      duration: duration,
      isPlaying: isPlaying ?? this.isPlaying,
    );
  }
}

/// Riverpod state notifier for the floating spiritual audio player.
class NowPlayingNotifier extends StateNotifier<PlayingTrack?> {
  NowPlayingNotifier() : super(null);

  void play({
    required String title,
    required String speaker,
    required String duration,
  }) {
    state = PlayingTrack(
      title: title,
      speaker: speaker,
      duration: duration,
      isPlaying: true,
    );
  }

  void togglePlayPause() {
    if (state != null) {
      state = state!.copyWith(isPlaying: !state!.isPlaying);
    }
  }

  void stop() {
    state = null;
  }
}

final nowPlayingProvider =
    StateNotifierProvider<NowPlayingNotifier, PlayingTrack?>((ref) {
  return NowPlayingNotifier();
});

/// SoundwaveBars — Animated golden acoustic frequency visualizer bars.
class SoundwaveBars extends StatefulWidget {
  const SoundwaveBars({
    super.key,
    this.barCount = 5,
    this.height = 18,
    this.color = const Color(0xFFFFD54F),
    this.isPlaying = true,
  });

  final int barCount;
  final double height;
  final Color color;
  final bool isPlaying;

  @override
  State<SoundwaveBars> createState() => _SoundwaveBarsState();
}

class _SoundwaveBarsState extends State<SoundwaveBars>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    if (widget.isPlaying) {
      _controller.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant SoundwaveBars oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isPlaying && !_controller.isAnimating) {
      _controller.repeat();
    } else if (!widget.isPlaying && _controller.isAnimating) {
      _controller.stop();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return RepaintBoundary(
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          return Row(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: List.generate(widget.barCount, (i) {
              final phase = (i * 0.28);
              final progress = (_controller.value + phase) % 1.0;
              final wave = math.sin(progress * 2 * math.pi);
              final scale = widget.isPlaying
                  ? (0.25 + 0.75 * ((wave + 1) / 2))
                  : 0.3;

              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 1.5),
                width: 3.0,
                height: widget.height * scale,
                decoration: BoxDecoration(
                  color: widget.color,
                  borderRadius: BorderRadius.circular(2),
                ),
              );
            }),
          );
        },
      ),
    );
  }
}

/// FloatingAudioPlayerDock — Luxury docked floating audio player.
class FloatingAudioPlayerDock extends ConsumerStatefulWidget {
  const FloatingAudioPlayerDock({super.key});

  @override
  ConsumerState<FloatingAudioPlayerDock> createState() =>
      _FloatingAudioPlayerDockState();
}

class _FloatingAudioPlayerDockState
    extends ConsumerState<FloatingAudioPlayerDock>
    with SingleTickerProviderStateMixin {
  late final AnimationController _chakraController;

  @override
  void initState() {
    super.initState();
    _chakraController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 14),
    )..repeat();
  }

  @override
  void dispose() {
    _chakraController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final track = ref.watch(nowPlayingProvider);
    if (track == null) return const SizedBox.shrink();

    if (track.isPlaying && !_chakraController.isAnimating) {
      _chakraController.repeat();
    } else if (!track.isPlaying && _chakraController.isAnimating) {
      _chakraController.stop();
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: AppDimensions.paddingM,
        right: AppDimensions.paddingM,
        bottom: 12,
      ),
      child: Container(
        height: 64,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [
              Color(0xFF5A0016),
              Color(0xFF800020),
              Color(0xFF4A0012),
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(24),
          border: Border.all(
            color: const Color(0xFFFFD54F).withValues(alpha: 0.45),
            width: 1.2,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: 0.4),
              blurRadius: 16,
              offset: const Offset(0, 6),
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(24),
          child: Column(
            children: [
              // ── Player Controls Row ──
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: Row(
                    children: [
                      // Rotating Sacred Chakra Vinyl Disc
                      RotationTransition(
                        turns: _chakraController,
                        child: Container(
                          width: 42,
                          height: 42,
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            gradient: const RadialGradient(
                              colors: [Color(0xFFFFD54F), Color(0xFFC9A94E), Color(0xFF3A000E)],
                              stops: [0.3, 0.7, 1.0],
                            ),
                            border: Border.all(color: const Color(0xFFFFE082), width: 1.2),
                          ),
                          child: const Center(
                            child: Icon(Icons.spa, size: 20, color: Color(0xFF5A0016)),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),

                      // Track Info
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              track.title,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 13,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              track.speaker,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                color: const Color(0xFFFFD54F).withValues(alpha: 0.85),
                                fontSize: 11,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                      ),

                      // Soundwave Visualizer Bars
                      SoundwaveBars(
                        height: 20,
                        barCount: 4,
                        isPlaying: track.isPlaying,
                      ),
                      const SizedBox(width: 12),

                      // Play/Pause Action
                      IconButton(
                        onPressed: () {
                          ref.read(nowPlayingProvider.notifier).togglePlayPause();
                        },
                        icon: Icon(
                          track.isPlaying ? Icons.pause_circle_filled_rounded : Icons.play_circle_filled_rounded,
                          color: const Color(0xFFFFD54F),
                          size: 32,
                        ),
                      ),

                      // Close Button
                      IconButton(
                        onPressed: () {
                          ref.read(nowPlayingProvider.notifier).stop();
                        },
                        icon: const Icon(Icons.close_rounded, color: Colors.white70, size: 20),
                      ),
                    ],
                  ),
                ),
              ),

              // Animated Golden Progress Line
              const LinearProgressIndicator(
                value: 0.42,
                minHeight: 2.5,
                backgroundColor: Color(0xFF3A000E),
                valueColor: AlwaysStoppedAnimation<Color>(Color(0xFFFFD54F)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
