/// AppStrings — Centralized string constants for the PTST app.
///
/// Provides both Hindi and English variants for the app's text content.
/// For full i18n, migrate to ARB-based localization in the future.
library;

abstract final class AppStrings {
  // ── App Identity ───────────────────────────────────────────
  static const String appName = 'PTST';
  static const String appFullNameHi = 'पंडित टोडरमल स्मारक ट्रस्ट';
  static const String appFullNameEn = 'Pandit Todarmal Smarak Trust';
  static const String appTaglineHi = 'ज्ञान, संस्कृति और सेवा का केंद्र';
  static const String appTaglineEn = 'Center of Knowledge, Culture & Service';

  // ── Onboarding ─────────────────────────────────────────────
  static const String onboardingTitle1Hi = 'ज्ञान का भंडार';
  static const String onboardingTitle1En = 'Treasure of Knowledge';
  static const String onboardingDesc1Hi =
      'हजारों जैन ग्रंथों और पुस्तकों का विशाल डिजिटल पुस्तकालय';
  static const String onboardingDesc1En =
      'A vast digital library of thousands of Jain texts and books';

  static const String onboardingTitle2Hi = 'कार्यक्रम और आयोजन';
  static const String onboardingTitle2En = 'Events & Programs';
  static const String onboardingDesc2Hi =
      'धार्मिक, सांस्कृतिक और शैक्षणिक कार्यक्रमों की जानकारी';
  static const String onboardingDesc2En =
      'Stay updated with religious, cultural & educational programs';

  static const String onboardingTitle3Hi = 'ट्रस्ट से जुड़ें';
  static const String onboardingTitle3En = 'Connect with Trust';
  static const String onboardingDesc3Hi =
      'दान, सदस्यता और सेवा के माध्यम से ट्रस्ट से जुड़ें';
  static const String onboardingDesc3En =
      'Join the Trust through donations, membership & service';

  // ── Authentication ─────────────────────────────────────────
  static const String loginHi = 'लॉग इन करें';
  static const String loginEn = 'Login';
  static const String registerHi = 'रजिस्टर करें';
  static const String registerEn = 'Register';
  static const String phoneHintHi = 'मोबाइल नंबर दर्ज करें';
  static const String phoneHintEn = 'Enter mobile number';
  static const String otpVerifyHi = 'OTP सत्यापित करें';
  static const String otpVerifyEn = 'Verify OTP';
  static const String mpinSetupHi = 'MPIN सेट करें';
  static const String mpinSetupEn = 'Set MPIN';
  static const String mpinLoginHi = 'MPIN दर्ज करें';
  static const String mpinLoginEn = 'Enter MPIN';

  // ── Navigation ─────────────────────────────────────────────
  static const String homeHi = 'होम';
  static const String homeEn = 'Home';
  static const String libraryHi = 'पुस्तकालय';
  static const String libraryEn = 'Library';
  static const String eventsHi = 'कार्यक्रम';
  static const String eventsEn = 'Events';
  static const String shopHi = 'दुकान';
  static const String shopEn = 'Shop';
  static const String profileHi = 'प्रोफ़ाइल';
  static const String profileEn = 'Profile';

  // ── Common Actions ─────────────────────────────────────────
  static const String continueHi = 'जारी रखें';
  static const String continueEn = 'Continue';
  static const String skipHi = 'छोड़ें';
  static const String skipEn = 'Skip';
  static const String nextHi = 'अगला';
  static const String nextEn = 'Next';
  static const String backHi = 'वापस';
  static const String backEn = 'Back';
  static const String cancelHi = 'रद्द करें';
  static const String cancelEn = 'Cancel';
  static const String okHi = 'ठीक है';
  static const String okEn = 'OK';
  static const String retryHi = 'पुनः प्रयास करें';
  static const String retryEn = 'Retry';

  // ── Errors ─────────────────────────────────────────────────
  static const String genericErrorHi = 'कुछ गलत हो गया, कृपया पुनः प्रयास करें';
  static const String genericErrorEn = 'Something went wrong, please try again';
  static const String noInternetHi = 'इंटरनेट कनेक्शन नहीं है';
  static const String noInternetEn = 'No internet connection';

  // ── Language Selection ─────────────────────────────────────
  static const String selectLanguageHi = 'भाषा चुनें';
  static const String selectLanguageEn = 'Select Language';
  static const String hindiLabel = 'हिन्दी';
  static const String englishLabel = 'English';
}
