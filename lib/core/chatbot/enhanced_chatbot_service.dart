import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';
import '../../models/meal_model.dart';
import '../../models/workout_model.dart';
import '../../models/nutrition_goal_model.dart';
import '../../database/database_helper.dart';
import '../../core/services/xp_service.dart';
import '../../core/localization/app_localizations.dart';

/// Chatbot Intent Classification
enum ChatIntent {
  greeting,
  nutrition,
  fitness,
  medication,
  sleep,
  hydration,
  xp,
  achievements,
  appFeatures,
  healthTips,
  weightManagement,
  stress,
  generalHealth,
  offTopic,
}

/// Conversation Context
class ConversationContext {
  final List<String> recentIntents;
  final Map<String, dynamic> userState;
  final DateTime lastInteraction;
  
  ConversationContext({
    List<String>? recentIntents,
    Map<String, dynamic>? userState,
    DateTime? lastInteraction,
  }) : recentIntents = recentIntents ?? [],
       userState = userState ?? {},
       lastInteraction = lastInteraction ?? DateTime.now();
  
  ConversationContext addIntent(String intent) {
    final updated = List<String>.from(recentIntents);
    updated.add(intent);
    if (updated.length > 5) updated.removeAt(0);
    return ConversationContext(
      recentIntents: updated,
      userState: userState,
      lastInteraction: DateTime.now(),
    );
  }
}

/// Enhanced Chatbot Service
class EnhancedChatbotService {
  final DatabaseHelper _db = DatabaseHelper.instance;
  ConversationContext _context = ConversationContext();
  
  /// Main response generation method
  Future<String> generateResponse({
    required String query,
    required String userEmail,
    required String language, // 'en' or 'ar'
    UserModel? user,
    List<MealModel>? todayMeals,
    NutritionGoalModel? nutritionGoal,
    List<WorkoutModel>? recentWorkouts,
    int? waterIntake,
    int? waterGoal,
    double? sleepHours,
  }) async {
    final lowerQuery = query.toLowerCase().trim();
    final isArabic = language == 'ar';
    
    // Classify intent
    final intent = _classifyIntent(lowerQuery, isArabic);
    
    // Update context
    _context = _context.addIntent(intent.name);
    
    // Validate query relevance
    if (intent == ChatIntent.offTopic) {
      return _getOffTopicResponse(isArabic);
    }
    
    // Load user data if not provided
    if (user == null) {
      user = await _db.getUserByEmail(userEmail);
    }
    
    // Generate contextual response based on intent
    switch (intent) {
      case ChatIntent.greeting:
        return _handleGreeting(user, isArabic);
      
      case ChatIntent.nutrition:
        return await _handleNutrition(
          query: lowerQuery,
          userEmail: userEmail,
          user: user,
          todayMeals: todayMeals,
          nutritionGoal: nutritionGoal,
          isArabic: isArabic,
        );
      
      case ChatIntent.fitness:
        return await _handleFitness(
          query: lowerQuery,
          user: user,
          recentWorkouts: recentWorkouts,
          isArabic: isArabic,
        );
      
      case ChatIntent.medication:
        return await _handleMedication(
          query: lowerQuery,
          userEmail: userEmail,
          isArabic: isArabic,
        );
      
      case ChatIntent.sleep:
        return _handleSleep(query: lowerQuery, sleepHours: sleepHours, isArabic: isArabic);
      
      case ChatIntent.hydration:
        return _handleHydration(
          query: lowerQuery,
          waterIntake: waterIntake,
          waterGoal: waterGoal,
          isArabic: isArabic,
        );
      
      case ChatIntent.xp:
        return _handleXP(user: user, isArabic: isArabic);
      
      case ChatIntent.achievements:
        return await _handleAchievements(userEmail: userEmail, isArabic: isArabic);
      
      case ChatIntent.appFeatures:
        return _handleAppFeatures(isArabic: isArabic);
      
      case ChatIntent.healthTips:
        return _handleHealthTips(user: user, isArabic: isArabic);
      
      case ChatIntent.weightManagement:
        return _handleWeightManagement(query: lowerQuery, user: user, isArabic: isArabic);
      
      case ChatIntent.stress:
        return _handleStress(isArabic: isArabic);
      
      case ChatIntent.generalHealth:
        return _handleGeneralHealth(user: user, isArabic: isArabic);
      
      default:
        return _getDefaultResponse(isArabic);
    }
  }
  
