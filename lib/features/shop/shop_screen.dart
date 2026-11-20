import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';

class ShopScreen extends ConsumerWidget {
  const ShopScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Scaffold(
      backgroundColor: AppColors.warmBeige.withOpacity(0.3),
      appBar: AppBar(
        title: Text(isHindi ? 'ऑनलाइन बुक शॉप' : 'Online Book Store'),
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
                  color: AppColors.saffronOrange.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.shopping_bag,
                  size: 44,
                  color: AppColors.saffronOrange,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingL),
              Text(
                isHindi ? 'ट्रस्ट प्रकाशन पुस्तकें' : 'Trust Publications & Literature',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepMaroon,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                isHindi
                    ? 'आध्यात्मिक ग्रंथ, बाल पोथियां, स्वाध्याय पुस्तकें एवं पत्रिकाएं सीधे घर मंगवाएं।'
                    : 'Order sacred spiritual texts, primers, Swadhyaya books, and monthly periodicals delivered directly to your doorstep.',
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
