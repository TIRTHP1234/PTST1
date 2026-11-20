/// AppWidget — The MaterialApp.router configuration.
///
/// Sets up routing via [GoRouter], theming via [AppTheme],
/// and dynamic locale support for Hindi and English via [localeProvider].
library;

import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'core/localization/locale_provider.dart';
import 'core/router/app_router.dart';
import 'core/theme/app_theme.dart';

/// Main application widget using [MaterialApp.router].
class AppWidget extends ConsumerWidget {
  const AppWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final activeLocale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'PTST — पंडित टोडरमल स्मारक ट्रस्ट',
      debugShowCheckedModeBanner: false,

      // ── Routing ──────────────────────────────────────────────
      routerConfig: router,

      // ── Theming ──────────────────────────────────────────────
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      themeMode: ThemeMode.light,

      // ── Dynamic Localization ─────────────────────────────────
      locale: activeLocale,
      supportedLocales: const [
        Locale('en', 'US'), // English
        Locale('hi', 'IN'), // Hindi
      ],
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
    );
  }
}
