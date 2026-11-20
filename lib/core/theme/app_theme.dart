/// AppTheme — Complete light and dark [ThemeData] for the PTST app.
///
/// Leverages [AppColors] for all palette decisions and [GoogleFonts]
/// for English typography (Poppins) alongside the bundled
/// NotoSansDevanagari for Hindi text.
///
/// Includes sub-themes for AppBar, Card, ElevatedButton,
/// InputDecoration, BottomNavigationBar, and more.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

abstract final class AppTheme {
  // ═══════════════════════════════════════════════════════════
  //  LIGHT THEME
  // ═══════════════════════════════════════════════════════════
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.light(
      primary: AppColors.deepMaroon,
      primaryContainer: AppColors.royalBurgundy,
      secondary: AppColors.antiqueGold,
      secondaryContainer: AppColors.saffronOrange,
      surface: AppColors.surfaceLight,
      error: AppColors.error,
      onPrimary: Colors.white,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryLight,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundLight,
      brightness: Brightness.light,

      // ── Typography ───────────────────────────────────────
      textTheme: _buildTextTheme(Brightness.light),
      fontFamily: GoogleFonts.poppins().fontFamily,

      // ── AppBar ───────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.deepMaroon,
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: AppDimensions.elevationSm,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: AppDimensions.fontTitle,
          fontWeight: FontWeight.w600,
          color: Colors.white,
        ),
        iconTheme: const IconThemeData(color: Colors.white),
      ),

      // ── Card ─────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.cardLight,
        elevation: AppDimensions.elevationSm,
        shadowColor: AppColors.shadow,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingSm,
        ),
      ),

      // ── Elevated Button ──────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.deepMaroon,
          foregroundColor: Colors.white,
          elevation: AppDimensions.elevationMd,
          shadowColor: AppColors.deepMaroon.withValues(alpha: 0.4),
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppDimensions.fontSubtitle,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Outlined Button ──────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.deepMaroon,
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeight,
          ),
          side: const BorderSide(color: AppColors.deepMaroon, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppDimensions.fontSubtitle,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Text Button ──────────────────────────────────────
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.deepMaroon,
          textStyle: GoogleFonts.poppins(
            fontSize: AppDimensions.fontBody,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),

      // ── Input Decoration ─────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.warmBeige.withValues(alpha: 0.3),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderLight),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.deepMaroon,
            width: AppDimensions.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textTertiaryLight,
          fontSize: AppDimensions.fontBody,
        ),
        labelStyle: GoogleFonts.poppins(
          color: AppColors.textSecondaryLight,
          fontSize: AppDimensions.fontBody,
        ),
      ),

      // ── Bottom Navigation Bar ────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.white,
        selectedItemColor: AppColors.deepMaroon,
        unselectedItemColor: AppColors.textTertiaryLight,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationLg,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: AppDimensions.fontSmall,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: AppDimensions.fontCaption,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Divider ──────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerLight,
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.spacingLg,
      ),

      // ── Chip ─────────────────────────────────────────────
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.softPeach,
        selectedColor: AppColors.deepMaroon,
        labelStyle: GoogleFonts.poppins(fontSize: AppDimensions.fontSmall),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusRound),
        ),
        side: BorderSide.none,
      ),

      // ── Floating Action Button ───────────────────────────
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.saffronOrange,
        foregroundColor: Colors.white,
        elevation: AppDimensions.elevationMd,
      ),

      // ── Dialog ───────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: Colors.white,
        elevation: AppDimensions.elevationXl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        ),
      ),

      // ── Bottom Sheet ─────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusXl),
          ),
        ),
      ),

      // ── Snack Bar ────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.textPrimaryLight,
        contentTextStyle: GoogleFonts.poppins(
          color: Colors.white,
          fontSize: AppDimensions.fontBody,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  //  DARK THEME
  // ═══════════════════════════════════════════════════════════
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.antiqueGold,
      primaryContainer: AppColors.deepMaroon,
      secondary: AppColors.saffronOrange,
      secondaryContainer: AppColors.royalBurgundy,
      surface: AppColors.surfaceDark,
      error: AppColors.error,
      onPrimary: AppColors.backgroundDark,
      onSecondary: Colors.white,
      onSurface: AppColors.textPrimaryDark,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      brightness: Brightness.dark,

      // ── Typography ───────────────────────────────────────
      textTheme: _buildTextTheme(Brightness.dark),
      fontFamily: GoogleFonts.poppins().fontFamily,

      // ── AppBar ───────────────────────────────────────────
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.surfaceDark,
        foregroundColor: AppColors.antiqueGold,
        elevation: 0,
        centerTitle: true,
        scrolledUnderElevation: AppDimensions.elevationSm,
        titleTextStyle: GoogleFonts.poppins(
          fontSize: AppDimensions.fontTitle,
          fontWeight: FontWeight.w600,
          color: AppColors.antiqueGold,
        ),
        iconTheme: const IconThemeData(color: AppColors.antiqueGold),
      ),

      // ── Card ─────────────────────────────────────────────
      cardTheme: CardThemeData(
        color: AppColors.cardDark,
        elevation: AppDimensions.elevationSm,
        shadowColor: Colors.black38,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusLg),
        ),
        margin: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingSm,
        ),
      ),

      // ── Elevated Button ──────────────────────────────────
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.antiqueGold,
          foregroundColor: AppColors.backgroundDark,
          elevation: AppDimensions.elevationMd,
          shadowColor: AppColors.antiqueGold.withValues(alpha: 0.4),
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeight,
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppDimensions.fontSubtitle,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Outlined Button ──────────────────────────────────
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.antiqueGold,
          minimumSize: const Size(
            double.infinity,
            AppDimensions.buttonHeight,
          ),
          side: const BorderSide(color: AppColors.antiqueGold, width: 1.5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          ),
          textStyle: GoogleFonts.poppins(
            fontSize: AppDimensions.fontSubtitle,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),

      // ── Input Decoration ─────────────────────────────────
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceElevatedDark,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: AppDimensions.spacingLg,
          vertical: AppDimensions.spacingLg,
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.borderDark),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(
            color: AppColors.antiqueGold,
            width: AppDimensions.borderWidthThick,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        hintStyle: GoogleFonts.poppins(
          color: AppColors.textTertiaryDark,
          fontSize: AppDimensions.fontBody,
        ),
        labelStyle: GoogleFonts.poppins(
          color: AppColors.textSecondaryDark,
          fontSize: AppDimensions.fontBody,
        ),
      ),

      // ── Bottom Navigation Bar ────────────────────────────
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.antiqueGold,
        unselectedItemColor: AppColors.textTertiaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: AppDimensions.elevationLg,
        selectedLabelStyle: GoogleFonts.poppins(
          fontSize: AppDimensions.fontSmall,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: GoogleFonts.poppins(
          fontSize: AppDimensions.fontCaption,
          fontWeight: FontWeight.w400,
        ),
      ),

      // ── Divider ──────────────────────────────────────────
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: AppDimensions.dividerThickness,
        space: AppDimensions.spacingLg,
      ),

      // ── Dialog ───────────────────────────────────────────
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceElevatedDark,
        elevation: AppDimensions.elevationXl,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusXl),
        ),
      ),

      // ── Bottom Sheet ─────────────────────────────────────
      bottomSheetTheme: const BottomSheetThemeData(
        backgroundColor: AppColors.surfaceDark,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(AppDimensions.radiusXl),
          ),
        ),
      ),

      // ── Snack Bar ────────────────────────────────────────
      snackBarTheme: SnackBarThemeData(
        backgroundColor: AppColors.surfaceElevatedDark,
        contentTextStyle: GoogleFonts.poppins(
          color: AppColors.textPrimaryDark,
          fontSize: AppDimensions.fontBody,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppDimensions.radiusMd),
        ),
        behavior: SnackBarBehavior.floating,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  //  TEXT THEME BUILDER
  // ═══════════════════════════════════════════════════════════
  static TextTheme _buildTextTheme(Brightness brightness) {
    final isLight = brightness == Brightness.light;
    final primaryColor =
        isLight ? AppColors.textPrimaryLight : AppColors.textPrimaryDark;
    final secondaryColor =
        isLight ? AppColors.textSecondaryLight : AppColors.textSecondaryDark;

    return TextTheme(
      displayLarge: GoogleFonts.poppins(
        fontSize: 34,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: -0.5,
      ),
      displayMedium: GoogleFonts.poppins(
        fontSize: 28,
        fontWeight: FontWeight.w700,
        color: primaryColor,
        letterSpacing: -0.25,
      ),
      displaySmall: GoogleFonts.poppins(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineLarge: GoogleFonts.poppins(
        fontSize: 22,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineMedium: GoogleFonts.poppins(
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      headlineSmall: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      titleLarge: GoogleFonts.poppins(
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      titleMedium: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: primaryColor,
      ),
      titleSmall: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      bodyLarge: GoogleFonts.poppins(
        fontSize: 16,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      bodyMedium: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w400,
        color: primaryColor,
      ),
      bodySmall: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w400,
        color: secondaryColor,
      ),
      labelLarge: GoogleFonts.poppins(
        fontSize: 14,
        fontWeight: FontWeight.w600,
        color: primaryColor,
      ),
      labelMedium: GoogleFonts.poppins(
        fontSize: 12,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
      ),
      labelSmall: GoogleFonts.poppins(
        fontSize: 11,
        fontWeight: FontWeight.w500,
        color: secondaryColor,
        letterSpacing: 0.5,
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════
  //  PREMIUM GLASSMORPHISM CARD DECORATION
  // ═══════════════════════════════════════════════════════════
  /// Returns a [BoxDecoration] for a glassmorphism-style card.
  ///
  /// Use this in a [Container] or [DecoratedBox] for a premium frosted
  /// glass appearance.
  static BoxDecoration glassmorphismDecoration({
    bool isDark = false,
    double borderRadius = AppDimensions.radiusLg,
    double opacity = 0.15,
  }) {
    return BoxDecoration(
      color: isDark
          ? Colors.white.withValues(alpha: opacity)
          : Colors.white.withValues(alpha: 0.7),
      borderRadius: BorderRadius.circular(borderRadius),
      border: Border.all(
        color: isDark
            ? Colors.white.withValues(alpha: 0.2)
            : AppColors.antiqueGold.withValues(alpha: 0.3),
        width: 1.5,
      ),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black26 : AppColors.shadow,
          blurRadius: 20,
          spreadRadius: -5,
          offset: const Offset(0, 8),
        ),
      ],
    );
  }

  /// Returns a [BoxDecoration] for a premium elevated card.
  static BoxDecoration premiumCardDecoration({
    bool isDark = false,
    double borderRadius = AppDimensions.radiusLg,
  }) {
    return BoxDecoration(
      color: isDark ? AppColors.cardDark : AppColors.cardLight,
      borderRadius: BorderRadius.circular(borderRadius),
      boxShadow: [
        BoxShadow(
          color: isDark ? Colors.black38 : AppColors.shadow,
          blurRadius: 16,
          spreadRadius: -4,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: isDark
              ? Colors.black12
              : AppColors.antiqueGold.withValues(alpha: 0.08),
          blurRadius: 8,
          spreadRadius: -2,
          offset: const Offset(0, 2),
        ),
      ],
    );
  }
}
