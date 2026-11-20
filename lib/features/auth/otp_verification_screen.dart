import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/shared/widgets/app_button.dart';

/// OTP verification screen.
///
/// Shows a masked phone number, 6-digit PIN input using pin_code_fields,
/// a 60-second countdown timer, and an auto-verify success animation.
class OtpVerificationScreen extends StatefulWidget {
  final String phoneNumber;
  final bool isLogin;

  const OtpVerificationScreen({
    super.key,
    required this.phoneNumber,
    this.isLogin = true,
  });

  @override
  State<OtpVerificationScreen> createState() => _OtpVerificationScreenState();
}

class _OtpVerificationScreenState extends State<OtpVerificationScreen>
    with SingleTickerProviderStateMixin {
  final _otpController = TextEditingController();
  Timer? _timer;
  int _secondsRemaining = 60;
  bool _canResend = false;
  bool _isVerified = false;
  bool _isVerifying = false;

  late final AnimationController _successController;

  @override
  void initState() {
    super.initState();
    _successController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _startTimer();
  }

  void _startTimer() {
    _secondsRemaining = 60;
    _canResend = false;
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_secondsRemaining == 0) {
        timer.cancel();
        setState(() => _canResend = true);
      } else {
        setState(() => _secondsRemaining--);
      }
    });
  }

  void _resendOtp() {
    if (!_canResend) return;
    _timer?.cancel();
    _startTimer();
    setState(() {});
    // TODO: Trigger OTP resend API
  }

  void _verifyOtp(String otp) {
    if (otp.length != 6) return;

    setState(() => _isVerifying = true);

    // Simulate verification delay
    Future.delayed(const Duration(milliseconds: 1200), () {
      if (!mounted) return;
      setState(() {
        _isVerifying = false;
        _isVerified = true;
      });
      _successController.forward();

      // Navigate after success animation
      Future.delayed(const Duration(milliseconds: 1500), () {
        if (!mounted) return;
        if (widget.isLogin) {
          context.go('/main/home');
        } else {
          context.go('/mpin-setup');
        }
      });
    });
  }

  String get _maskedPhone {
    final phone = widget.phoneNumber;
    if (phone.length < 4) return phone;
    return '${phone.substring(0, 2)}${'*' * (phone.length - 4)}${phone.substring(phone.length - 2)}';
  }

  @override
  void dispose() {
    _timer?.cancel();
    _otpController.dispose();
    _successController.dispose();
    super.dispose();
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
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.paddingXl,
        ),
        child: _isVerified ? _buildSuccessState() : _buildOtpEntry(),
      ),
    );
  }

  Widget _buildOtpEntry() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(height: AppDimensions.paddingLg),

        // Icon
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: AppColors.antiqueGold.withOpacity(0.1),
          ),
          child: const Icon(
            Iconsax.sms,
            size: 36,
            color: AppColors.antiqueGold,
          ),
        )
            .animate()
            .fadeIn(duration: 500.ms)
            .scale(
              begin: const Offset(0.5, 0.5),
              duration: 600.ms,
              curve: Curves.elasticOut,
            ),

        const SizedBox(height: AppDimensions.paddingXl),

        // Title
        Text(
          'OTP Verification',
          style: GoogleFonts.poppins(
            fontSize: 26,
            fontWeight: FontWeight.w700,
            color: AppColors.deepMaroon,
          ),
        )
            .animate()
            .fadeIn(delay: 200.ms, duration: 500.ms),

        const SizedBox(height: AppDimensions.paddingSm),

        // Subtitle
        RichText(
          textAlign: TextAlign.center,
          text: TextSpan(
            text: 'We sent a 6-digit code to\n',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.deepMaroon.withOpacity(0.55),
              height: 1.5,
            ),
            children: [
              TextSpan(
                text: '+91 $_maskedPhone',
                style: GoogleFonts.poppins(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: AppColors.deepMaroon,
                ),
              ),
            ],
          ),
        )
            .animate()
            .fadeIn(delay: 300.ms, duration: 500.ms),

        const SizedBox(height: AppDimensions.paddingXl * 1.5),

        // OTP input
        PinCodeTextField(
          appContext: context,
          length: 6,
          controller: _otpController,
          keyboardType: TextInputType.number,
          animationType: AnimationType.scale,
          animationDuration: const Duration(milliseconds: 200),
          enableActiveFill: true,
          autoFocus: true,
          cursorColor: AppColors.deepMaroon,
          textStyle: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w700,
            color: AppColors.deepMaroon,
          ),
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
            fieldHeight: 56,
            fieldWidth: 48,
            activeFillColor: AppColors.deepMaroon.withOpacity(0.05),
            inactiveFillColor: Colors.white,
            selectedFillColor: AppColors.antiqueGold.withOpacity(0.08),
            activeColor: AppColors.antiqueGold,
            inactiveColor: AppColors.deepMaroon.withOpacity(0.12),
            selectedColor: AppColors.antiqueGold,
            borderWidth: 2,
          ),
          onCompleted: _verifyOtp,
          onChanged: (_) {},
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 500.ms)
            .slideY(begin: 0.2, duration: 500.ms),

        const SizedBox(height: AppDimensions.paddingLg),

        // Timer & resend
        _buildTimerAndResend()
            .animate()
            .fadeIn(delay: 500.ms, duration: 400.ms),

        const SizedBox(height: AppDimensions.paddingXl),

        // Verify button
        SizedBox(
          width: double.infinity,
          child: AppButton(
            label: 'Verify',
            isLoading: _isVerifying,
            onPressed: _otpController.text.length == 6
                ? () => _verifyOtp(_otpController.text)
                : null,
          ),
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 400.ms)
            .slideY(begin: 0.2, duration: 400.ms),
      ],
    );
  }

  Widget _buildTimerAndResend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (!_canResend) ...[
          Icon(
            Iconsax.timer_1,
            size: 18,
            color: AppColors.deepMaroon.withOpacity(0.4),
          ),
          const SizedBox(width: 6),
          Text(
            '00:${_secondsRemaining.toString().padLeft(2, '0')}',
            style: GoogleFonts.poppins(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.deepMaroon.withOpacity(0.6),
            ),
          ),
        ],
        if (_canResend)
          GestureDetector(
            onTap: _resendOtp,
            child: Text(
              'Resend OTP',
              style: GoogleFonts.poppins(
                fontSize: 15,
                fontWeight: FontWeight.w600,
                color: AppColors.saffronOrange,
              ),
            ),
          ),
      ],
    );
  }

  Widget _buildSuccessState() {
    return Column(
      children: [
        const SizedBox(height: 100),

        // Animated checkmark with golden burst
        AnimatedBuilder(
          animation: _successController,
          builder: (context, child) {
            return Stack(
              alignment: Alignment.center,
              children: [
                // Golden burst
                ...List.generate(8, (i) {
                  final angle = (i / 8) * 3.14159 * 2;
                  final radius = 60.0 * _successController.value;
                  return Transform.translate(
                    offset: Offset(
                      radius * _cosFromAngle(angle),
                      radius * _sinFromAngle(angle),
                    ),
                    child: Opacity(
                      opacity: (1 - _successController.value).clamp(0.0, 1.0),
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.antiqueGold,
                        ),
                      ),
                    ),
                  );
                }),

                // Check circle
                Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: const LinearGradient(
                      colors: [
                        Color(0xFF4CAF50),
                        Color(0xFF66BB6A),
                      ],
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withOpacity(0.3),
                        blurRadius: 20,
                        spreadRadius: 4,
                      ),
                    ],
                  ),
                  child: const Icon(
                    Icons.check_rounded,
                    size: 52,
                    color: Colors.white,
                  ),
                ),
              ],
            );
          },
        )
            .animate()
            .scale(
              begin: const Offset(0.3, 0.3),
              duration: 600.ms,
              curve: Curves.elasticOut,
            ),

        const SizedBox(height: AppDimensions.paddingXl),

        Text(
          'Verified Successfully!',
          style: GoogleFonts.poppins(
            fontSize: 24,
            fontWeight: FontWeight.w700,
            color: AppColors.deepMaroon,
          ),
        )
            .animate()
            .fadeIn(delay: 400.ms, duration: 500.ms),

        const SizedBox(height: AppDimensions.paddingSm),

        Text(
          'Redirecting you...',
          style: GoogleFonts.poppins(
            fontSize: 14,
            color: AppColors.deepMaroon.withOpacity(0.5),
          ),
        )
            .animate()
            .fadeIn(delay: 600.ms, duration: 400.ms),
      ],
    );
  }

  double _cosFromAngle(double angle) {
    // Using dart:math import would be cleaner, but keep inline for simplicity
    return angle < 1.5708
        ? 1 - (angle / 1.5708)
        : angle < 3.1416
            ? -(angle - 1.5708) / 1.5708
            : angle < 4.7124
                ? -1 + (angle - 3.1416) / 1.5708
                : (angle - 4.7124) / 1.5708;
  }

  double _sinFromAngle(double angle) {
    return _cosFromAngle(angle - 1.5708);
  }
}