  /// Intent Classification using keyword matching and context
  ChatIntent _classifyIntent(String query, bool isArabic) {
    // Arabic keywords
    if (isArabic) {
      if (_matchesAny(query, ['مرحبا', 'السلام', 'أهلا', 'صباح', 'مساء'])) {
        return ChatIntent.greeting;
      }
      if (_matchesAny(query, ['طعام', 'أكل', 'وجبة', 'سعرات', 'بروتين', 'كارب', 'دهون', 'تغذية', 'نظام غذائي'])) {
        return ChatIntent.nutrition;
      }
      if (_matchesAny(query, ['تمرين', 'رياضة', 'لياقة', 'جيم', 'كارديو', 'عضلات'])) {
        return ChatIntent.fitness;
      }
      if (_matchesAny(query, ['دواء', 'دواء', 'حبة', 'جرعة', 'تذكير'])) {
        return ChatIntent.medication;
      }
      if (_matchesAny(query, ['نوم', 'نائم', 'إرهاق', 'راحة'])) {
        return ChatIntent.sleep;
      }
      if (_matchesAny(query, ['ماء', 'شرب', 'ترطيب', 'عطش'])) {
        return ChatIntent.hydration;
      }
      if (_matchesAny(query, ['نقاط', 'خبرة', 'xp', 'مستوى', 'ترقية'])) {
        return ChatIntent.xp;
      }
      if (_matchesAny(query, ['إنجاز', 'إنجازات'])) {
        return ChatIntent.achievements;
      }
      if (_matchesAny(query, ['تطبيق', 'ميزة', 'كيف', 'استخدام'])) {
        return ChatIntent.appFeatures;
      }
      if (_matchesAny(query, ['وزن', 'bmi', 'نحيف', 'سمين'])) {
        return ChatIntent.weightManagement;
      }
      if (_matchesAny(query, ['توتر', 'قلق', 'ضغط', 'استرخاء'])) {
        return ChatIntent.stress;
      }
      if (_matchesAny(query, ['صحة', 'نصيحة', 'نصائح', 'صحي'])) {
        return ChatIntent.healthTips;
      }
    }
    
    // English keywords
    if (_matchesAny(query, ['hello', 'hi', 'hey', 'good morning', 'good afternoon', 'good evening'])) {
      return ChatIntent.greeting;
    }
    if (_matchesAny(query, ['food', 'eat', 'meal', 'calorie', 'protein', 'carb', 'fat', 'nutrition', 'diet', 'breakfast', 'lunch', 'dinner'])) {
      return ChatIntent.nutrition;
    }
    if (_matchesAny(query, ['workout', 'exercise', 'fitness', 'gym', 'cardio', 'muscle', 'strength', 'training', 'run'])) {
      return ChatIntent.fitness;
    }
    if (_matchesAny(query, ['medicine', 'medication', 'pill', 'drug', 'dose', 'reminder', 'prescription'])) {
      return ChatIntent.medication;
    }
    if (_matchesAny(query, ['sleep', 'rest', 'insomnia', 'tired', 'fatigue', 'bedtime'])) {
      return ChatIntent.sleep;
    }
    if (_matchesAny(query, ['water', 'hydration', 'drink', 'thirst', 'fluid'])) {
      return ChatIntent.hydration;
    }
    if (_matchesAny(query, ['xp', 'points', 'level', 'experience', 'level up'])) {
      return ChatIntent.xp;
    }
    if (_matchesAny(query, ['achievement', 'achievements', 'unlock', 'badge'])) {
      return ChatIntent.achievements;
    }
    if (_matchesAny(query, ['app', 'feature', 'how to', 'use', 'sehati', 'saheeh', 'help'])) {
      return ChatIntent.appFeatures;
    }
    if (_matchesAny(query, ['weight', 'bmi', 'lose', 'gain', 'slim', 'overweight'])) {
      return ChatIntent.weightManagement;
    }
    if (_matchesAny(query, ['stress', 'anxiety', 'relax', 'calm', 'mental'])) {
      return ChatIntent.stress;
    }
    if (_matchesAny(query, ['health', 'healthy', 'tip', 'advice', 'recommend', 'suggest'])) {
      return ChatIntent.healthTips;
    }
    
    // Check context for follow-up questions
    if (_context.recentIntents.isNotEmpty) {
      final lastIntent = _context.recentIntents.last;
      if (query.contains('more') || query.contains('tell me') || query.contains('explain')) {
        return ChatIntent.values.firstWhere(
          (e) => e.name == lastIntent,
          orElse: () => ChatIntent.generalHealth,
        );
      }
    }
    
    // Default to general health if health-related keywords found
    if (_isHealthRelated(query)) {
      return ChatIntent.generalHealth;
    }
    
    return ChatIntent.offTopic;
  }
  
  bool _matchesAny(String query, List<String> keywords) {
    return keywords.any((keyword) => query.contains(keyword));
  }
  
  bool _isHealthRelated(String query) {
    final healthKeywords = [
      'health', 'wellness', 'medical', 'doctor', 'symptom', 'pain', 'ache',
      'صحة', 'طبي', 'طبيب', 'ألم', 'عرض'
    ];
    return healthKeywords.any((keyword) => query.contains(keyword));
  }
  
