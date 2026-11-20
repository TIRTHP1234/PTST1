import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Reusable social authentication button (Google, Facebook, Apple, Email).
///
/// Displays a white rounded button with an icon and optional label.
/// Includes a subtle shadow and scale animation on press.
class SocialAuthButton extends StatefulWidget {
  final IconData icon;
  final String label;
  final Color? iconColor;
  final VoidCallback? onPressed;

  const SocialAuthButton({
    super.key,
    required this.icon,
    required this.label,
    this.iconColor,
    this.onPressed,
  });

  @override
  State<SocialAuthButton> createState() => _SocialAuthButtonState();
}

class _SocialAuthButtonState extends State<SocialAuthButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _scaleController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _scaleController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 120),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.92).animate(
      CurvedAnimation(parent: _scaleController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _scaleController.dispose();
    super.dispose();
  }

  void _onTapDown(TapDownDetails _) => _scaleController.forward();
  void _onTapUp(TapUpDetails _) {
    _scaleController.reverse();
    widget.onPressed?.call();
  }

  void _onTapCancel() => _scaleController.reverse();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _scaleAnimation,
      builder: (context, child) => Transform.scale(
        scale: _scaleAnimation.value,
        child: child,
      ),
      child: GestureDetector(
        onTapDown: _onTapDown,
        onTapUp: _onTapUp,
        onTapCancel: _onTapCancel,
        child: Container(
          width: 64,
          height: 64,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
            boxShadow: [
              BoxShadow(
                color: AppColors.deepMaroon.withOpacity(0.08),
                blurRadius: 12,
                offset: const Offset(0, 4),
              ),
              BoxShadow(
                color: AppColors.antiqueGold.withOpacity(0.05),
                blurRadius: 6,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                widget.icon,
                size: 28,
                color: widget.iconColor ?? AppColors.deepMaroon,
              ),
              const SizedBox(height: 4),
              Text(
                widget.label,
                style: TextStyle(
                  fontSize: 10,
                  color: AppColors.deepMaroon.withOpacity(0.7),
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// A row of social auth buttons for login/register screens.
class SocialAuthButtonRow extends StatelessWidget {
  final VoidCallback? onGooglePressed;
  final VoidCallback? onFacebookPressed;
  final VoidCallback? onApplePressed;
  final VoidCallback? onEmailPressed;

  const SocialAuthButtonRow({
    super.key,
    this.onGooglePressed,
    this.onFacebookPressed,
    this.onApplePressed,
    this.onEmailPressed,
  });

  @override
  Widget build(BuildContext context) {
    final buttons = [
      SocialAuthButton(
        icon: Icons.g_mobiledata_rounded,
        label: 'Google',
        iconColor: const Color(0xFFDB4437),
        onPressed: onGooglePressed,
      ),
      SocialAuthButton(
        icon: Icons.facebook_rounded,
        label: 'Facebook',
        iconColor: const Color(0xFF4267B2),
        onPressed: onFacebookPressed,
      ),
      SocialAuthButton(
        icon: Icons.apple_rounded,
        label: 'Apple',
        iconColor: Colors.black87,
        onPressed: onApplePressed,
      ),
      SocialAuthButton(
        icon: Icons.email_outlined,
        label: 'Email',
        iconColor: AppColors.saffronOrange,
        onPressed: onEmailPressed,
      ),
    ];

    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: buttons
          .asMap()
          .entries
          .map((e) => Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingSm / 2,
                ),
                child: e.value
                    .animate()
                    .fadeIn(
                      delay: Duration(milliseconds: 100 * e.key),
                      duration: 400.ms,
                    )
                    .slideY(
                      begin: 0.3,
                      delay: Duration(milliseconds: 100 * e.key),
                      duration: 400.ms,
                      curve: Curves.easeOut,
                    ),
              ))
          .toList(),
    );
  }
}
