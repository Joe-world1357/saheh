import 'package:flutter/material.dart';
import 'app_colors.dart';

/// Theme utilities and helpers
class AppTheme {
  /// Get blue gradient colors based on context
  static List<Color> getBlueGradient(BuildContext context) {
    return [
      AppColors.primary,
      AppColors.primaryLight,
    ];
  }
  
  /// Get primary gradient
  static List<Color> getPrimaryGradient() {
    return [
      AppColors.primary,
      AppColors.primaryDark,
    ];
  }
  
  /// Get success gradient
  static List<Color> getSuccessGradient() {
    return [
      AppColors.success,
      AppColors.success.withOpacity(0.7),
    ];
  }
  
  /// Get macro colors
  static Color getProteinColor(BuildContext context) => AppColors.protein;
  static Color getCarbsColor(BuildContext context) => AppColors.carbs;
  static Color getFatsColor(BuildContext context) => AppColors.fats;
  static Color getCaloriesColor(BuildContext context) => AppColors.calories;
  
  /// Get surface colors
  static Color getSurface2(BuildContext context) => AppColors.surfaceElevated;
}