  // Intent Handlers
  String _handleGreeting(UserModel? user, bool isArabic) {
    final userName = user?.name?.split(' ').first ?? (isArabic ? 'هناك' : 'there');
    final hour = DateTime.now().hour;
    
    String timeGreeting;
    if (isArabic) {
      timeGreeting = hour < 12 ? 'صباح الخير' : (hour < 17 ? 'مساء الخير' : 'مساء الخير');
    } else {
      timeGreeting = hour < 12 ? 'Good morning' : (hour < 17 ? 'Good afternoon' : 'Good evening');
    }
    
    if (isArabic) {
      return '$timeGreeting، $userName! 👋\n\n'
          'أنا مساعدك الصحي الذكي. يمكنني مساعدتك في:\n\n'
          '• 🥗 التغذية والنظام الغذائي\n'
          '• 💪 التمارين واللياقة البدنية\n'
          '• 💊 إدارة الأدوية\n'
          '• 💧 الترطيب والماء\n'
          '• 😴 النوم والعافية\n'
          '• ⭐ نقاط الخبرة والإنجازات\n\n'
          'كيف يمكنني مساعدتك اليوم؟';
    }
    
    return '$timeGreeting, $userName! 👋\n\n'
        'I\'m your intelligent health assistant. I can help you with:\n\n'
        '• 🥗 Nutrition & diet planning\n'
        '• 💪 Fitness & workouts\n'
        '• 💊 Medication management\n'
        '• 💧 Hydration tracking\n'
        '• 😴 Sleep & wellness\n'
        '• ⭐ XP & achievements\n\n'
        'How can I assist you today?';
  }
  
