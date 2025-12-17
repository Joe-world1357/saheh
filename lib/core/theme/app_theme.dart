import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app_colors.dart';
import 'app_text_styles.dart';

/// ============================================================================
/// SEHATI HEALTH APP - UNIFIED THEME SYSTEM
/// ============================================================================
/// 
/// Material Design 3 compliant theme with:
/// - Light theme: ORIGINAL palette preserved exactly
/// - Dark theme: Modern OLED-friendly design
/// - Full component theming
/// - Gradient & shadow helpers
/// 
/// ⚠️ ALL widgets MUST use theme - NO inline styling
/// ============================================================================
class AppTheme {
  AppTheme._();

  // ============================================================================
  // 📐 DESIGN TOKENS - CONSISTENT ACROSS APP
  // ============================================================================
  
  /// Buttons & inputs
  static const double radiusSmall = 8.0;
  
  /// Cards & containers
  static const double radiusMedium = 12.0;
  
  /// Large cards
  static const double radiusLarge = 16.0;
  
  /// Dialogs & bottom sheets
  static const double radiusXLarge = 28.0;
  
  /// Spacing system
  static const double spacingXS = 4.0;
  static const double spacingS = 8.0;
  static const double spacingM = 16.0;
  static const double spacingL = 24.0;
  static const double spacingXL = 32.0;
  
  /// Elevation
  static const double elevationCard = 0.0;
  static const double elevationCardHover = 2.0;
  static const double elevationDialog = 8.0;
  static const double elevationFAB = 6.0;

  // ============================================================================
  // ☀️ LIGHT THEME (ORIGINAL PALETTE PRESERVED)
  // ============================================================================
  
