/// Centralized validation system for the entire app
/// All validation logic must be defined here - no inline validators allowed
class Validators {
  Validators._(); // Private constructor to prevent instantiation

  /// Email validation
  static String? email(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    
    final trimmed = value.trim();
    if (trimmed.isEmpty) {
      return 'Email cannot be empty';
    }

    // Email regex pattern
    final emailRegex = RegExp(
      r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
    );

    if (!emailRegex.hasMatch(trimmed)) {
      return 'Please enter a valid email address';
    }

    if (trimmed.length > 100) {
      return 'Email must be less than 100 characters';
    }

    return null;
  }

  /// Password validation
  static String? password(String? value, {int minLength = 6}) {
    if (value == null || value.isEmpty) {
      return 'Password is required';
    }

    if (value.length < minLength) {
      return 'Password must be at least $minLength characters';
    }

    if (value.length > 128) {
      return 'Password must be less than 128 characters';
    }

    // Optional: Add complexity requirements
    // if (!value.contains(RegExp(r'[A-Z]'))) {
    //   return 'Password must contain at least one uppercase letter';
    // }
    // if (!value.contains(RegExp(r'[a-z]'))) {
    //   return 'Password must contain at least one lowercase letter';
    // }
    // if (!value.contains(RegExp(r'[0-9]'))) {
    //   return 'Password must contain at least one number';
    // }

    return null;
  }

