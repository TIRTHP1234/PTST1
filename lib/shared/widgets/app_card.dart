/// AppCard — Premium card widget with glassmorphism option.
///
/// Features:
/// - Standard elevated card mode
/// - Glassmorphism (frosted glass) mode with translucent background
/// - Subtle shadow with antique-gold tint
/// - Customizable padding, border radius, and child content
library;

import 'dart:ui';

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

/// A premium card with optional glassmorphism effect.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.isGlassmorphism = false,
    this.padding,
    this.margin,
    this.borderRadius = AppDimensions.radiusLg,
    this.backgroundColor,
    this.borderColor,
    this.elevation = AppDimensions.elevationSm,
    this.onTap,
    this.width,
    this.height,
    this.glassOpacity = 0.15,
    this.blurSigma = 12.0,
  });

  /// Content rendered inside the card.
  final Widget child;

  /// Enable the frosted-glass appearance.
  final bool isGlassmorphism;

  /// Inner padding; defaults to 16px all around.
  final EdgeInsetsGeometry? padding;

  /// Outer margin.
  final EdgeInsetsGeometry? margin;

  /// Corner radius.
  final double borderRadius;

  /// Background color (overridden when [isGlassmorphism] is `true`).
  final Color? backgroundColor;

  /// Border color.
  final Color? borderColor;

  /// Shadow elevation.
  final double elevation;

  /// Tap callback to make the card interactive.
  final VoidCallback? onTap;

  /// Fixed width (optional).
  final double? width;

  /// Fixed height (optional).
  final double? height;

  /// Opacity of the glass layer when [isGlassmorphism] is `true`.
  final double glassOpacity;

  /// Blur intensity for the glassmorphism effect.
  final double blurSigma;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveBg = backgroundColor ??
        (isDark ? AppColors.cardDark : AppColors.cardLight);

    final effectiveBorder = borderColor ??
        (isGlassmorphism
            ? (isDark
                ? Colors.white.withValues(alpha: 0.2)
                : AppColors.antiqueGold.withValues(alpha: 0.3))
            : Colors.transparent);

    Widget card = Container(
      width: width,
      height: height,
      padding: padding ??
          const EdgeInsets.all(AppDimensions.spacingLg),
      margin: margin,
      decoration: BoxDecoration(
        color: isGlassmorphism
            ? (isDark
                ? Colors.white.withValues(alpha: glassOpacity)
                : Colors.white.withValues(alpha: 0.7))
            : effectiveBg,
        borderRadius: BorderRadius.circular(borderRadius),
        border: Border.all(color: effectiveBorder, width: 1.5),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black26 : AppColors.shadow,
            blurRadius: elevation * 4,
            spreadRadius: -elevation,
            offset: Offset(0, elevation * 1.5),
          ),
          // Subtle gold tint shadow for the premium feel
          if (!isDark)
            BoxShadow(
              color: AppColors.antiqueGold.withValues(alpha: 0.08),
              blurRadius: 8,
              spreadRadius: -2,
              offset: const Offset(0, 2),
            ),
        ],
      ),
      child: child,
    );

    // Wrap with blur filter for glassmorphism
    if (isGlassmorphism) {
      card = ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius),
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: blurSigma,
            sigmaY: blurSigma,
          ),
          child: card,
        ),
      );
    }

    // Wrap with InkWell if tappable
    if (onTap != null) {
      return GestureDetector(
        onTap: onTap,
        behavior: HitTestBehavior.opaque,
        child: card,
      );
    }

    return card;
  }
}
