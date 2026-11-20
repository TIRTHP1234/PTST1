/// RouteNames — Centralized route name and path constants.
///
/// Use these constants throughout the app to avoid magic strings
/// in navigation calls.
library;

abstract final class RouteNames {
  // ── Standalone Routes ──────────────────────────────────────
  static const String splash = 'splash';
  static const String splashPath = '/';

  static const String onboarding = 'onboarding';
  static const String onboardingPath = '/onboarding';

  static const String languageSelection = 'language';
  static const String languageSelectionPath = '/language';

  static const String login = 'login';
  static const String loginPath = '/login';

  static const String register = 'register';
  static const String registerPath = '/register';

  static const String otpVerify = 'otp-verify';
  static const String otpVerifyPath = '/otp-verify';

  static const String mpinSetup = 'mpin-setup';
  static const String mpinSetupPath = '/mpin-setup';

  static const String mpinLogin = 'mpin-login';
  static const String mpinLoginPath = '/mpin-login';

  // ── Main Shell (Bottom Navigation) ─────────────────────────
  static const String main = 'main';
  static const String mainPath = '/main';

  // ── Bottom Nav Tabs ────────────────────────────────────────
  static const String home = 'home';
  static const String homePath = '/main/home';

  static const String library = 'library';
  static const String libraryPath = '/main/library';

  static const String events = 'events';
  static const String eventsPath = '/main/events';

  static const String shop = 'shop';
  static const String shopPath = '/main/shop';

  static const String profile = 'profile';
  static const String profilePath = '/main/profile';
}