  Future<String> _handleNutrition({
    required String query,
    required String userEmail,
    UserModel? user,
    List<MealModel>? todayMeals,
    NutritionGoalModel? nutritionGoal,
    required bool isArabic,
  }) async {
    // Load data if not provided
    if (todayMeals == null) {
      final today = DateTime.now();
      todayMeals = await _db.getMealsByDate(today, userEmail: userEmail);
    }
    if (nutritionGoal == null) {
      nutritionGoal = await _db.getNutritionGoal(userEmail);
    }
    
    final caloriesConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.calories);
    final proteinConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.protein);
    final carbsConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.carbs);
    final fatConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.fat);
    
    final caloriesGoal = nutritionGoal?.caloriesGoal ?? 2000.0;
    final proteinGoal = nutritionGoal?.proteinGoal ?? 150.0;
    final carbsGoal = nutritionGoal?.carbsGoal ?? 250.0;
    final fatGoal = nutritionGoal?.fatGoal ?? 65.0;
    
    final caloriesRemaining = (caloriesGoal - caloriesConsumed).clamp(0.0, double.infinity);
    final proteinRemaining = (proteinGoal - proteinConsumed).clamp(0.0, double.infinity);
    
    // Generate personalized response
    if (query.contains('today') || query.contains('اليوم')) {
      if (isArabic) {
        return '📊 **تغذيتك اليوم:**\n\n'
            '🔥 السعرات: ${caloriesConsumed.toStringAsFixed(0)} / ${caloriesGoal.toStringAsFixed(0)} سعرة\n'
            '🥩 البروتين: ${proteinConsumed.toStringAsFixed(1)} / ${proteinGoal.toStringAsFixed(1)} جم\n'
            '🍞 الكربوهيدرات: ${carbsConsumed.toStringAsFixed(1)} / ${carbsGoal.toStringAsFixed(1)} جم\n'
            '🥑 الدهون: ${fatConsumed.toStringAsFixed(1)} / ${fatGoal.toStringAsFixed(1)} جم\n\n'
            '${caloriesRemaining > 0 ? "✅ متبقي: ${caloriesRemaining.toStringAsFixed(0)} سعرة" : "⚠️ تجاوزت هدفك اليوم"}\n\n'
            '💡 **اقتراح:** ${caloriesRemaining > 500 ? "يمكنك إضافة وجبة خفيفة صحية" : caloriesRemaining > 0 ? "وجبة عشاء خفيفة" : "ركز على البروتين والخضروات"}\n\n'
            '📝 سجل وجباتك في قسم التغذية!';
      }
      
      return '📊 **Your Nutrition Today:**\n\n'
          '🔥 Calories: ${caloriesConsumed.toStringAsFixed(0)} / ${caloriesGoal.toStringAsFixed(0)} kcal\n'
          '🥩 Protein: ${proteinConsumed.toStringAsFixed(1)} / ${proteinGoal.toStringAsFixed(1)}g\n'
          '🍞 Carbs: ${carbsConsumed.toStringAsFixed(1)} / ${carbsGoal.toStringAsFixed(1)}g\n'
          '🥑 Fats: ${fatConsumed.toStringAsFixed(1)} / ${fatGoal.toStringAsFixed(1)}g\n\n'
          '${caloriesRemaining > 0 ? "✅ Remaining: ${caloriesRemaining.toStringAsFixed(0)} kcal" : "⚠️ You\'ve exceeded your goal today"}\n\n'
          '💡 **Suggestion:** ${caloriesRemaining > 500 ? "You can add a healthy snack" : caloriesRemaining > 0 ? "Light dinner recommended" : "Focus on protein and vegetables"}\n\n'
          '📝 Log your meals in the Nutrition section!';
    }
    
    // General nutrition advice
    if (isArabic) {
      return '🥗 **نصائح التغذية الشخصية:**\n\n'
          '**هدفك اليومي:**\n'
          '• السعرات: ${caloriesGoal.toStringAsFixed(0)} سعرة\n'
          '• البروتين: ${proteinGoal.toStringAsFixed(0)} جم\n'
          '• الكربوهيدرات: ${carbsGoal.toStringAsFixed(0)} جم\n'
          '• الدهون: ${fatGoal.toStringAsFixed(0)} جم\n\n'
          '**وجبات اليوم:** ${todayMeals.length} وجبة\n\n'
          '💡 **اقتراحات:**\n'
          '${proteinConsumed < proteinGoal * 0.7 ? "• أضف المزيد من البروتين (دجاج، سمك، بيض)\n" : ""}'
          '${carbsConsumed < carbsGoal * 0.7 ? "• تناول الكربوهيدرات المعقدة (أرز بني، شوفان)\n" : ""}'
          '• اشرب الماء قبل الوجبات\n'
          '• تناول الخضروات مع كل وجبة\n\n'
          '📝 سجل وجباتك للحصول على نقاط الخبرة!';
    }
    
    return '🥗 **Personalized Nutrition Advice:**\n\n'
        '**Your Daily Goals:**\n'
        '• Calories: ${caloriesGoal.toStringAsFixed(0)} kcal\n'
        '• Protein: ${proteinGoal.toStringAsFixed(0)}g\n'
        '• Carbs: ${carbsGoal.toStringAsFixed(0)}g\n'
        '• Fats: ${fatGoal.toStringAsFixed(0)}g\n\n'
        '**Today\'s Meals:** ${todayMeals.length} meals logged\n\n'
        '💡 **Suggestions:**\n'
        '${proteinConsumed < proteinGoal * 0.7 ? "• Add more protein (chicken, fish, eggs)\n" : ""}'
        '${carbsConsumed < carbsGoal * 0.7 ? "• Include complex carbs (brown rice, oats)\n" : ""}'
        '• Drink water before meals\n'
        '• Include vegetables with every meal\n\n'
        '📝 Log your meals to earn XP!';
  }
  
  Future<String> _handleFitness({
    required String query,
    UserModel? user,
    List<WorkoutModel>? recentWorkouts,
    required bool isArabic,
  }) async {
    final workoutCount = recentWorkouts?.length ?? 0;
    
    if (query.contains('today') || query.contains('اليوم')) {
      if (isArabic) {
        return '💪 **تمارينك اليوم:**\n\n'
            '${workoutCount > 0 ? "✅ أكملت $workoutCount تمرين اليوم!\n\n" : "⚠️ لم تسجل أي تمرين بعد\n\n"}'
            '💡 **اقتراح:** ${workoutCount == 0 ? "ابدأ بتمرين خفيف لمدة 20 دقيقة" : "رائع! يمكنك إضافة تمرين كارديو"}\n\n'
            '📝 سجل تمارينك في قسم اللياقة!';
      }
      
      return '💪 **Your Workouts Today:**\n\n'
          '${workoutCount > 0 ? "✅ You completed $workoutCount workout(s) today!\n\n" : "⚠️ No workouts logged yet\n\n"}'
          '💡 **Suggestion:** ${workoutCount == 0 ? "Start with a light 20-minute workout" : "Great! You can add a cardio session"}\n\n'
          '📝 Log your workouts in the Fitness section!';
    }
    
    // General fitness advice
    if (isArabic) {
      return '💪 **نصائح اللياقة البدنية:**\n\n'
          '**الهدف الأسبوعي:** 3-5 جلسات تمرين\n\n'
          '**أنواع التمارين:**\n'
          '• القوة: 2-3 مرات/أسبوع\n'
          '• الكارديو: 2-3 مرات/أسبوع\n'
          '• المرونة: يومياً\n\n'
          '💡 **اقتراحات:**\n'
          '• ابدأ بتمارين الإحماء (5-10 دقائق)\n'
          '• ركز على الشكل الصحيح قبل الكثافة\n'
          '• استرح يوم بين جلسات القوة\n'
          '• سجل تمارينك لتحصل على نقاط الخبرة!\n\n'
          '📝 استخدم قسم اللياقة لتتبع تقدمك!';
    }
    
    return '💪 **Fitness Recommendations:**\n\n'
        '**Weekly Goal:** 3-5 workout sessions\n\n'
        '**Workout Types:**\n'
        '• Strength: 2-3x/week\n'
        '• Cardio: 2-3x/week\n'
        '• Flexibility: Daily\n\n'
        '💡 **Tips:**\n'
        '• Start with warm-up (5-10 min)\n'
        '• Focus on form before intensity\n'
        '• Rest day between strength sessions\n'
        '• Log workouts to earn XP!\n\n'
        '📝 Use the Fitness section to track progress!';
  }
  
  Future<String> _handleMedication({
    required String query,
    required String userEmail,
    required bool isArabic,
  }) async {
    final reminders = await _db.getAllMedicineReminders(userEmail: userEmail);
    final activeReminders = reminders.where((r) => r.isActive).toList();
    
    if (isArabic) {
      return '💊 **أدويتك:**\n\n'
          '${activeReminders.isEmpty ? "⚠️ لا توجد تذكيرات دواء نشطة\n\n" : "✅ لديك ${activeReminders.length} دواء نشط\n\n"}'
          '💡 **اقتراح:** ${activeReminders.isEmpty ? "أضف دواء في قسم الصحة" : "تأكد من تناول الأدوية في الوقت المحدد"}\n\n'
          '📝 إدارة الأدوية في قسم الصحة!';
    }
    
    return '💊 **Your Medications:**\n\n'
        '${activeReminders.isEmpty ? "⚠️ No active medication reminders\n\n" : "✅ You have ${activeReminders.length} active medication(s)\n\n"}'
        '💡 **Suggestion:** ${activeReminders.isEmpty ? "Add medication in Health section" : "Make sure to take medications on time"}\n\n'
        '📝 Manage medications in Health section!';
  }
  
  String _handleSleep({required String query, double? sleepHours, required bool isArabic}) {
    final recommended = 7.5;
    final current = sleepHours ?? 0;
    
    if (isArabic) {
      return '😴 **نومك:**\n\n'
          '${current > 0 ? "⏰ ساعات النوم: ${current.toStringAsFixed(1)} ساعة\n" : "⚠️ لم تسجل نومك بعد\n"}'
          '🎯 الموصى به: $recommended ساعات\n\n'
          '💡 **نصائح:**\n'
          '• نم في نفس الوقت كل ليلة\n'
          '• لا تستخدم الشاشات قبل النوم بساعة\n'
          '• حافظ على غرفة مظلمة وباردة\n'
          '• تجنب الكافيين بعد 2 مساءً\n\n'
          '📝 سجل نومك في قسم الصحة!';
    }
    
    return '😴 **Your Sleep:**\n\n'
        '${current > 0 ? "⏰ Sleep Hours: ${current.toStringAsFixed(1)} hours\n" : "⚠️ No sleep logged yet\n"}'
        '🎯 Recommended: $recommended hours\n\n'
        '💡 **Tips:**\n'
        '• Sleep at the same time every night\n'
        '• No screens 1 hour before bed\n'
        '• Keep room dark and cool\n'
        '• Avoid caffeine after 2 PM\n\n'
        '📝 Log sleep in Health section!';
  }
  
  String _handleHydration({
    required String query,
    int? waterIntake,
    int? waterGoal,
    required bool isArabic,
  }) {
    final intake = waterIntake ?? 0;
    final goal = waterGoal ?? 2000;
    final remaining = (goal - intake).clamp(0, goal);
    final percentage = goal > 0 ? (intake / goal * 100).clamp(0, 100) : 0;
    
    if (isArabic) {
      return '💧 **ترطيبك:**\n\n'
          '📊 شربت: ${intake}ml / ${goal}ml\n'
          '📈 التقدم: ${percentage.toStringAsFixed(0)}%\n'
          '${remaining > 0 ? "✅ متبقي: ${remaining}ml\n\n" : "🎉 أكملت هدفك اليوم!\n\n"}'
          '💡 **اقتراح:** ${remaining > 500 ? "اشرب كوب ماء الآن" : remaining > 0 ? "أنت على الطريق الصحيح" : "حافظ على الترطيب طوال اليوم"}\n\n'
          '📝 تتبع الماء في قسم الصحة!';
    }
    
    return '💧 **Your Hydration:**\n\n'
        '📊 Drank: ${intake}ml / ${goal}ml\n'
        '📈 Progress: ${percentage.toStringAsFixed(0)}%\n'
        '${remaining > 0 ? "✅ Remaining: ${remaining}ml\n\n" : "🎉 Goal completed!\n\n"}'
        '💡 **Suggestion:** ${remaining > 500 ? "Drink a glass of water now" : remaining > 0 ? "You\'re on track" : "Stay hydrated throughout the day"}\n\n'
        '📝 Track water in Health section!';
  }
  
  String _handleXP({UserModel? user, required bool isArabic}) {
    final xp = user?.xp ?? 0;
    final level = user?.level ?? 1;
    final xpForNextLevel = XPService.xpForNextLevel(level, xp);
    
    if (isArabic) {
      return '⭐ **نقاط الخبرة:**\n\n'
          '📊 النقاط الحالية: $xp XP\n'
          '🏆 المستوى: $level\n'
          '📈 متبقي للترقية: $xpForNextLevel XP\n\n'
          '💡 **كيف تكسب المزيد:**\n'
          '• سجل وجبة: +10 XP\n'
          '• أكمل تمرين: +25 XP\n'
          '• اشرب ماء: +2 XP\n'
          '• سجل نوم: +5 XP\n'
          '• أكمل هدف: +50 XP\n\n'
          '📝 استمر في استخدام التطبيق لكسب المزيد!';
    }
    
    return '⭐ **Your XP:**\n\n'
        '📊 Current Points: $xp XP\n'
        '🏆 Level: $level\n'
        '📈 XP to Next Level: $xpForNextLevel XP\n\n'
        '💡 **How to Earn More:**\n'
        '• Log meal: +10 XP\n'
        '• Complete workout: +25 XP\n'
        '• Drink water: +2 XP\n'
        '• Log sleep: +5 XP\n'
        '• Complete goal: +50 XP\n\n'
        '📝 Keep using the app to earn more!';
  }
  
  Future<String> _handleAchievements({required String userEmail, required bool isArabic}) async {
    final achievements = await _db.getAchievements(userEmail);
    final unlocked = achievements.where((a) => a.isUnlocked).length;
    final total = achievements.length;
    
    if (isArabic) {
      return '🏆 **إنجازاتك:**\n\n'
          '📊 الإنجازات: $unlocked / $total\n'
          '📈 التقدم: ${total > 0 ? ((unlocked / total) * 100).toStringAsFixed(0) : 0}%\n\n'
          '💡 **اقتراح:** ${unlocked < total * 0.5 ? "استمر في استخدام التطبيق لإلغاء قفل المزيد" : "رائع! أنت على الطريق الصحيح"}\n\n'
          '📝 شاهد جميع الإنجازات في ملفك الشخصي!';
    }
    
    return '🏆 **Your Achievements:**\n\n'
        '📊 Achievements: $unlocked / $total\n'
        '📈 Progress: ${total > 0 ? ((unlocked / total) * 100).toStringAsFixed(0) : 0}%\n\n'
        '💡 **Suggestion:** ${unlocked < total * 0.5 ? "Keep using the app to unlock more" : "Great! You\'re on the right track"}\n\n'
        '📝 View all achievements in your profile!';
  }
  
  String _handleAppFeatures({required bool isArabic}) {
    if (isArabic) {
      return '📱 **ميزات تطبيق صحيح:**\n\n'
          '🏠 **الصفحة الرئيسية:**\n'
          '• ملخص يومي شامل\n'
          '• وصول سريع لجميع الميزات\n'
          '• رؤى صحية ذكية\n\n'
          '💊 **إدارة الأدوية:**\n'
          '• تذكيرات تلقائية\n'
          '• تتبع التاريخ\n'
          '• طلب من الصيدلية\n\n'
          '🥗 **التغذية:**\n'
          '• سجل الوجبات\n'
          '• تتبع السعرات والماكرو\n'
          '• اقتراحات وجبات\n\n'
          '💪 **اللياقة:**\n'
          '• مكتبة التمارين\n'
          '• تتبع الأنشطة\n'
          '• مراقبة التقدم\n\n'
          '💧 **تتبع الصحة:**\n'
          '• الماء والنوم\n'
          '• الأهداف الصحية\n\n'
          '⭐ **نقاط الخبرة:**\n'
          '• اكسب XP للأنشطة\n'
          '• ترقيات المستوى\n'
          '• إنجازات\n\n'
          'ما الميزة التي تريد استكشافها؟';
    }
    
    return '📱 **Saheeh App Features:**\n\n'
        '🏠 **Home Dashboard:**\n'
        '• Complete daily summary\n'
        '• Quick access to all features\n'
        '• AI-powered health insights\n\n'
        '💊 **Medicine Management:**\n'
        '• Automatic reminders\n'
        '• History tracking\n'
        '• Pharmacy orders\n\n'
        '🥗 **Nutrition:**\n'
        '• Log meals\n'
        '• Track calories & macros\n'
        '• Meal suggestions\n\n'
        '💪 **Fitness:**\n'
        '• Workout library\n'
        '• Activity tracking\n'
        '• Progress monitoring\n\n'
        '💧 **Health Tracking:**\n'
        '• Water & sleep\n'
        '• Health goals\n\n'
        '⭐ **XP System:**\n'
        '• Earn XP for activities\n'
        '• Level ups\n'
        '• Achievements\n\n'
        'What feature would you like to explore?';
  }
  
  String _handleHealthTips({UserModel? user, required bool isArabic}) {
    if (isArabic) {
      return '🌟 **نصائح صحية شخصية:**\n\n'
          '☀️ **الصباح:**\n'
          '• اشرب الماء عند الاستيقاظ\n'
          '• تناول فطور متوازن\n'
          '• 10 دقائق تمارين خفيفة\n\n'
          '🌤️ **خلال اليوم:**\n'
          '• حافظ على الترطيب (8+ أكواب)\n'
          '• خذ فترات راحة للحركة\n'
          '• تناول وجبات متوازنة\n\n'
          '🌙 **المساء:**\n'
          '• عشاء خفيف قبل 3 ساعات من النوم\n'
          '• قلل وقت الشاشات\n'
          '• روتين استرخاء\n'
          '• 7-9 ساعات نوم جيد\n\n'
          '📝 تتبع تقدمك في التطبيق!';
    }
    
    return '🌟 **Personalized Health Tips:**\n\n'
        '☀️ **Morning:**\n'
        '• Drink water upon waking\n'
        '• Eat balanced breakfast\n'
        '• 10 min light exercise\n\n'
        '🌤️ **Throughout Day:**\n'
        '• Stay hydrated (8+ glasses)\n'
        '• Take movement breaks\n'
        '• Eat balanced meals\n\n'
        '🌙 **Evening:**\n'
        '• Light dinner 3 hours before bed\n'
        '• Limit screen time\n'
        '• Relaxation routine\n'
        '• 7-9 hours quality sleep\n\n'
        '📝 Track your progress in the app!';
  }
  
  String _handleWeightManagement({required String query, UserModel? user, required bool isArabic}) {
    final weight = user?.weight ?? 0;
    final height = user?.height ?? 0;
    
    if (weight > 0 && height > 0) {
      final bmi = weight / ((height / 100) * (height / 100));
      final bmiCategory = bmi < 18.5 ? 'Underweight' : 
                         bmi < 25 ? 'Normal' : 
                         bmi < 30 ? 'Overweight' : 'Obese';
      
      if (isArabic) {
        return '⚖️ **إدارة الوزن:**\n\n'
            '📊 مؤشر كتلة الجسم: ${bmi.toStringAsFixed(1)}\n'
            '📈 الفئة: $bmiCategory\n\n'
            '💡 **نصائح:**\n'
            '${bmi < 18.5 ? "• ركز على زيادة السعرات الصحية\n" : ""}'
            '${bmi >= 25 ? "• عجز 500 سعرة يومياً لفقدان الوزن\n" : ""}'
            '• بروتين عالي (يشعر بالشبع)\n'
            '• كارديو + تمارين القوة\n'
            '• نوم كافٍ (7-9 ساعات)\n\n'
            '📝 تتبع وزنك في ملفك الشخصي!';
      }
      
      return '⚖️ **Weight Management:**\n\n'
          '📊 BMI: ${bmi.toStringAsFixed(1)}\n'
          '📈 Category: $bmiCategory\n\n'
          '💡 **Tips:**\n'
          '${bmi < 18.5 ? "• Focus on healthy calorie surplus\n" : ""}'
          '${bmi >= 25 ? "• 500 kcal deficit for weight loss\n" : ""}'
          '• High protein (keeps you full)\n'
          '• Cardio + strength training\n'
          '• Adequate sleep (7-9 hours)\n\n'
          '📝 Track weight in your profile!';
    }
    
    if (isArabic) {
      return '⚖️ **إدارة الوزن:**\n\n'
          '💡 **نصائح عامة:**\n'
          '• فقدان صحي: 0.5-1 كجم/أسبوع\n'
          '• زيادة صحي: 0.25-0.5 كجم/أسبوع\n'
          '• عجز 500 سعرة لفقدان الوزن\n'
          '• فائض 300-500 سعرة لزيادة الوزن\n\n'
          '📝 أضف وزنك وطولك في ملفك الشخصي للحصول على نصائح شخصية!';
    }
    
    return '⚖️ **Weight Management:**\n\n'
        '💡 **General Tips:**\n'
        '• Healthy loss: 0.5-1 kg/week\n'
        '• Healthy gain: 0.25-0.5 kg/week\n'
        '• 500 kcal deficit for weight loss\n'
        '• 300-500 kcal surplus for weight gain\n\n'
        '📝 Add your weight & height in profile for personalized tips!';
  }
  
  String _handleStress({required bool isArabic}) {
    if (isArabic) {
      return '🧘 **إدارة التوتر:**\n\n'
          '🌬️ **تنفس الصندوق (4-4-4-4):**\n'
          '• شهيق: 4 ثوان\n'
          '• حبس: 4 ثوان\n'
          '• زفير: 4 ثوان\n'
          '• حبس: 4 ثوان\n'
          '• كرر 4 مرات\n\n'
          '💡 **نصائح يومية:**\n'
          '• تمرين: 30 دقيقة يومياً\n'
          '• نوم: 7-8 ساعات\n'
          '• ترطيب كافٍ\n'
          '• تجنب الكافيين الزائد\n'
          '• 20 دقيقة في الطبيعة\n\n'
          '📝 تتبع صحتك العقلية في التطبيق!';
    }
    
    return '🧘 **Stress Management:**\n\n'
        '🌬️ **Box Breathing (4-4-4-4):**\n'
        '• Inhale: 4 seconds\n'
        '• Hold: 4 seconds\n'
        '• Exhale: 4 seconds\n'
        '• Hold: 4 seconds\n'
        '• Repeat 4 times\n\n'
        '💡 **Daily Tips:**\n'
        '• Exercise: 30 min daily\n'
        '• Sleep: 7-8 hours\n'
        '• Stay hydrated\n'
        '• Avoid excessive caffeine\n'
        '• 20 min in nature\n\n'
        '📝 Track mental health in the app!';
  }
  
  String _handleGeneralHealth({UserModel? user, required bool isArabic}) {
    if (isArabic) {
      return '🌟 **صحتك العامة:**\n\n'
          '💡 **نصائح يومية:**\n'
          '• اشرب 8+ أكواب ماء\n'
          '• تناول 5 حصص فواكه وخضروات\n'
          '• 30 دقيقة نشاط بدني\n'
          '• 7-9 ساعات نوم\n'
          '• إدارة التوتر\n\n'
          '📊 **في تطبيق صحيح يمكنك:**\n'
          '• تتبع التغذية والتمارين\n'
          '• إدارة الأدوية\n'
          '• مراقبة النوم والماء\n'
          '• كسب نقاط الخبرة\n\n'
          '📝 استخدم التطبيق بانتظام لتحسين صحتك!';
    }
    
    return '🌟 **Your General Health:**\n\n'
        '💡 **Daily Tips:**\n'
        '• Drink 8+ glasses water\n'
        '• Eat 5 servings fruits/vegetables\n'
        '• 30 min physical activity\n'
        '• 7-9 hours sleep\n'
        '• Manage stress\n\n'
        '📊 **In Saheeh App you can:**\n'
        '• Track nutrition & workouts\n'
        '• Manage medications\n'
        '• Monitor sleep & water\n'
        '• Earn XP points\n\n'
        '📝 Use the app regularly to improve your health!';
  }
  
  String _getOffTopicResponse(bool isArabic) {
    if (isArabic) {
      return 'أقدر سؤالك، لكنني مصمم خصيصاً لمساعدتك في مواضيع الصحة واللياقة! 🏥\n\n'
          'يمكنني مساعدتك في:\n'
          '• 💊 تذكيرات الأدوية\n'
          '• 🥗 نصائح التغذية\n'
          '• 🏃 خطط التمارين\n'
          '• 💧 تتبع الترطيب\n'
          '• 😴 نصائح النوم\n\n'
          'هل هناك شيء متعلق بالصحة يمكنني مساعدتك فيه؟';
    }
    
    return 'I appreciate your question, but I\'m specifically designed to help with health and fitness topics! 🏥\n\n'
        'I can assist you with:\n'
        '• 💊 Medication reminders\n'
        '• 🥗 Nutrition advice\n'
        '• 🏃 Workout plans\n'
        '• 💧 Hydration tracking\n'
        '• 😴 Sleep tips\n\n'
        'Is there anything health-related I can help you with?';
  }
  
  String _getDefaultResponse(bool isArabic) {
    if (isArabic) {
      return 'سأكون سعيداً بمساعدتك! 🌟\n\n'
          'يمكنني تقديم إرشادات حول:\n\n'
          '• 💊 الأدوية: التذكيرات، الجرعات\n'
          '• 🥗 التغذية: خطط الوجبات، السعرات\n'
          '• 🏃 اللياقة: التمارين، الكارديو\n'
          '• 💧 الترطيب: أهداف شرب الماء\n'
          '• 😴 النوم: نصائح تحسين الجودة\n'
          '• ⚖️ الوزن: استراتيجيات الإدارة\n'
          '• 🧘 العافية: التوتر، الصحة العقلية\n\n'
          'هل يمكنك إخباري بالمزيد من التفاصيل عما تريد معرفته؟';
    }
    
    return 'I\'d be happy to help! 🌟\n\n'
        'I can provide guidance on:\n\n'
        '• 💊 Medications: Reminders, dosages\n'
        '• 🥗 Nutrition: Meal plans, calories\n'
        '• 🏃 Fitness: Workouts, cardio\n'
        '• 💧 Hydration: Water intake goals\n'
        '• 😴 Sleep: Quality improvement tips\n'
        '• ⚖️ Weight: Management strategies\n'
        '• 🧘 Wellness: Stress, mental health\n\n'
        'Could you tell me more specifically what you\'d like to know?';
  }
  
  /// Get actionable suggestions based on user state
  List<String> getActionableSuggestions({
    required String userEmail,
    UserModel? user,
    List<MealModel>? todayMeals,
    NutritionGoalModel? nutritionGoal,
    int? waterIntake,
    int? waterGoal,
    double? sleepHours,
  }) {
    final suggestions = <String>[];
    
    // Nutrition suggestions
    if (todayMeals != null && nutritionGoal != null) {
      final caloriesConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.calories);
      if (caloriesConsumed < nutritionGoal.caloriesGoal * 0.5) {
        suggestions.add('Log a meal in Nutrition section');
      }
      if (caloriesConsumed > nutritionGoal.caloriesGoal * 1.2) {
        suggestions.add('Consider lighter meals for dinner');
      }
    }
    
    // Water suggestions
    if (waterIntake != null && waterGoal != null) {
      final percentage = (waterIntake / waterGoal * 100);
      if (percentage < 50) {
        suggestions.add('Drink water now - you\'re below 50% of goal');
      }
    }
    
    // Sleep suggestions
    if (sleepHours != null && sleepHours < 7) {
      suggestions.add('Aim for 7-9 hours of sleep tonight');
    }
    
    // XP suggestions
    if (user != null && user.xp < 100) {
      suggestions.add('Complete daily activities to earn XP');
    }
    
    return suggestions;
  }
}

