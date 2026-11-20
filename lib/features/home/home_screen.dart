import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';
import 'package:ptst_app/core/localization/locale_provider.dart';

import 'widgets/continue_reading_strip.dart';
import 'widgets/daily_thought_card.dart';
import 'widgets/donation_cta_card.dart';
import 'widgets/featured_pravachan_card.dart';
import 'widgets/greeting_header.dart';
import 'widgets/new_book_card.dart';
import 'widgets/new_media_card.dart';
import 'widgets/panchang_card.dart';
import 'widgets/promo_banner_carousel.dart';
import 'widgets/quick_access_grid.dart';
import 'widgets/section_header.dart';
import 'widgets/upcoming_events_strip.dart';

/// Main Home Dashboard for Pandit Todarmal Smarak Trust.
/// Optimized for silky-smooth 60-120 FPS scrolling with dynamic
/// Hindi and English bilingual support.
class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  Future<void> _handleRefresh() async {
    await Future.delayed(const Duration(milliseconds: 600));
    if (mounted) setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Scaffold(
      backgroundColor: const Color(0xFFFBF8F2), // Luxury ivory cream
      body: RefreshIndicator(
        color: AppColors.deepMaroon,
        backgroundColor: AppColors.ivory,
        onRefresh: _handleRefresh,
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(
            parent: AlwaysScrollableScrollPhysics(),
          ),
          slivers: [
            // ── Sliver App Bar with Sacred Emblem ──────────────
            SliverAppBar(
              floating: true,
              pinned: true,
              elevation: 0,
              backgroundColor: AppColors.ivory.withOpacity(0.96),
              surfaceTintColor: Colors.transparent,
              expandedHeight: 70,
              toolbarHeight: 65,
              leading: Padding(
                padding: const EdgeInsets.only(left: AppDimensions.paddingM),
                child: Center(
                  child: Container(
                    width: 42,
                    height: 42,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: const LinearGradient(
                        colors: [Color(0xFF800020), Color(0xFF5A0016)],
                      ),
                      border: Border.all(
                        color: const Color(0xFFFFD54F),
                        width: 1.2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: const Color(0xFF800020).withOpacity(0.2),
                          blurRadius: 6,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: const Center(
                      child: Text(
                        'ॐ',
                        style: TextStyle(
                          color: Color(0xFFFFE082),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    isHindi ? 'पंडित टोडरमल स्मारक ट्रस्ट' : 'Pt. Todarmal Smarak Trust',
                    style: const TextStyle(
                      color: AppColors.deepMaroon,
                      fontSize: 16.5,
                      fontWeight: FontWeight.w800,
                      letterSpacing: 0.3,
                    ),
                  ),
                  Text(
                    isHindi ? 'आधिकारिक मोबाइल ऐप • जयपुर' : 'Official Mobile App • Jaipur',
                    style: const TextStyle(
                      color: AppColors.antiqueGold,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              actions: [
                // Quick Language Switcher Pill
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 14),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      borderRadius: BorderRadius.circular(20),
                      onTap: () => ref.read(localeProvider.notifier).toggleLocale(),
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppColors.antiqueGold.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: AppColors.antiqueGold.withOpacity(0.4),
                            width: 1,
                          ),
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            const Icon(Icons.translate_rounded, size: 13, color: AppColors.deepMaroon),
                            const SizedBox(width: 4),
                            Text(
                              isHindi ? 'EN' : 'हिन्दी',
                              style: const TextStyle(
                                fontSize: 11.5,
                                fontWeight: FontWeight.bold,
                                color: AppColors.deepMaroon,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Iconsax.search_normal_1, color: AppColors.deepMaroon),
                  tooltip: isHindi ? 'खोजें' : 'Search',
                  onPressed: () {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          isHindi
                              ? 'खोज सुविधा शीघ्र उपलब्ध होगी'
                              : 'Universal Search coming soon',
                        ),
                      ),
                    );
                  },
                ),
                Stack(
                  children: [
                    IconButton(
                      icon: const Icon(Iconsax.notification, color: AppColors.deepMaroon),
                      tooltip: isHindi ? 'सूचनाएं' : 'Notifications',
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              isHindi
                                  ? 'कोई नई सूचना नहीं है'
                                  : 'No new notifications',
                            ),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      top: 10,
                      right: 10,
                      child: Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: AppColors.saffronOrange,
                          shape: BoxShape.circle,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: AppDimensions.paddingS),
              ],
            ),

            // ── Main Dashboard Content ─────────────────────────
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // 1. Personalized Greeting
                  RepaintBoundary(
                    child: GreetingHeader(isHindi: isHindi),
                  ),

                  // 2. Promotional Banners
                  RepaintBoundary(
                    child: PromoBannerCarousel(isHindi: isHindi),
                  ),

                  const SizedBox(height: AppDimensions.paddingS),

                  // 3. Daily Spiritual Thought Card (with 3D perspective)
                  RepaintBoundary(
                    child: DailyThoughtCard(isHindi: isHindi),
                  ),

                  // 4. Continue Reading Strip
                  RepaintBoundary(
                    child: ContinueReadingStrip(isHindi: isHindi),
                  ),

                  // 5. Quick Access Shortcuts
                  RepaintBoundary(
                    child: QuickAccessGrid(isHindi: isHindi),
                  ),

                  // 6. Featured Pravachans
                  SectionHeader(
                    title: isHindi
                        ? 'विशेष प्रवचन व्याख्यान'
                        : 'Featured Spiritual Discourses',
                    isHindi: isHindi,
                    onSeeAllTap: () {},
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      height: 230,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        cacheExtent: 400,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                        ),
                        children: [
                          FeaturedPravachanCard(
                            title: isHindi
                                ? 'समयसार परमागम व्याख्यान माला'
                                : 'Samayasara Paramagama Lectures',
                            speaker: isHindi
                                ? 'पं. हुकमचंद जी भारिल्ल'
                                : 'Pt. Hukamchand Bharill',
                            duration: '45:20',
                          ),
                          FeaturedPravachanCard(
                            title: isHindi
                                ? 'मोक्षमार्ग प्रकाशक विवेचन'
                                : 'Mokshamarga Prakashak Discourses',
                            speaker: isHindi
                                ? 'पं. शांतिलाल जी शाह'
                                : 'Pt. Shantilal Shah',
                            duration: '52:15',
                          ),
                          FeaturedPravachanCard(
                            title: isHindi
                                ? 'द्रव्यसंग्रह गाथा विवेचना'
                                : 'Dravyasangraha Gatha Analysis',
                            speaker: isHindi
                                ? 'डॉ. संजीव गोधा'
                                : 'Dr. Sanjeev Godha',
                            duration: '38:40',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // 7. Today's Jain Panchang
                  RepaintBoundary(
                    child: PanchangCard(isHindi: isHindi),
                  ),

                  // 8. New Audio & Video Media
                  SectionHeader(
                    title: isHindi
                        ? 'नया ऑडियो एवं वीडियो'
                        : 'New Audio & Video',
                    isHindi: isHindi,
                    onSeeAllTap: () {},
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      height: 200,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        cacheExtent: 400,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                        ),
                        children: [
                          NewMediaCard(
                            title: isHindi
                                ? 'भक्तामर स्तोत्र पाठ (संगीतमय)'
                                : 'Bhaktamar Stotra Musical Chants',
                            duration: '24:30',
                            isVideo: false,
                            isHindi: isHindi,
                          ),
                          const SizedBox(width: AppDimensions.paddingM),
                          NewMediaCard(
                            title: isHindi
                                ? 'तत्त्वार्थसूत्र प्रथम अध्याय पाठ'
                                : 'Tattvartha Sutra Chapter 1',
                            duration: '18:45',
                            isVideo: true,
                            isHindi: isHindi,
                          ),
                          const SizedBox(width: AppDimensions.paddingM),
                          NewMediaCard(
                            title: isHindi
                                ? 'आलोचना पाठ एवं शांति पाठ'
                                : 'Alochana & Shanti Paath',
                            duration: '15:10',
                            isVideo: false,
                            isHindi: isHindi,
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // 9. 3D Hardcover Sacred Books Showcase
                  SectionHeader(
                    title: isHindi
                        ? 'नवीन साहित्य एवं शास्त्र ग्रंथागार'
                        : 'Sacred Books & Shastras',
                    isHindi: isHindi,
                    onSeeAllTap: () {},
                  ),
                  RepaintBoundary(
                    child: SizedBox(
                      height: 250,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const BouncingScrollPhysics(),
                        cacheExtent: 400,
                        padding: const EdgeInsets.symmetric(
                          horizontal: AppDimensions.paddingL,
                        ),
                        children: [
                          NewBookCard(
                            title: isHindi
                                ? 'मोक्षमार्ग प्रकाशक'
                                : 'Mokshamarga Prakashak',
                            author: isHindi
                                ? 'पं. टोडरमल जी'
                                : 'Pt. Todarmal Ji',
                          ),
                          NewBookCard(
                            title: isHindi
                                ? 'समयसार टीका'
                                : 'Samayasara Teeka',
                            author: isHindi
                                ? 'आचार्य कुंदकुंद / अमृतचंद्र'
                                : 'Acharya Kundakunda',
                          ),
                          NewBookCard(
                            title: isHindi
                                ? 'जैन सिद्धांत प्रवेशिका'
                                : 'Jain Siddhanta Praveshika',
                            author: isHindi
                                ? 'पं. गोपालदास जी बरैया'
                                : 'Pt. Gopaldas Baraiya',
                          ),
                        ],
                      ),
                    ),
                  ),

                  const SizedBox(height: AppDimensions.paddingM),

                  // 10. Upcoming Events
                  SectionHeader(
                    title: isHindi
                        ? 'आगामी धार्मिक कार्यक्रम'
                        : 'Upcoming Religious Events',
                    isHindi: isHindi,
                    onSeeAllTap: () {},
                  ),
                  RepaintBoundary(
                    child: UpcomingEventsStrip(isHindi: isHindi),
                  ),

                  // 11. Donation Campaign Card
                  RepaintBoundary(
                    child: DonationCtaCard(isHindi: isHindi),
                  ),

                  const SizedBox(height: 90), // Bottom nav bar clearance
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
