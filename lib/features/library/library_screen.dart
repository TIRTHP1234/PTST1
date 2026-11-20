import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';

class LibraryScreen extends ConsumerWidget {
  const LibraryScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Scaffold(
      backgroundColor: AppColors.warmBeige.withOpacity(0.3),
      appBar: AppBar(
        title: Text(isHindi ? 'डिजिटल शास्त्र लाइब्रेरी' : 'Digital Shastra Library'),
        centerTitle: true,
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(AppDimensions.paddingXL),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                width: 90,
                height: 90,
                decoration: BoxDecoration(
                  color: AppColors.deepMaroon.withOpacity(0.08),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.book_1,
                  size: 44,
                  color: AppColors.deepMaroon,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingL),
              Text(
                isHindi ? 'जैन शास्त्र एवं ग्रंथागार' : 'Jain Scriptures & Archives',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepMaroon,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                isHindi
                    ? 'समयसार, नियमसार, प्रवचनसार, तत्त्वार्थसूत्र एवं दुर्लभ जैन साहित्य की डिजिटल प्रतियां शीघ्र उपलब्ध होंगी।'
                    : 'Digital editions of Samayasara, Niyamasara, Pravachanasara, Tattvartha Sutra and rare Jain scriptures will be available soon.',
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.textSecondaryLight,
                  height: 1.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
