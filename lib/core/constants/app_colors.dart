import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  // ── Scaffold / Background ────────────────────────────────────────────────
  static const Color scaffold = Colors.white;
  static const Color cardBackground = Color(0xFFFFFFFF); // pure white
  static const Color surfaceLight = Color(0xFFF0EAE3); // slightly deeper cream
  static const Color surfaceMedium = Color(0xFFE8E0D8); // medium cream

  // ── Primary Accent ───────────────────────────────────────────────────────
  static const Color primary = Color(0xFFE8385A);
  static const Color primaryDark = Color(0xFFBF2A46);
  static const Color primaryGlow = Color(0x44E8385A);
  static const Color primaryLight = Color(0xFFFDE8EC); // very light rose tint

  // ── Text (dark, for light theme) ─────────────────────────────────────────
  static const Color textPrimary = Color(0xFF1C1C1E);
  static const Color textSecondary = Color(0xFF6B6B6B);
  static const Color textMuted = Color(0xFFAAAAAA);
  static const Color textOnDark = Color(0xFFFFFFFF); // white text on dark card

  // ── Navigation ───────────────────────────────────────────────────────────
  static const Color navActive = Color(0xFFE8385A);
  static const Color navInactive = Color(0xFFBBBBBB);
  static const Color navBackground = Color(0xFFFFFFFF);

  // ── Badges ───────────────────────────────────────────────────────────────
  static const Color matchBlue = Color(0xFF4A9EFF);
  static const Color trustGreen = Color(0xFF2DD87F);
  static const Color replyOrange = Color(0xFFFF8C42);

  // ── Status ───────────────────────────────────────────────────────────────
  static const Color onlineGreen = Color(0xFF2DD87F);
  static const Color unreadDot = Color(0xFFE8385A);

  // ── Divider ──────────────────────────────────────────────────────────────
  static const Color divider = Color(0xFFECE6DE);

  // ── Card (swipe card stays dark) ─────────────────────────────────────────
  static const Color swipeCardDark = Color(0xFF111111);

  // ── Card scrim ───────────────────────────────────────────────────────────
  static const Color cardScrimBottom = Color(0xE5000000);

  // ── Chat bubbles ─────────────────────────────────────────────────────────
  static const Color bubbleSent = Color(0xFFE8385A);
  static const Color bubbleReceived = Color(0xFFF0EAE3);

  // ── Input ────────────────────────────────────────────────────────────────
  static const Color inputFill = Color(0xFFF5EFE8);
  static const Color inputBorder = Color(0xFFDDD7CF);

  // ── Section ──────────────────────────────────────────────────────────────
  static const Color sectionLabel = Color(0xFFE8385A);
  static const Color sectionCard = Color(0xFFFFFFFF);

  // ── Dating goal card ─────────────────────────────────────────────────────
  static const Color goalCard = Color(0xFFE8385A);
}
