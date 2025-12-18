import 'package:flutter/material.dart';
import 'app_localizations.dart';

/// Extension to easily access localization in widgets
extension LocalizationExtension on BuildContext {
  AppLocalizations get l10n => AppLocalizations.of(this)!;
  
  /// Check if current locale is Arabic (RTL)
  bool get isRTL => Localizations.localeOf(this).languageCode == 'ar';
  
  /// Get text direction based on locale
  TextDirection get textDirection => isRTL ? TextDirection.rtl : TextDirection.ltr;
}

