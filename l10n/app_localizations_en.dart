// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'Saheeh';

  @override
  String appVersion(String version) {
    return 'Version $version';
  }

  @override
  String get home => 'Home';

  @override
  String get profile => 'Profile';

  @override
  String get settings => 'Settings';

  @override
  String get pharmacy => 'Pharmacy';

  @override
  String get notifications => 'Notifications';

  @override
  String get achievements => 'Achievements';

  @override
  String get editPersonalInfo => 'Edit Personal Info';

  @override
  String get notificationSettings => 'Notification Settings';

  @override
  String get fitnessReminders => 'Fitness Reminders';

  @override
  String get fitnessRemindersDesc => 'Daily workout reminders';

  @override
  String get waterReminders => 'Water Intake Reminders';

  @override
  String get waterRemindersDesc =>
      'Reminders to drink water throughout the day';

  @override
  String get sleepReminders => 'Sleep Reminders';

  @override
  String get sleepRemindersDesc => 'Bedtime reminders based on your sleep goal';

  @override
  String get nutritionReminders => 'Nutrition Reminders';

  @override
  String get nutritionRemindersDesc =>
      'Meal logging and nutrition goal reminders';

  @override
  String get xpNotifications => 'XP Earned';

  @override
  String get xpNotificationsDesc =>
      'Notifications when you earn XP and level up';

  @override
  String get achievementNotifications => 'Achievement Unlocked';

  @override
  String get achievementNotificationsDesc =>
      'Notifications when you unlock achievements';

  @override
  String get save => 'Save';

  @override
  String get cancel => 'Cancel';

  @override
  String get close => 'Close';

  @override
  String get confirm => 'Confirm';

  @override
  String get delete => 'Delete';

  @override
  String get edit => 'Edit';

  @override
  String get add => 'Add';

  @override
  String get search => 'Search';

  @override
  String get filter => 'Filter';

  @override
  String get loading => 'Loading...';

  @override
  String get error => 'Error';

  @override
  String get success => 'Success';

  @override
  String get retry => 'Retry';

  @override
  String get noData => 'No data available';

  @override
  String get fullName => 'Full Name';

  @override
  String get email => 'Email';

  @override
  String get phone => 'Phone Number';

  @override
  String get age => 'Age';

  @override
  String get gender => 'Gender';

  @override
  String get height => 'Height (cm)';

  @override
  String get weight => 'Weight (kg)';

  @override
  String get address => 'Address';

  @override
  String get male => 'Male';

  @override
  String get female => 'Female';

  @override
  String get saveChanges => 'Save Changes';

  @override
  String get noChangesMade => 'No changes made';

  @override
  String get personalInformationUpdated =>
      'Personal information updated successfully';

  @override
  String errorUpdatingInformation(String error) {
    return 'Error updating information: $error';
  }

  @override
  String get enterYourFullName => 'Enter your full name';

  @override
  String get enterYourEmail => 'Enter your email address';

  @override
  String get enterYourPhone => 'Enter your phone number';

  @override
  String get enterAge => 'Enter age';

  @override
  String get enterHeight => 'Enter height';

  @override
  String get enterWeight => 'Enter weight';

  @override
  String get enterYourAddress => 'Enter your address';

  @override
  String get pleaseSelectGender => 'Please select gender';

  @override
  String get redeemXPPoints => 'Redeem XP Points';

  @override
  String yourXP(int xp) {
    return 'Your XP: $xp';
  }

  @override
  String get availableRedemptions => 'Available Redemptions';

  @override
  String get redeem => 'Redeem';

  @override
  String get insufficientXP => 'Insufficient XP';

  @override
  String get redemptionSuccessful => 'Redemption successful!';

  @override
  String get redemptionFailed => 'Redemption failed. Please try again.';

  @override
  String get achievementProgress => 'Achievement Progress';

  @override
  String get noAchievementsYet => 'No achievements yet';

  @override
  String get unlocked => 'Unlocked';

  @override
  String get locked => 'Locked';

  @override
  String get xp => 'XP';

  @override
  String get level => 'Level';

  @override
  String get levelUp => 'Level Up!';

  @override
  String youReachedLevel(int level) {
    return 'You reached Level $level! Keep it up!';
  }

  @override
  String youEarnedXP(int amount, int total) {
    return 'You earned $amount XP! Total: $total XP';
  }

  @override
  String get achievementUnlocked => 'Achievement Unlocked!';

  @override
  String get goalCompleted => 'Goal Completed!';

  @override
  String congratulationsYouCompleted(String goalName) {
    return 'Congratulations! You completed: $goalName';
  }

  @override
  String get notificationsEnabled => 'Notifications Enabled';

  @override
  String get notificationsDisabled => 'Notifications Disabled';

  @override
  String get youWillReceiveNotifications =>
      'You will receive notifications for reminders and achievements';

  @override
  String get enableNotificationsToReceive =>
      'Enable notifications to receive reminders and updates';

  @override
  String get enableNotifications => 'Enable Notifications';

  @override
  String get permissionRequired => 'Permission Required';

  @override
  String get notificationsAreDisabled =>
      'Notifications are disabled. Please enable them in app settings.';

  @override
  String get openSettings => 'Open Settings';

  @override
  String get language => 'Language';

  @override
  String get english => 'English';

  @override
  String get arabic => 'Arabic';

  @override
  String get theme => 'Theme';

  @override
  String get light => 'Light';

  @override
  String get dark => 'Dark';

  @override
  String get system => 'System';

  @override
  String get about => 'About';

  @override
  String get privacyPolicy => 'Privacy Policy';

  @override
  String get termsOfService => 'Terms of Service';

  @override
  String get contactSupport => 'Contact Support';

  @override
  String get logout => 'Logout';

  @override
  String get login => 'Login';

  @override
  String get register => 'Register';

  @override
  String get password => 'Password';

  @override
  String get confirmPassword => 'Confirm Password';

  @override
  String get forgotPassword => 'Forgot Password?';

  @override
  String get dontHaveAccount => 'Don\'t have an account?';

  @override
  String get alreadyHaveAccount => 'Already have an account?';

  @override
  String get workout => 'Workout';

  @override
  String get nutrition => 'Nutrition';

  @override
  String get medications => 'Medications';

  @override
  String get appointments => 'Appointments';

  @override
  String get healthTracking => 'Health Tracking';

  @override
  String get waterIntake => 'Water Intake';

  @override
  String get sleep => 'Sleep';

  @override
  String get steps => 'Steps';

  @override
  String get calories => 'Calories';

  @override
  String get today => 'Today';

  @override
  String get thisWeek => 'This Week';

  @override
  String get thisMonth => 'This Month';

  @override
  String get seeAll => 'See all';

  @override
  String get popularProducts => 'Popular Products';

  @override
  String get specialOffers => 'Special Offers';

  @override
  String get viewRedemptions => 'View Redemptions';

  @override
  String get discount => 'Discount';

  @override
  String get product => 'Product';

  @override
  String get service => 'Service';

  @override
  String get freeDelivery => 'Free Delivery';

  @override
  String get freeDeliveryDesc => 'Free delivery on your next order';

  @override
  String percentOffOrder(int percent) {
    return '$percent% Off Order';
  }

  @override
  String getPercentDiscount(int percent) {
    return 'Get $percent% discount on your next order';
  }

  @override
  String freeProduct(String productName) {
    return 'Free $productName';
  }

  @override
  String redeemFreeProduct(String productName) {
    return 'Redeem a free $productName';
  }

  @override
  String get activityLevel => 'Activity Level';

  @override
  String get sedentary => 'Sedentary';

  @override
  String get moderate => 'Moderate';

  @override
  String get active => 'Active';

  @override
  String get veryActive => 'Very Active';

  @override
  String get searchMedicines => 'Search medicines, categories...';

  @override
  String get barcodeScanner => 'Barcode Scanner';

  @override
  String get scanAndOrder => 'Scan & order';

  @override
  String get prescription => 'Prescription';

  @override
  String get uploadAndOrder => 'Upload & order';

  @override
  String get categories => 'Categories';

  @override
  String get all => 'All';

  @override
  String get painRelief => 'Pain Relief';

  @override
  String get coldAndFlu => 'Cold & Flu';

  @override
  String get vitamins => 'Vitamins';

  @override
  String get herbal => 'Herbal';

  @override
  String get antiseptic => 'Antiseptic';

  @override
  String get cough => 'Cough';

  @override
  String get myCart => 'My Cart';
}
