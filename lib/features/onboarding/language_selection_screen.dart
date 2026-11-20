import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';
import 'package:ptst_app/shared/widgets/app_button.dart';

/// Language selection screen.
///
/// Presents two elegant cards for Hindi and English. The selected card
/// gets a golden border glow. The choice updates [localeProvider] and is persisted.
class LanguageSelectionScreen extends ConsumerStatefulWidget {
  const LanguageSelectionScreen({super.key});

  @override
  ConsumerState<LanguageSelectionScreen> createState() =>
      _LanguageSelectionScreenState();
}

class _LanguageSelectionScreenState
    extends ConsumerState<LanguageSelectionScreen> {
  String _selectedLanguage = 'hi'; // default Hindi

  Future<void> _onContinue() async {
    await ref.read(localeProvider.notifier).setLocale(_selectedLanguage);
    if (!mounted) return;
    context.go('/login');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [AppColors.warmBeige, AppColors.ivory],
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: AppDimensions.paddingXl,
            ),
            child: Column(
              children: [
                const Spacer(flex: 2),

                // Golden emblem
                _buildEmblem()
                    .animate()
                    .fadeIn(duration: 500.ms)
                    .scale(
                      begin: const Offset(0.6, 0.6),
                      duration: 700.ms,
                      curve: Curves.elasticOut,
                    ),

                const SizedBox(height: AppDimensions.paddingXl),

                // Title
                Column(
                  children: [
                    Text(
                      'भाषा चुनें',
                      style: TextStyle(
                        fontFamily: 'NotoSansDevanagari',
                        fontSize: 28,
                        fontWeight: FontWeight.w700,
                        color: AppColors.deepMaroon,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Choose Language',
                      style: GoogleFonts.poppins(
                        fontSize: 18,
                        fontWeight: FontWeight.w400,
                        color: AppColors.deepMaroon.withOpacity(0.6),
                        letterSpacing: 0.5,
                      ),
                    ),
                  ],
                )
                    .animate()
                    .fadeIn(delay: 200.ms, duration: 500.ms)
                    .slideY(begin: 0.3, duration: 500.ms),

                const SizedBox(height: AppDimensions.paddingXl * 1.5),

                // Language cards
                Row(
                  children: [
                    Expanded(
                      child: _LanguageCard(
                        language: 'hi',
                        label: 'हिन्दी',
                        sublabel: 'Hindi',
                        scriptSample: 'अ',
                        isSelected: _selectedLanguage == 'hi',
                        onTap: () =>
                            setState(() => _selectedLanguage = 'hi'),
                      )
                          .animate()
                          .fadeIn(delay: 400.ms, duration: 500.ms)
                          .slideX(begin: -0.3, duration: 500.ms),
                    ),
                    const SizedBox(width: AppDimensions.paddingMd),
                    Expanded(
                      child: _LanguageCard(
                        language: 'en',
                        label: 'English',
                        sublabel: 'अंग्रेज़ी',
                        scriptSample: 'A',
                        isSelected: _selectedLanguage == 'en',
                        onTap: () =>
                            setState(() => _selectedLanguage = 'en'),
                      )
                          .animate()
                          .fadeIn(delay: 500.ms, duration: 500.ms)
                          .slideX(begin: 0.3, duration: 500.ms),
                    ),
                  ],
                ),

                const Spacer(flex: 2),

                // Continue button
                SizedBox(
                  width: double.infinity,
                  child: AppButton(
                    label: _selectedLanguage == 'hi' ? 'आगे बढ़ें →' : 'Continue →',
                    onPressed: _onContinue,
                  ),
                )
                    .animate()
                    .fadeIn(delay: 700.ms, duration: 500.ms)
                    .slideY(begin: 0.3, duration: 500.ms),

                const SizedBox(height: AppDimensions.paddingXl),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmblem() {
    return Container(
      width: 80,
      height: 80,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.antiqueGold, AppColors.saffronOrange],
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.antiqueGold.withOpacity(0.35),
            blurRadius: 20,
            spreadRadius: 2,
          ),
        ],
      ),
      child: const Center(
        child: Icon(
          Icons.translate_rounded,
          size: 36,
          color: Colors.white,
        ),
      ),
    );
  }
}

/// A language selection card with golden glow when selected.
class _LanguageCard extends StatelessWidget {
  final String language;
  final String label;
  final String sublabel;
  final String scriptSample;
  final bool isSelected;
  final VoidCallback onTap;

  const _LanguageCard({
    required this.language,
    required this.label,
    required this.sublabel,
    required this.scriptSample,
    required this.isSelected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 350),
        curve: Curves.easeOutCubic,
        padding: const EdgeInsets.symmetric(
          vertical: AppDimensions.paddingXl,
          horizontal: AppDimensions.paddingMd,
        ),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.antiqueGold.withOpacity(0.08)
              : Colors.white,
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
          border: Border.all(
            color: isSelected
                ? AppColors.antiqueGold
                : AppColors.deepMaroon.withOpacity(0.1),
            width: isSelected ? 2.5 : 1.5,
          ),
          boxShadow: isSelected
              ? [
                  BoxShadow(
                    color: AppColors.antiqueGold.withOpacity(0.25),
                    blurRadius: 20,
                    spreadRadius: 2,
                  ),
                  BoxShadow(
                    color: AppColors.antiqueGold.withOpacity(0.1),
                    blurRadius: 40,
                    spreadRadius: 4,
                  ),
                ]
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.04),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Script sample circle
            AnimatedContainer(
              duration: const Duration(milliseconds: 350),
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.antiqueGold.withOpacity(0.15)
                    : AppColors.warmBeige,
                border: Border.all(
                  color: isSelected
                      ? AppColors.antiqueGold
                      : AppColors.deepMaroon.withOpacity(0.1),
                ),
              ),
              child: Center(
                child: Text(
                  scriptSample,
                  style: TextStyle(
                    fontFamily: language == 'hi'
                        ? 'NotoSansDevanagari'
                        : null,
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isSelected
                        ? AppColors.antiqueGold
                        : AppColors.deepMaroon.withOpacity(0.5),
                  ),
                ),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingMd),

            // Label
            Text(
              label,
              style: TextStyle(
                fontFamily: language == 'hi'
                    ? 'NotoSansDevanagari'
                    : null,
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: isSelected
                    ? AppColors.deepMaroon
                    : AppColors.deepMaroon.withOpacity(0.7),
              ),
            ),

            const SizedBox(height: 4),

            // Sublabel
            Text(
              sublabel,
              style: GoogleFonts.poppins(
                fontSize: 13,
                color: AppColors.deepMaroon.withOpacity(0.45),
              ),
            ),

            const SizedBox(height: AppDimensions.paddingMd),

            // Check indicator
            AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              width: 24,
              height: 24,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isSelected
                    ? AppColors.antiqueGold
                    : Colors.transparent,
                border: Border.all(
                  color: isSelected
                      ? AppColors.antiqueGold
                      : AppColors.deepMaroon.withOpacity(0.2),
                  width: 2,
                ),
              ),
              child: isSelected
                  ? const Icon(Icons.check, size: 16, color: Colors.white)
                  : null,
            ),
          ],
        ),
      ),
    );
  }
}
