import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Centralized text styles for the Sehati Health App
/// All text styles used throughout the app should reference this file
class AppTextStyles {
  // ============================================================================
  // HEADINGS
  // ============================================================================
  
<<<<<<< HEAD
  static const TextStyle heading1 = TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.2,
  );
  
  static const TextStyle heading2 = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle heading3 = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
    height: 1.3,
  );
  
  static const TextStyle heading4 = TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
=======
  static TextStyle heading1(Brightness brightness) => TextStyle(
    fontSize: 32,
    fontWeight: FontWeight.bold,
    color: AppColors.getTextPrimary(brightness),
    height: 1.2,
  );
  
  static TextStyle heading2(Brightness brightness) => TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.getTextPrimary(brightness),
    height: 1.3,
  );
  
  static TextStyle heading3(Brightness brightness) => TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: AppColors.getTextPrimary(brightness),
    height: 1.3,
  );
  
  static TextStyle heading4(Brightness brightness) => TextStyle(
    fontSize: 18,
    fontWeight: FontWeight.bold,
    color: AppColors.getTextPrimary(brightness),
>>>>>>> 11527b2 (Initial commit)
    height: 1.4,
  );

  // ============================================================================
  // BODY TEXT
  // ============================================================================
  
<<<<<<< HEAD
  static const TextStyle bodyLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodyMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.textPrimary,
    height: 1.5,
  );
  
  static const TextStyle bodySmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
=======
  static TextStyle bodyLarge(Brightness brightness) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.normal,
    color: AppColors.getTextPrimary(brightness),
    height: 1.5,
  );
  
  static TextStyle bodyMedium(Brightness brightness) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.normal,
    color: AppColors.getTextPrimary(brightness),
    height: 1.5,
  );
  
  static TextStyle bodySmall(Brightness brightness) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.getTextSecondary(brightness),
>>>>>>> 11527b2 (Initial commit)
    height: 1.4,
  );

  // ============================================================================
  // BUTTON TEXT
  // ============================================================================
  
<<<<<<< HEAD
  static const TextStyle buttonLarge = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle buttonMedium = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
  );
  
  static const TextStyle buttonSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.textPrimary,
=======
  static TextStyle buttonLarge(Brightness brightness) => TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: brightness == Brightness.dark 
        ? AppColors.backgroundDark 
        : AppColors.textWhite,
  );
  
  static TextStyle buttonMedium(Brightness brightness) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w600,
    color: brightness == Brightness.dark 
        ? AppColors.backgroundDark 
        : AppColors.textWhite,
  );
  
  static TextStyle buttonSmall(Brightness brightness) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w600,
    color: AppColors.getPrimary(brightness),
>>>>>>> 11527b2 (Initial commit)
  );

  // ============================================================================
  // CAPTION & LABEL
  // ============================================================================
  
<<<<<<< HEAD
  static const TextStyle caption = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.textSecondary,
    height: 1.3,
  );
  
  static const TextStyle label = TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.textPrimary,
    height: 1.4,
  );
  
  static const TextStyle labelSmall = TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.textSecondary,
    height: 1.3,
  );
}

=======
  static TextStyle caption(Brightness brightness) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.normal,
    color: AppColors.getTextSecondary(brightness),
    height: 1.3,
  );
  
  static TextStyle label(Brightness brightness) => TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w500,
    color: AppColors.getTextPrimary(brightness),
    height: 1.4,
  );
  
  static TextStyle labelSmall(Brightness brightness) => TextStyle(
    fontSize: 12,
    fontWeight: FontWeight.w500,
    color: AppColors.getTextSecondary(brightness),
    height: 1.3,
  );
}
>>>>>>> 11527b2 (Initial commit)
