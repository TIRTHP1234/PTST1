import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';
import 'package:ptst_app/shared/widgets/app_button.dart';
import 'package:ptst_app/features/auth/widgets/social_auth_button.dart';

/// Login screen with phone number input, OTP trigger, social auth, and guest mode.
///
/// Features a beautiful gradient header with spiritual illustration,
/// phone input with +91 prefix, and smooth focus animations.
class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final _phoneController = TextEditingController();
  final _phoneFocus = FocusNode();
  bool _isPhoneValid = false;

  @override
  void initState() {
    super.initState();
    _phoneController.addListener(_validatePhone);
  }

  void _validatePhone() {
    setState(() {
      _isPhoneValid = _phoneController.text.length == 10;
    });
  }

  void _sendOtp() {
    if (!_isPhoneValid) return;
    context.push('/otp-verify', extra: {
      'phone': _phoneController.text,
      'isLogin': true,
    });
  }

  @override
  void dispose() {
    _phoneController.dispose();
    _phoneFocus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            // Gradient header
            _buildHeader(topPadding),

            // Form body
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXl,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: AppDimensions.paddingXl),

                  // Welcome text
                  Text(
                    isHindi ? 'पुनः स्वागत है' : 'Welcome Back',
                    style: GoogleFonts.poppins(
                      fontSize: 28,
                      fontWeight: FontWeight.w700,
                      color: AppColors.deepMaroon,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 300.ms, duration: 500.ms)
                      .slideX(begin: -0.2, duration: 500.ms),

                  const SizedBox(height: 4),

                  Text(
                    isHindi
                        ? 'अपनी आध्यात्मिक यात्रा जारी रखने के लिए लॉगिन करें'
                        : 'Sign in to continue your spiritual journey',
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: AppColors.deepMaroon.withOpacity(0.55),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 400.ms, duration: 500.ms),

                  const SizedBox(height: AppDimensions.paddingXl),

                  // Phone input
                  _buildPhoneInput()
                      .animate()
                      .fadeIn(delay: 500.ms, duration: 500.ms)
                      .slideY(begin: 0.2, duration: 500.ms),

                  const SizedBox(height: AppDimensions.paddingLg),

                  // Send OTP button
                  SizedBox(
                    width: double.infinity,
                    child: AppButton(
                      label: isHindi ? 'OTP भेजें' : 'Send OTP',
                      onPressed: _isPhoneValid ? _sendOtp : null,
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 600.ms, duration: 500.ms)
                      .slideY(begin: 0.2, duration: 500.ms),

                  const SizedBox(height: AppDimensions.paddingXl),

                  // Divider
                  _buildDivider()
                      .animate()
                      .fadeIn(delay: 700.ms, duration: 400.ms),

                  const SizedBox(height: AppDimensions.paddingLg),

                  // Social auth buttons
                  Center(
                    child: SocialAuthButtonRow(
                      onGooglePressed: () {},
                      onFacebookPressed: () {},
                      onApplePressed: () {},
                      onEmailPressed: () {},
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingXl * 1.5),

                  // Register link
                  Center(
                    child: GestureDetector(
                      onTap: () => context.push('/register'),
                      child: RichText(
                        text: TextSpan(
                          text: isHindi ? "खाता नहीं है? " : "Don't have an account? ",
                          style: GoogleFonts.poppins(
                            fontSize: 14,
                            color: AppColors.deepMaroon.withOpacity(0.6),
                          ),
                          children: [
                            TextSpan(
                              text: isHindi ? 'नया खाता बनाएं' : 'Register Now',
                              style: GoogleFonts.poppins(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: AppColors.saffronOrange,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 900.ms, duration: 500.ms),

                  const SizedBox(height: AppDimensions.paddingMd),

                  // Guest link
                  Center(
                    child: TextButton(
                      onPressed: () => context.go('/main/home'),
                      child: Text(
                        isHindi ? 'अतिथि के रूप में जारी रखें →' : 'Continue as Guest →',
                        style: GoogleFonts.poppins(
                          fontSize: 13.5,
                          fontWeight: FontWeight.w600,
                          color: AppColors.deepMaroon.withOpacity(0.6),
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  )
                      .animate()
                      .fadeIn(delay: 1000.ms, duration: 500.ms),

                  const SizedBox(height: AppDimensions.paddingXl),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// Gradient header with spiritual illustration placeholder.
  Widget _buildHeader(double topPadding) {
    return Container(
      width: double.infinity,
      height: 220 + topPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.deepMaroon,
            AppColors.royalBurgundy,
          ],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          // Background mandala pattern
          Positioned(
            right: -40,
            top: topPadding,
            child: Icon(
              Icons.auto_awesome,
              size: 180,
              color: Colors.white.withOpacity(0.04),
            ),
          ),
          Positioned(
            left: -20,
            bottom: 10,
            child: Icon(
              Icons.spa,
              size: 100,
              color: Colors.white.withOpacity(0.03),
            ),
          ),

          // Illustration placeholder
          Positioned(
            right: 30,
            bottom: 20,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.08),
                border: Border.all(
                  color: AppColors.antiqueGold.withOpacity(0.3),
                  width: 2,
                ),
              ),
              child: Icon(
                Iconsax.user,
                size: 48,
                color: AppColors.antiqueGold.withOpacity(0.7),
              ),
            )
                .animate()
                .fadeIn(delay: 200.ms, duration: 600.ms)
                .scale(
                  begin: const Offset(0.7, 0.7),
                  duration: 600.ms,
                  curve: Curves.easeOut,
                ),
          ),

          // Trust name
          Positioned(
            left: AppDimensions.paddingXl,
            bottom: 30,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'पं. टोडरमल स्मारक ट्रस्ट',
                  style: TextStyle(
                    fontFamily: 'NotoSansDevanagari',
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
                    color: AppColors.antiqueGold.withOpacity(0.8),
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  'PTST',
                  style: GoogleFonts.poppins(
                    fontSize: 32,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                    letterSpacing: 4,
                  ),
                ),
              ],
            ),
          )
              .animate()
              .fadeIn(duration: 500.ms)
              .slideX(begin: -0.3, duration: 500.ms),
        ],
      ),
    );
  }

  /// Phone number input field with +91 prefix and Indian flag.
  Widget _buildPhoneInput() {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        border: Border.all(
          color: _phoneFocus.hasFocus
              ? AppColors.antiqueGold
              : AppColors.deepMaroon.withOpacity(0.12),
          width: _phoneFocus.hasFocus ? 2 : 1.5,
        ),
        color: Colors.white,
        boxShadow: _phoneFocus.hasFocus
            ? [
                BoxShadow(
                  color: AppColors.antiqueGold.withOpacity(0.1),
                  blurRadius: 12,
                  spreadRadius: 2,
                ),
              ]
            : null,
      ),
      child: Row(
        children: [
          // Flag + code
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingMd,
            ),
            decoration: BoxDecoration(
              border: Border(
                right: BorderSide(
                  color: AppColors.deepMaroon.withOpacity(0.1),
                ),
              ),
            ),
            child: Row(
              children: [
                Container(
                  width: 22,
                  height: 15,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(2),
                    border: Border.all(
                      color: AppColors.antiqueGold.withOpacity(0.5),
                      width: 0.8,
                    ),
                  ),
                  child: Column(
                    children: [
                      Expanded(child: Container(color: const Color(0xFFFF9933))),
                      Expanded(
                        child: Container(
                          color: Colors.white,
                          child: const Center(
                            child: Icon(Icons.circle, size: 3, color: Color(0xFF000080)),
                          ),
                        ),
                      ),
                      Expanded(child: Container(color: const Color(0xFF138808))),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  '+91',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: AppColors.deepMaroon,
                  ),
                ),
              ],
            ),
          ),

          // Phone input
          Expanded(
            child: TextField(
              controller: _phoneController,
              focusNode: _phoneFocus,
              keyboardType: TextInputType.phone,
              maxLength: 10,
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: AppColors.deepMaroon,
                letterSpacing: 1.5,
              ),
              decoration: InputDecoration(
                hintText: 'Enter mobile number',
                hintStyle: GoogleFonts.poppins(
                  fontSize: 15,
                  color: AppColors.deepMaroon.withOpacity(0.3),
                ),
                border: InputBorder.none,
                counterText: '',
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: AppDimensions.paddingMd,
                  vertical: AppDimensions.paddingMd,
                ),
              ),
              onTap: () => setState(() {}),
              onEditingComplete: () {
                _phoneFocus.unfocus();
                setState(() {});
              },
            ),
          ),
        ],
      ),
    );
  }

  /// Divider with "or" text.
  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.deepMaroon.withOpacity(0.1),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: AppDimensions.paddingMd,
          ),
          child: Text(
            'or',
            style: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.deepMaroon.withOpacity(0.4),
            ),
          ),
        ),
        Expanded(
          child: Container(
            height: 1,
            color: AppColors.deepMaroon.withOpacity(0.1),
          ),
        ),
      ],
    );
  }
}
