import 'package:flutter/material.dart';

/// Centralized color definitions for the Sehati Health App
<<<<<<< HEAD
=======
/// Following darkmode.md specification for dark mode
>>>>>>> 11527b2 (Initial commit)
/// All colors used throughout the app should reference this file
class AppColors {
  // ============================================================================
  // PRIMARY COLORS
  // ============================================================================
  
<<<<<<< HEAD
  /// Primary brand color - Teal/Cyan
  static const Color primary = Color(0xFF20C6B7);
  
  /// Primary color variant - darker
  static const Color primaryDark = Color(0xFF17A89A);
  
  /// Primary color variant - lighter
  static const Color primaryLight = Color(0xFF4DD0E1);

  // ============================================================================
  // BACKGROUND COLORS
=======
  /// Primary brand color - Teal/Cyan (Light Mode)
  static const Color primary = Color(0xFF20C6B7);
  
  /// Primary color variant - darker (Light Mode)
  static const Color primaryDark = Color(0xFF17A89A);
  
  /// Primary color variant - lighter (Light Mode)
  static const Color primaryLight = Color(0xFF4DD0E1);
  
  /// Primary color for dark mode - lighter for better contrast
  static const Color primaryDarkMode = Color(0xFF4DD0E1);
  
  /// Primary variant for dark mode
  static const Color primaryVariantDarkMode = Color(0xFF26C6DA);

  // ============================================================================
  // BACKGROUND & SURFACE COLORS (Light Mode)
>>>>>>> 11527b2 (Initial commit)
  // ============================================================================
  
  /// Main app background color
  static const Color background = Color(0xFFF5FAFA);
  
  /// Card/Container background
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Elevated surface for floating elements
  static const Color surfaceElevated = Color(0xFFF8F9FA);

  // ============================================================================
<<<<<<< HEAD
  // TEXT COLORS
=======
  // BACKGROUND & SURFACE COLORS (Dark Mode)
  // ============================================================================
  
  /// Main app background color (Dark) - True dark gray to prevent OLED burn-in
  static const Color backgroundDark = Color(0xFF121212);
  
  /// Card/Container background (Dark) - 1dp elevation
  static const Color surfaceDark = Color(0xFF1E1E1E);
  
  /// Elevated surface for floating elements (Dark) - 6dp-8dp elevation
  static const Color surfaceElevatedDark = Color(0xFF2D2D2D);
  
  /// Surface variant for input fields, chips (Dark) - 3dp-4dp elevation
  static const Color surfaceVariantDark = Color(0xFF383838);
  
  /// App bar background (Dark) - 2dp elevation
  static const Color appBarDark = Color(0xFF232323);

  // ============================================================================
  // TEXT COLORS (Light Mode)
>>>>>>> 11527b2 (Initial commit)
  // ============================================================================
  
  /// Primary text color
  static const Color textPrimary = Color(0xFF1A2A2C);
  
  /// Secondary text color
  static const Color textSecondary = Color(0xFF687779);
  
  /// Tertiary text color for hints
  static const Color textTertiary = Color(0xFF9AA0A6);
  
  /// White text (for dark backgrounds)
  static const Color textWhite = Color(0xFFFFFFFF);

  // ============================================================================
<<<<<<< HEAD
  // BORDER & DIVIDER COLORS
=======
  // TEXT COLORS (Dark Mode)
  // ============================================================================
  
  /// Primary text color (Dark) - 87% opacity
  static const Color textPrimaryDark = Color(0xFFE1E1E1);
  
  /// Secondary text color (Dark) - 60% opacity
  static const Color textSecondaryDark = Color(0xFFB0B0B0);
  
  /// Tertiary text color for hints (Dark) - 38% opacity
  static const Color textTertiaryDark = Color(0xFF757575);

  // ============================================================================
  // BORDER & DIVIDER COLORS (Light Mode)
>>>>>>> 11527b2 (Initial commit)
  // ============================================================================
  
  /// Border color
  static const Color border = Color(0xFFDADCE0);
  
  /// Divider color
  static const Color divider = Color(0xFFE8EAED);
<<<<<<< HEAD
  
  /// Border color for primary elements
  static const Color borderPrimary = Color(0xFF20C6B7);

  // ============================================================================
  // STATUS COLORS
=======

  // ============================================================================
  // BORDER & DIVIDER COLORS (Dark Mode)
  // ============================================================================
  
  /// Border color (Dark)
  static const Color borderDark = Color(0xFF3D3D3D);
  
