import 'package:flutter/material.dart';

/// AppLocalizations — Simple, high-performance in-app translation dictionary
/// supporting Hindi ('hi') and English ('en').
class AppLocalizations {
  AppLocalizations(this.locale);

  final Locale locale;

  static AppLocalizations of(BuildContext context) {
    final loc = Localizations.maybeLocaleOf(context) ?? const Locale('hi');
    return AppLocalizations(loc);
  }

  bool get isHindi => locale.languageCode == 'hi';

  String get(String key) {
    final map = isHindi ? _hi : _en;
    return map[key] ?? _hi[key] ?? key;
  }

  static const Map<String, String> _hi = {
    // App Bar
    'app_title': 'पंडित टोडरमल स्मारक ट्रस्ट',
    'app_subtitle': 'आधिकारिक मोबाइल ऐप • जयपुर',
    'search_hint': 'खोज सुविधा शीघ्र उपलब्ध होगी',
    'no_notifications': 'कोई नई सूचना नहीं है',

    // Greeting
    'greeting': 'जय जिनेन्द्र',
    'guest_user': 'साधर्मी भाई',

    // Banners
    'banner1_title': 'पंडित टोडरमल स्मारक ट्रस्ट',
    'banner1_subtitle': 'जैन दर्शन एवं संस्कृति का संरक्षण',
    'banner1_cta': 'अधिक जानें',
    'banner2_title': 'विशेष प्रवचन व्याख्यान माला',
    'banner2_subtitle': 'आचार्य श्री विद्यासागर जी महाराज',
    'banner2_cta': 'अभी सुनें',
    'banner3_title': 'नवीन साहित्य विमोचन',
    'banner3_subtitle': 'मोक्षमार्ग प्रकाशक — अब डिजिटल रूप में',
    'banner3_cta': 'अभी पढ़ें',

    // Daily Thought
    'daily_thought_label': 'आज का आध्यात्मिक विचार',
    'daily_thought_quote':
        '\"जो आत्मा को जानता है, वही सच्चा ज्ञानी है। बाहरी संपत्ति नहीं, आंतरिक शुद्धि ही असली धन है।\"',
    'daily_thought_author': 'आचार्य कुन्दकुन्द — समयसार',
    'share': 'शेयर करें',
    'save': 'सहेजें',

    // Continue Reading
    'continue_reading': 'जारी रखें',
    'book_type': 'पुस्तक',
    'audio_type': 'ऑडियो',

    // Quick Access
    'shastra': 'शास्त्र',
    'pravachan': 'प्रवचन',
    'calendar': 'कैलेंडर',
    'donation': 'दान',
    'book_shop': 'बुक शॉप',
    'courses': 'कोर्स',
    'events': 'कार्यक्रम',
    'downloads': 'डाउनलोड',

    // Section Titles
    'featured_pravachan': 'विशेष प्रवचन व्याख्यान',
    'new_media': 'नया ऑडियो एवं वीडियो',
    'new_books': 'नवीन साहित्य एवं शास्त्र ग्रंथागार',
    'upcoming_events': 'आगामी धार्मिक कार्यक्रम',
    'see_all': 'सभी देखें →',

    // Panchang
    'panchang_title': 'आज का जैन पंचांग',
    'tithi_name': 'शुक्ल पक्ष, एकादशी',
    'sunrise': 'सूर्योदय: ०६:१२',
    'sunset': 'सूर्यास्त: १८:२४',

    // Donation Card
    'donation_title': 'सहयोग एवं दान अभियान',
    'donation_subtitle': 'धार्मिक साहित्य प्रकाशन एवं शिक्षण शिविर',
    'donation_desc':
        'धर्म प्रचार एवं शिक्षा के लिए आपका योगदान अमूल्य है।\n८०G आयकर छूट की डिजिटल रसीद तुरंत प्राप्त करें।',
    'donation_collected': '₹३,२०,००० एकत्रित (६४%)',
    'donation_target': 'लक्ष्य ₹५,००,०००',
    'donate_now': 'अभी दान करें (Donate Now)',

    // Bottom Navigation
    'nav_home': 'होम',
    'nav_library': 'शास्त्र',
    'nav_events': 'कार्यक्रम',
    'nav_shop': 'शॉप',
    'nav_profile': 'प्रोफ़ाइल',
  };

  static const Map<String, String> _en = {
    // App Bar
    'app_title': 'Pt. Todarmal Smarak Trust',
    'app_subtitle': 'Official Mobile App • Jaipur',
    'search_hint': 'Universal Search coming soon',
    'no_notifications': 'No new notifications',

    // Greeting
    'greeting': 'Jai Jinendra',
    'guest_user': 'Sadharmik Brother',

    // Banners
    'banner1_title': 'Pt. Todarmal Smarak Trust',
    'banner1_subtitle': 'Preserving Jain Philosophy & Heritage',
    'banner1_cta': 'Learn More',
    'banner2_title': 'Special Discourse Series',
    'banner2_subtitle': 'Acharya Shri Vidyasagar Ji Maharaj',
    'banner2_cta': 'Listen Now',
    'banner3_title': 'New Book Release',
    'banner3_subtitle': 'Mokshamarga Prakashak — Now in Digital Format',
    'banner3_cta': 'Read Now',

    // Daily Thought
    'daily_thought_label': 'Today\'s Spiritual Thought',
    'daily_thought_quote':
        '\"One who knows the true nature of Soul is the truly enlightened one. Inner purity, not external wealth, is the ultimate treasure.\"',
    'daily_thought_author': 'Acharya Kundakunda — Samayasara',
    'share': 'Share',
    'save': 'Bookmark',

    // Continue Reading
    'continue_reading': 'Continue Reading',
    'book_type': 'Book',
    'audio_type': 'Audio',

    // Quick Access
    'shastra': 'Scriptures',
    'pravachan': 'Discourses',
    'calendar': 'Calendar',
    'donation': 'Donation',
    'book_shop': 'Book Store',
    'courses': 'Courses',
    'events': 'Events',
    'downloads': 'Downloads',

    // Section Titles
    'featured_pravachan': 'Featured Spiritual Discourses',
    'new_media': 'New Audio & Video',
    'new_books': 'Sacred Books & Literature',
    'upcoming_events': 'Upcoming Religious Events',
    'see_all': 'View All →',

    // Panchang
    'panchang_title': 'Today\'s Jain Panchang',
    'tithi_name': 'Shukla Paksha, Ekadashi',
    'sunrise': 'Sunrise: 06:12 AM',
    'sunset': 'Sunset: 06:24 PM',

    // Donation Card
    'donation_title': 'Support & Donation Campaign',
    'donation_subtitle': 'Religious Publishing & Educational Shibirs',
    'donation_desc':
        'Your contribution is invaluable for spreading spiritual education.\nReceive instant 80G tax exemption digital receipts.',
    'donation_collected': '₹3,20,000 Raised (64%)',
    'donation_target': 'Goal ₹5,00,000',
    'donate_now': 'Donate Now',

    // Bottom Navigation
    'nav_home': 'Home',
    'nav_library': 'Library',
    'nav_events': 'Events',
    'nav_shop': 'Shop',
    'nav_profile': 'Profile',
  };
}

extension AppLocalizationsX on BuildContext {
  AppLocalizations get loc => AppLocalizations.of(this);
  String tr(String key) => loc.get(key);
}
