import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/shared/widgets/app_button.dart';

/// Registration screen with name, mobile, email, city, state fields.
///
/// Layout mirrors the login screen for visual consistency.
/// Includes Terms & Conditions checkbox and navigation to OTP verification.
class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _cityController = TextEditingController();

  String? _selectedState;
  bool _agreedToTerms = false;

  static const _indianStates = [
    'Andhra Pradesh', 'Arunachal Pradesh', 'Assam', 'Bihar',
    'Chhattisgarh', 'Goa', 'Gujarat', 'Haryana', 'Himachal Pradesh',
    'Jharkhand', 'Karnataka', 'Kerala', 'Madhya Pradesh', 'Maharashtra',
    'Manipur', 'Meghalaya', 'Mizoram', 'Nagaland', 'Odisha',
    'Punjab', 'Rajasthan', 'Sikkim', 'Tamil Nadu', 'Telangana',
    'Tripura', 'Uttar Pradesh', 'Uttarakhand', 'West Bengal',
    'Delhi', 'Chandigarh', 'Puducherry',
  ];

  bool get _isFormValid =>
      _nameController.text.trim().isNotEmpty &&
      _phoneController.text.length == 10 &&
      _agreedToTerms;

  void _register() {
    if (!_formKey.currentState!.validate() || !_agreedToTerms) return;
    context.push('/otp-verify', extra: {
      'phone': _phoneController.text,
      'isLogin': false,
      'name': _nameController.text.trim(),
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;

    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeader(topPadding),

            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: AppDimensions.paddingXl,
              ),
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: AppDimensions.paddingXl),

                    Text(
                      'Create Account',
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
                      'Join our spiritual community',
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.deepMaroon.withOpacity(0.55),
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 400.ms, duration: 500.ms),

                    const SizedBox(height: AppDimensions.paddingXl),

                    // Full Name
                    _buildInputField(
                      controller: _nameController,
                      label: 'Full Name',
                      hint: 'Enter your full name',
                      icon: Iconsax.user,
                      textInputAction: TextInputAction.next,
                      validator: (v) =>
                          (v == null || v.trim().isEmpty) ? 'Required' : null,
                    )
                        .animate()
                        .fadeIn(delay: 500.ms, duration: 400.ms)
                        .slideY(begin: 0.15, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingMd),

                    // Mobile Number
                    _buildPhoneField()
                        .animate()
                        .fadeIn(delay: 600.ms, duration: 400.ms)
                        .slideY(begin: 0.15, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingMd),

                    // Email (optional)
                    _buildInputField(
                      controller: _emailController,
                      label: 'Email (optional)',
                      hint: 'Enter email address',
                      icon: Iconsax.sms,
                      keyboardType: TextInputType.emailAddress,
                      textInputAction: TextInputAction.next,
                    )
                        .animate()
                        .fadeIn(delay: 700.ms, duration: 400.ms)
                        .slideY(begin: 0.15, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingMd),

                    // City
                    _buildInputField(
                      controller: _cityController,
                      label: 'City',
                      hint: 'Enter your city',
                      icon: Iconsax.location,
                      textInputAction: TextInputAction.done,
                    )
                        .animate()
                        .fadeIn(delay: 800.ms, duration: 400.ms)
                        .slideY(begin: 0.15, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingMd),

                    // State dropdown
                    _buildStateDropdown()
                        .animate()
                        .fadeIn(delay: 900.ms, duration: 400.ms)
                        .slideY(begin: 0.15, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingLg),

                    // Terms checkbox
                    _buildTermsCheckbox()
                        .animate()
                        .fadeIn(delay: 1000.ms, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingLg),

                    // Register button
                    SizedBox(
                      width: double.infinity,
                      child: AppButton(
                        label: 'Register',
                        onPressed: _isFormValid ? _register : null,
                      ),
                    )
                        .animate()
                        .fadeIn(delay: 1100.ms, duration: 400.ms)
                        .slideY(begin: 0.2, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingXl),

                    // Login link
                    Center(
                      child: GestureDetector(
                        onTap: () => context.pop(),
                        child: RichText(
                          text: TextSpan(
                            text: 'Already have an account? ',
                            style: GoogleFonts.poppins(
                              fontSize: 14,
                              color: AppColors.deepMaroon.withOpacity(0.6),
                            ),
                            children: [
                              TextSpan(
                                text: 'Login',
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
                        .fadeIn(delay: 1200.ms, duration: 400.ms),

                    const SizedBox(height: AppDimensions.paddingXl),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader(double topPadding) {
    return Container(
      width: double.infinity,
      height: 180 + topPadding,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.deepMaroon, AppColors.royalBurgundy],
        ),
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(40),
          bottomRight: Radius.circular(40),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            right: -30,
            top: topPadding + 10,
            child: Icon(
              Icons.auto_awesome,
              size: 150,
              color: Colors.white.withOpacity(0.04),
            ),
          ),
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
                  'Register',
                  style: GoogleFonts.poppins(
                    fontSize: 28,
                    fontWeight: FontWeight.w700,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ).animate().fadeIn(duration: 500.ms).slideX(begin: -0.3, duration: 500.ms),

          // Back button
          Positioned(
            left: AppDimensions.paddingSm,
            top: topPadding + AppDimensions.paddingSm,
            child: IconButton(
              onPressed: () => context.pop(),
              icon: const Icon(
                Icons.arrow_back_ios_rounded,
                color: Colors.white,
                size: 22,
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData icon,
    TextInputType keyboardType = TextInputType.text,
    TextInputAction textInputAction = TextInputAction.next,
    String? Function(String?)? validator,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.deepMaroon.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: controller,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          validator: validator,
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.deepMaroon,
          ),
          decoration: InputDecoration(
            hintText: hint,
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.deepMaroon.withOpacity(0.3),
            ),
            prefixIcon: Icon(icon, size: 20, color: AppColors.antiqueGold),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingMd,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: BorderSide(
                color: AppColors.deepMaroon.withOpacity(0.12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: BorderSide(
                color: AppColors.deepMaroon.withOpacity(0.12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: const BorderSide(
                color: AppColors.antiqueGold,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildPhoneField() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Mobile Number',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.deepMaroon.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 6),
        TextFormField(
          controller: _phoneController,
          keyboardType: TextInputType.phone,
          maxLength: 10,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
          validator: (v) =>
              (v == null || v.length != 10) ? 'Enter valid 10-digit number' : null,
          onChanged: (_) => setState(() {}),
          style: GoogleFonts.poppins(
            fontSize: 15,
            color: AppColors.deepMaroon,
            letterSpacing: 1.2,
          ),
          decoration: InputDecoration(
            hintText: 'Enter mobile number',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.deepMaroon.withOpacity(0.3),
            ),
            counterText: '',
            prefixIcon: Padding(
              padding: const EdgeInsets.only(
                left: AppDimensions.paddingMd,
                right: 8,
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 20,
                    height: 14,
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
                              child: Icon(Icons.circle, size: 2.5, color: Color(0xFF000080)),
                            ),
                          ),
                        ),
                        Expanded(child: Container(color: const Color(0xFF138808))),
                      ],
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    '+91',
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.deepMaroon,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    width: 1,
                    height: 24,
                    color: AppColors.deepMaroon.withOpacity(0.1),
                  ),
                ],
              ),
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingMd,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: BorderSide(
                color: AppColors.deepMaroon.withOpacity(0.12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: BorderSide(
                color: AppColors.deepMaroon.withOpacity(0.12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: const BorderSide(
                color: AppColors.antiqueGold,
                width: 2,
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildStateDropdown() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'State',
          style: GoogleFonts.poppins(
            fontSize: 13,
            fontWeight: FontWeight.w500,
            color: AppColors.deepMaroon.withOpacity(0.7),
          ),
        ),
        const SizedBox(height: 6),
        DropdownButtonFormField<String>(
          value: _selectedState,
          isExpanded: true,
          icon: Icon(
            Iconsax.arrow_down_1,
            color: AppColors.deepMaroon.withOpacity(0.5),
          ),
          decoration: InputDecoration(
            hintText: 'Select state',
            hintStyle: GoogleFonts.poppins(
              fontSize: 14,
              color: AppColors.deepMaroon.withOpacity(0.3),
            ),
            prefixIcon: Icon(
              Iconsax.map,
              size: 20,
              color: AppColors.antiqueGold,
            ),
            filled: true,
            fillColor: Colors.white,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingMd,
              vertical: AppDimensions.paddingMd,
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: BorderSide(
                color: AppColors.deepMaroon.withOpacity(0.12),
              ),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: BorderSide(
                color: AppColors.deepMaroon.withOpacity(0.12),
              ),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
              borderSide: const BorderSide(
                color: AppColors.antiqueGold,
                width: 2,
              ),
            ),
          ),
          items: _indianStates
              .map((s) => DropdownMenuItem(
                    value: s,
                    child: Text(
                      s,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: AppColors.deepMaroon,
                      ),
                    ),
                  ))
              .toList(),
          onChanged: (v) => setState(() => _selectedState = v),
        ),
      ],
    );
  }

  Widget _buildTermsCheckbox() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          width: 24,
          height: 24,
          child: Checkbox(
            value: _agreedToTerms,
            onChanged: (v) => setState(() => _agreedToTerms = v ?? false),
            activeColor: AppColors.antiqueGold,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6),
            ),
            side: BorderSide(
              color: AppColors.deepMaroon.withOpacity(0.3),
              width: 1.5,
            ),
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: GestureDetector(
            onTap: () => setState(() => _agreedToTerms = !_agreedToTerms),
            child: RichText(
              text: TextSpan(
                text: 'I agree to the ',
                style: GoogleFonts.poppins(
                  fontSize: 13,
                  color: AppColors.deepMaroon.withOpacity(0.6),
                ),
                children: [
                  TextSpan(
                    text: 'Terms & Conditions',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.saffronOrange,
                    ),
                  ),
                  TextSpan(text: ' and '),
                  TextSpan(
                    text: 'Privacy Policy',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.saffronOrange,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
