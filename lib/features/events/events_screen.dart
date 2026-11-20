import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';

class EventsScreen extends ConsumerWidget {
  const EventsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Scaffold(
      backgroundColor: AppColors.warmBeige.withOpacity(0.3),
      appBar: AppBar(
        title: Text(isHindi ? 'कार्यक्रम एवं आयोजन' : 'Events & Programs'),
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
                  color: AppColors.antiqueGold.withOpacity(0.12),
                  shape: BoxShape.circle,
                ),
                child: const Icon(
                  Iconsax.calendar_tick,
                  size: 44,
                  color: AppColors.antiqueGold,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingL),
              Text(
                isHindi ? 'आगामी धार्मिक आयोजन' : 'Upcoming Religious Events',
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: AppColors.deepMaroon,
                ),
              ),
              const SizedBox(height: AppDimensions.paddingS),
              Text(
                isHindi
                    ? 'शिक्षण शिविर, संगोष्ठियां, पंचकल्याणक एवं विशेष व्याख्यान मालाओं का विवरण एवं ऑनलाइन पंजीकरण।'
                    : 'Details and online registration for spiritual learning camps, seminars, Panch Kalyanaks, and special discourse series.',
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
