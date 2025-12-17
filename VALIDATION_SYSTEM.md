# Centralized Validation System - Implementation Guide

## ✅ Completed Implementation

### 1. Core Validation System

**File: `lib/core/validators/validators.dart`**
- ✅ Email validation
- ✅ Password validation (with min length)
- ✅ Required field validation
- ✅ Name validation
- ✅ Username validation
- ✅ Age validation (1-150)
- ✅ Height validation (50-300 cm)
- ✅ Weight validation (10-500 kg)
- ✅ Sleep hours validation (0-24)
- ✅ Water intake validation (100-10000 ml)
- ✅ XP value validation
- ✅ Goal target validation
- ✅ Workout duration validation (1-600 min)
- ✅ Calories validation
- ✅ Generic number validation (with min/max)
- ✅ Phone number validation
- ✅ Feedback/comment validation
- ✅ Medicine name validation
- ✅ Dosage validation
- ✅ Password confirmation validation

**File: `lib/core/validators/input_formatters.dart`**
- ✅ Digits only formatter
- ✅ Decimal numbers formatter
- ✅ No leading zeros formatter
- ✅ Max value formatter
- ✅ Min value formatter
- ✅ Max length formatter
- ✅ Trim whitespace formatter
- ✅ Email formatter (lowercase, no spaces)
- ✅ Phone number formatter
- ✅ Name formatter (letters, spaces, hyphens, apostrophes)
- ✅ Username formatter (letters, numbers, underscores, hyphens)

### 2. Reusable Form Widgets

**File: `lib/shared/widgets/app_form_fields.dart`**
- ✅ `AppTextField` - Generic text field with validation and theming
- ✅ `AppNumberField` - Number field with automatic validation
- ✅ `AppPasswordField` - Password field with visibility toggle
- ✅ `AppEmailField` - Email field with automatic validation

All widgets:
- Automatically apply validation
- Apply theme styles
- Support input formatters
- Have proper keyboard types
- Include error handling

### 3. Updated Forms

#### ✅ Authentication
- **Login Screen** (`lib/features/auth/view/login_screen.dart`)
  - Email field with validation
  - Password field with validation
  - Form validation before submission

- **Register Screen** (`lib/features/auth/view/register_screen.dart`)
  - Name field with validation
  - Email field with validation
  - Phone field (optional) with validation
  - Password field with validation
  - Password confirmation with matching validation
  - Form validation before submission

#### ✅ Health Tracking
- **Water Intake Screen** (`lib/features/health/view/water_intake_screen.dart`)
  - Custom amount field with validation (100-10000 ml)
  - Goal setting dialog with validation (500-10000 ml)

- **Health Goals Screen** (`lib/features/health/view/health_goals_screen.dart`)
  - Goal title field with required validation
  - Target field with goal target validation
  - Deadline field (optional)

## 📋 Remaining Forms to Update

### High Priority
1. **Add Medicine Screen** (`lib/features/health/view/add_medicine.dart`)
   - Medicine name field
   - Dosage field

2. **Sleep Tracker Screen** (`lib/features/health/view/sleep_tracker_screen.dart`)
   - Sleep duration field
   - Bedtime/wake time fields

3. **Fitness Onboarding** (`lib/features/fitness/view/fitness_onboarding_screen.dart`)
   - Age field
   - Weight field
   - Height field

4. **Profile Edit Screen** (`lib/features/profile/view/edit_personal_info_screen.dart`)
   - Name field
   - Email field
   - Phone field
   - Age field
   - Height field
   - Weight field

### Medium Priority
5. **Men Workouts Screen** (`lib/features/fitness/view/men_workouts_screen.dart`)
   - Workout name field
   - Duration field
   - Calories field

6. **Activity Tracker Screen** (`lib/features/fitness/view/activity_tracker_screen.dart`)
   - Steps field
   - Active minutes field

7. **Settings Screens**
   - Feedback screen
   - Contact support screen
   - Nutrition settings screen

## 🎯 Usage Examples

### Basic Text Field
```dart
AppTextField(
  controller: _nameController,
  label: 'Full Name',
  hint: 'Enter your name',
  validator: Validators.name,
  prefixIcon: Icons.person_outline,
)
```

### Number Field
```dart
AppNumberField(
  controller: _ageController,
  label: 'Age',
  hint: 'Enter your age',
  min: 1,
  max: 150,
  validator: Validators.age,
)
```

### Email Field
```dart
AppEmailField(
  controller: _emailController,
  label: 'Email',
  hint: 'Enter email address',
)
```

### Password Field
```dart
AppPasswordField(
  controller: _passwordController,
  label: 'Password',
  hint: 'Enter password',
  minLength: 6,
)
```

### Form Validation
```dart
final _formKey = GlobalKey<FormState>();

Form(
  key: _formKey,
  child: Column(
    children: [
      AppTextField(...),
      AppNumberField(...),
    ],
  ),
)

// Validate before submission
if (!_formKey.currentState!.validate()) {
  return;
}
```

## 🔒 Runtime Validation

Always validate before:
- Saving data to database
- Updating goals
- Submitting workouts
- Calculating XP
- Any data mutation

Example:
```dart
Future<void> _saveData() async {
  // Validate form first
  if (!_formKey.currentState!.validate()) {
    return;
  }
  
  // Additional runtime validation
  final age = int.tryParse(_ageController.text);
  if (age == null || age < 1 || age > 150) {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Invalid age')),
    );
    return;
  }
  
  // Proceed with save
  await saveToDatabase(...);
}
```

## ❌ Forbidden Practices

1. ❌ **Inline validators** - Always use `Validators` class
2. ❌ **Hardcoded error messages** - Use validator messages
3. ❌ **Missing keyboard types** - Always set appropriate `keyboardType`
4. ❌ **No input formatters** - Use `AppInputFormatters` for numbers
5. ❌ **Saving unchecked input** - Always validate before save
6. ❌ **Ad-hoc validation logic** - Centralize in `Validators` class

## ✅ Best Practices

1. ✅ Always use `Form` widget with `GlobalKey<FormState>`
2. ✅ Use `AppTextField`, `AppNumberField`, `AppEmailField`, `AppPasswordField`
3. ✅ Set appropriate `keyboardType` for each field
4. ✅ Use `inputFormatters` for number fields
5. ✅ Validate on form submission
6. ✅ Provide clear, user-friendly error messages
7. ✅ Test validation with edge cases (empty, too long, invalid format)

## 🚀 Next Steps

1. Update remaining forms (see list above)
2. Add runtime validation to all data operations
3. Test all forms with edge cases
4. Add unit tests for validators
5. Document any custom validation rules

