import 'package:flutter/material.dart';
import 'app_colors.dart';
<<<<<<< HEAD

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
=======
import 'app_text_styles.dart';

/// Complete theme configuration for Sehati Health App
/// Following Material Design 3 and darkmode.md specification
class AppTheme {
  // ============================================================================
  // LIGHT THEME
  // ============================================================================
  
  static ThemeData get lightTheme {
    final colorScheme = ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      brightness: Brightness.light,
      primary: AppColors.primary,
      onPrimary: Colors.white,
      secondary: AppColors.primaryLight,
      onSecondary: Colors.white,
      surface: AppColors.surface,
      onSurface: AppColors.textPrimary,
      surfaceVariant: AppColors.surfaceElevated,
      onSurfaceVariant: AppColors.textSecondary,
      background: AppColors.background,
      onBackground: AppColors.textPrimary,
      error: AppColors.error,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.light,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.background,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        elevation: 0,
        centerTitle: false,
        titleTextStyle: AppTextStyles.heading3(Brightness.light),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimary,
          size: 24,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surface,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 2,
          shadowColor: AppColors.primary.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: AppTextStyles.buttonLarge(Brightness.light),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.primary, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          textStyle: AppTextStyles.buttonMedium(Brightness.light),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.buttonMedium(Brightness.light),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surface,
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.border, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        labelStyle: AppTextStyles.label(Brightness.light),
        hintStyle: AppTextStyles.bodyMedium(Brightness.light).copyWith(
          color: AppColors.textTertiary,
        ),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: 1,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textSecondary,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceElevated,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.surfaceElevated,
        labelStyle: AppTextStyles.bodyMedium(Brightness.light),
        secondaryLabelStyle: AppTextStyles.bodyMedium(Brightness.light).copyWith(
          color: Colors.white,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.border, width: 1),
        ),
      ),
      
      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        titleTextStyle: AppTextStyles.heading3(Brightness.light),
        contentTextStyle: AppTextStyles.bodyMedium(Brightness.light),
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        modalBackgroundColor: Colors.black.withValues(alpha: 0.5),
      ),
      
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return AppColors.textTertiary;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary.withValues(alpha: 0.5);
          }
          return AppColors.surfaceElevated;
        }),
      ),
      
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primary;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(Colors.white),
        side: const BorderSide(color: AppColors.border, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceElevated,
        circularTrackColor: AppColors.surfaceElevated,
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1(Brightness.light),
        displayMedium: AppTextStyles.heading2(Brightness.light),
        displaySmall: AppTextStyles.heading3(Brightness.light),
        headlineMedium: AppTextStyles.heading4(Brightness.light),
        titleLarge: AppTextStyles.heading3(Brightness.light),
        titleMedium: AppTextStyles.heading4(Brightness.light),
        bodyLarge: AppTextStyles.bodyLarge(Brightness.light),
        bodyMedium: AppTextStyles.bodyMedium(Brightness.light),
        bodySmall: AppTextStyles.bodySmall(Brightness.light),
        labelLarge: AppTextStyles.label(Brightness.light),
        labelMedium: AppTextStyles.labelSmall(Brightness.light),
        labelSmall: AppTextStyles.caption(Brightness.light),
      ),
    );
  }

  // ============================================================================
  // DARK THEME
  // ============================================================================
  // Following darkmode.md specification
  
  static ThemeData get darkTheme {
    final colorScheme = ColorScheme.dark(
      primary: AppColors.primaryDarkMode,
      onPrimary: AppColors.backgroundDark,
      secondary: AppColors.primaryVariantDarkMode,
      onSecondary: AppColors.backgroundDark,
      surface: AppColors.surfaceDark,
      onSurface: AppColors.textPrimaryDark,
      surfaceVariant: AppColors.surfaceVariantDark,
      onSurfaceVariant: AppColors.textSecondaryDark,
      background: AppColors.backgroundDark,
      onBackground: AppColors.textPrimaryDark,
      error: AppColors.errorDark,
      onError: Colors.white,
    );

    return ThemeData(
      useMaterial3: true,
      brightness: Brightness.dark,
      colorScheme: colorScheme,
      scaffoldBackgroundColor: AppColors.backgroundDark,
      
      // App Bar Theme
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.appBarDark, // 2dp elevation
        foregroundColor: AppColors.textPrimaryDark,
        elevation: 2,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        centerTitle: false,
        titleTextStyle: AppTextStyles.heading3(Brightness.dark),
        iconTheme: const IconThemeData(
          color: AppColors.textPrimaryDark,
          size: 24,
        ),
      ),
      
      // Card Theme
      cardTheme: CardThemeData(
        color: AppColors.surfaceDark,
        elevation: 0,
        shadowColor: Colors.black.withValues(alpha: 0.3),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      ),
      
      // Button Themes
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDarkMode,
          foregroundColor: AppColors.backgroundDark,
          elevation: 4,
          shadowColor: AppColors.primaryDarkMode.withValues(alpha: 0.3),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
          textStyle: AppTextStyles.buttonLarge(Brightness.dark),
        ),
      ),
      
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDarkMode,
          side: const BorderSide(color: AppColors.primaryDarkMode, width: 2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 14),
          textStyle: AppTextStyles.buttonMedium(Brightness.dark),
        ),
      ),
      
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryDarkMode,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(32),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
          textStyle: AppTextStyles.buttonMedium(Brightness.dark),
        ),
      ),
      
      // Input Decoration Theme
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantDark, // 3dp-4dp elevation
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.primaryDarkMode, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 1),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 2),
        ),
        labelStyle: AppTextStyles.label(Brightness.dark),
        hintStyle: AppTextStyles.bodyMedium(Brightness.dark).copyWith(
          color: AppColors.textTertiaryDark,
        ),
      ),
      
      // Divider Theme
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: 1,
      ),
      
      // Bottom Navigation Bar Theme
      bottomNavigationBarTheme: const BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark, // 1dp elevation
        selectedItemColor: AppColors.primaryDarkMode,
        unselectedItemColor: AppColors.textTertiaryDark,
        elevation: 8,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
        unselectedLabelStyle: TextStyle(
          fontSize: 12,
          fontWeight: FontWeight.normal,
        ),
      ),
      
      // Chip Theme
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceElevatedDark,
        selectedColor: AppColors.primaryDarkMode,
        disabledColor: AppColors.surfaceDark,
        labelStyle: AppTextStyles.bodyMedium(Brightness.dark),
        secondaryLabelStyle: AppTextStyles.bodyMedium(Brightness.dark).copyWith(
          color: AppColors.backgroundDark,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: const BorderSide(color: AppColors.borderDark, width: 1),
        ),
      ),
      
      // Dialog Theme
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceElevatedDark, // 6dp elevation
        elevation: 8,
        shadowColor: Colors.black.withValues(alpha: 0.5),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
        ),
        titleTextStyle: AppTextStyles.heading3(Brightness.dark),
        contentTextStyle: AppTextStyles.bodyMedium(Brightness.dark),
      ),
      
      // Bottom Sheet Theme
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceElevatedDark,
        elevation: 8,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
        ),
        modalBackgroundColor: Colors.black.withValues(alpha: 0.6),
      ),
      
      // Switch Theme
      switchTheme: SwitchThemeData(
        thumbColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryDarkMode;
          }
          return AppColors.textTertiaryDark;
        }),
        trackColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryDarkMode.withValues(alpha: 0.5);
          }
          return AppColors.surfaceVariantDark;
        }),
      ),
      
      // Checkbox Theme
      checkboxTheme: CheckboxThemeData(
        fillColor: MaterialStateProperty.resolveWith((states) {
          if (states.contains(MaterialState.selected)) {
            return AppColors.primaryDarkMode;
          }
          return Colors.transparent;
        }),
        checkColor: MaterialStateProperty.all(AppColors.backgroundDark),
        side: const BorderSide(color: AppColors.borderDark, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Progress Indicator Theme
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryDarkMode,
        linearTrackColor: AppColors.surfaceElevatedDark,
        circularTrackColor: AppColors.surfaceElevatedDark,
      ),
      
      // Text Theme
      textTheme: TextTheme(
        displayLarge: AppTextStyles.heading1(Brightness.dark),
        displayMedium: AppTextStyles.heading2(Brightness.dark),
        displaySmall: AppTextStyles.heading3(Brightness.dark),
        headlineMedium: AppTextStyles.heading4(Brightness.dark),
        titleLarge: AppTextStyles.heading3(Brightness.dark),
        titleMedium: AppTextStyles.heading4(Brightness.dark),
        bodyLarge: AppTextStyles.bodyLarge(Brightness.dark),
        bodyMedium: AppTextStyles.bodyMedium(Brightness.dark),
        bodySmall: AppTextStyles.bodySmall(Brightness.dark),
        labelLarge: AppTextStyles.label(Brightness.dark),
        labelMedium: AppTextStyles.labelSmall(Brightness.dark),
        labelSmall: AppTextStyles.caption(Brightness.dark),
      ),
    );
  }

  // ============================================================================
  // GRADIENT HELPERS
  // ============================================================================
  
  /// Get primary gradient (Light Mode)
