/// MainShell — Shell screen with a custom animated bottom navigation bar.
///
/// Wraps the [StatefulNavigationShell] child from GoRouter and renders
/// a curved bottom nav with 5 tabs:
///   Home · Library · Events · Shop · Profile
///
/// Features:
/// - Animated active-icon pill background
/// - Scale + color transition on tab change
/// - Curved top edge with subtle shadow
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:iconsax/iconsax.dart';

import '../../core/constants/app_colors.dart';
import '../../core/constants/app_dimensions.dart';
import '../../core/localization/locale_provider.dart';
import '../../features/home/widgets/audio_player_dock.dart';

/// The main shell that provides bottom navigation across the app's tabs.
class MainShell extends ConsumerWidget {
  const MainShell({super.key, required this.navigationShell});

  /// The navigation shell supplied by [StatefulShellRoute.indexedStack].
  final StatefulNavigationShell navigationShell;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isHindi = ref.watch(localeProvider).languageCode == 'hi';

    return Container(
      color: const Color(0xFF1E0610), // Royal temple backdrop for desktop browser
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 480),
          child: Container(
            decoration: BoxDecoration(
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.35),
                  blurRadius: 28,
                  spreadRadius: 4,
                ),
              ],
            ),
            child: Scaffold(
              body: Stack(
                children: [
                  navigationShell,
                  const Positioned(
                    left: 0,
                    right: 0,
                    bottom: 0,
                    child: FloatingAudioPlayerDock(),
                  ),
                ],
              ),
              bottomNavigationBar: _AnimatedBottomNav(
                currentIndex: navigationShell.currentIndex,
                isHindi: isHindi,
                onTap: (index) => navigationShell.goBranch(
                  index,
                  initialLocation: index == navigationShell.currentIndex,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  NAV ITEM DATA
// ═══════════════════════════════════════════════════════════════

class _NavItem {
  const _NavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

const _navItems = <_NavItem>[
  _NavItem(icon: Iconsax.home, activeIcon: Iconsax.home_15, label: 'Home'),
  _NavItem(icon: Iconsax.book, activeIcon: Iconsax.book5, label: 'Library'),
  _NavItem(
      icon: Iconsax.calendar, activeIcon: Iconsax.calendar5, label: 'Events'),
  _NavItem(
      icon: Iconsax.shopping_bag,
      activeIcon: Iconsax.shopping_bag5,
      label: 'Shop'),
  _NavItem(
      icon: Iconsax.profile_circle,
      activeIcon: Iconsax.profile_circle5,
      label: 'Profile'),
];

// ═══════════════════════════════════════════════════════════════
//  ANIMATED BOTTOM NAV
// ═══════════════════════════════════════════════════════════════

class _AnimatedBottomNav extends StatefulWidget {
  const _AnimatedBottomNav({
    required this.currentIndex,
    required this.isHindi,
    required this.onTap,
  });

  final int currentIndex;
  final bool isHindi;
  final ValueChanged<int> onTap;

  @override
  State<_AnimatedBottomNav> createState() => _AnimatedBottomNavState();
}

class _AnimatedBottomNavState extends State<_AnimatedBottomNav>
    with TickerProviderStateMixin {
  late List<AnimationController> _controllers;
  late List<Animation<double>> _scaleAnimations;

  @override
  void initState() {
    super.initState();
    _controllers = List.generate(
      _navItems.length,
      (i) => AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        value: i == widget.currentIndex ? 1.0 : 0.0,
      ),
    );
    _scaleAnimations = _controllers
        .map(
          (c) => Tween<double>(begin: 1.0, end: 1.15).animate(
            CurvedAnimation(parent: c, curve: Curves.easeOutBack),
          ),
        )
        .toList();
  }

  @override
  void didUpdateWidget(covariant _AnimatedBottomNav oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controllers[oldWidget.currentIndex].reverse();
      _controllers[widget.currentIndex].forward();
    }
  }

  @override
  void dispose() {
    for (final c in _controllers) {
      c.dispose();
    }
    super.dispose();
  }

  String _getTabLabel(int index) {
    switch (index) {
      case 0:
        return widget.isHindi ? 'होम' : 'Home';
      case 1:
        return widget.isHindi ? 'शास्त्र' : 'Library';
      case 2:
        return widget.isHindi ? 'कार्यक्रम' : 'Events';
      case 3:
        return widget.isHindi ? 'शॉप' : 'Shop';
      case 4:
        return widget.isHindi ? 'प्रोफ़ाइल' : 'Profile';
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Container(
      height: AppDimensions.bottomNavHeight +
          MediaQuery.of(context).padding.bottom,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : Colors.white,
        borderRadius: const BorderRadius.vertical(
          top: Radius.circular(AppDimensions.radiusXl),
        ),
        boxShadow: [
          BoxShadow(
            color: isDark ? Colors.black38 : AppColors.shadow,
            blurRadius: 20,
            spreadRadius: -5,
            offset: const Offset(0, -4),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: List.generate(_navItems.length, (index) {
            final item = _navItems[index];
            final isActive = index == widget.currentIndex;

            return Expanded(
              child: GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () => widget.onTap(index),
                child: AnimatedBuilder(
                  animation: _scaleAnimations[index],
                  builder: (context, child) {
                    return Transform.scale(
                      scale: _scaleAnimations[index].value,
                      child: child,
                    );
                  },
                  child: SizedBox(
                    height: AppDimensions.bottomNavHeight,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // ── Active pill background ───────────
                        AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeOutCubic,
                          padding: EdgeInsets.symmetric(
                            horizontal: isActive ? 16.0 : 8.0,
                            vertical: isActive ? 6.0 : 4.0,
                          ),
                          decoration: BoxDecoration(
                            color: isActive
                                ? (isDark
                                    ? AppColors.antiqueGold
                                        .withValues(alpha: 0.15)
                                    : AppColors.deepMaroon
                                        .withValues(alpha: 0.1))
                                : Colors.transparent,
                            borderRadius: BorderRadius.circular(
                              AppDimensions.radiusRound,
                            ),
                          ),
                          child: Icon(
                            isActive ? item.activeIcon : item.icon,
                            color: isActive
                                ? (isDark
                                    ? AppColors.antiqueGold
                                    : AppColors.deepMaroon)
                                : (isDark
                                    ? AppColors.textTertiaryDark
                                    : AppColors.textTertiaryLight),
                            size: AppDimensions.iconMd,
                          ),
                        ),
                        const SizedBox(height: 2),

                        // ── Label ────────────────────────────
                        AnimatedDefaultTextStyle(
                          duration: const Duration(milliseconds: 200),
                          style: TextStyle(
                            fontSize: isActive
                                ? AppDimensions.fontSmall
                                : AppDimensions.fontCaption,
                            fontWeight: isActive
                                ? FontWeight.w600
                                : FontWeight.w400,
                            color: isActive
                                ? (isDark
                                    ? AppColors.antiqueGold
                                    : AppColors.deepMaroon)
                                : (isDark
                                    ? AppColors.textTertiaryDark
                                    : AppColors.textTertiaryLight),
                          ),
                          child: Text(_getTabLabel(index)),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          }),
        ),
      ),
    );
  }
}

/// Convenience alias for [AnimatedWidget] builder pattern.
class AnimatedBuilder extends AnimatedWidget {
  const AnimatedBuilder({
    super.key,
    required Animation<double> animation,
    required this.builder,
    this.child,
  }) : super(listenable: animation);

  final Widget Function(BuildContext context, Widget? child) builder;
  final Widget? child;

  @override
  Widget build(BuildContext context) => builder(context, child);
}
