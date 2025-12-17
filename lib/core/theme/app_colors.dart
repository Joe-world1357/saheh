import 'package:flutter/material.dart';

/// ============================================================================
/// SEHATI HEALTH APP - UNIFIED COLOR SYSTEM
/// ============================================================================
/// 
/// ⚠️ CRITICAL: ALL colors in the app MUST reference this file
/// ❌ NO hardcoded Color() values allowed anywhere in widgets
/// 
/// 🔒 LIGHT THEME: Original palette PRESERVED exactly
/// 🌙 DARK THEME: Modern OLED-friendly design
/// ============================================================================
class AppColors {
  AppColors._();

  // ============================================================================
  // 🎨 PRIMARY BRAND COLORS (LIGHT - PRESERVED)
  // ============================================================================
  
  /// Primary brand color - Teal/Cyan
  static const Color primary = Color(0xFF20C6B7);
  
  /// Primary darker variant
  static const Color primaryDark = Color(0xFF17A89A);
  
  /// Primary lighter variant
  static const Color primaryLight = Color(0xFF4DD0E1);
  
  // ============================================================================
  // 🎨 PRIMARY BRAND COLORS (DARK - NEW)
  // ============================================================================
  
  /// Primary for dark mode - brighter for contrast
  static const Color primaryDarkMode = Color(0xFF4DD0E1);
  
  /// Primary variant for dark mode
  static const Color primaryVariantDarkMode = Color(0xFF26C6DA);

  // ============================================================================
  // 🎨 SECONDARY & TERTIARY (LIGHT - PRESERVED)
  // ============================================================================
  
  static const Color secondary = Color(0xFF03DAC6);
  static const Color tertiary = Color(0xFF7C4DFF);
  
  // ============================================================================
  // 🎨 SECONDARY & TERTIARY (DARK - NEW)
  // ============================================================================
  
  static const Color secondaryDark = Color(0xFF03DAC6);
  static const Color tertiaryDark = Color(0xFFB388FF);

  // ============================================================================
  // 🏠 BACKGROUND & SURFACE (LIGHT - PRESERVED)
  // ============================================================================
  
  /// Main app background
  static const Color background = Color(0xFFF5FAFA);
  
  /// Card/Container surface
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Elevated surface (modals, FABs)
  static const Color surfaceElevated = Color(0xFFF8F9FA);
  
  /// Surface variant (inputs, chips)
  static const Color surfaceVariant = Color(0xFFECF0F1);

  // ============================================================================
  // 🏠 BACKGROUND & SURFACE (DARK - OLED FRIENDLY)
  // ============================================================================
  
  /// OLED-friendly true dark background
  static const Color backgroundDark = Color(0xFF0D1117);
  
  /// Card surface (1dp elevation)
  static const Color surfaceDark = Color(0xFF161B22);
  
  /// Elevated surface (6-8dp)
  static const Color surfaceElevatedDark = Color(0xFF21262D);
  
  /// Surface variant (3-4dp)
  static const Color surfaceVariantDark = Color(0xFF30363D);
  
  /// App bar (2dp)
  static const Color appBarDark = Color(0xFF161B22);
  
  /// Card alias
  static const Color cardDark = Color(0xFF161B22);

  // ============================================================================
  // ✏️ TEXT COLORS (LIGHT - PRESERVED)
  // ============================================================================
  
  /// Primary text (87% opacity equivalent)
  static const Color textPrimary = Color(0xFF1A2A2C);
  
  /// Secondary text (60%)
  static const Color textSecondary = Color(0xFF58666E);
  
  /// Tertiary/hint text (38%)
  static const Color textTertiary = Color(0xFF8B949E);
  
  /// Disabled text
  static const Color textDisabled = Color(0xFFBDBDBD);
  
  /// White text for dark backgrounds
  static const Color textWhite = Color(0xFFFFFFFF);
  
  /// Text on primary color
  static const Color onPrimary = Color(0xFFFFFFFF);

  // ============================================================================
  // ✏️ TEXT COLORS (DARK - HIGH CONTRAST)
  // ============================================================================
  
  /// Primary text (87%)
  static const Color textPrimaryDark = Color(0xFFE6EDF3);
  
