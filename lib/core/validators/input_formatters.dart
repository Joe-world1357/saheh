import 'package:flutter/services.dart';

/// Centralized input formatters for consistent input handling
class AppInputFormatters {
  AppInputFormatters._(); // Private constructor

  /// Digits only (integers)
  static final digitsOnly = FilteringTextInputFormatter.digitsOnly;

  /// Decimal numbers only
  static final decimalOnly = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  /// Numbers with optional decimal (for weight, height, etc.)
  static final numberWithDecimal = FilteringTextInputFormatter.allow(RegExp(r'^\d+\.?\d{0,2}'));

  /// No leading zeros
  static TextInputFormatter noLeadingZeros() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      if (newValue.text.isEmpty) {
        return newValue;
      }
      
      // Allow single zero
      if (newValue.text == '0') {
        return newValue;
      }
      
      // Remove leading zeros
      if (newValue.text.startsWith('0') && newValue.text.length > 1) {
        final withoutLeadingZero = newValue.text.replaceFirst(RegExp(r'^0+'), '');
        return TextEditingValue(
          text: withoutLeadingZero,
          selection: TextSelection.collapsed(offset: withoutLeadingZero.length),
        );
      }
      
      return newValue;
    });
  }

  /// Max value formatter - allows all input, validation should be done in validator
  /// This allows users to type partial numbers without blocking
  static TextInputFormatter maxValue(double max) {
    // Don't block input - let validator handle min/max validation
    // This allows partial input while typing
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue;
    });
  }

  /// Min value formatter - allows all input, validation should be done in validator
  /// This allows users to type partial numbers (e.g., "1" when min is 50, to type "150")
  static TextInputFormatter minValue(double min) {
    // Don't block input - let validator handle min/max validation
    // This allows partial input while typing
    return TextInputFormatter.withFunction((oldValue, newValue) {
      return newValue;
    });
  }

  /// Max length formatter
  static TextInputFormatter maxLength(int max) {
    return LengthLimitingTextInputFormatter(max);
  }

  /// Trim whitespace
  static TextInputFormatter trimWhitespace() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      // Trim leading and trailing whitespace
      final trimmed = newValue.text.trim();
      if (trimmed != newValue.text) {
        return TextEditingValue(
          text: trimmed,
          selection: TextSelection.collapsed(offset: trimmed.length),
        );
      }
      return newValue;
    });
  }

  /// Email formatter (lowercase, no spaces)
  static TextInputFormatter email() {
    return TextInputFormatter.withFunction((oldValue, newValue) {
      // Convert to lowercase and remove spaces
      final processed = newValue.text.toLowerCase().replaceAll(' ', '');
      if (processed != newValue.text) {
        return TextEditingValue(
          text: processed,
          selection: TextSelection.collapsed(offset: processed.length),
        );
      }
      return newValue;
    });
  }

  /// Phone number formatter (digits and + only)
  static TextInputFormatter phone() {
    return FilteringTextInputFormatter.allow(RegExp(r'[\d+]'));
  }

  /// Name formatter (letters, spaces, hyphens, apostrophes only)
  static TextInputFormatter name() {
    return FilteringTextInputFormatter.allow(RegExp(r"[a-zA-Z\s'-]"));
  }

  /// Username formatter (letters, numbers, underscores, hyphens)
  static TextInputFormatter username() {
    return FilteringTextInputFormatter.allow(RegExp(r'[a-zA-Z0-9_-]'));
  }

  /// Combine multiple formatters
  static List<TextInputFormatter> combine(List<TextInputFormatter> formatters) {
    return formatters;
  }
}

