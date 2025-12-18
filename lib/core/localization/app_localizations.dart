import 'package:flutter/material.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  // App name
  String get appName => locale.languageCode == 'ar' ? 'صحيح' : 'Saheeh';
  
  // Common
  String get home => locale.languageCode == 'ar' ? 'الرئيسية' : 'Home';
  String get profile => locale.languageCode == 'ar' ? 'الملف الشخصي' : 'Profile';
  String get settings => locale.languageCode == 'ar' ? 'الإعدادات' : 'Settings';
  String get pharmacy => locale.languageCode == 'ar' ? 'الصيدلية' : 'Pharmacy';
  String get notifications => locale.languageCode == 'ar' ? 'الإشعارات' : 'Notifications';
  String get achievements => locale.languageCode == 'ar' ? 'الإنجازات' : 'Achievements';
  String get save => locale.languageCode == 'ar' ? 'حفظ' : 'Save';
  String get cancel => locale.languageCode == 'ar' ? 'إلغاء' : 'Cancel';
  String get close => locale.languageCode == 'ar' ? 'إغلاق' : 'Close';
  String get confirm => locale.languageCode == 'ar' ? 'تأكيد' : 'Confirm';
  String get edit => locale.languageCode == 'ar' ? 'تعديل' : 'Edit';
  String get add => locale.languageCode == 'ar' ? 'إضافة' : 'Add';
  String get search => locale.languageCode == 'ar' ? 'بحث' : 'Search';
  String get loading => locale.languageCode == 'ar' ? 'جاري التحميل...' : 'Loading...';
  String get error => locale.languageCode == 'ar' ? 'خطأ' : 'Error';
  String get success => locale.languageCode == 'ar' ? 'نجح' : 'Success';
  
  // Personal Info
  String get editPersonalInfo => locale.languageCode == 'ar' ? 'تعديل المعلومات الشخصية' : 'Edit Personal Info';
  String get fullName => locale.languageCode == 'ar' ? 'الاسم الكامل' : 'Full Name';
  String get email => locale.languageCode == 'ar' ? 'البريد الإلكتروني' : 'Email';
  String get phone => locale.languageCode == 'ar' ? 'رقم الهاتف' : 'Phone Number';
  String get age => locale.languageCode == 'ar' ? 'العمر' : 'Age';
  String get gender => locale.languageCode == 'ar' ? 'الجنس' : 'Gender';
  String get height => locale.languageCode == 'ar' ? 'الطول (سم)' : 'Height (cm)';
  String get weight => locale.languageCode == 'ar' ? 'الوزن (كجم)' : 'Weight (kg)';
  String get address => locale.languageCode == 'ar' ? 'العنوان' : 'Address';
  String get male => locale.languageCode == 'ar' ? 'ذكر' : 'Male';
  String get female => locale.languageCode == 'ar' ? 'أنثى' : 'Female';
  String get saveChanges => locale.languageCode == 'ar' ? 'حفظ التغييرات' : 'Save Changes';
  String get noChangesMade => locale.languageCode == 'ar' ? 'لم يتم إجراء أي تغييرات' : 'No changes made';
  String get enterYourFullName => locale.languageCode == 'ar' ? 'أدخل اسمك الكامل' : 'Enter your full name';
  String get enterYourEmail => locale.languageCode == 'ar' ? 'أدخل عنوان بريدك الإلكتروني' : 'Enter your email address';
  String get enterYourPhone => locale.languageCode == 'ar' ? 'أدخل رقم هاتفك' : 'Enter your phone number';
  String get enterAge => locale.languageCode == 'ar' ? 'أدخل العمر' : 'Enter age';
  String get enterHeight => locale.languageCode == 'ar' ? 'أدخل الطول' : 'Enter height';
  String get enterWeight => locale.languageCode == 'ar' ? 'أدخل الوزن' : 'Enter weight';
  String get enterYourAddress => locale.languageCode == 'ar' ? 'أدخل عنوانك' : 'Enter your address';
  String get pleaseSelectGender => locale.languageCode == 'ar' ? 'الرجاء اختيار الجنس' : 'Please select gender';
  String get personalInformationUpdated => locale.languageCode == 'ar' ? 'تم تحديث المعلومات الشخصية بنجاح' : 'Personal information updated successfully';
  String errorUpdatingInformation(String error) => locale.languageCode == 'ar' ? 'خطأ في تحديث المعلومات: $error' : 'Error updating information: $error';
  
  // Notifications
  String get notificationSettings => locale.languageCode == 'ar' ? 'إعدادات الإشعارات' : 'Notification Settings';
  String get fitnessReminders => locale.languageCode == 'ar' ? 'تذكيرات اللياقة البدنية' : 'Fitness Reminders';
  String get fitnessRemindersDesc => locale.languageCode == 'ar' ? 'تذكيرات التمارين اليومية' : 'Daily workout reminders';
  String get waterReminders => locale.languageCode == 'ar' ? 'تذكيرات شرب الماء' : 'Water Intake Reminders';
  String get waterRemindersDesc => locale.languageCode == 'ar' ? 'تذكيرات لشرب الماء طوال اليوم' : 'Reminders to drink water throughout the day';
  String get sleepReminders => locale.languageCode == 'ar' ? 'تذكيرات النوم' : 'Sleep Reminders';
  String get sleepRemindersDesc => locale.languageCode == 'ar' ? 'تذكيرات وقت النوم بناءً على هدف نومك' : 'Bedtime reminders based on your sleep goal';
  String get nutritionReminders => locale.languageCode == 'ar' ? 'تذكيرات التغذية' : 'Nutrition Reminders';
  String get nutritionRemindersDesc => locale.languageCode == 'ar' ? 'تذكيرات تسجيل الوجبات وأهداف التغذية' : 'Meal logging and nutrition goal reminders';
  String get xpNotifications => locale.languageCode == 'ar' ? 'نقاط الخبرة المكتسبة' : 'XP Earned';
  String get xpNotificationsDesc => locale.languageCode == 'ar' ? 'إشعارات عند كسب نقاط الخبرة والترقية' : 'Notifications when you earn XP and level up';
  String get achievementNotifications => locale.languageCode == 'ar' ? 'إنجاز تم إلغاء قفله' : 'Achievement Unlocked';
  String get achievementNotificationsDesc => locale.languageCode == 'ar' ? 'إشعارات عند إلغاء قفل الإنجازات' : 'Notifications when you unlock achievements';
  String get notificationsEnabled => locale.languageCode == 'ar' ? 'الإشعارات مفعلة' : 'Notifications Enabled';
  String get notificationsDisabled => locale.languageCode == 'ar' ? 'الإشعارات معطلة' : 'Notifications Disabled';
  String get youWillReceiveNotifications => locale.languageCode == 'ar' ? 'ستتلقى إشعارات للتذكيرات والإنجازات' : 'You will receive notifications for reminders and achievements';
  String get enableNotificationsToReceive => locale.languageCode == 'ar' ? 'قم بتمكين الإشعارات لتلقي التذكيرات والتحديثات' : 'Enable notifications to receive reminders and updates';
  String get enableNotifications => locale.languageCode == 'ar' ? 'تمكين الإشعارات' : 'Enable Notifications';
  String get permissionRequired => locale.languageCode == 'ar' ? 'إذن مطلوب' : 'Permission Required';
  String get notificationsAreDisabled => locale.languageCode == 'ar' ? 'الإشعارات معطلة. يرجى تمكينها في إعدادات التطبيق.' : 'Notifications are disabled. Please enable them in app settings.';
  String get openSettings => locale.languageCode == 'ar' ? 'فتح الإعدادات' : 'Open Settings';
  
  // Language & Theme
  String get language => locale.languageCode == 'ar' ? 'اللغة' : 'Language';
  String get english => locale.languageCode == 'ar' ? 'الإنجليزية' : 'English';
  String get arabic => locale.languageCode == 'ar' ? 'العربية' : 'Arabic';
  
  // About
  String get about => locale.languageCode == 'ar' ? 'حول' : 'About';
  String appVersion(String version) => locale.languageCode == 'ar' ? 'الإصدار $version' : 'Version $version';
  
  // Pharmacy
  String get searchMedicines => locale.languageCode == 'ar' ? 'ابحث عن الأدوية، الفئات...' : 'Search medicines, categories...';
  String get barcodeScanner => locale.languageCode == 'ar' ? 'ماسح الباركود' : 'Barcode Scanner';
  String get scanAndOrder => locale.languageCode == 'ar' ? 'امسح واطلب' : 'Scan & order';
  String get prescription => locale.languageCode == 'ar' ? 'الوصفة الطبية' : 'Prescription';
  String get uploadAndOrder => locale.languageCode == 'ar' ? 'رفع وطلب' : 'Upload & order';
  String get categories => locale.languageCode == 'ar' ? 'الفئات' : 'Categories';
  String get all => locale.languageCode == 'ar' ? 'الكل' : 'All';
  String get popularProducts => locale.languageCode == 'ar' ? 'المنتجات الشائعة' : 'Popular Products';
  String get specialOffers => locale.languageCode == 'ar' ? 'عروض خاصة' : 'Special Offers';
  String get seeAll => locale.languageCode == 'ar' ? 'عرض الكل' : 'See all';
  String get redeemXPPoints => locale.languageCode == 'ar' ? 'استبدال نقاط الخبرة' : 'Redeem XP Points';
  String yourXP(int xp) => locale.languageCode == 'ar' ? 'نقاطك: $xp' : 'Your XP: $xp';
  String get availableRedemptions => locale.languageCode == 'ar' ? 'الاستبدالات المتاحة' : 'Available Redemptions';
  String get redeem => locale.languageCode == 'ar' ? 'استبدال' : 'Redeem';
  String get insufficientXP => locale.languageCode == 'ar' ? 'نقاط غير كافية' : 'Insufficient XP';
  String get redemptionSuccessful => locale.languageCode == 'ar' ? 'تم الاستبدال بنجاح!' : 'Redemption successful!';
  String get redemptionFailed => locale.languageCode == 'ar' ? 'فشل الاستبدال. يرجى المحاولة مرة أخرى.' : 'Redemption failed. Please try again.';
  String get viewRedemptions => locale.languageCode == 'ar' ? 'عرض الاستبدالات' : 'View Redemptions';
  String percentOffOrder(int percent) => locale.languageCode == 'ar' ? 'خصم $percent% على الطلب' : '$percent% Off Order';
  String getPercentDiscount(int percent) => locale.languageCode == 'ar' ? 'احصل على خصم $percent% على طلبك القادم' : 'Get $percent% discount on your next order';
  String freeProduct(String productName) => locale.languageCode == 'ar' ? '$productName مجاني' : 'Free $productName';
  String redeemFreeProduct(String productName) => locale.languageCode == 'ar' ? 'استبدل $productName مجاناً' : 'Redeem a free $productName';
  String get freeDelivery => locale.languageCode == 'ar' ? 'توصيل مجاني' : 'Free Delivery';
  String get freeDeliveryDesc => locale.languageCode == 'ar' ? 'توصيل مجاني على طلبك القادم' : 'Free delivery on your next order';
  
  // Achievements
  String get achievementProgress => locale.languageCode == 'ar' ? 'تقدم الإنجازات' : 'Achievement Progress';
  String get noAchievementsYet => locale.languageCode == 'ar' ? 'لا توجد إنجازات بعد' : 'No achievements yet';
  String get xp => locale.languageCode == 'ar' ? 'نقاط الخبرة' : 'XP';
  
  // Activity Level
  String get activityLevel => locale.languageCode == 'ar' ? 'مستوى النشاط' : 'Activity Level';
  
  // Categories
  String get painRelief => locale.languageCode == 'ar' ? 'مسكنات الألم' : 'Pain Relief';
  String get coldAndFlu => locale.languageCode == 'ar' ? 'نزلات البرد والإنفلونزا' : 'Cold & Flu';
  String get vitamins => locale.languageCode == 'ar' ? 'الفيتامينات' : 'Vitamins';
  String get herbal => locale.languageCode == 'ar' ? 'عشبي' : 'Herbal';
  String get antiseptic => locale.languageCode == 'ar' ? 'مطهر' : 'Antiseptic';
  String get cough => locale.languageCode == 'ar' ? 'السعال' : 'Cough';
  
  // Features
  String get workout => locale.languageCode == 'ar' ? 'تمرين' : 'Workout';
  String get nutrition => locale.languageCode == 'ar' ? 'التغذية' : 'Nutrition';
  String get appointments => locale.languageCode == 'ar' ? 'المواعيد' : 'Appointments';
  
  // Legal
  String get privacyPolicy => locale.languageCode == 'ar' ? 'سياسة الخصوصية' : 'Privacy Policy';
  String get termsOfService => locale.languageCode == 'ar' ? 'شروط الخدمة' : 'Terms of Service';
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) => ['en', 'ar'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    return AppLocalizations(locale);
  }

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