  /// Secondary text (60%)
  static const Color textSecondaryDark = Color(0xFF8B949E);
  
  /// Tertiary/hint text (38%)
  static const Color textTertiaryDark = Color(0xFF6E7681);
  
  /// Disabled text
  static const Color textDisabledDark = Color(0xFF484F58);
  
  /// Text on primary (dark)
  static const Color onPrimaryDark = Color(0xFF0D1117);

  // ============================================================================
  // 📏 BORDER & DIVIDER (LIGHT - PRESERVED)
  // ============================================================================
  
  static const Color border = Color(0xFFD0D7DE);
  static const Color divider = Color(0xFFE8EAED);
  static const Color outline = Color(0xFFB0BEC5);

  // ============================================================================
  // 📏 BORDER & DIVIDER (DARK)
  // ============================================================================
  
  static const Color borderDark = Color(0xFF30363D);
  static const Color dividerDark = Color(0xFF21262D);
  static const Color outlineDark = Color(0xFF424A53);

  // ============================================================================
  // ✅ STATUS COLORS (LIGHT - PRESERVED)
  // ============================================================================
  
  static const Color success = Color(0xFF2DA44E);
  static const Color successBackground = Color(0xFFDFF7E7);
  
  static const Color warning = Color(0xFFBF8700);
  static const Color warningBackground = Color(0xFFFFF4DB);
  
  static const Color error = Color(0xFFCF222E);
  static const Color errorBackground = Color(0xFFFFEBEC);
  
  static const Color info = Color(0xFF0969DA);
  static const Color infoBackground = Color(0xFFDDF4FF);

  // ============================================================================
  // ✅ STATUS COLORS (DARK)
  // ============================================================================
  
  static const Color successDark = Color(0xFF3FB950);
  static const Color successBackgroundDark = Color(0xFF0D2818);
  
  static const Color warningDark = Color(0xFFD29922);
  static const Color warningBackgroundDark = Color(0xFF2D2106);
  
  static const Color errorDark = Color(0xFFFF7B72);
  static const Color errorBackgroundDark = Color(0xFF2D0B0E);
  
  static const Color infoDark = Color(0xFF58A6FF);
  static const Color infoBackgroundDark = Color(0xFF0C1929);

  // ============================================================================
  // 🥗 NUTRITION COLORS (LIGHT - PRESERVED)
  // ============================================================================
  
  static const Color protein = Color(0xFF2DA44E);
  static const Color carbs = Color(0xFFBF8700);
  static const Color fats = Color(0xFF8250DF);
  static const Color calories = Color(0xFFCF222E);
  static const Color fiber = Color(0xFF0969DA);

  // ============================================================================
  // 🥗 NUTRITION COLORS (DARK)
  // ============================================================================
  
  static const Color proteinDark = Color(0xFF3FB950);
  static const Color carbsDark = Color(0xFFD29922);
  static const Color fatsDark = Color(0xFFA371F7);
  static const Color caloriesDark = Color(0xFFFF7B72);
  static const Color fiberDark = Color(0xFF58A6FF);

  // ============================================================================
  // 💊 PHARMACY COLORS (LIGHT - PRESERVED)
  // ============================================================================
  
  static const Color pharmacyPrimary = Color(0xFF20C6B7);
  static const Color pharmacyAccent = Color(0xFFFF6B6B);
  static const Color pharmacyBackground = Color(0xFFF5FAFA);

  // ============================================================================
  // 💊 PHARMACY COLORS (DARK)
  // ============================================================================
  
  static const Color pharmacyPrimaryDark = Color(0xFF4DD0E1);
  static const Color pharmacyAccentDark = Color(0xFFFF8A80);
  static const Color pharmacyBackgroundDark = Color(0xFF0D1117);

  // ============================================================================
  // 🌫️ OVERLAY & SHADOW
  // ============================================================================
  
  static const Color scrim = Color(0x52000000);
  static const Color scrimDark = Color(0x80000000);
  static const Color shadow = Color(0x1A000000);
  static const Color shadowDark = Color(0x40000000);
  static const Color barrier = Color(0x80000000);

