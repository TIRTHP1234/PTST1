import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:ptst_app/core/constants/app_colors.dart';
import 'package:ptst_app/core/constants/app_dimensions.dart';

/// 2×4 grid of quick-access shortcut icons with labels dynamically supporting
/// Hindi & English.
class QuickAccessGrid extends StatelessWidget {
  const QuickAccessGrid({super.key, this.isHindi});

  final bool? isHindi;

  List<_QuickItem> _getItems(bool isHindi) => [
        _QuickItem(
          icon: Iconsax.book_1,
          label: isHindi ? 'शास्त्र' : 'Scriptures',
          colors: const [Color(0xFF800020), Color(0xFFA0334A)],
        ),
        _QuickItem(
          icon: Iconsax.microphone,
          label: isHindi ? 'प्रवचन' : 'Discourses',
          colors: const [Color(0xFFC9A94E), Color(0xFFD4B85A)],
        ),
        _QuickItem(
          icon: Iconsax.calendar_1,
          label: isHindi ? 'कैलेंडर' : 'Calendar',
          colors: const [Color(0xFFF5A623), Color(0xFFF7BC5A)],
        ),
        _QuickItem(
          icon: Iconsax.heart,
          label: isHindi ? 'दान' : 'Donation',
          colors: const [Color(0xFF76052E), Color(0xFF9A2050)],
        ),
        _QuickItem(
          icon: Iconsax.shopping_bag,
          label: isHindi ? 'बुक शॉप' : 'Book Store',
          colors: const [Color(0xFF2D5016), Color(0xFF4A7A2E)],
        ),
        _QuickItem(
          icon: Iconsax.teacher,
          label: isHindi ? 'कोर्स' : 'Courses',
          colors: const [Color(0xFF0D3B66), Color(0xFF1B6CA8)],
        ),
        _QuickItem(
          icon: Iconsax.calendar_tick,
          label: isHindi ? 'कार्यक्रम' : 'Events',
          colors: const [Color(0xFF3D1E6D), Color(0xFF6040A0)],
        ),
        _QuickItem(
          icon: Iconsax.document_download,
          label: isHindi ? 'डाउनलोड' : 'Downloads',
          colors: const [Color(0xFF1A3A5C), Color(0xFF2D5F8A)],
        ),
      ];

  @override
  Widget build(BuildContext context) {
    final hindi = isHindi ?? (Localizations.localeOf(context).languageCode == 'hi');
    final items = _getItems(hindi);

    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppDimensions.paddingL,
        vertical: AppDimensions.paddingM,
      ),
      child: GridView.builder(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 14,
          crossAxisSpacing: 10,
          childAspectRatio: 0.85,
        ),
        itemCount: items.length,
        itemBuilder: (context, index) => _QuickAccessItem(item: items[index]),
      ),
    );
  }
}

class _QuickItem {
  const _QuickItem({
    required this.icon,
    required this.label,
    required this.colors,
  });

  final IconData icon;
  final String label;
  final List<Color> colors;
}

class _QuickAccessItem extends StatefulWidget {
  const _QuickAccessItem({required this.item});

  final _QuickItem item;

  @override
  State<_QuickAccessItem> createState() => _QuickAccessItemState();
}

class _QuickAccessItemState extends State<_QuickAccessItem>
    with SingleTickerProviderStateMixin {
  late final AnimationController _bounceController;
  late final Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _bounceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 140),
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.88).animate(
      CurvedAnimation(parent: _bounceController, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _bounceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _bounceController.forward(),
      onTapUp: (_) {
        _bounceController.reverse();
      },
      onTapCancel: () => _bounceController.reverse(),
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) => Transform.scale(
          scale: _scaleAnimation.value,
          child: child,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: widget.item.colors,
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                shape: BoxShape.circle,
                boxShadow: [
                  BoxShadow(
                    color: widget.item.colors.first.withOpacity(0.3),
                    blurRadius: 8,
                    offset: const Offset(0, 3),
                  ),
                ],
              ),
              child: Icon(
                widget.item.icon,
                color: Colors.white,
                size: 22,
              ),
            ),
            const SizedBox(height: 6),
            Text(
              widget.item.label,
              style: const TextStyle(
                color: AppColors.textPrimaryLight,
                fontSize: 12,
                fontWeight: FontWeight.w600,
              ),
              textAlign: TextAlign.center,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}
