import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// Auto-scrolling promotional banner carousel with parallax effect and dot
/// indicators. Dynamically supports both Hindi & English.
class PromoBannerCarousel extends StatefulWidget {
  const PromoBannerCarousel({super.key, this.isHindi});

  final bool? isHindi;

  @override
  State<PromoBannerCarousel> createState() => _PromoBannerCarouselState();
}

class _PromoBannerCarouselState extends State<PromoBannerCarousel> {
  int _currentIndex = 0;
  bool _isLoading = true;

  static const _banners = [
    _BannerData(
      titleHi: 'पंडित टोडरमल स्मारक ट्रस्ट',
      titleEn: 'Pt. Todarmal Smarak Trust',
      subtitleHi: 'जैन दर्शन एवं संस्कृति का संरक्षण',
      subtitleEn: 'Preserving Sacred Jain Philosophy & Heritage',
      gradient: [AppColors.deepMaroon, AppColors.royalBurgundy],
      ctaHi: 'अधिक जानें',
      ctaEn: 'Learn More',
    ),
    _BannerData(
      titleHi: 'विशेष प्रवचन व्याख्यान माला',
      titleEn: 'Special Spiritual Discourses',
      subtitleHi: 'आचार्य श्री विद्यासागर जी महाराज',
      subtitleEn: 'Acharya Shri Vidyasagar Ji Maharaj',
      gradient: [Color(0xFF2C1810), Color(0xFF5D3A29)],
      ctaHi: 'अभी सुनें',
      ctaEn: 'Listen Now',
    ),
    _BannerData(
      titleHi: 'नवीन साहित्य विमोचन',
      titleEn: 'New Literature Release',
      subtitleHi: 'मोक्षमार्ग प्रकाशक — अब डिजिटल रूप में',
      subtitleEn: 'Mokshamarga Prakashak — Now in Digital Format',
      gradient: [AppColors.antiqueGold, Color(0xFF8B6914)],
      ctaHi: 'अभी पढ़ें',
      ctaEn: 'Read Now',
    ),
    _BannerData(
      titleHi: 'पर्युषण महापर्व 2026',
      titleEn: 'Paryushan Mahaparva 2026',
      subtitleHi: '10-दिवसीय विशेष आयोजन — रजिस्ट्रेशन खुला',
      subtitleEn: '10-Day Grand Spiritual Festival — Registration Open',
      gradient: [AppColors.saffronOrange, AppColors.deepMaroon],
      ctaHi: 'पंजीकरण करें',
      ctaEn: 'Register Now',
    ),
  ];

  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(milliseconds: 600), () {
      if (mounted) setState(() => _isLoading = false);
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) return _buildShimmer();

    final isHindi = widget.isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');

    return Column(
      children: [
        CarouselSlider.builder(
          itemCount: _banners.length,
          options: CarouselOptions(
            height: 170,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 4),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.22,
            viewportFraction: 0.88,
            onPageChanged: (index, _) => setState(() => _currentIndex = index),
          ),
          itemBuilder: (context, index, realIndex) {
            final banner = _banners[index];
            return _BannerCard(
              title: isHindi ? banner.titleHi : banner.titleEn,
              subtitle: isHindi ? banner.subtitleHi : banner.subtitleEn,
              cta: isHindi ? banner.ctaHi : banner.ctaEn,
              gradient: banner.gradient,
              parallaxOffset: index - _currentIndex,
            );
          },
        ),
        const SizedBox(height: 10),

        // ── Dot Indicator ──
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _banners.length,
            (index) => AnimatedContainer(
              duration: const Duration(milliseconds: 300),
              margin: const EdgeInsets.symmetric(horizontal: 3),
              height: 7,
              width: _currentIndex == index ? 22 : 7,
              decoration: BoxDecoration(
                color: _currentIndex == index
                    ? AppColors.antiqueGold
                    : AppColors.warmBeige,
                borderRadius: BorderRadius.circular(4),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildShimmer() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppDimensions.paddingL),
      child: Shimmer.fromColors(
        baseColor: AppColors.warmBeige,
        highlightColor: AppColors.ivory,
        child: Container(
          height: 170,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(AppDimensions.radiusL),
          ),
        ),
      ),
    );
  }
}

class _BannerData {
  const _BannerData({
    required this.titleHi,
    required this.titleEn,
    required this.subtitleHi,
    required this.subtitleEn,
    required this.gradient,
    required this.ctaHi,
    required this.ctaEn,
  });

  final String titleHi;
  final String titleEn;
  final String subtitleHi;
  final String subtitleEn;
  final List<Color> gradient;
  final String ctaHi;
  final String ctaEn;
}

class _BannerCard extends StatelessWidget {
  const _BannerCard({
    required this.title,
    required this.subtitle,
    required this.cta,
    required this.gradient,
    required this.parallaxOffset,
  });

  final String title;
  final String subtitle;
  final String cta;
  final List<Color> gradient;
  final int parallaxOffset;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppDimensions.radiusL),
        gradient: LinearGradient(
          colors: gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        boxShadow: [
          BoxShadow(
            color: gradient.first.withOpacity(0.35),
            blurRadius: 12,
            offset: const Offset(0, 5),
          ),
        ],
      ),
      child: Stack(
        children: [
          // Background geometric motif
          Positioned(
            right: -20,
            bottom: -20,
            child: Container(
              width: 120,
              height: 120,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.white.withOpacity(0.06),
              ),
            ),
          ),

          Padding(
            padding: const EdgeInsets.all(AppDimensions.paddingL),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.w800,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  subtitle,
                  style: TextStyle(
                    color: Colors.white.withOpacity(0.85),
                    fontSize: 12,
                    height: 1.3,
                  ),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 12),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.antiqueGold,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(
                    cta,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
