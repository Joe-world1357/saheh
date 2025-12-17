import 'package:flutter/material.dart';
import 'app_colors.dart';

/// ============================================================================
/// SEHATI HEALTH APP - TYPOGRAPHY SYSTEM
/// ============================================================================
/// 
/// Material Design 3 compliant typography with:
/// - Full type scale (Display → Overline)
/// - Tabular figures for metrics (XP, calories, steps)
/// - Theme-aware color helpers
/// 
/// ⚠️ ALL text styles MUST reference this file
/// ❌ NO inline TextStyle() allowed
/// ============================================================================
class AppTextStyles {
  AppTextStyles._();

  // ============================================================================
  // 🔤 BASE FONT
  // ============================================================================
  
  static const String _fontFamily = 'Poppins';

  // ============================================================================
  // 📐 DISPLAY STYLES (Hero sections, large headers)
  // ============================================================================
  
  static TextStyle displayLarge(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 57,
    fontWeight: FontWeight.w400,
    letterSpacing: -0.25,
    height: 1.12,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle displayMedium(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 45,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.16,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle displaySmall(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 36,
    fontWeight: FontWeight.w400,
    letterSpacing: 0,
    height: 1.22,
    color: AppColors.getTextPrimary(b),
  );

  // ============================================================================
  // 📐 HEADLINE STYLES (Section headers)
  // ============================================================================
  
  static TextStyle headlineLarge(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.25,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle headlineMedium(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 28,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.29,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle headlineSmall(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.33,
    color: AppColors.getTextPrimary(b),
  );

  // ============================================================================
  // 📐 TITLE STYLES (Card titles, list headers)
  // ============================================================================
  
  static TextStyle titleLarge(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 22,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.27,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle titleMedium(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.15,
    height: 1.5,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle titleSmall(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w600,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.getTextPrimary(b),
  );

  // ============================================================================
  // 📐 BODY STYLES (Paragraphs, descriptions)
  // ============================================================================
  
  static TextStyle bodyLarge(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 16,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.5,
    height: 1.5,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle bodyMedium(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.25,
    height: 1.43,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle bodySmall(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: AppColors.getTextSecondary(b),
  );

  // ============================================================================
  // 📐 LABEL STYLES (Buttons, chips, form labels)
  // ============================================================================
  
  static TextStyle labelLarge(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 14,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.1,
    height: 1.43,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle labelMedium(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.33,
    color: AppColors.getTextPrimary(b),
  );
  
  static TextStyle labelSmall(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 11,
    fontWeight: FontWeight.w500,
    letterSpacing: 0.5,
    height: 1.45,
    color: AppColors.getTextSecondary(b),
  );

  // ============================================================================
  // 📐 OVERLINE & CAPTION
  // ============================================================================
  
  static TextStyle overline(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 10,
    fontWeight: FontWeight.w500,
    letterSpacing: 1.5,
    height: 1.6,
    color: AppColors.getTextTertiary(b),
  );
  
  static TextStyle caption(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 12,
    fontWeight: FontWeight.w400,
    letterSpacing: 0.4,
    height: 1.33,
    color: AppColors.getTextTertiary(b),
  );

  // ============================================================================
  // 🔢 METRIC STYLES (XP, Calories, Steps, Stats)
  // ============================================================================
  
  /// Large metric numbers (main stats display)
  static TextStyle metricLarge(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 48,
    fontWeight: FontWeight.w700,
    letterSpacing: -1,
    height: 1.1,
    color: AppColors.getTextPrimary(b),
    fontFeatures: const [FontFeature.tabularFigures()],
  );
  
  /// Medium metric numbers (card stats)
  static TextStyle metricMedium(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 32,
    fontWeight: FontWeight.w700,
    letterSpacing: -0.5,
    height: 1.15,
    color: AppColors.getTextPrimary(b),
    fontFeatures: const [FontFeature.tabularFigures()],
  );
  
  /// Small metric numbers (inline stats)
  static TextStyle metricSmall(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.2,
    color: AppColors.getTextPrimary(b),
    fontFeatures: const [FontFeature.tabularFigures()],
  );
  
  /// XP display style
  static TextStyle xp(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 24,
    fontWeight: FontWeight.w700,
    letterSpacing: 0,
    height: 1.2,
    color: AppColors.getPrimary(b),
    fontFeatures: const [FontFeature.tabularFigures()],
  );
  
  /// Calories display style
  static TextStyle calories(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.2,
    color: AppColors.getCalories(b),
    fontFeatures: const [FontFeature.tabularFigures()],
  );
  
  /// Steps display style
  static TextStyle steps(Brightness b) => TextStyle(
    fontFamily: _fontFamily,
    fontSize: 20,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    height: 1.2,
    color: AppColors.getPrimary(b),
    fontFeatures: const [FontFeature.tabularFigures()],
  );

  // ============================================================================
  // 🔧 HELPER METHODS
  // ============================================================================
  
  /// Apply custom color to any style
  static TextStyle withColor(TextStyle style, Color color) {
    return style.copyWith(color: color);
  }
  
  /// Apply primary color
  static TextStyle withPrimary(TextStyle style, Brightness b) {
    return style.copyWith(color: AppColors.getPrimary(b));
  }
  
  /// Apply error color
  static TextStyle withError(TextStyle style, Brightness b) {
    return style.copyWith(color: AppColors.getError(b));
  }
  
  /// Apply success color
  static TextStyle withSuccess(TextStyle style, Brightness b) {
    return style.copyWith(color: AppColors.getSuccess(b));
  }
  
  /// Apply secondary text color
  static TextStyle withSecondary(TextStyle style, Brightness b) {
    return style.copyWith(color: AppColors.getTextSecondary(b));
  }
  
  /// Make bold
  static TextStyle bold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w700);
  }
  
  /// Make semi-bold
  static TextStyle semiBold(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w600);
  }
  
  /// Make medium weight
  static TextStyle medium(TextStyle style) {
    return style.copyWith(fontWeight: FontWeight.w500);
  }
}
