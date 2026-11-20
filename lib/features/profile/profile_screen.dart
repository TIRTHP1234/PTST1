import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';

class ProfileScreen extends ConsumerWidget {
  const ProfileScreen({super.key});

  void _showLanguageDialog(BuildContext context, WidgetRef ref) {
    final activeLocale = ref.read(localeProvider);

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          backgroundColor: AppColors.ivory,
          title: const Text(
            'भाषा चयन / Select Language',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: AppColors.deepMaroon,
            ),
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _buildLangOption(
                title: 'हिन्दी (Hindi)',
                subtitle: 'पवित्र जैन आगम एवं देवनागरी',
                isSelected: activeLocale.languageCode == 'hi',
                onTap: () {
                  ref.read(localeProvider.notifier).setLocale('hi');
                  Navigator.pop(context);
                },
              ),
              const SizedBox(height: 10),
              _buildLangOption(
                title: 'English',
                subtitle: 'International Romanized Script',
                isSelected: activeLocale.languageCode == 'en',
                onTap: () {
                  ref.read(localeProvider.notifier).setLocale('en');
                  Navigator.pop(context);
                },
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildLangOption({
    required String title,
    required String subtitle,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
        decoration: BoxDecoration(
          color: isSelected
              ? AppColors.antiqueGold.withOpacity(0.15)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected
                ? AppColors.antiqueGold
                : AppColors.warmBeige,
            width: isSelected ? 1.5 : 1.0,
          ),
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: isSelected
                          ? AppColors.deepMaroon
                          : AppColors.textPrimaryLight,
                    ),
                  ),
                  Text(
                    subtitle,
                    style: TextStyle(
                      fontSize: 11,
                      color: AppColors.textSecondaryLight.withOpacity(0.8),
                    ),
                  ),
                ],
              ),
            ),
            if (isSelected)
              const Icon(
                Icons.check_circle_rounded,
                color: AppColors.antiqueGold,
                size: 22,
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final activeLocale = ref.watch(localeProvider);
    final isHindi = activeLocale.languageCode == 'hi';

    return Scaffold(
      backgroundColor: AppColors.warmBeige.withOpacity(0.3),
      appBar: AppBar(
        title: Text(isHindi ? 'मेरी प्रोफाइल' : 'My Profile'),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(AppDimensions.paddingL),
        children: [
          // User Card
          Container(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [AppColors.deepMaroon, AppColors.royalBurgundy],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(AppDimensions.radiusL),
              boxShadow: [
                BoxShadow(
                  color: AppColors.deepMaroon.withOpacity(0.2),
                  blurRadius: 10,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
            child: Row(
              children: [
                Container(
                  width: 60,
                  height: 60,
                  decoration: const BoxDecoration(
                    color: AppColors.antiqueGold,
                    shape: BoxShape.circle,
                  ),
                  child: Center(
                    child: Text(
                      isHindi ? 'सा' : 'S',
                      style: const TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: AppColors.deepMaroon,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppDimensions.paddingM),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        isHindi ? 'साधर्मी सदस्य' : 'Sadharmik Member',
                        style: const TextStyle(
                          color: AppColors.ivory,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        '+91 98765 43210',
                        style: TextStyle(
                          color: AppColors.antiqueGold,
                          fontSize: 13,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  icon: const Icon(Iconsax.edit, color: AppColors.ivory),
                  onPressed: () {},
                ),
              ],
            ),
          ),
          const SizedBox(height: AppDimensions.paddingL),

          // Options List
          _buildProfileTile(
            icon: Iconsax.global,
            title: isHindi ? 'भाषा चयन (Language)' : 'Language Selection',
            subtitle: isHindi
                ? 'वर्तमान: हिन्दी (Tap to switch to English)'
                : 'Current: English (Tap to switch to Hindi)',
            onTap: () => _showLanguageDialog(context, ref),
          ),
          _buildProfileTile(
            icon: Iconsax.book_saved,
            title: isHindi ? 'पसंदीदा पुस्तकें एवं प्रवचन' : 'Saved Books & Discourses',
            subtitle: isHindi ? 'सहेजे गए शास्त्र एवं व्याख्यान' : 'Bookmarks & Library History',
          ),
          _buildProfileTile(
            icon: Iconsax.document_download,
            title: isHindi ? 'डाउनलोड्स' : 'Offline Downloads',
            subtitle: isHindi ? 'ऑफलाइन पठन एवं श्रवण हेतु सामग्री' : 'Downloaded PDFs & Audio',
          ),
          _buildProfileTile(
            icon: Iconsax.heart,
            title: isHindi ? 'दान इतिहास एवं रसीदें' : 'Donations & Receipts',
            subtitle: isHindi ? '80G प्रमाण पत्र डाउनलोड करें' : 'Download 80G Tax Certificates',
          ),
          _buildProfileTile(
            icon: Iconsax.bag_2,
            title: isHindi ? 'मेरी ऑर्डर्स' : 'My Orders',
            subtitle: isHindi ? 'पुस्तकों की स्थिति एवं ट्रैकिंग' : 'Track book store shipments',
          ),
          _buildProfileTile(
            icon: Iconsax.lock,
            title: isHindi ? 'सुरक्षा एवं MPIN' : 'Security & MPIN',
            subtitle: isHindi ? 'MPIN व बायोमेट्रिक सेटिंग्स' : 'Biometric & PIN Settings',
          ),
          _buildProfileTile(
            icon: Iconsax.info_circle,
            title: isHindi ? 'ट्रस्ट के बारे में' : 'About the Trust',
            subtitle: isHindi ? 'इतिहास, उद्देश्य एवं संपर्क' : 'History, Vision & Contact',
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }

  Widget _buildProfileTile({
    required IconData icon,
    required String title,
    required String subtitle,
    VoidCallback? onTap,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: AppDimensions.paddingS),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        leading: Container(
          width: 40,
          height: 40,
          decoration: BoxDecoration(
            color: AppColors.deepMaroon.withOpacity(0.06),
            borderRadius: BorderRadius.circular(AppDimensions.radiusS),
          ),
          child: Icon(icon, color: AppColors.deepMaroon, size: 20),
        ),
        title: Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w600,
            color: AppColors.textPrimaryLight,
          ),
        ),
        subtitle: Text(
          subtitle,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondaryLight,
          ),
        ),
        trailing: const Icon(
          Icons.arrow_forward_ios_rounded,
          size: 14,
          color: AppColors.textSecondaryLight,
        ),
        onTap: onTap,
      ),
    );
  }
}
