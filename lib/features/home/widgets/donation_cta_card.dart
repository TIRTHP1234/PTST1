import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/shared/animations/golden_sheen_border.dart';
import 'package:ptst_app/shared/animations/tilt_3d_card.dart';

/// Donation call-to-action card with 3D perspective, royal burgundy velvet
/// gradient, golden metallic accents, and bilingual support.
class DonationCtaCard extends StatelessWidget {
  const DonationCtaCard({super.key, this.isHindi});

  final bool? isHindi;

  @override
  Widget build(BuildContext context) {
    final isHindiActive = isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: GoldenSheenBorder(
        borderRadius: AppDimensions.radiusL,
        strokeWidth: 1.4,
        child: Tilt3DCard(
        maxTiltAngle: 0.12,
        glareOpacity: 0.35,
        glareColor: const Color(0xFFFFE082),
        borderRadius: AppDimensions.radiusL,
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.all(AppDimensions.paddingL),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Color(0xFF5A0016),
                Color(0xFF800020),
                Color(0xFF4A0012),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
            border: Border.all(
              color: AppColors.antiqueGold.withOpacity(0.5),
              width: 1.2,
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ── Header with 3D Coin Badge ──
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      gradient: const RadialGradient(
                        colors: [Color(0xFFFFE082), Color(0xFFC9A94E)],
                      ),
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFFFFD700).withOpacity(0.4),
                          blurRadius: 10,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Icon(
                      Iconsax.heart5,
                      color: Color(0xFF5A0016),
                      size: 20,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          isHindiActive
                              ? 'सहयोग एवं दान अभियान'
                              : 'Support & Donation Campaign',
                          style: const TextStyle(
                            color: Color(0xFFFFE082),
                            fontSize: 17,
                            fontWeight: FontWeight.w800,
                            letterSpacing: 0.5,
                          ),
                        ),
                        Text(
                          isHindiActive
                              ? 'धार्मिक साहित्य प्रकाशन एवं शिक्षण शिविर'
                              : 'Literature Publishing & Educational Camps',
                          style: const TextStyle(
                            color: Color(0xFFF5E6CC),
                            fontSize: 11.5,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 12),

              Text(
                isHindiActive
                    ? 'धर्म प्रचार एवं शिक्षा के लिए आपका योगदान अमूल्य है।\n८०G आयकर छूट की डिजिटल रसीद तुरंत प्राप्त करें।'
                    : 'Your contribution is invaluable for spiritual education.\nReceive instant 80G tax exemption digital receipts.',
                style: TextStyle(
                  color: Colors.white.withOpacity(0.88),
                  fontSize: 12.5,
                  height: 1.45,
                ),
              ),
              const SizedBox(height: 16),

              // ── Progress Label ──
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    isHindiActive
                        ? '₹३,२०,००० एकत्रित (६४%)'
                        : '₹3,20,000 Raised (64%)',
                    style: const TextStyle(
                      color: Color(0xFFFFE082),
                      fontSize: 12.5,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  Text(
                    isHindiActive ? 'लक्ष्य ₹५,००,०००' : 'Goal: ₹5,00,000',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.7),
                      fontSize: 12,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),

              // ── Progress Bar ──
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Container(
                  height: 10,
                  width: double.infinity,
                  color: Colors.black.withOpacity(0.35),
                  child: FractionallySizedBox(
                    alignment: Alignment.centerLeft,
                    widthFactor: 0.64,
                    child: Container(
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color(0xFFC9A94E),
                            Color(0xFFFFD54F),
                            Color(0xFFF5A623),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // ── 3D Golden Donate Button ──
              Center(
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(28),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 32,
                        vertical: 11,
                      ),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFFFE082),
                            Color(0xFFC9A94E),
                            Color(0xFFB38F35),
                          ],
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                        ),
                        borderRadius: BorderRadius.circular(28),
                        border: Border.all(
                          color: const Color(0xFFFFF8E1),
                          width: 1.2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: const Color(0xFFFFD54F).withOpacity(0.4),
                            blurRadius: 12,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          const Icon(Iconsax.wallet_3, color: Color(0xFF4A0012), size: 18),
                          const SizedBox(width: 8),
                          Text(
                            isHindiActive ? 'अभी दान करें' : 'Donate Now',
                            style: const TextStyle(
                              color: Color(0xFF4A0012),
                              fontSize: 14,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 0.5,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      ),
    );
  }
}
