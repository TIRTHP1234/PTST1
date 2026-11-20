/// AppButton — Premium animated elevated button.
///
/// Features:
/// - Scale-down animation on press for tactile feedback
/// - Optional gradient background (maroon → burgundy by default)
/// - Loading state with circular progress indicator
/// - Disabled state handling
/// - Customizable border radius, padding, and text style
library;

import 'package:flutter/material.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';

/// A premium elevated button with press animation and optional gradient.
class AppButton extends StatefulWidget {
  const AppButton({
    super.key,
    String? text,
    String? label,
    required this.onPressed,
    this.isLoading = false,
    this.isDisabled = false,
    this.useGradient = true,
    this.gradient,
    this.backgroundColor,
    this.foregroundColor,
    this.width = double.infinity,
    this.height = AppDimensions.buttonHeight,
    this.borderRadius = AppDimensions.radiusMd,
    this.textStyle,
    this.icon,
    this.elevation = AppDimensions.elevationMd,
  }) : text = text ?? label ?? '';

  /// Button label text.
  final String text;

  /// Called when the button is tapped and not loading/disabled.
  final VoidCallback? onPressed;

  /// When `true`, shows a circular progress indicator instead of text.
  final bool isLoading;

  /// When `true`, grays out the button and disables interactions.
  final bool isDisabled;

  /// Whether to use gradient background (defaults to `true`).
  final bool useGradient;

  /// Custom gradient; falls back to [AppColors.primaryGradient].
  final Gradient? gradient;

  /// Flat background color (used when [useGradient] is `false`).
  final Color? backgroundColor;

  /// Text / icon color.
  final Color? foregroundColor;

  /// Button width; defaults to full width.
  final double width;

  /// Button height.
  final double height;

  /// Corner radius.
  final double borderRadius;

  /// Custom text style.
  final TextStyle? textStyle;

  /// Optional leading icon.
  final IconData? icon;

  /// Elevation level.
  final double elevation;

  @override
  State<AppButton> createState() => _AppButtonState();
}

class _AppButtonState extends State<AppButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
      reverseDuration: const Duration(milliseconds: 180),
      lowerBound: 0.0,
      upperBound: 0.04,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.96).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  bool get _isActive => !widget.isLoading && !widget.isDisabled;

  void _onTapDown(TapDownDetails _) {
    if (_isActive) _scaleController.forward();
  }

  void _onTapUp(TapUpDetails _) {
    _scaleController.reverse();
  }

  void _onTapCancel() {
    _scaleController.reverse();
  }

  @override
  Widget build(BuildContext context) {
    final effectiveGradient = widget.useGradient
        ? (widget.gradient ?? AppColors.primaryGradient)
        : null;
    final effectiveBg =
        widget.backgroundColor ?? AppColors.deepMaroon;
    final effectiveFg = widget.foregroundColor ?? Colors.white;

    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) {
        return Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        );
      },
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        onTap: _isActive ? widget.onPressed : null,
        child: AnimatedOpacity(
          duration: const Duration(milliseconds: 200),
          opacity: widget.isDisabled ? 0.5 : 1.0,
          child: Container(
            width: widget.width,
            height: widget.height,
            decoration: BoxDecoration(
              gradient: widget.isDisabled ? null : effectiveGradient,
              color: widget.isDisabled
                  ? AppColors.textDisabledLight
                  : (effectiveGradient == null ? effectiveBg : null),
              borderRadius: BorderRadius.circular(widget.borderRadius),
              boxShadow: widget.isDisabled
                  ? null
                  : [
                      BoxShadow(
                        color: (effectiveGradient != null
                                ? AppColors.deepMaroon
                                : effectiveBg)
                            .withValues(alpha: 0.35),
                        blurRadius: widget.elevation * 2,
                        spreadRadius: -2,
                        offset: Offset(0, widget.elevation),
                      ),
                    ],
            ),
            child: Center(
              child: widget.isLoading
                  ? SizedBox(
                      width: 22,
                      height: 22,
                      child: CircularProgressIndicator(
                        strokeWidth: 2.5,
                        valueColor: AlwaysStoppedAnimation(effectiveFg),
                      ),
                    )
                  : Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (widget.icon != null) ...[
                          Icon(widget.icon, color: effectiveFg, size: 20),
                          const SizedBox(width: AppDimensions.spacingSm),
                        ],
                        Text(
                          widget.text,
                          style: widget.textStyle ??
                              TextStyle(
                                fontSize: AppDimensions.fontSubtitle,
                                fontWeight: FontWeight.w600,
                                color: effectiveFg,
                              ),
                        ),
                      ],
                    ),
            ),
          ),
        ),
      ),
    );
  }
}


