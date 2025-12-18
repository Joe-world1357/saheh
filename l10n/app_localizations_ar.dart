// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Arabic (`ar`).
class AppLocalizationsAr extends AppLocalizations {
  AppLocalizationsAr([String locale = 'ar']) : super(locale);

  @override
  String get appName => 'صحيح';

  @override
  String appVersion(String version) {
    return 'الإصدار $version';
  }

  @override
  String get home => 'الرئيسية';

  @override
  String get profile => 'الملف الشخصي';

  @override
  String get settings => 'الإعدادات';

  @override
  String get pharmacy => 'الصيدلية';

  @override
  String get notifications => 'الإشعارات';

  @override
  String get achievements => 'الإنجازات';

  @override
  String get editPersonalInfo => 'تعديل المعلومات الشخصية';

  @override
  String get notificationSettings => 'إعدادات الإشعارات';

  @override
  String get fitnessReminders => 'تذكيرات اللياقة البدنية';

  @override
  String get fitnessRemindersDesc => 'تذكيرات التمارين اليومية';

  @override
  String get waterReminders => 'تذكيرات شرب الماء';

  @override
  String get waterRemindersDesc => 'تذكيرات لشرب الماء طوال اليوم';

  @override
  String get sleepReminders => 'تذكيرات النوم';

  @override
  String get sleepRemindersDesc => 'تذكيرات وقت النوم بناءً على هدف نومك';

  @override
  String get nutritionReminders => 'تذكيرات التغذية';

  @override
  String get nutritionRemindersDesc => 'تذكيرات تسجيل الوجبات وأهداف التغذية';

  @override
  String get xpNotifications => 'نقاط الخبرة المكتسبة';

  @override
  String get xpNotificationsDesc => 'إشعارات عند كسب نقاط الخبرة والترقية';

  @override
  String get achievementNotifications => 'إنجاز تم إلغاء قفله';

  @override
  String get achievementNotificationsDesc => 'إشعارات عند إلغاء قفل الإنجازات';

  @override
  String get save => 'حفظ';

  @override
  String get cancel => 'إلغاء';

  @override
  String get close => 'إغلاق';

  @override
  String get confirm => 'تأكيد';

  @override
  String get delete => 'حذف';

  @override
  String get edit => 'تعديل';

  @override
  String get add => 'إضافة';

  @override
  String get search => 'بحث';

  @override
  String get filter => 'تصفية';

  @override
  String get loading => 'جاري التحميل...';

  @override
  String get error => 'خطأ';

  @override
  String get success => 'نجح';

  @override
  String get retry => 'إعادة المحاولة';

  @override
  String get noData => 'لا توجد بيانات متاحة';

  @override
  String get fullName => 'الاسم الكامل';

  @override
  String get email => 'البريد الإلكتروني';

  @override
  String get phone => 'رقم الهاتف';

  @override
  String get age => 'العمر';

  @override
  String get gender => 'الجنس';

  @override
  String get height => 'الطول (سم)';

  @override
  String get weight => 'الوزن (كجم)';

  @override
  String get address => 'العنوان';

  @override
  String get male => 'ذكر';

  @override
  String get female => 'أنثى';

  @override
  String get saveChanges => 'حفظ التغييرات';

  @override
  String get noChangesMade => 'لم يتم إجراء أي تغييرات';

  @override
  String get personalInformationUpdated => 'تم تحديث المعلومات الشخصية بنجاح';

  @override
  String errorUpdatingInformation(String error) {
    return 'خطأ في تحديث المعلومات: $error';
  }

  @override
  String get enterYourFullName => 'أدخل اسمك الكامل';

  @override
  String get enterYourEmail => 'أدخل عنوان بريدك الإلكتروني';

  @override
  String get enterYourPhone => 'أدخل رقم هاتفك';

  @override
  String get enterAge => 'أدخل العمر';

  @override
  String get enterHeight => 'أدخل الطول';

  @override
  String get enterWeight => 'أدخل الوزن';

  @override
  String get enterYourAddress => 'أدخل عنوانك';

  @override
  String get pleaseSelectGender => 'الرجاء اختيار الجنس';

  @override
  String get redeemXPPoints => 'استبدال نقاط الخبرة';

  @override
  String yourXP(int xp) {
    return 'نقاطك: $xp';
  }

  @override
  String get availableRedemptions => 'الاستبدالات المتاحة';

  @override
  String get redeem => 'استبدال';

  @override
  String get insufficientXP => 'نقاط غير كافية';

  @override
  String get redemptionSuccessful => 'تم الاستبدال بنجاح!';

  @override
  String get redemptionFailed => 'فشل الاستبدال. يرجى المحاولة مرة أخرى.';

  @override
  String get achievementProgress => 'تقدم الإنجازات';

  @override
  String get noAchievementsYet => 'لا توجد إنجازات بعد';

  @override
  String get unlocked => 'مفتوح';

  @override
  String get locked => 'مقفل';

  @override
  String get xp => 'نقاط الخبرة';

  @override
  String get level => 'المستوى';

  @override
  String get levelUp => 'ترقية المستوى!';

