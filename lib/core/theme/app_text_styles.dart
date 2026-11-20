/// AppTextStyles — Pre-built text styles for English (Poppins)
/// and Hindi (NotoSansDevanagari) typography.
///
/// Use these directly or as a base with `.copyWith()` for one-off overrides.
library;

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../constants/app_colors.dart';
import '../constants/app_dimensions.dart';

abstract final class AppTextStyles {
  // ═══════════════════════════════════════════════════════════
  //  ENGLISH TEXT STYLES (Poppins)
  // ═══════════════════════════════════════════════════════════

  // ── Headlines ────────────────────────────────────────────
  static TextStyle get headlineXl => GoogleFonts.poppins(
        fontSize: AppDimensions.fontHero,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        letterSpacing: -0.5,
        height: 1.2,
      );

  static TextStyle get headlineLg => GoogleFonts.poppins(
        fontSize: AppDimensions.fontDisplay,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        letterSpacing: -0.25,
        height: 1.25,
      );

  static TextStyle get headlineMd => GoogleFonts.poppins(
        fontSize: AppDimensions.fontHeadline,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
        height: 1.3,
      );

  static TextStyle get headlineSm => GoogleFonts.poppins(
        fontSize: AppDimensions.fontTitle,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
        height: 1.3,
      );

  // ── Titles ───────────────────────────────────────────────
  static TextStyle get titleLg => GoogleFonts.poppins(
        fontSize: AppDimensions.fontTitle,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
        height: 1.35,
      );

  static TextStyle get titleMd => GoogleFonts.poppins(
        fontSize: AppDimensions.fontSubtitle,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimaryLight,
        height: 1.4,
      );

  static TextStyle get titleSm => GoogleFonts.poppins(
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryLight,
        height: 1.4,
      );

  // ── Body ─────────────────────────────────────────────────
  static TextStyle get bodyLg => GoogleFonts.poppins(
        fontSize: AppDimensions.fontSubtitle,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
        height: 1.5,
      );

  static TextStyle get bodyMd => GoogleFonts.poppins(
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
        height: 1.5,
      );

  static TextStyle get bodySm => GoogleFonts.poppins(
        fontSize: AppDimensions.fontSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
        height: 1.5,
      );

  // ── Captions ─────────────────────────────────────────────
  static TextStyle get caption => GoogleFonts.poppins(
        fontSize: AppDimensions.fontCaption,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiaryLight,
        height: 1.4,
      );

  static TextStyle get captionBold => GoogleFonts.poppins(
        fontSize: AppDimensions.fontCaption,
        fontWeight: FontWeight.w600,
        color: AppColors.textSecondaryLight,
        height: 1.4,
      );

  // ── Labels ───────────────────────────────────────────────
  static TextStyle get labelLg => GoogleFonts.poppins(
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimaryLight,
        height: 1.3,
      );

  static TextStyle get labelMd => GoogleFonts.poppins(
        fontSize: AppDimensions.fontSmall,
        fontWeight: FontWeight.w500,
        color: AppColors.textSecondaryLight,
        height: 1.3,
      );

  static TextStyle get labelSm => GoogleFonts.poppins(
        fontSize: AppDimensions.fontCaption,
        fontWeight: FontWeight.w500,
        color: AppColors.textTertiaryLight,
        letterSpacing: 0.5,
        height: 1.3,
      );

  // ── Button Text ──────────────────────────────────────────
  static TextStyle get buttonLg => GoogleFonts.poppins(
        fontSize: AppDimensions.fontSubtitle,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.2,
      );

  static TextStyle get buttonMd => GoogleFonts.poppins(
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w600,
        color: Colors.white,
        height: 1.2,
      );

  // ═══════════════════════════════════════════════════════════
  //  HINDI TEXT STYLES (NotoSansDevanagari)
  // ═══════════════════════════════════════════════════════════

  // ── Headlines ────────────────────────────────────────────
  static TextStyle get headlineXlHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontHero,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        height: 1.3,
      );

  static TextStyle get headlineLgHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontDisplay,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        height: 1.35,
      );

  static TextStyle get headlineMdHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontHeadline,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        height: 1.35,
      );

  static TextStyle get headlineSmHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontTitle,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        height: 1.35,
      );

  // ── Titles ───────────────────────────────────────────────
  static TextStyle get titleLgHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontTitle,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        height: 1.4,
      );

  static TextStyle get titleMdHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontSubtitle,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
        height: 1.45,
      );

  static TextStyle get titleSmHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
        height: 1.45,
      );

  // ── Body ─────────────────────────────────────────────────
  static TextStyle get bodyLgHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontSubtitle,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
        height: 1.6,
      );

  static TextStyle get bodyMdHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w400,
        color: AppColors.textPrimaryLight,
        height: 1.6,
      );

  static TextStyle get bodySmHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
        height: 1.6,
      );

  // ── Captions ─────────────────────────────────────────────
  static TextStyle get captionHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontCaption,
        fontWeight: FontWeight.w400,
        color: AppColors.textTertiaryLight,
        height: 1.5,
      );

  // ── Labels ───────────────────────────────────────────────
  static TextStyle get labelLgHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontBody,
        fontWeight: FontWeight.w700,
        color: AppColors.textPrimaryLight,
        height: 1.4,
      );

  static TextStyle get labelMdHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontSmall,
        fontWeight: FontWeight.w400,
        color: AppColors.textSecondaryLight,
        height: 1.4,
      );

  // ── Button Text ──────────────────────────────────────────
  static TextStyle get buttonLgHi => const TextStyle(
        fontFamily: 'NotoSansDevanagari',
        fontSize: AppDimensions.fontSubtitle,
        fontWeight: FontWeight.w700,
        color: Colors.white,
        height: 1.3,
      );
}
