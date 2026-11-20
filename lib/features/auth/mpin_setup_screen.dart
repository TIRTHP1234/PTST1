import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/features/auth/widgets/custom_keypad.dart';
import 'package:ptst_app/features/auth/widgets/pin_dots.dart';

/// MPIN setup screen for creating a 4-digit security PIN.
///
/// Two-step flow: enter MPIN → confirm MPIN.
/// Includes a custom numeric keypad, animated PIN dots,
/// biometric toggle, and success state animation.
class MpinSetupScreen extends StatefulWidget {
  const MpinSetupScreen({super.key});

  @override
  State<MpinSetupScreen> createState() => _MpinSetupScreenState();
}

class _MpinSetupScreenState extends State<MpinSetupScreen> {
  static const int _pinLength = 4;

  String _pin = '';
  String _confirmPin = '';
  bool _isConfirmStep = false;
  bool _hasError = false;
  bool _isSuccess = false;
  bool _enableBiometric = false;
  String _errorMessage = '';

  void _onDigit(int digit) {
    setState(() {
      _hasError = false;
      _errorMessage = '';

      if (_isConfirmStep) {
        if (_confirmPin.length < _pinLength) {
          _confirmPin += digit.toString();
          if (_confirmPin.length == _pinLength) {
            _validatePins();
          }
        }
      } else {
        if (_pin.length < _pinLength) {
          _pin += digit.toString();
          if (_pin.length == _pinLength) {
            Future.delayed(const Duration(milliseconds: 300), () {
              if (mounted) {
                setState(() => _isConfirmStep = true);
              }
            });
          }
        }
      }
    });
  }

  void _onBackspace() {
    setState(() {
      _hasError = false;
      _errorMessage = '';

      if (_isConfirmStep) {
        if (_confirmPin.isNotEmpty) {
          _confirmPin = _confirmPin.substring(0, _confirmPin.length - 1);
        } else {
          _isConfirmStep = false;
        }
      } else {
        if (_pin.isNotEmpty) {
          _pin = _pin.substring(0, _pin.length - 1);
        }
      }
    });
  }

  Future<void> _validatePins() async {
    if (_pin != _confirmPin) {
      setState(() {
        _hasError = true;
        _errorMessage = 'PINs do not match. Try again.';
        _confirmPin = '';
      });
      return;
    }

    // Save MPIN
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('user_mpin', _pin);
    await prefs.setBool('is_registered', true);
    await prefs.setBool('biometric_enabled', _enableBiometric);

    if (!mounted) return;
    setState(() => _isSuccess = true);

    // Navigate after animation
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) context.go('/main/home');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          onPressed: () => context.pop(),
          icon: const Icon(
            Icons.arrow_back_ios_rounded,
            color: AppColors.deepMaroon,
          ),
        ),
      ),
      body: SafeArea(
        child: _isSuccess ? _buildSuccessState() : _buildSetupState(),
      ),
    );
  }

  Widget _buildSetupState() {
    return Column(
      children: [
        const SizedBox(height: AppDimensions.paddingMd),

        // Lock icon
        Container(
          width: 70,
          height: 70,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.antiqueGold.withOpacity(0.1),
          ),
          child: const Icon(
            Iconsax.lock_1,
            size: 32,
            color: AppColors.antiqueGold,
          ),
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .scale(
              begin: const Offset(0.5, 0.5),
              duration: 500.ms,
              curve: Curves.elasticOut,
            ),

        const SizedBox(height: AppDimensions.paddingLg),

        // Title
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 300),
          child: Text(
            _isConfirmStep ? 'Confirm Your MPIN' : 'Create Your MPIN',
            key: ValueKey(_isConfirmStep),
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: AppColors.deepMaroon,
            ),
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 400.ms),

        const SizedBox(height: 8),

        Text(
          _isConfirmStep
              ? 'Re-enter your 4-digit MPIN'
              : 'Set a 4-digit MPIN for quick login',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.deepMaroon.withOpacity(0.5),
          ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 400.ms),

        const SizedBox(height: AppDimensions.paddingXl * 1.5),

        // PIN dots
        PinDots(
          pinLength: _pinLength,
          filledCount: _isConfirmStep ? _confirmPin.length : _pin.length,
          hasError: _hasError,
        ),

        // Error message
        AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          height: _hasError ? 32 : 0,
          child: _hasError
              ? Padding(
                  padding: const EdgeInsets.only(top: 8),
                  child: Text(
                    _errorMessage,
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.red.shade400,
                    ),
                  ),
                )
              : const SizedBox.shrink(),
        ),

        const SizedBox(height: AppDimensions.paddingLg),

        // Biometric toggle
        if (!_isConfirmStep)
          Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingXl,
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingMd,
                vertical: AppDimensions.paddingSm,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
                color: AppColors.warmBeige.withOpacity(0.5),
                border: Border.all(
                  color: AppColors.deepMaroon.withOpacity(0.06),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Iconsax.finger_scan,
                    size: 22,
                    color: AppColors.antiqueGold,
                  ),
                  const SizedBox(width: AppDimensions.paddingSm),
                  Expanded(
                    child: Text(
                      'Enable Biometric Login',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: AppColors.deepMaroon,
                      ),
                    ),
                  ),
                  Switch(
                    value: _enableBiometric,
                    onChanged: (v) => setState(() => _enableBiometric = v),
                    activeColor: AppColors.antiqueGold,
                    activeTrackColor: AppColors.antiqueGold.withOpacity(0.3),
                  ),
                ],
              ),
            ),
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 400.ms),

        const Spacer(),

        // Custom keypad
        CustomKeypad(
          onDigitPressed: _onDigit,
          onBackspacePressed: _onBackspace,
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 500.ms)
            .slideY(begin: 0.15, duration: 500.ms),

        const SizedBox(height: AppDimensions.paddingXl),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 110,
            height: 110,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              gradient: const LinearGradient(
                colors: [Color(0xFF4CAF50), Color(0xFF66BB6A)],
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFF4CAF50).withOpacity(0.3),
                  blurRadius: 24,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: const Icon(
              Icons.check_rounded,
              size: 56,
              color: Colors.white,
            ),
          )
              .animate()
              .scale(
                begin: const Offset(0.3, 0.3),
                duration: 600.ms,
                curve: Curves.elasticOut,
              ),

          const SizedBox(height: AppDimensions.paddingXl),

          Text(
            'MPIN Created!',
            style: GoogleFonts.poppins(
              fontSize: 26,
              fontWeight: FontWeight.w700,
              color: AppColors.deepMaroon,
            ),
          )
              .animate()
              .fadeIn(delay: 300.ms, duration: 500.ms),

          const SizedBox(height: 8),

          Text(
            'Your account is ready to use',
            style: GoogleFonts.poppins(
              fontSize: 15,
              color: AppColors.deepMaroon.withOpacity(0.5),
            ),
          )
              .animate()
              .fadeIn(delay: 500.ms, duration: 400.ms),

          if (_enableBiometric) ...[
            const SizedBox(height: AppDimensions.paddingMd),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Iconsax.finger_scan,
                  size: 18,
                  color: AppColors.antiqueGold,
                ),
                const SizedBox(width: 6),
                Text(
                  'Biometric login enabled',
                  style: GoogleFonts.poppins(
                    fontSize: 13,
                    color: AppColors.antiqueGold,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            )
                .animate()
                .fadeIn(delay: 700.ms, duration: 400.ms),
          ],
        ],
      ),
    );
  }
}
