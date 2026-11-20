/// AppRouter — GoRouter configuration for the PTST app.
///
/// Defines every route in the application and uses
/// [StatefulShellRoute.indexedStack] for bottom-navigation persistence.
library;

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/login_screen.dart';
import '../../features/auth/mpin_login_screen.dart';
import '../../features/auth/mpin_setup_screen.dart';
import '../../features/auth/otp_verification_screen.dart';
import '../../features/auth/register_screen.dart';
import '../../features/events/events_screen.dart';
import '../../features/home/home_screen.dart';
import '../../features/library/library_screen.dart';
import '../../features/onboarding/language_selection_screen.dart';
import '../../features/onboarding/onboarding_screen.dart';
import '../../features/onboarding/splash_screen.dart';
import '../../features/profile/profile_screen.dart';
import '../../features/shop/shop_screen.dart';
import '../../shared/widgets/main_shell.dart';
import 'route_names.dart';

// ═════════════════════════════════════════════════════════════
//  ROUTER PROVIDER
// ═════════════════════════════════════════════════════════════

/// Global navigator keys for the shell branches.
final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorHomeKey = GlobalKey<NavigatorState>(debugLabel: 'home');
final _shellNavigatorLibraryKey =
    GlobalKey<NavigatorState>(debugLabel: 'library');
final _shellNavigatorEventsKey =
    GlobalKey<NavigatorState>(debugLabel: 'events');
final _shellNavigatorShopKey = GlobalKey<NavigatorState>(debugLabel: 'shop');
final _shellNavigatorProfileKey =
    GlobalKey<NavigatorState>(debugLabel: 'profile');

/// Provides the [GoRouter] instance to the widget tree via Riverpod.
final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: RouteNames.splashPath,
    debugLogDiagnostics: true,
    routes: [
      // ── Standalone (pre-auth) routes ───────────────────────
      GoRoute(
        name: RouteNames.splash,
        path: RouteNames.splashPath,
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        name: RouteNames.onboarding,
        path: RouteNames.onboardingPath,
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        name: RouteNames.languageSelection,
        path: RouteNames.languageSelectionPath,
        builder: (context, state) => const LanguageSelectionScreen(),
      ),
      GoRoute(
        name: RouteNames.login,
        path: RouteNames.loginPath,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        name: RouteNames.register,
        path: RouteNames.registerPath,
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        name: RouteNames.otpVerify,
        path: RouteNames.otpVerifyPath,
        builder: (context, state) {
          final extra = state.extra as Map<String, dynamic>?;
          return OtpVerificationScreen(
            phoneNumber: extra?['phoneNumber'] as String? ?? '+91 98765 43210',
            isLogin: extra?['isLogin'] as bool? ?? true,
          );
        },
      ),
      GoRoute(
        name: RouteNames.mpinSetup,
        path: RouteNames.mpinSetupPath,
        builder: (context, state) => const MpinSetupScreen(),
      ),
      GoRoute(
        name: RouteNames.mpinLogin,
        path: RouteNames.mpinLoginPath,
        builder: (context, state) => const MpinLoginScreen(),
      ),

      // ── Main shell with bottom navigation ──────────────────
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return MainShell(navigationShell: navigationShell);
        },
        branches: [
          // Tab 0 — Home
          StatefulShellBranch(
            navigatorKey: _shellNavigatorHomeKey,
            routes: [
              GoRoute(
                name: RouteNames.home,
                path: RouteNames.homePath,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // Tab 1 — Library
          StatefulShellBranch(
            navigatorKey: _shellNavigatorLibraryKey,
            routes: [
              GoRoute(
                name: RouteNames.library,
                path: RouteNames.libraryPath,
                builder: (context, state) => const LibraryScreen(),
              ),
            ],
          ),

          // Tab 2 — Events
          StatefulShellBranch(
            navigatorKey: _shellNavigatorEventsKey,
            routes: [
              GoRoute(
                name: RouteNames.events,
                path: RouteNames.eventsPath,
                builder: (context, state) => const EventsScreen(),
              ),
            ],
          ),

          // Tab 3 — Shop
          StatefulShellBranch(
            navigatorKey: _shellNavigatorShopKey,
            routes: [
              GoRoute(
                name: RouteNames.shop,
                path: RouteNames.shopPath,
                builder: (context, state) => const ShopScreen(),
              ),
            ],
          ),

          // Tab 4 — Profile
          StatefulShellBranch(
            navigatorKey: _shellNavigatorProfileKey,
            routes: [
              GoRoute(
                name: RouteNames.profile,
                path: RouteNames.profilePath,
                builder: (context, state) => const ProfileScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
});