  /// Required field validation
  static String? required(String? value, {String? fieldName}) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName is required'
          : 'This field is required';
    }
    return null;
  }

  /// Name validation (for user names, not usernames)
  static String? name(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }

    final trimmed = value.trim();
    
    if (trimmed.length < 2) {
      return 'Name must be at least 2 characters';
    }

    if (trimmed.length > 50) {
      return 'Name must be less than 50 characters';
    }

    // Allow letters, spaces, hyphens, apostrophes
    if (!RegExp(r"^[a-zA-Z\s'-]+$").hasMatch(trimmed)) {
      return 'Name can only contain letters, spaces, hyphens, and apostrophes';
    }

    return null;
  }

  /// Username validation
  static String? username(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Username is required';
    }

    final trimmed = value.trim();
    
    if (trimmed.length < 3) {
      return 'Username must be at least 3 characters';
    }

    if (trimmed.length > 20) {
      return 'Username must be less than 20 characters';
    }

    // Allow letters, numbers, underscores, hyphens
    if (!RegExp(r'^[a-zA-Z0-9_-]+$').hasMatch(trimmed)) {
      return 'Username can only contain letters, numbers, underscores, and hyphens';
    }

    return null;
  }

  /// Age validation
  static String? age(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Age is required';
    }

    final num = int.tryParse(value.trim());
    if (num == null) {
      return 'Age must be a number';
    }

    if (num < 1 || num > 150) {
      return 'Age must be between 1 and 150';
    }

    return null;
  }

  /// Height validation (in cm)
  static String? height(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Height is required';
    }

    final num = double.tryParse(value.trim());
    if (num == null) {
      return 'Height must be a number';
    }

    if (num < 50 || num > 300) {
      return 'Height must be between 50cm and 300cm';
    }

    return null;
  }

  /// Weight validation (in kg)
  static String? weight(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Weight is required';
    }

    final num = double.tryParse(value.trim());
    if (num == null) {
      return 'Weight must be a number';
    }

    if (num < 10 || num > 500) {
      return 'Weight must be between 10kg and 500kg';
    }

    return null;
  }

  /// Sleep hours validation
  static String? sleepHours(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Sleep duration is required';
    }

    final num = double.tryParse(value.trim());
    if (num == null) {
      return 'Sleep duration must be a number';
    }

    if (num < 0 || num > 24) {
      return 'Sleep duration must be between 0 and 24 hours';
    }

    return null;
  }

  /// Water intake validation (in ml)
  static String? waterIntake(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Water intake is required';
    }

    final num = int.tryParse(value.trim());
    if (num == null) {
      return 'Water intake must be a number';
    }

    if (num < 100 || num > 10000) {
      return 'Water intake must be between 100ml and 10000ml';
    }

    return null;
  }

  /// XP value validation
  static String? xp(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'XP value is required';
    }

    final num = int.tryParse(value.trim());
    if (num == null) {
      return 'XP must be a number';
    }

    if (num < 0) {
      return 'XP cannot be negative';
    }

    if (num > 1000000) {
      return 'XP value is too large';
    }

    return null;
  }

  /// Goal target validation
  static String? goalTarget(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Goal target is required';
    }

    final num = double.tryParse(value.trim());
    if (num == null) {
      return 'Goal target must be a number';
    }

    if (num < 0) {
      return 'Goal target cannot be negative';
    }

    return null;
  }

  /// Workout duration validation (in minutes)
  static String? workoutDuration(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Duration is required';
    }

    final num = int.tryParse(value.trim());
    if (num == null) {
      return 'Duration must be a number';
    }

    if (num < 1 || num > 600) {
      return 'Duration must be between 1 and 600 minutes';
    }

    return null;
  }

  /// Calories validation
  static String? calories(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Calories is required';
    }

    final num = int.tryParse(value.trim());
    if (num == null) {
      return 'Calories must be a number';
    }

    if (num < 0) {
      return 'Calories cannot be negative';
    }

    if (num > 10000) {
      return 'Calories value is too large';
    }

    return null;
  }

  /// Generic number validation
  static String? number(
    String? value, {
    int? min,
    int? max,
    String? fieldName,
    bool allowDecimal = false,
  }) {
    if (value == null || value.trim().isEmpty) {
      return fieldName != null 
          ? '$fieldName is required'
          : 'This field is required';
    }

    if (allowDecimal) {
      final num = double.tryParse(value.trim());
      if (num == null) {
        return '${fieldName ?? "Value"} must be a number';
      }
      if (min != null && num < min) {
        return '${fieldName ?? "Value"} must be at least $min';
      }
      if (max != null && num > max) {
        return '${fieldName ?? "Value"} must be at most $max';
      }
    } else {
      final num = int.tryParse(value.trim());
      if (num == null) {
        return '${fieldName ?? "Value"} must be a whole number';
      }
      if (min != null && num < min) {
        return '${fieldName ?? "Value"} must be at least $min';
      }
      if (max != null && num > max) {
        return '${fieldName ?? "Value"} must be at most $max';
      }
    }

    return null;
  }

  /// Phone number validation (basic)
  static String? phone(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Phone number is required';
    }

    final trimmed = value.trim();
    
    // Remove common phone formatting characters
    final digitsOnly = trimmed.replaceAll(RegExp(r'[^\d+]'), '');
    
    if (digitsOnly.length < 7 || digitsOnly.length > 15) {
      return 'Please enter a valid phone number';
    }

    return null;
  }

  /// Feedback/comment validation
  static String? feedback(String? value, {int minLength = 10}) {
    if (value == null || value.trim().isEmpty) {
      return 'Feedback is required';
    }

    final trimmed = value.trim();
    
    if (trimmed.length < minLength) {
      return 'Feedback must be at least $minLength characters';
    }

    if (trimmed.length > 1000) {
      return 'Feedback must be less than 1000 characters';
    }

    return null;
  }

  /// Medicine name validation
  static String? medicineName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Medicine name is required';
    }

    final trimmed = value.trim();
    
    if (trimmed.length < 2) {
      return 'Medicine name must be at least 2 characters';
    }

    if (trimmed.length > 100) {
      return 'Medicine name must be less than 100 characters';
    }

    return null;
  }

  /// Dosage validation
  static String? dosage(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Dosage is required';
    }

    final num = double.tryParse(value.trim());
    if (num == null) {
      return 'Dosage must be a number';
    }

    if (num <= 0) {
      return 'Dosage must be greater than 0';
    }

    if (num > 1000) {
      return 'Dosage value is too large';
    }

    return null;
  }

  /// Password confirmation validation
  static String? Function(String?) passwordConfirmation(
    String? password,
  ) {
    return (String? value) {
      if (value == null || value.isEmpty) {
        return 'Please confirm your password';
      }
      if (value != password) {
        return 'Passwords do not match';
      }
      return null;
    };
  }
}

