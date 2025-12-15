import 'package:flutter/material.dart';

/// Centralized color definitions for the Sehati Health App
/// All colors used throughout the app should reference this file
class AppColors {
  // ============================================================================
  // PRIMARY COLORS
  // ============================================================================
  
  /// Primary brand color - Teal/Cyan
  static const Color primary = Color(0xFF20C6B7);
  
  /// Primary color variant - darker
  static const Color primaryDark = Color(0xFF17A89A);
  
  /// Primary color variant - lighter
  static const Color primaryLight = Color(0xFF4DD0E1);

  // ============================================================================
  // BACKGROUND COLORS
  // ============================================================================
  
  /// Main app background color
  static const Color background = Color(0xFFF5FAFA);
  
  /// Card/Container background
  static const Color surface = Color(0xFFFFFFFF);
  
  /// Elevated surface for floating elements
  static const Color surfaceElevated = Color(0xFFF8F9FA);

  // ============================================================================
  // TEXT COLORS
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
  // BORDER & DIVIDER COLORS
  // ============================================================================
  
  /// Border color
  static const Color border = Color(0xFFDADCE0);
  
  /// Divider color
  static const Color divider = Color(0xFFE8EAED);
  
  /// Border color for primary elements
  static const Color borderPrimary = Color(0xFF20C6B7);

  // ============================================================================
  // STATUS COLORS
  // ============================================================================
  
  static const Color success = Color(0xFF4CAF50);
  static const Color warning = Color(0xFFFF9800);
  static const Color error = Color(0xFFEF5350);
  static const Color info = Color(0xFF2196F3);

  // ============================================================================
  // NUTRITION COLORS
  // ============================================================================
  
  static const Color protein = Color(0xFF66BB6A);
  static const Color carbs = Color(0xFFFF9800);
  static const Color fats = Color(0xFFAB47BC);
  static const Color calories = Color(0xFFFFA726);

  // ============================================================================
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

