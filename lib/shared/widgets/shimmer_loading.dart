/// ShimmerLoading — Reusable shimmer placeholder widgets.
///
/// Provides ready-made shimmer skeletons for common UI patterns:
/// - [ShimmerCard] — a rectangular card placeholder
/// - [ShimmerListTile] — a list-item placeholder with avatar + lines
/// - [ShimmerGrid] — a grid of shimmer cards
library;

import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

// ═══════════════════════════════════════════════════════════════
//  SHIMMER CARD
// ═══════════════════════════════════════════════════════════════

/// A shimmering rectangular card placeholder.
class ShimmerCard extends StatelessWidget {
  const ShimmerCard({
    super.key,
    this.width = double.infinity,
    this.height = AppDimensions.cardMinHeight,
    this.borderRadius = AppDimensions.radiusLg,
    this.margin,
  });

  final double width;
  final double height;
  final double borderRadius;
  final EdgeInsetsGeometry? margin;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Container(
        width: width,
        height: height,
        margin: margin ??
            const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLg,
              vertical: AppDimensions.spacingSm,
            ),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(borderRadius),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SHIMMER LIST TILE
// ═══════════════════════════════════════════════════════════════

/// A shimmering list-item placeholder with a circular avatar and text lines.
class ShimmerListTile extends StatelessWidget {
  const ShimmerListTile({
    super.key,
    this.hasAvatar = true,
    this.lineCount = 2,
    this.padding,
  });

  /// Whether to show a circular avatar on the left.
  final bool hasAvatar;

  /// Number of text-line skeletons to display.
  final int lineCount;

  /// Custom padding.
  final EdgeInsetsGeometry? padding;

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Shimmer.fromColors(
      baseColor: isDark ? Colors.grey[800]! : Colors.grey[300]!,
      highlightColor: isDark ? Colors.grey[700]! : Colors.grey[100]!,
      child: Padding(
        padding: padding ??
            const EdgeInsets.symmetric(
              horizontal: AppDimensions.spacingLg,
              vertical: AppDimensions.spacingMd,
            ),
        child: Row(
          children: [
            if (hasAvatar) ...[
              Container(
                width: AppDimensions.avatarMd,
                height: AppDimensions.avatarMd,
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: AppDimensions.spacingMd),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: List.generate(lineCount, (index) {
                  return Padding(
                    padding: EdgeInsets.only(
                      bottom: index < lineCount - 1
                          ? AppDimensions.spacingSm
                          : 0,
                    ),
                    child: Container(
                      width: index == 0
                          ? double.infinity
                          : MediaQuery.of(context).size.width * 0.5,
                      height: 14,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(AppDimensions.radiusXs),
                      ),
                    ),
                  );
                }),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SHIMMER LIST (convenience builder)
// ═══════════════════════════════════════════════════════════════

/// Builds a [ListView] of [ShimmerListTile] items.
class ShimmerList extends StatelessWidget {
  const ShimmerList({
    super.key,
    this.itemCount = 6,
    this.hasAvatar = true,
  });

  final int itemCount;
  final bool hasAvatar;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: itemCount,
      itemBuilder: (_, __) => ShimmerListTile(hasAvatar: hasAvatar),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SHIMMER GRID
// ═══════════════════════════════════════════════════════════════

/// Builds a grid of [ShimmerCard] items.
class ShimmerGrid extends StatelessWidget {
  const ShimmerGrid({
    super.key,
    this.itemCount = 4,
    this.crossAxisCount = 2,
    this.childAspectRatio = 1.0,
    this.cardHeight = AppDimensions.cardMinHeight,
  });

  final int itemCount;
  final int crossAxisCount;
  final double childAspectRatio;
  final double cardHeight;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: const EdgeInsets.all(AppDimensions.spacingLg),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: crossAxisCount,
        childAspectRatio: childAspectRatio,
        crossAxisSpacing: AppDimensions.spacingMd,
        mainAxisSpacing: AppDimensions.spacingMd,
      ),
      itemCount: itemCount,
      itemBuilder: (_, __) => ShimmerCard(
        height: cardHeight,
        margin: EdgeInsets.zero,
      ),
    );
  }
}