  @override
  String youReachedLevel(int level) {
    return 'لقد وصلت إلى المستوى $level! استمر!';
  }

  @override
  String youEarnedXP(int amount, int total) {
    return 'لقد ربحت $amount نقطة خبرة! الإجمالي: $total نقطة';
  }

  @override
  String get achievementUnlocked => 'تم إلغاء قفل الإنجاز!';

  @override
  String get goalCompleted => 'تم إكمال الهدف!';

  @override
  String congratulationsYouCompleted(String goalName) {
    return 'تهانينا! لقد أكملت: $goalName';
  }

  @override
  String get notificationsEnabled => 'الإشعارات مفعلة';

  @override
  String get notificationsDisabled => 'الإشعارات معطلة';

  @override
  String get youWillReceiveNotifications =>
      'ستتلقى إشعارات للتذكيرات والإنجازات';

  @override
  String get enableNotificationsToReceive =>
      'قم بتمكين الإشعارات لتلقي التذكيرات والتحديثات';

  @override
  String get enableNotifications => 'تمكين الإشعارات';

  @override
  String get permissionRequired => 'إذن مطلوب';

  @override
  String get notificationsAreDisabled =>
      'الإشعارات معطلة. يرجى تمكينها في إعدادات التطبيق.';

  @override
  String get openSettings => 'فتح الإعدادات';

  @override
  String get language => 'اللغة';

  @override
  String get english => 'الإنجليزية';

  @override
  String get arabic => 'العربية';

  @override
  String get theme => 'المظهر';

  @override
  String get light => 'خفيف';

  @override
  String get dark => 'داكن';

  @override
  String get system => 'النظام';

  @override
  String get about => 'حول';

  @override
  String get privacyPolicy => 'سياسة الخصوصية';

  @override
  String get termsOfService => 'شروط الخدمة';

  @override
  String get contactSupport => 'اتصل بالدعم';

  @override
  String get logout => 'تسجيل الخروج';

  @override
  String get login => 'تسجيل الدخول';

  @override
  String get register => 'التسجيل';

  @override
  String get password => 'كلمة المرور';

  @override
  String get confirmPassword => 'تأكيد كلمة المرور';

  @override
  String get forgotPassword => 'نسيت كلمة المرور؟';

  @override
  String get dontHaveAccount => 'ليس لديك حساب؟';

  @override
  String get alreadyHaveAccount => 'لديك حساب بالفعل؟';

  @override
  String get workout => 'تمرين';

  @override
  String get nutrition => 'التغذية';

  @override
  String get medications => 'الأدوية';

  @override
  String get appointments => 'المواعيد';

  @override
  String get healthTracking => 'تتبع الصحة';

  @override
  String get waterIntake => 'استهلاك الماء';

  @override
  String get sleep => 'النوم';

  @override
  String get steps => 'الخطوات';

  @override
  String get calories => 'السعرات الحرارية';

  @override
  String get today => 'اليوم';

  @override
  String get thisWeek => 'هذا الأسبوع';

  @override
  String get thisMonth => 'هذا الشهر';

  @override
  String get seeAll => 'عرض الكل';

  @override
  String get popularProducts => 'المنتجات الشائعة';

  @override
  String get specialOffers => 'عروض خاصة';

  @override
  String get viewRedemptions => 'عرض الاستبدالات';

  @override
  String get discount => 'خصم';

  @override
  String get product => 'منتج';

  @override
  String get service => 'خدمة';

  @override
  String get freeDelivery => 'توصيل مجاني';

  @override
  String get freeDeliveryDesc => 'توصيل مجاني على طلبك القادم';

  @override
  String percentOffOrder(int percent) {
    return 'خصم $percent% على الطلب';
  }

  @override
  String getPercentDiscount(int percent) {
    return 'احصل على خصم $percent% على طلبك القادم';
  }

  @override
  String freeProduct(String productName) {
    return '$productName مجاني';
  }

  @override
  String redeemFreeProduct(String productName) {
    return 'استبدل $productName مجاناً';
  }

  @override
  String get activityLevel => 'مستوى النشاط';

  @override
  String get sedentary => 'قليل الحركة';

  @override
  String get moderate => 'معتدل';

  @override
  String get active => 'نشط';

  @override
  String get veryActive => 'نشط جداً';

  @override
  String get searchMedicines => 'ابحث عن الأدوية، الفئات...';

  @override
  String get barcodeScanner => 'ماسح الباركود';

  @override
  String get scanAndOrder => 'امسح واطلب';

  @override
  String get prescription => 'الوصفة الطبية';

  @override
  String get uploadAndOrder => 'رفع وطلب';

  @override
  String get categories => 'الفئات';

  @override
  String get all => 'الكل';

  @override
  String get painRelief => 'مسكنات الألم';

  @override
  String get coldAndFlu => 'نزلات البرد والإنفلونزا';

  @override
  String get vitamins => 'الفيتامينات';

  @override
  String get herbal => 'عشبي';

  @override
  String get antiseptic => 'مطهر';

  @override
  String get cough => 'السعال';

  @override
  String get myCart => 'سلة التسوق';
}
