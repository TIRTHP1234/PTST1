/// PTST App - Pandit Todarmal Smarak Trust
/// Entry point of the application.
///
/// Initializes Flutter bindings, sets up dependency injection via
/// [ProviderScope], configures responsive design via [ScreenUtilInit],
/// and launches the [AppWidget].
library;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'app.dart';

Future<void> main() async {
  // Ensure Flutter bindings are initialized before any async work
  WidgetsFlutterBinding.ensureInitialized();

  // Lock orientation to portrait mode for consistent UI
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);

  // Set system UI overlay style for a premium feel
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarColor: Colors.white,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );

  runApp(
    // ProviderScope is the root of all Riverpod providers
    const ProviderScope(
      child: PtstApp(),
    ),
  );
}

/// Root widget that sets up [ScreenUtilInit] for responsive design
/// and delegates to [AppWidget] for MaterialApp configuration.
class PtstApp extends StatelessWidget {
  const PtstApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      // Design size based on standard mobile viewport
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return Container(
          color: const Color(0xFF1E0610), // Royal temple backdrop for wide screens
          child: Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 480),
              child: const AppWidget(),
            ),
          ),
        );
      },
    );
  }
}