  // ============================================================================
  // 🔧 HELPER METHODS - THEME-AWARE GETTERS
  // ============================================================================
  
  // Primary
  static Color getPrimary(Brightness b) => b == Brightness.dark ? primaryDarkMode : primary;
  static Color getOnPrimary(Brightness b) => b == Brightness.dark ? onPrimaryDark : onPrimary;
  static Color getSecondary(Brightness b) => b == Brightness.dark ? secondaryDark : secondary;
  static Color getTertiary(Brightness b) => b == Brightness.dark ? tertiaryDark : tertiary;
  
  // Background & Surface
  static Color getBackground(Brightness b) => b == Brightness.dark ? backgroundDark : background;
  static Color getSurface(Brightness b) => b == Brightness.dark ? surfaceDark : surface;
  static Color getSurfaceElevated(Brightness b) => b == Brightness.dark ? surfaceElevatedDark : surfaceElevated;
  static Color getSurfaceVariant(Brightness b) => b == Brightness.dark ? surfaceVariantDark : surfaceVariant;
  static Color getCard(Brightness b) => b == Brightness.dark ? cardDark : surface;
  static Color getAppBar(Brightness b) => b == Brightness.dark ? appBarDark : background;
  
  // Text
  static Color getTextPrimary(Brightness b) => b == Brightness.dark ? textPrimaryDark : textPrimary;
  static Color getTextSecondary(Brightness b) => b == Brightness.dark ? textSecondaryDark : textSecondary;
  static Color getTextTertiary(Brightness b) => b == Brightness.dark ? textTertiaryDark : textTertiary;
  static Color getTextDisabled(Brightness b) => b == Brightness.dark ? textDisabledDark : textDisabled;
  static Color getOnSurface(Brightness b) => getTextPrimary(b);
  
  // Border & Divider
  static Color getBorder(Brightness b) => b == Brightness.dark ? borderDark : border;
  static Color getDivider(Brightness b) => b == Brightness.dark ? dividerDark : divider;
  static Color getOutline(Brightness b) => b == Brightness.dark ? outlineDark : outline;
  
  // Status
  static Color getSuccess(Brightness b) => b == Brightness.dark ? successDark : success;
  static Color getSuccessBackground(Brightness b) => b == Brightness.dark ? successBackgroundDark : successBackground;
  static Color getWarning(Brightness b) => b == Brightness.dark ? warningDark : warning;
  static Color getWarningBackground(Brightness b) => b == Brightness.dark ? warningBackgroundDark : warningBackground;
  static Color getError(Brightness b) => b == Brightness.dark ? errorDark : error;
  static Color getErrorBackground(Brightness b) => b == Brightness.dark ? errorBackgroundDark : errorBackground;
  static Color getInfo(Brightness b) => b == Brightness.dark ? infoDark : info;
  static Color getInfoBackground(Brightness b) => b == Brightness.dark ? infoBackgroundDark : infoBackground;
  
  // Nutrition
  static Color getProtein(Brightness b) => b == Brightness.dark ? proteinDark : protein;
  static Color getCarbs(Brightness b) => b == Brightness.dark ? carbsDark : carbs;
  static Color getFats(Brightness b) => b == Brightness.dark ? fatsDark : fats;
  static Color getCalories(Brightness b) => b == Brightness.dark ? caloriesDark : calories;
  static Color getFiber(Brightness b) => b == Brightness.dark ? fiberDark : fiber;
  
  // Pharmacy
  static Color getPharmacyPrimary(Brightness b) => b == Brightness.dark ? pharmacyPrimaryDark : pharmacyPrimary;
  static Color getPharmacyAccent(Brightness b) => b == Brightness.dark ? pharmacyAccentDark : pharmacyAccent;
  
  // Overlay
  static Color getScrim(Brightness b) => b == Brightness.dark ? scrimDark : scrim;
  static Color getShadow(Brightness b) => b == Brightness.dark ? shadowDark : shadow;
  
  // Opacity helpers
  static Color primaryWithOpacity(double o) => primary.withOpacity(o);
  static Color withOpacity(Color c, double o) => c.withOpacity(o);
}