>>>>>>> 11527b2 (Initial commit)
  static List<Color> getPrimaryGradient() {
    return [
      AppColors.primary,
      AppColors.primaryDark,
    ];
  }
  
<<<<<<< HEAD
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

=======
  /// Get primary gradient (Dark Mode) - Following darkmode.md spec
  static List<Color> getPrimaryGradientDark() {
    return [
      AppColors.primaryVariantDarkMode, // #26C6DA
      const Color(0xFF00ACC1), // Darker primary
    ];
  }
  
  /// Get primary gradient based on brightness
  static List<Color> getPrimaryGradientForBrightness(Brightness brightness) {
    return brightness == Brightness.dark
        ? getPrimaryGradientDark()
        : getPrimaryGradient();
  }
  
  /// Get card gradient (Dark Mode) - Following darkmode.md spec
  static List<Color> getCardGradientDark() {
    return [
      AppColors.surfaceDark, // #1E1E1E
      AppColors.surfaceElevatedDark, // #2D2D2D
    ];
  }
  
  /// Get success gradient (Light Mode)
  static List<Color> getSuccessGradient() {
    return [
      AppColors.success,
      AppColors.success.withValues(alpha: 0.7),
    ];
  }
  
  /// Get success gradient (Dark Mode) - Following darkmode.md spec
  static List<Color> getSuccessGradientDark() {
    return [
      AppColors.successDark, // #66BB6A
      AppColors.success, // #4CAF50
    ];
  }
  
  /// Get macro colors based on brightness
  static Color getProteinColor(Brightness brightness) {
    return brightness == Brightness.dark ? AppColors.proteinDark : AppColors.protein;
  }
  
  static Color getCarbsColor(Brightness brightness) {
    return brightness == Brightness.dark ? AppColors.carbsDark : AppColors.carbs;
  }
  
  static Color getFatsColor(Brightness brightness) {
    return brightness == Brightness.dark ? AppColors.fatsDark : AppColors.fats;
  }
  
  static Color getCaloriesColor(Brightness brightness) {
    return brightness == Brightness.dark ? AppColors.caloriesDark : AppColors.calories;
  }
}
>>>>>>> 11527b2 (Initial commit)
