import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ptst_app/core/constants/app_colors.dart';

/// Animated PIN dot indicator for MPIN entry screens.
///
/// Shows empty circles that fill with a bounce animation when digits are entered.
/// Uses golden/maroon colors to match the spiritual aesthetic.
class PinDots extends StatelessWidget {
  /// Total number of PIN digits expected (4 or 6).
  final int pinLength;

  /// Current number of digits entered.
  final int filledCount;

  /// Whether to display error state (shake + red dots).
  final bool hasError;

  /// Dot size.
  final double dotSize;

  /// Spacing between dots.
  final double spacing;

  const PinDots({
    super.key,
    this.pinLength = 4,
    required this.filledCount,
    this.hasError = false,
    this.dotSize = 18,
    this.spacing = 20,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(pinLength, (index) {
        final isFilled = index < filledCount;
        return Padding(
          padding: EdgeInsets.symmetric(horizontal: spacing / 2),
          child: _AnimatedDot(
            isFilled: isFilled,
            hasError: hasError,
            size: dotSize,
            index: index,
          ),
        );
      }),
    );
  }
}

class _AnimatedDot extends StatelessWidget {
  final bool isFilled;
  final bool hasError;
  final double size;
  final int index;

  const _AnimatedDot({
    required this.isFilled,
    required this.hasError,
    required this.size,
    required this.index,
  });

  @override
  Widget build(BuildContext context) {
    final fillColor = hasError
        ? Colors.red.shade400
        : AppColors.deepMaroon;

    final borderColor = hasError
        ? Colors.red.shade300
        : isFilled
            ? AppColors.antiqueGold
            : AppColors.deepMaroon.withOpacity(0.25);

    Widget dot = AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOutCubic,
      width: size,
      height: size,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isFilled ? fillColor : Colors.transparent,
        border: Border.all(
          color: borderColor,
          width: isFilled ? 2.5 : 1.8,
        ),
        boxShadow: isFilled
            ? [
                BoxShadow(
                  color: (hasError
                          ? Colors.red
                          : AppColors.antiqueGold)
                      .withOpacity(0.35),
                  blurRadius: 10,
                  spreadRadius: 1,
                ),
              ]
            : null,
      ),
    );

    // Bounce animation when filled
    if (isFilled) {
      dot = dot
          .animate(
            autoPlay: true,
          )
          .scale(
            begin: const Offset(0.5, 0.5),
            end: const Offset(1.0, 1.0),
            duration: 300.ms,
            curve: Curves.elasticOut,
          );
    }

    // Shake animation on error
    if (hasError) {
      dot = dot
          .animate(
            autoPlay: true,
          )
          .shake(
            hz: 4,
            offset: const Offset(4, 0),
            duration: 400.ms,
            delay: Duration(milliseconds: index * 30),
          );
    }

    return dot;
  }
}