  static ThemeData get light {
    const brightness = Brightness.light;
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      
      // Color Scheme
      colorScheme: const ColorScheme.light(
        primary: AppColors.primary,
        onPrimary: AppColors.onPrimary,
        primaryContainer: AppColors.primaryLight,
        onPrimaryContainer: AppColors.textPrimary,
        secondary: AppColors.secondary,
        onSecondary: AppColors.onPrimary,
        secondaryContainer: AppColors.surfaceVariant,
        onSecondaryContainer: AppColors.textPrimary,
        tertiary: AppColors.tertiary,
        onTertiary: AppColors.onPrimary,
        tertiaryContainer: AppColors.surfaceVariant,
        onTertiaryContainer: AppColors.textPrimary,
        error: AppColors.error,
        onError: AppColors.onPrimary,
        errorContainer: AppColors.errorBackground,
        onErrorContainer: AppColors.error,
        surface: AppColors.surface,
        onSurface: AppColors.textPrimary,
        surfaceContainerHighest: AppColors.surfaceVariant,
        onSurfaceVariant: AppColors.textSecondary,
        outline: AppColors.outline,
        outlineVariant: AppColors.border,
        shadow: AppColors.shadow,
        scrim: AppColors.scrim,
        inverseSurface: AppColors.textPrimary,
        onInverseSurface: AppColors.surface,
        inversePrimary: AppColors.primaryLight,
        surfaceTint: Colors.transparent,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: AppColors.background,
      
      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.background,
        foregroundColor: AppColors.textPrimary,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge(brightness),
        iconTheme: const IconThemeData(color: AppColors.textPrimary),
        systemOverlayStyle: SystemUiOverlayStyle.dark,
      ),
      
      // Card
      cardTheme: CardThemeData(
        elevation: elevationCard,
        color: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        margin: const EdgeInsets.all(spacingS),
      ),
      
      // FilledButton
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.textDisabled,
          disabledForegroundColor: AppColors.surface,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: AppColors.onPrimary,
          disabledBackgroundColor: AppColors.textDisabled,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textDisabled,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          side: const BorderSide(color: AppColors.primary),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          disabledForegroundColor: AppColors.textDisabled,
          padding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primary,
        foregroundColor: AppColors.onPrimary,
        elevation: elevationFAB,
        shape: CircleBorder(),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariant,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.primary, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.error),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.error, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingM),
        hintStyle: AppTextStyles.bodyMedium(brightness).copyWith(color: AppColors.textTertiary),
        labelStyle: AppTextStyles.bodyMedium(brightness),
        errorStyle: AppTextStyles.bodySmall(brightness).copyWith(color: AppColors.error),
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.divider,
        thickness: 1,
        space: spacingM,
      ),
      
      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surface,
        selectedItemColor: AppColors.primary,
        unselectedItemColor: AppColors.textTertiary,
        type: BottomNavigationBarType.fixed,
        elevation: 8,
        selectedLabelStyle: AppTextStyles.labelSmall(brightness),
        unselectedLabelStyle: AppTextStyles.labelSmall(brightness),
      ),
      
      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surface,
        indicatorColor: AppColors.primaryLight.withOpacity(0.3),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.primary);
          }
          return AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.textTertiary);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primary);
          }
          return const IconThemeData(color: AppColors.textTertiary);
        }),
      ),
      
      // NavigationRail
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.surface,
        selectedIconTheme: const IconThemeData(color: AppColors.primary),
        unselectedIconTheme: const IconThemeData(color: AppColors.textTertiary),
        selectedLabelTextStyle: AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.primary),
        unselectedLabelTextStyle: AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.textTertiary),
        indicatorColor: AppColors.primaryLight.withOpacity(0.3),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariant,
        selectedColor: AppColors.primary,
        disabledColor: AppColors.surfaceVariant,
        labelStyle: AppTextStyles.labelMedium(brightness),
        secondaryLabelStyle: AppTextStyles.labelMedium(brightness).copyWith(color: AppColors.onPrimary),
        padding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingS),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),
      
      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: elevationDialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXLarge),
        ),
        titleTextStyle: AppTextStyles.headlineSmall(brightness),
        contentTextStyle: AppTextStyles.bodyMedium(brightness),
      ),
      
      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surface,
        surfaceTintColor: Colors.transparent,
        elevation: elevationDialog,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXLarge)),
        ),
        modalBackgroundColor: AppColors.surface,
        modalElevation: elevationDialog,
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.surfaceElevated;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primaryLight;
          return AppColors.surfaceVariant;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.onPrimary),
        side: const BorderSide(color: AppColors.outline, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primary;
          return AppColors.outline;
        }),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primary,
        inactiveTrackColor: AppColors.surfaceVariant,
        thumbColor: AppColors.primary,
        overlayColor: AppColors.primary.withOpacity(0.12),
        valueIndicatorColor: AppColors.primary,
        valueIndicatorTextStyle: AppTextStyles.labelMedium(brightness).copyWith(color: AppColors.onPrimary),
      ),
      
      // ProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primary,
        linearTrackColor: AppColors.surfaceVariant,
        circularTrackColor: AppColors.surfaceVariant,
      ),
      
      // ListTile
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primaryLight.withOpacity(0.1),
        iconColor: AppColors.textSecondary,
        textColor: AppColors.textPrimary,
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        titleTextStyle: AppTextStyles.bodyLarge(brightness),
        subtitleTextStyle: AppTextStyles.bodySmall(brightness),
      ),
      
      // Icon
      iconTheme: const IconThemeData(
        color: AppColors.textSecondary,
        size: 24,
      ),
      
      // Text
      textTheme: _buildTextTheme(brightness),
    );
  }

  // ============================================================================
  // 🌙 DARK THEME (MODERN OLED-FRIENDLY)
  // ============================================================================
  
  static ThemeData get dark {
    const brightness = Brightness.dark;
    
    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      
      // Color Scheme
      colorScheme: const ColorScheme.dark(
        primary: AppColors.primaryDarkMode,
        onPrimary: AppColors.onPrimaryDark,
        primaryContainer: AppColors.surfaceVariantDark,
        onPrimaryContainer: AppColors.textPrimaryDark,
        secondary: AppColors.secondaryDark,
        onSecondary: AppColors.onPrimaryDark,
        secondaryContainer: AppColors.surfaceVariantDark,
        onSecondaryContainer: AppColors.textPrimaryDark,
        tertiary: AppColors.tertiaryDark,
        onTertiary: AppColors.onPrimaryDark,
        tertiaryContainer: AppColors.surfaceVariantDark,
        onTertiaryContainer: AppColors.textPrimaryDark,
        error: AppColors.errorDark,
        onError: AppColors.onPrimaryDark,
        errorContainer: AppColors.errorBackgroundDark,
        onErrorContainer: AppColors.errorDark,
        surface: AppColors.surfaceDark,
        onSurface: AppColors.textPrimaryDark,
        surfaceContainerHighest: AppColors.surfaceVariantDark,
        onSurfaceVariant: AppColors.textSecondaryDark,
        outline: AppColors.outlineDark,
        outlineVariant: AppColors.borderDark,
        shadow: AppColors.shadowDark,
        scrim: AppColors.scrimDark,
        inverseSurface: AppColors.textPrimaryDark,
        onInverseSurface: AppColors.surfaceDark,
        inversePrimary: AppColors.primary,
        surfaceTint: Colors.transparent,
      ),
      
      // Scaffold
      scaffoldBackgroundColor: AppColors.backgroundDark,
      
      // AppBar
      appBarTheme: AppBarTheme(
        elevation: 0,
        scrolledUnderElevation: 0,
        backgroundColor: AppColors.backgroundDark,
        foregroundColor: AppColors.textPrimaryDark,
        surfaceTintColor: Colors.transparent,
        centerTitle: true,
        titleTextStyle: AppTextStyles.titleLarge(brightness),
        iconTheme: const IconThemeData(color: AppColors.textPrimaryDark),
        systemOverlayStyle: SystemUiOverlayStyle.light,
      ),
      
      // Card
      cardTheme: CardThemeData(
        elevation: elevationCard,
        color: AppColors.cardDark,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusLarge),
        ),
        margin: const EdgeInsets.all(spacingS),
      ),
      
      // FilledButton
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: AppColors.primaryDarkMode,
          foregroundColor: AppColors.onPrimaryDark,
          disabledBackgroundColor: AppColors.textDisabledDark,
          disabledForegroundColor: AppColors.surfaceDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // ElevatedButton
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primaryDarkMode,
          foregroundColor: AppColors.onPrimaryDark,
          disabledBackgroundColor: AppColors.textDisabledDark,
          elevation: 0,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // OutlinedButton
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primaryDarkMode,
          disabledForegroundColor: AppColors.textDisabledDark,
          padding: const EdgeInsets.symmetric(horizontal: spacingL, vertical: spacingM),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          side: const BorderSide(color: AppColors.primaryDarkMode),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // TextButton
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primaryDarkMode,
          disabledForegroundColor: AppColors.textDisabledDark,
          padding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingS),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(radiusMedium),
          ),
          textStyle: AppTextStyles.labelLarge(brightness),
        ),
      ),
      
      // FAB
      floatingActionButtonTheme: const FloatingActionButtonThemeData(
        backgroundColor: AppColors.primaryDarkMode,
        foregroundColor: AppColors.onPrimaryDark,
        elevation: elevationFAB,
        shape: CircleBorder(),
      ),
      
      // Input
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: AppColors.surfaceVariantDark,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.primaryDarkMode, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.errorDark),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
          borderSide: const BorderSide(color: AppColors.errorDark, width: 2),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingM),
        hintStyle: AppTextStyles.bodyMedium(brightness).copyWith(color: AppColors.textTertiaryDark),
        labelStyle: AppTextStyles.bodyMedium(brightness),
        errorStyle: AppTextStyles.bodySmall(brightness).copyWith(color: AppColors.errorDark),
      ),
      
      // Divider
      dividerTheme: const DividerThemeData(
        color: AppColors.dividerDark,
        thickness: 1,
        space: spacingM,
      ),
      
      // BottomNavigationBar
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedItemColor: AppColors.primaryDarkMode,
        unselectedItemColor: AppColors.textTertiaryDark,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        selectedLabelStyle: AppTextStyles.labelSmall(brightness),
        unselectedLabelStyle: AppTextStyles.labelSmall(brightness),
      ),
      
      // NavigationBar (Material 3)
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: AppColors.surfaceDark,
        indicatorColor: AppColors.primaryDarkMode.withOpacity(0.2),
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.primaryDarkMode);
          }
          return AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.textTertiaryDark);
        }),
        iconTheme: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return const IconThemeData(color: AppColors.primaryDarkMode);
          }
          return const IconThemeData(color: AppColors.textTertiaryDark);
        }),
      ),
      
      // NavigationRail
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: AppColors.surfaceDark,
        selectedIconTheme: const IconThemeData(color: AppColors.primaryDarkMode),
        unselectedIconTheme: const IconThemeData(color: AppColors.textTertiaryDark),
        selectedLabelTextStyle: AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.primaryDarkMode),
        unselectedLabelTextStyle: AppTextStyles.labelSmall(brightness).copyWith(color: AppColors.textTertiaryDark),
        indicatorColor: AppColors.primaryDarkMode.withOpacity(0.2),
      ),
      
      // Chip
      chipTheme: ChipThemeData(
        backgroundColor: AppColors.surfaceVariantDark,
        selectedColor: AppColors.primaryDarkMode,
        disabledColor: AppColors.surfaceVariantDark,
        labelStyle: AppTextStyles.labelMedium(brightness),
        secondaryLabelStyle: AppTextStyles.labelMedium(brightness).copyWith(color: AppColors.onPrimaryDark),
        padding: const EdgeInsets.symmetric(horizontal: spacingM, vertical: spacingS),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusSmall),
        ),
      ),
      
      // Dialog
      dialogTheme: DialogThemeData(
        backgroundColor: AppColors.surfaceElevatedDark,
        surfaceTintColor: Colors.transparent,
        elevation: elevationDialog,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusXLarge),
        ),
        titleTextStyle: AppTextStyles.headlineSmall(brightness),
        contentTextStyle: AppTextStyles.bodyMedium(brightness),
      ),
      
      // BottomSheet
      bottomSheetTheme: BottomSheetThemeData(
        backgroundColor: AppColors.surfaceElevatedDark,
        surfaceTintColor: Colors.transparent,
        elevation: elevationDialog,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(radiusXLarge)),
        ),
        modalBackgroundColor: AppColors.surfaceElevatedDark,
        modalElevation: elevationDialog,
      ),
      
      // Switch
      switchTheme: SwitchThemeData(
        thumbColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primaryDarkMode;
          return AppColors.surfaceElevatedDark;
        }),
        trackColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primaryDarkMode.withOpacity(0.5);
          return AppColors.surfaceVariantDark;
        }),
        trackOutlineColor: WidgetStateProperty.all(Colors.transparent),
      ),
      
      // Checkbox
      checkboxTheme: CheckboxThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primaryDarkMode;
          return Colors.transparent;
        }),
        checkColor: WidgetStateProperty.all(AppColors.onPrimaryDark),
        side: const BorderSide(color: AppColors.outlineDark, width: 2),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(4),
        ),
      ),
      
      // Radio
      radioTheme: RadioThemeData(
        fillColor: WidgetStateProperty.resolveWith((states) {
          if (states.contains(WidgetState.selected)) return AppColors.primaryDarkMode;
          return AppColors.outlineDark;
        }),
      ),
      
      // Slider
      sliderTheme: SliderThemeData(
        activeTrackColor: AppColors.primaryDarkMode,
        inactiveTrackColor: AppColors.surfaceVariantDark,
        thumbColor: AppColors.primaryDarkMode,
        overlayColor: AppColors.primaryDarkMode.withOpacity(0.12),
        valueIndicatorColor: AppColors.primaryDarkMode,
        valueIndicatorTextStyle: AppTextStyles.labelMedium(brightness).copyWith(color: AppColors.onPrimaryDark),
      ),
      
      // ProgressIndicator
      progressIndicatorTheme: const ProgressIndicatorThemeData(
        color: AppColors.primaryDarkMode,
        linearTrackColor: AppColors.surfaceVariantDark,
        circularTrackColor: AppColors.surfaceVariantDark,
      ),
      
      // ListTile
      listTileTheme: ListTileThemeData(
        tileColor: Colors.transparent,
        selectedTileColor: AppColors.primaryDarkMode.withOpacity(0.1),
        iconColor: AppColors.textSecondaryDark,
        textColor: AppColors.textPrimaryDark,
        contentPadding: const EdgeInsets.symmetric(horizontal: spacingM),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(radiusMedium),
        ),
        titleTextStyle: AppTextStyles.bodyLarge(brightness),
        subtitleTextStyle: AppTextStyles.bodySmall(brightness),
      ),
      
      // Icon
      iconTheme: const IconThemeData(
        color: AppColors.textSecondaryDark,
        size: 24,
      ),
      
      // Text
      textTheme: _buildTextTheme(brightness),
    );
  }

  // ============================================================================
  // 🔤 TEXT THEME BUILDER
  // ============================================================================
  
  static TextTheme _buildTextTheme(Brightness brightness) {
    return TextTheme(
      displayLarge: AppTextStyles.displayLarge(brightness),
      displayMedium: AppTextStyles.displayMedium(brightness),
      displaySmall: AppTextStyles.displaySmall(brightness),
      headlineLarge: AppTextStyles.headlineLarge(brightness),
      headlineMedium: AppTextStyles.headlineMedium(brightness),
      headlineSmall: AppTextStyles.headlineSmall(brightness),
      titleLarge: AppTextStyles.titleLarge(brightness),
      titleMedium: AppTextStyles.titleMedium(brightness),
      titleSmall: AppTextStyles.titleSmall(brightness),
      bodyLarge: AppTextStyles.bodyLarge(brightness),
      bodyMedium: AppTextStyles.bodyMedium(brightness),
      bodySmall: AppTextStyles.bodySmall(brightness),
      labelLarge: AppTextStyles.labelLarge(brightness),
      labelMedium: AppTextStyles.labelMedium(brightness),
      labelSmall: AppTextStyles.labelSmall(brightness),
    );
  }

  // ============================================================================
  // 🌈 GRADIENT HELPERS
  // ============================================================================
  
  /// Primary gradient (horizontal)
  static LinearGradient primaryGradient(Brightness b) {
    return LinearGradient(
      colors: [
        AppColors.getPrimary(b),
        AppColors.getSecondary(b),
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    );
  }
  
  /// Primary gradient (vertical)
  static LinearGradient primaryGradientVertical(Brightness b) {
    return LinearGradient(
      colors: [
        AppColors.getPrimary(b),
        AppColors.getSecondary(b),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  
  /// Surface gradient for cards
  static LinearGradient surfaceGradient(Brightness b) {
    return LinearGradient(
      colors: [
        AppColors.getSurface(b),
        AppColors.getSurfaceElevated(b),
      ],
      begin: Alignment.topCenter,
      end: Alignment.bottomCenter,
    );
  }
  
  /// Success gradient
  static LinearGradient successGradient(Brightness b) {
    return LinearGradient(
      colors: [
        AppColors.getSuccess(b),
        AppColors.getSuccess(b).withOpacity(0.8),
      ],
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
    );
  }

  // ============================================================================
  // 🌫️ SHADOW HELPERS
  // ============================================================================
  
  /// Card shadow
  static List<BoxShadow> cardShadow(Brightness b) {
    return [
      BoxShadow(
        color: AppColors.getShadow(b),
        blurRadius: 8,
        offset: const Offset(0, 2),
      ),
    ];
  }
  
  /// Elevated shadow
  static List<BoxShadow> elevatedShadow(Brightness b) {
    return [
      BoxShadow(
        color: AppColors.getShadow(b),
        blurRadius: 16,
        offset: const Offset(0, 4),
      ),
    ];
  }
  
  /// Dialog shadow
  static List<BoxShadow> dialogShadow(Brightness b) {
    return [
      BoxShadow(
        color: AppColors.getShadow(b),
        blurRadius: 24,
        offset: const Offset(0, 8),
      ),
    ];
  }
  
  /// FAB shadow
  static List<BoxShadow> fabShadow(Brightness b) {
    return [
      BoxShadow(
        color: AppColors.getPrimary(b).withOpacity(0.3),
        blurRadius: 12,
        offset: const Offset(0, 4),
      ),
    ];
  }

  // ============================================================================
  // 📱 SYSTEM UI OVERLAY STYLES
  // ============================================================================
  
  /// Light status bar (for dark backgrounds)
  static const SystemUiOverlayStyle lightSystemUI = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.light,
    statusBarBrightness: Brightness.dark,
    systemNavigationBarColor: AppColors.backgroundDark,
    systemNavigationBarIconBrightness: Brightness.light,
  );
  
  /// Dark status bar (for light backgrounds)
  static const SystemUiOverlayStyle darkSystemUI = SystemUiOverlayStyle(
    statusBarColor: Colors.transparent,
    statusBarIconBrightness: Brightness.dark,
    statusBarBrightness: Brightness.light,
    systemNavigationBarColor: AppColors.background,
    systemNavigationBarIconBrightness: Brightness.dark,
  );
  
  /// Get system UI style based on brightness
  static SystemUiOverlayStyle getSystemUI(Brightness b) {
    return b == Brightness.dark ? lightSystemUI : darkSystemUI;
  }
}
