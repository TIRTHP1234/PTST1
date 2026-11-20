import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Horizontal scrollable strip of upcoming event cards with date badges,
/// event details, and "Register" chip buttons.
class UpcomingEventsStrip extends StatelessWidget {
  const UpcomingEventsStrip({super.key, this.isHindi});

  final bool? isHindi;

  static const _dummyEvents = [
    _EventData(
      day: '15',
      monthHi: 'दिस',
      monthEn: 'Dec',
      nameHi: 'पर्युषण महापर्व',
      nameEn: 'Paryushan Mahaparva',
      locationHi: 'जैन मंदिर, जयपुर',
      locationEn: 'Jain Temple, Jaipur',
      timeHi: 'प्रातः 6:00 बजे',
      timeEn: '6:00 AM',
    ),
    _EventData(
      day: '22',
      monthHi: 'दिस',
      monthEn: 'Dec',
      nameHi: 'दस लक्षण पर्व',
      nameEn: 'Das Lakshana Parva',
      locationHi: 'दिगंबर जैन मंदिर, दिल्ली',
      locationEn: 'Digambar Jain Temple, Delhi',
      timeHi: 'प्रातः 7:00 बजे',
      timeEn: '7:00 AM',
    ),
    _EventData(
      day: '01',
      monthHi: 'जन',
      monthEn: 'Jan',
      nameHi: 'विशेष प्रवचन श्रृंखला',
      nameEn: 'Special Pravachan Series',
      locationHi: 'टोडरमल स्मारक भवन',
      locationEn: 'Todarmal Smarak Bhavan',
      timeHi: 'सायं 5:00 बजे',
      timeEn: '5:00 PM',
    ),
    _EventData(
      day: '10',
      monthHi: 'जन',
      monthEn: 'Jan',
      nameHi: 'शास्त्र अध्ययन शिविर',
      nameEn: 'Shastra Study Camp',
      locationHi: 'ऑनलाइन — Zoom',
      locationEn: 'Online — Zoom',
      timeHi: 'प्रातः 9:00 बजे',
      timeEn: '9:00 AM',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final hindi = isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    return SizedBox(
      height: 145,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
        itemCount: _dummyEvents.length,
        itemBuilder: (context, index) {
          return _EventCard(event: _dummyEvents[index], isHindi: hindi);
        },
      ),
    );
  }
}

// ── Event Data Model ──
class _EventData {
  const _EventData({
    required this.day,
    required this.monthHi,
    required this.monthEn,
    required this.nameHi,
    required this.nameEn,
    required this.locationHi,
    required this.locationEn,
    required this.timeHi,
    required this.timeEn,
  });

  final String day;
  final String monthHi;
  final String monthEn;
  final String nameHi;
  final String nameEn;
  final String locationHi;
  final String locationEn;
  final String timeHi;
  final String timeEn;
}

// ── Individual Event Card ──
class _EventCard extends StatelessWidget {
  const _EventCard({required this.event, required this.isHindi});

  final _EventData event;
  final bool isHindi;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 260,
      margin: const EdgeInsets.only(right: AppDimensions.paddingM),
      decoration: BoxDecoration(
        color: AppColors.ivory,
        borderRadius: BorderRadius.circular(AppDimensions.radiusM),
        border: const Border(
          left: BorderSide(color: AppColors.antiqueGold, width: 3),
        ),
        boxShadow: [
          BoxShadow(
            color: AppColors.deepMaroon.withOpacity(0.06),
            blurRadius: 10,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            // ── Date Badge ──
            Container(
              width: 50,
              height: 56,
              decoration: BoxDecoration(
                color: AppColors.deepMaroon,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    event.day,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      height: 1.1,
                    ),
                  ),
                  Text(
                    isHindi ? event.monthHi : event.monthEn,
                    style: TextStyle(
                      color: AppColors.antiqueGold.withOpacity(0.9),
                      fontSize: 11,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(width: 12),

            // ── Details ──
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    isHindi ? event.nameHi : event.nameEn,
                    style: const TextStyle(
                      color: AppColors.deepMaroon,
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      height: 1.3,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 4),
                  Row(
                    children: [
                      Icon(
                        Iconsax.location,
                        size: 12,
                        color: AppColors.royalBurgundy.withOpacity(0.5),
                      ),
                      const SizedBox(width: 3),
                      Expanded(
                        child: Text(
                          isHindi ? event.locationHi : event.locationEn,
                          style: TextStyle(
                            color: AppColors.royalBurgundy.withOpacity(0.55),
                            fontSize: 11,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 2),
                  Row(
                    children: [
                      Icon(
                        Iconsax.clock,
                        size: 12,
                        color: AppColors.royalBurgundy.withOpacity(0.5),
                      ),
                      const SizedBox(width: 3),
                      Text(
                        isHindi ? event.timeHi : event.timeEn,
                        style: TextStyle(
                          color: AppColors.royalBurgundy.withOpacity(0.55),
                          fontSize: 11,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),

                  // Register chip
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: AppColors.antiqueGold.withOpacity(0.12),
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: AppColors.antiqueGold.withOpacity(0.4),
                      ),
                    ),
                    child: Text(
                      isHindi ? 'पंजीकरण करें' : 'Register',
                      style: const TextStyle(
                        color: AppColors.antiqueGold,
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
