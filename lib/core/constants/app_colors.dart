/// AppColors — Design-system color palette for the PTST app.
///
/// Organized into primary, secondary, accent, semantic, surface,
/// background, and text color groups for both light and dark themes.
library;

import 'package:flutter/material.dart';

abstract final class AppColors {
  // ── Primary Colors ─────────────────────────────────────────
  /// Deep maroon — the dominant brand color.
  static const Color deepMaroon = Color(0xFF800020);

  /// Royal burgundy — used for headers, CTAs, and emphasis.
  static const Color royalBurgundy = Color(0xFF76052E);

  /// Antique gold — used for accents, borders, and decorative elements.
  static const Color antiqueGold = Color(0xFFC9A94E);

  // ── Secondary Colors ───────────────────────────────────────
  /// Ivory — light background for cards and surfaces.
  static const Color ivory = Color(0xFFFFFFF0);

  /// Cream — secondary background, subtle contrast with ivory.
  static const Color cream = Color(0xFFFFFDD0);

  /// Warm beige — input fields and muted surface areas.
  static const Color warmBeige = Color(0xFFF5E6CC);

  // ── Accent Colors ──────────────────────────────────────────
  /// Saffron orange — attention-drawing accents, notifications.
  static const Color saffronOrange = Color(0xFFF5A623);

  /// Soft peach — gentle background tints and highlights.
  static const Color softPeach = Color(0xFFFDEBD0);

  // ── Semantic Colors ────────────────────────────────────────
  /// Success green — confirmations and positive states.
  static const Color success = Color(0xFF2E7D32);

  /// Error red — validation errors and destructive actions.
  static const Color error = Color(0xFFC62828);

  /// Warning amber — cautionary alerts.
  static const Color warning = Color(0xFFF9A825);

  /// Info blue — informational messages and links.
  static const Color info = Color(0xFF1565C0);

  // ── Surface Colors (Light Theme) ───────────────────────────
  /// Primary surface for cards, dialogs, and sheets.
  static const Color surfaceLight = Color(0xFFFFFBF5);

  /// Elevated surface — slightly warmer for raised elements.
  static const Color surfaceElevatedLight = Colors.white;

  /// Card surface with subtle warmth.
  static const Color cardLight = Color(0xFFFFF8F0);

  // ── Surface Colors (Dark Theme) ────────────────────────────
  /// Primary surface in dark mode.
  static const Color surfaceDark = Color(0xFF1E1E1E);

  /// Elevated surface in dark mode.
  static const Color surfaceElevatedDark = Color(0xFF2C2C2C);

  /// Card surface in dark mode.
  static const Color cardDark = Color(0xFF252525);

  // ── Background Colors ──────────────────────────────────────
  /// Light theme scaffold background.
  static const Color backgroundLight = Color(0xFFFFF9F0);

  /// Dark theme scaffold background.
  static const Color backgroundDark = Color(0xFF121212);

  // ── Text Colors (Light Theme) ──────────────────────────────
  /// Primary text — headings, body copy.
  static const Color textPrimaryLight = Color(0xFF1A1A1A);

  /// Secondary text — subtitles, descriptions.
  static const Color textSecondaryLight = Color(0xFF5A5A5A);

  /// Tertiary text — hints, placeholders.
  static const Color textTertiaryLight = Color(0xFF9E9E9E);

  /// Disabled text.
  static const Color textDisabledLight = Color(0xFFBDBDBD);

  // ── Text Colors (Dark Theme) ───────────────────────────────
  /// Primary text in dark mode.
  static const Color textPrimaryDark = Color(0xFFF5F5F5);

  /// Secondary text in dark mode.
  static const Color textSecondaryDark = Color(0xFFB0B0B0);

  /// Tertiary text in dark mode.
  static const Color textTertiaryDark = Color(0xFF757575);

  /// Disabled text in dark mode.
  static const Color textDisabledDark = Color(0xFF616161);

  // ── Gradient Presets ───────────────────────────────────────
  /// Premium maroon-to-burgundy gradient for headers and buttons.
  static const LinearGradient primaryGradient = LinearGradient(
    colors: [deepMaroon, royalBurgundy],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Gold shimmer gradient for decorative accents.
  static const LinearGradient goldGradient = LinearGradient(
    colors: [Color(0xFFD4AF37), antiqueGold, Color(0xFFE8D48B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  /// Saffron gradient for call-to-action highlights.
  static const LinearGradient saffronGradient = LinearGradient(
    colors: [saffronOrange, Color(0xFFF7C26B)],
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  );

  // ── Divider & Border ───────────────────────────────────────
  /// Divider color for light theme.
  static const Color dividerLight = Color(0xFFE0D6C8);

  /// Divider color for dark theme.
  static const Color dividerDark = Color(0xFF3A3A3A);

  /// Border color for input fields in light theme.
  static const Color borderLight = Color(0xFFD6CBBA);

  /// Border color for input fields in dark theme.
  static const Color borderDark = Color(0xFF4A4A4A);

  // ── Shadow ─────────────────────────────────────────────────
  /// Shadow color (used at low opacity).
  static const Color shadow = Color(0x1A000000);

  /// Dark shadow for elevated elements.
  static const Color shadowDark = Color(0x33000000);
}