  /// Divider color (Dark)
  static const Color dividerDark = Color(0xFF2D2D2D);

  // ============================================================================
  // STATUS COLORS (Light Mode)
>>>>>>> 11527b2 (Initial commit)
  // ============================================================================
  
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF2196F3);

  // ============================================================================
<<<<<<< HEAD
  // NUTRITION COLORS
=======
  // STATUS COLORS (Dark Mode)
  // ============================================================================
  
  /// Success color (Dark) - lighter for better visibility
  static const Color successDark = Color(0xFF66BB6A);
  
  /// Warning color (Dark) - lighter for better visibility
  static const Color warningDark = Color(0xFFFFA726);
  
  /// Error color (Dark) - lighter for better visibility
  static const Color errorDark = Color(0xFFE57373);
  
  /// Info color (Dark) - lighter for better visibility
  static const Color infoDark = Color(0xFF42A5F5);

  // ============================================================================
  // NUTRITION COLORS (Light Mode)
>>>>>>> 11527b2 (Initial commit)
  // ============================================================================
  
  static const Color protein = Color(0xFF66BB6A);
  static const Color carbs = Color(0xFFFF9800);
  static const Color fats = Color(0xFFAB47BC);
  static const Color calories = Color(0xFFFFA726);

  // ============================================================================
<<<<<<< HEAD
  // GRAY SCALE
  // ============================================================================
  
  static const Color gray100 = Color(0xFFF5F5F5);
  static const Color gray200 = Color(0xFFEEEEEE);
  static const Color gray300 = Color(0xFFE0E0E0);
  static const Color gray400 = Color(0xFFBDBDBD);
  static const Color gray500 = Color(0xFF9E9E9E);
  static const Color gray600 = Color(0xFF757575);
  static const Color gray700 = Color(0xFF616161);
  static const Color gray800 = Color(0xFF424242);
  static const Color gray900 = Color(0xFF212121);
}

=======
  // NUTRITION COLORS (Dark Mode)
  // ============================================================================
  
  /// Protein color (Dark)
  static const Color proteinDark = Color(0xFF81C784);
  
  /// Carbs color (Dark)
  static const Color carbsDark = Color(0xFFFFB74D);
  
  /// Fats color (Dark)
  static const Color fatsDark = Color(0xFFBA68C8);
  
  /// Calories color (Dark)
  static const Color caloriesDark = Color(0xFFFFCA28);

  // ============================================================================
  // HELPER METHODS - Theme-Aware Color Access
  // ============================================================================
  
  /// Get background color based on brightness
  static Color getBackground(Brightness brightness) {
    return brightness == Brightness.dark ? backgroundDark : background;
  }
  
  /// Get surface color based on brightness
  static Color getSurface(Brightness brightness) {
    return brightness == Brightness.dark ? surfaceDark : surface;
  }
  
  /// Get elevated surface color based on brightness
  static Color getSurfaceElevated(Brightness brightness) {
    return brightness == Brightness.dark ? surfaceElevatedDark : surfaceElevated;
  }
  
  /// Get primary color based on brightness
  static Color getPrimary(Brightness brightness) {
    return brightness == Brightness.dark ? primaryDarkMode : primary;
  }
  
  /// Get primary text color based on brightness
  static Color getTextPrimary(Brightness brightness) {
    return brightness == Brightness.dark ? textPrimaryDark : textPrimary;
  }
  
  /// Get secondary text color based on brightness
  static Color getTextSecondary(Brightness brightness) {
    return brightness == Brightness.dark ? textSecondaryDark : textSecondary;
  }
  
  /// Get border color based on brightness
  static Color getBorder(Brightness brightness) {
    return brightness == Brightness.dark ? borderDark : border;
  }
  
  /// Get divider color based on brightness
  static Color getDivider(Brightness brightness) {
    return brightness == Brightness.dark ? dividerDark : divider;
  }
  
  /// Get success color based on brightness
  static Color getSuccess(Brightness brightness) {
    return brightness == Brightness.dark ? successDark : success;
  }
  
  /// Get warning color based on brightness
  static Color getWarning(Brightness brightness) {
    return brightness == Brightness.dark ? warningDark : warning;
  }
  
  /// Get error color based on brightness
  static Color getError(Brightness brightness) {
    return brightness == Brightness.dark ? errorDark : error;
  }
  
  /// Get info color based on brightness
  static Color getInfo(Brightness brightness) {
    return brightness == Brightness.dark ? infoDark : info;
  }
}
>>>>>>> 11527b2 (Initial commit)
