import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// A beautiful custom numeric keypad for MPIN entry.
///
/// Displays digits 1-9, 0, backspace, and an optional biometric button.
/// Each key has a ripple effect, maroon text, and golden highlights.
class CustomKeypad extends StatelessWidget {
  /// Called when a digit (0-9) is pressed.
  final ValueChanged<int> onDigitPressed;

  /// Called when backspace is pressed.
  final VoidCallback onBackspacePressed;

  /// Called when the biometric button is pressed. If null, the button is hidden.
  final VoidCallback? onBiometricPressed;

  /// Whether to show the biometric button in the bottom-left position.
  final bool showBiometric;

  const CustomKeypad({
    super.key,
    required this.onDigitPressed,
    required this.onBackspacePressed,
    this.onBiometricPressed,
    this.showBiometric = false,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingXl,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildRow([1, 2, 3]),
          const SizedBox(height: AppDimensions.paddingMd),
          _buildRow([4, 5, 6]),
          const SizedBox(height: AppDimensions.paddingMd),
          _buildRow([7, 8, 9]),
          const SizedBox(height: AppDimensions.paddingMd),
          _buildBottomRow(),
        ],
      ),
    );
  }

  Widget _buildRow(List<int> digits) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: digits
          .map((digit) => _KeypadButton(
                label: digit.toString(),
                onPressed: () {
                  HapticFeedback.lightImpact();
                  onDigitPressed(digit);
                },
              ))
          .toList(),
    );
  }

  Widget _buildBottomRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // Biometric or empty space
        if (showBiometric)
          _KeypadButton(
            icon: Iconsax.finger_scan,
            onPressed: () {
              HapticFeedback.mediumImpact();
              onBiometricPressed?.call();
            },
            isAccent: true,
          )
        else
          const SizedBox(width: 72, height: 72),

        // Zero
        _KeypadButton(
          label: '0',
          onPressed: () {
            HapticFeedback.lightImpact();
            onDigitPressed(0);
          },
        ),

        // Backspace
        _KeypadButton(
          icon: Iconsax.arrow_left_1,
          onPressed: () {
            HapticFeedback.lightImpact();
            onBackspacePressed();
          },
        ),
      ],
    );
  }
}

/// Individual keypad button with scale animation and ripple effect.
class _KeypadButton extends StatefulWidget {
  final String? label;
  final IconData? icon;
  final VoidCallback onPressed;
  final bool isAccent;

  const _KeypadButton({
    this.label,
    this.icon,
    required this.onPressed,
    this.isAccent = false,
  });

  @override
  State<_KeypadButton> createState() => _KeypadButtonState();
}

class _KeypadButtonState extends State<_KeypadButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _scaleAnim;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 100),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnim,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnim.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: (_) => _controller.forward(),
        onTapUp: (_) {
          _controller.reverse();
          widget.onPressed();
        },
        onTapCancel: () => _controller.reverse(),
        child: Container(
          width: 72,
          height: 72,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: widget.isAccent
                ? AppColors.antiqueGold.withOpacity(0.12)
                : AppColors.deepMaroon.withOpacity(0.04),
            border: Border.all(
              color: widget.isAccent
                  ? AppColors.antiqueGold.withOpacity(0.3)
                  : AppColors.deepMaroon.withOpacity(0.08),
              width: 1.5,
            ),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              customBorder: const CircleBorder(),
              splashColor: AppColors.antiqueGold.withOpacity(0.2),
              highlightColor: AppColors.antiqueGold.withOpacity(0.1),
              onTap: () {}, // handled by GestureDetector above
              child: Center(
                child: widget.label != null
                    ? Text(
                        widget.label!,
                        style: TextStyle(
                          fontSize: 28,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepMaroon,
                          letterSpacing: 0.5,
                        ),
                      )
                    : Icon(
                        widget.icon,
                        size: 26,
                        color: widget.isAccent
                            ? AppColors.antiqueGold
                            : AppColors.deepMaroon,
                      ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
