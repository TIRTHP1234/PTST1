import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/features/auth/widgets/custom_keypad.dart';
import 'package:ptst_app/features/auth/widgets/pin_dots.dart';

/// MPIN login screen for returning users.
///
/// Displays user greeting, animated lock icon, PIN entry with custom keypad,
/// biometric option, wrong-PIN shake animation, and temporary lockout
/// after 5 failed attempts.
class MpinLoginScreen extends StatefulWidget {
  const MpinLoginScreen({super.key});

  @override
  State<MpinLoginScreen> createState() => _MpinLoginScreenState();
}

class _MpinLoginScreenState extends State<MpinLoginScreen> {
  static const int _pinLength = 4;
  static const int _maxAttempts = 5;
  static const int _lockoutSeconds = 30;

  final _localAuth = LocalAuthentication();

  String _pin = '';
  String _savedMpin = '';
  String _userName = '';
  bool _hasError = false;
  int _failedAttempts = 0;
  bool _isLocked = false;
  int _lockCountdown = 0;
  Timer? _lockTimer;
  bool _biometricEnabled = false;
  bool _biometricAvailable = false;

  @override
  void initState() {
    super.initState();
    _loadUserData();
    _checkBiometric();
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      _savedMpin = prefs.getString('user_mpin') ?? '1234';
      _userName = prefs.getString('user_name') ?? '';
      _biometricEnabled = prefs.getBool('biometric_enabled') ?? false;
    });
  }

  Future<void> _checkBiometric() async {
    try {
      final available = await _localAuth.canCheckBiometrics;
      final isDeviceSupported = await _localAuth.isDeviceSupported();
      setState(() {
        _biometricAvailable = available && isDeviceSupported;
      });
    } catch (_) {
      _biometricAvailable = false;
    }
  }

  void _onDigit(int digit) {
    if (_isLocked) return;

    setState(() {
      _hasError = false;

      if (_pin.length < _pinLength) {
        _pin += digit.toString();

        if (_pin.length == _pinLength) {
          _verifyPin();
        }
      }
    });
  }

  void _onBackspace() {
    if (_isLocked) return;

    setState(() {
      _hasError = false;
      if (_pin.isNotEmpty) {
        _pin = _pin.substring(0, _pin.length - 1);
      }
    });
  }

  void _verifyPin() {
    if (_pin == _savedMpin) {
      // Success
      context.go('/main/home');
    } else {
      _failedAttempts++;

      if (_failedAttempts >= _maxAttempts) {
        _startLockout();
      }

      setState(() {
        _hasError = true;
        _pin = '';
      });

      // Clear error after shake animation
      Future.delayed(const Duration(milliseconds: 600), () {
        if (mounted) setState(() => _hasError = false);
      });
    }
  }

  void _startLockout() {
    setState(() {
      _isLocked = true;
      _lockCountdown = _lockoutSeconds;
    });

    _lockTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_lockCountdown <= 1) {
        timer.cancel();
        setState(() {
          _isLocked = false;
          _failedAttempts = 0;
          _lockCountdown = 0;
        });
      } else {
        setState(() => _lockCountdown--);
      }
    });
  }

  Future<void> _authenticateWithBiometric() async {
    if (!_biometricEnabled || !_biometricAvailable) return;

    try {
      final authenticated = await _localAuth.authenticate(
        localizedReason: 'Authenticate to access PTST',
        options: const AuthenticationOptions(
          stickyAuth: true,
          biometricOnly: true,
        ),
      );

      if (authenticated && mounted) {
        context.go('/main/home');
      }
    } catch (_) {
      // Biometric failed — user can try MPIN
    }
  }

  @override
  void dispose() {
    _lockTimer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.ivory,
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: AppDimensions.paddingXl),

            // Lock icon
            _buildLockIcon()
                .animate()
                .fadeIn(duration: 500.ms)
                .scale(
                  begin: const Offset(0.5, 0.5),
                  duration: 600.ms,
                  curve: Curves.elasticOut,
                ),

            const SizedBox(height: AppDimensions.paddingLg),

            // Greeting
            if (_userName.isNotEmpty)
              Text(
                'Welcome back,',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  color: AppColors.deepMaroon.withOpacity(0.5),
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms),

            if (_userName.isNotEmpty)
              Text(
                _userName,
                style: GoogleFonts.poppins(
                  fontSize: 22,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepMaroon,
                ),
              )
                  .animate()
                  .fadeIn(delay: 300.ms, duration: 400.ms),

            if (_userName.isEmpty)
              Text(
                'Enter MPIN',
                style: GoogleFonts.poppins(
                  fontSize: 24,
                  fontWeight: FontWeight.w700,
                  color: AppColors.deepMaroon,
                ),
              )
                  .animate()
                  .fadeIn(delay: 200.ms, duration: 400.ms),

            const SizedBox(height: 8),

            Text(
              'Enter your 4-digit MPIN to continue',
              style: GoogleFonts.poppins(
                fontSize: 14,
                color: AppColors.deepMaroon.withOpacity(0.45),
              ),
            )
                .animate()
                .fadeIn(delay: 400.ms, duration: 400.ms),

            const SizedBox(height: AppDimensions.paddingXl * 1.5),

            // PIN dots
            PinDots(
              pinLength: _pinLength,
              filledCount: _pin.length,
              hasError: _hasError,
            ),

            const SizedBox(height: AppDimensions.paddingSm),

            // Error / lock message
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              child: _isLocked
                  ? _buildLockMessage()
                  : _hasError
                      ? _buildErrorMessage()
                      : const SizedBox(height: 24),
            ),

            const SizedBox(height: AppDimensions.paddingMd),

            // Forgot MPIN
            TextButton(
              onPressed: () => context.push('/otp-verify', extra: {
                'phone': '',
                'isLogin': true,
              }),
              child: Text(
                'Forgot MPIN?',
                style: GoogleFonts.poppins(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: AppColors.saffronOrange,
                ),
              ),
            )
                .animate()
                .fadeIn(delay: 600.ms, duration: 400.ms),

            const Spacer(),

            // Biometric button
            if (_biometricEnabled && _biometricAvailable && !_isLocked)
              GestureDetector(
                onTap: _authenticateWithBiometric,
                child: Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppDimensions.paddingLg,
                    vertical: AppDimensions.paddingSm + 4,
                  ),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
                    border: Border.all(
                      color: AppColors.antiqueGold.withOpacity(0.4),
                    ),
                    color: AppColors.antiqueGold.withOpacity(0.06),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Iconsax.finger_scan,
                        size: 22,
                        color: AppColors.antiqueGold,
                      ),
                      const SizedBox(width: 8),
                      Text(
                        'Use Biometric',
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepMaroon,
                        ),
                      ),
                    ],
                  ),
                ),
              )
                  .animate()
                  .fadeIn(delay: 700.ms, duration: 400.ms),

            const SizedBox(height: AppDimensions.paddingLg),

            // Custom keypad
            Opacity(
              opacity: _isLocked ? 0.4 : 1.0,
              child: CustomKeypad(
                onDigitPressed: _onDigit,
                onBackspacePressed: _onBackspace,
                showBiometric: _biometricEnabled && _biometricAvailable,
                onBiometricPressed: _authenticateWithBiometric,
              ),
            )
                .animate()
                .fadeIn(delay: 500.ms, duration: 500.ms)
                .slideY(begin: 0.1, duration: 500.ms),

            const SizedBox(height: AppDimensions.paddingXl),
          ],
        ),
      ),
    );
  }

  Widget _buildLockIcon() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            _isLocked
                ? Colors.red.shade100
                : AppColors.antiqueGold.withOpacity(0.12),
            _isLocked
                ? Colors.red.shade50
                : AppColors.antiqueGold.withOpacity(0.06),
          ],
        ),
      ),
      child: Icon(
        _isLocked ? Iconsax.lock : Iconsax.lock_1,
        size: 36,
        color: _isLocked ? Colors.red.shade400 : AppColors.antiqueGold,
      ),
    );
  }

  Widget _buildErrorMessage() {
    final remaining = _maxAttempts - _failedAttempts;
    return Padding(
      key: const ValueKey('error'),
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingXl),
      child: Text(
        'Wrong MPIN. $remaining attempt${remaining == 1 ? '' : 's'} remaining.',
        textAlign: TextAlign.center,
        style: GoogleFonts.poppins(
          fontSize: 13,
          fontWeight: FontWeight.w500,
          color: Colors.red.shade400,
        ),
      ),
    )
        .animate()
        .shake(hz: 3, offset: const Offset(4, 0), duration: 400.ms);
  }

  Widget _buildLockMessage() {
    return Container(
      key: const ValueKey('lock'),
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingLg,
        vertical: AppDimensions.paddingSm,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        color: Colors.red.shade50,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Iconsax.timer_1, size: 18, color: Colors.red.shade400),
          const SizedBox(width: 8),
          Text(
            'Locked for ${_lockCountdown}s',
            style: GoogleFonts.poppins(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.red.shade400,
            ),
          ),
        ],
      ),
    )
        .animate()
        .fadeIn(duration: 300.ms)
        .scale(begin: const Offset(0.9, 0.9), duration: 300.ms);
  }
}
