import 'package:flutter/foundation.dart';
import '../../models/user_model.dart';
import '../../models/meal_model.dart';
import '../../models/workout_model.dart';
import '../../models/nutrition_goal_model.dart';
import '../../database/database_helper.dart';
import '../../core/services/xp_service.dart';
import '../../core/localization/app_localizations.dart';
import '../../features/fitness/view/workout_library.dart';

/// Comprehensive Nutrition Knowledge Base
class NutritionKnowledgeBase {
  static const Map<String, Map<String, dynamic>> foodDatabase = {
    'chicken breast': {'calories': 165, 'protein': 31, 'carbs': 0, 'fat': 3.6, 'serving': '100g'},
    'rice': {'calories': 130, 'protein': 2.7, 'carbs': 28, 'fat': 0.3, 'serving': '100g cooked'},
    'salmon': {'calories': 208, 'protein': 20, 'carbs': 0, 'fat': 13, 'serving': '100g'},
    'eggs': {'calories': 155, 'protein': 13, 'carbs': 1.1, 'fat': 11, 'serving': '2 large'},
    'oats': {'calories': 389, 'protein': 17, 'carbs': 66, 'fat': 7, 'serving': '100g dry'},
    'banana': {'calories': 89, 'protein': 1.1, 'carbs': 23, 'fat': 0.3, 'serving': '1 medium'},
    'broccoli': {'calories': 34, 'protein': 2.8, 'carbs': 7, 'fat': 0.4, 'serving': '100g'},
    'sweet potato': {'calories': 86, 'protein': 1.6, 'carbs': 20, 'fat': 0.1, 'serving': '100g'},
    'quinoa': {'calories': 120, 'protein': 4.4, 'carbs': 22, 'fat': 1.9, 'serving': '100g cooked'},
    'avocado': {'calories': 160, 'protein': 2, 'carbs': 9, 'fat': 15, 'serving': '100g'},
  };
  
  static const List<String> highProteinFoods = [
    'chicken breast', 'salmon', 'eggs', 'greek yogurt', 'cottage cheese',
    'lean beef', 'turkey', 'tuna', 'protein powder', 'lentils'
  ];
  
  static const List<String> highCarbFoods = [
    'rice', 'oats', 'sweet potato', 'quinoa', 'brown rice',
    'potato', 'pasta', 'bread', 'banana', 'dates'
  ];
  
  static const List<String> healthyFats = [
    'avocado', 'olive oil', 'nuts', 'almonds', 'walnuts',
    'salmon', 'chia seeds', 'flax seeds', 'peanut butter'
  ];
}

/// Comprehensive Health & Fitness Knowledge Base
class HealthKnowledgeBase {
  static const Map<String, String> sleepTips = {
    'routine': 'Maintain consistent sleep schedule (same bedtime/wake time)',
    'environment': 'Keep room dark, cool (18-20°C), and quiet',
    'screens': 'Avoid screens 1 hour before bed (blue light disrupts sleep)',
    'caffeine': 'No caffeine after 2 PM',
    'meals': 'Avoid heavy meals 3 hours before bed',
    'exercise': 'Light exercise during day improves sleep quality',
    'relaxation': 'Use relaxation techniques (deep breathing, meditation)',
  };
  
  static const Map<String, String> hydrationTips = {
    'morning': 'Drink 500ml water upon waking',
    'meals': 'Drink water 30 min before meals (aids digestion)',
    'workout': 'Drink 250-500ml water during workouts',
    'signs': 'Dark urine = dehydration, light yellow = well hydrated',
    'frequency': 'Drink small amounts frequently (not large amounts at once)',
    'temperature': 'Room temperature water is absorbed faster',
  };
  
  static const Map<String, String> workoutTips = {
    'warmup': 'Always warm up 5-10 min before workouts',
    'form': 'Focus on proper form before increasing weight',
    'rest': 'Rest 48 hours between same muscle group workouts',
    'progression': 'Progressive overload: gradually increase weight/reps',
    'cardio': 'Cardio 2-3x/week, strength 3-4x/week',
    'recovery': 'Sleep 7-9 hours for optimal recovery',
    'nutrition': 'Eat protein within 30 min post-workout',
  };
}

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
  
  /// Intent Classification using enhanced keyword matching and context
  ChatIntent _classifyIntent(String query, bool isArabic) {
    // Enhanced Arabic keywords with more variations
    if (isArabic) {
      if (_matchesAny(query, ['مرحبا', 'السلام', 'أهلا', 'صباح', 'مساء', 'أهلاً', 'مرحب', 'السلام عليكم', 'أهلاً وسهلاً'])) {
        return ChatIntent.greeting;
      }
      if (_matchesAny(query, ['طعام', 'أكل', 'وجبة', 'سعرات', 'بروتين', 'كارب', 'دهون', 'تغذية', 'نظام غذائي', 'ماكرو', 'فطور', 'غداء', 'عشاء', 'سناك', 'وجبات'])) {
        return ChatIntent.nutrition;
      }
      if (_matchesAny(query, ['تمرين', 'رياضة', 'لياقة', 'جيم', 'كارديو', 'عضلات', 'تمارين', 'تدريب', 'قوة', 'رفع', 'ضغط', 'سكوات', 'ديدليفت'])) {
        return ChatIntent.fitness;
      }
      if (_matchesAny(query, ['دواء', 'أدوية', 'حبة', 'جرعة', 'تذكير', 'دواء', 'علاج', 'وصفة', 'صيدلية'])) {
        return ChatIntent.medication;
      }
      if (_matchesAny(query, ['نوم', 'نائم', 'إرهاق', 'راحة', 'نومي', 'ساعات النوم', 'نوم جيد', 'قلة نوم'])) {
        return ChatIntent.sleep;
      }
      if (_matchesAny(query, ['ماء', 'شرب', 'ترطيب', 'عطش', 'مياه', 'كوب ماء', 'شرب الماء'])) {
        return ChatIntent.hydration;
      }
      if (_matchesAny(query, ['نقاط', 'خبرة', 'xp', 'مستوى', 'ترقية', 'نقاط الخبرة', 'المستوى', 'الترقية'])) {
        return ChatIntent.xp;
      }
      if (_matchesAny(query, ['إنجاز', 'إنجازات', 'إنجازي', 'شارة', 'جائزة'])) {
        return ChatIntent.achievements;
      }
      if (_matchesAny(query, ['تطبيق', 'ميزة', 'كيف', 'استخدام', 'ميزات', 'كيفية', 'شرح', 'مساعدة'])) {
        return ChatIntent.appFeatures;
      }
      if (_matchesAny(query, ['وزن', 'bmi', 'نحيف', 'سمين', 'فقدان وزن', 'زيادة وزن', 'مؤشر كتلة الجسم'])) {
        return ChatIntent.weightManagement;
      }
      if (_matchesAny(query, ['توتر', 'قلق', 'ضغط', 'استرخاء', 'قلق', 'توتر', 'ضغط نفسي'])) {
        return ChatIntent.stress;
      }
      if (_matchesAny(query, ['صحة', 'نصيحة', 'نصائح', 'صحي', 'نصائح صحية', 'صحة عامة'])) {
        return ChatIntent.healthTips;
      }
    }
    
    // Enhanced English keywords with more variations
    if (_matchesAny(query, ['hello', 'hi', 'hey', 'good morning', 'good afternoon', 'good evening', 'greetings', 'hey there'])) {
      return ChatIntent.greeting;
    }
    if (_matchesAny(query, ['food', 'eat', 'meal', 'calorie', 'protein', 'carb', 'fat', 'nutrition', 'diet', 'breakfast', 'lunch', 'dinner', 'snack', 'macro', 'macros', 'calories', 'eating'])) {
      return ChatIntent.nutrition;
    }
    if (_matchesAny(query, ['workout', 'exercise', 'fitness', 'gym', 'cardio', 'muscle', 'strength', 'training', 'run', 'training', 'lift', 'squat', 'deadlift', 'bench', 'exercise routine'])) {
      return ChatIntent.fitness;
    }
    if (_matchesAny(query, ['medicine', 'medication', 'pill', 'drug', 'dose', 'reminder', 'prescription', 'pharmacy', 'meds'])) {
      return ChatIntent.medication;
    }
    if (_matchesAny(query, ['sleep', 'rest', 'insomnia', 'tired', 'fatigue', 'bedtime', 'sleeping', 'slept', 'sleep quality'])) {
      return ChatIntent.sleep;
    }
    if (_matchesAny(query, ['water', 'hydration', 'drink', 'thirst', 'fluid', 'drinking water', 'water intake', 'hydrated'])) {
      return ChatIntent.hydration;
    }
    if (_matchesAny(query, ['xp', 'points', 'level', 'experience', 'level up', 'xp points', 'experience points', 'leveling'])) {
      return ChatIntent.xp;
    }
    if (_matchesAny(query, ['achievement', 'achievements', 'unlock', 'badge', 'unlocked', 'badges'])) {
      return ChatIntent.achievements;
    }
    if (_matchesAny(query, ['app', 'feature', 'how to', 'use', 'sehati', 'saheeh', 'help', 'features', 'how do i', 'tutorial'])) {
      return ChatIntent.appFeatures;
    }
    if (_matchesAny(query, ['weight', 'bmi', 'lose', 'gain', 'slim', 'overweight', 'weight loss', 'weight gain', 'body mass'])) {
      return ChatIntent.weightManagement;
    }
    if (_matchesAny(query, ['stress', 'anxiety', 'relax', 'calm', 'mental', 'stressed', 'anxious', 'relaxation'])) {
      return ChatIntent.stress;
    }
    if (_matchesAny(query, ['health', 'healthy', 'tip', 'advice', 'recommend', 'suggest', 'health tips', 'wellness', 'health advice'])) {
      return ChatIntent.healthTips;
    }
    
    // Enhanced context tracking for follow-up questions
    if (_context.recentIntents.isNotEmpty) {
      final lastIntent = _context.recentIntents.last;
      final followUpKeywords = isArabic 
          ? ['أكثر', 'أخبرني', 'اشرح', 'ماذا عن', 'كيف']
          : ['more', 'tell me', 'explain', 'what about', 'how', 'can you', 'please'];
      
      if (_matchesAny(query, followUpKeywords)) {
        try {
          return ChatIntent.values.firstWhere(
            (e) => e.name == lastIntent,
            orElse: () => ChatIntent.generalHealth,
          );
        } catch (e) {
          return ChatIntent.generalHealth;
        }
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
  
  /// Fuzzy matching for better intent classification (handles typos and variations)
  bool _fuzzyMatch(String query, List<String> keywords, {double threshold = 0.7}) {
    for (final keyword in keywords) {
      if (query.contains(keyword)) return true;
      // Simple Levenshtein-like check for close matches
      if (_similarity(query, keyword) >= threshold) return true;
    }
    return false;
  }
  
  /// Simple similarity score (0.0 to 1.0)
  double _similarity(String s1, String s2) {
    if (s1.isEmpty || s2.isEmpty) return 0.0;
    if (s1 == s2) return 1.0;
    
    final longer = s1.length > s2.length ? s1 : s2;
    final shorter = s1.length > s2.length ? s2 : s1;
    
    if (longer.length == 0) return 1.0;
    
    int matches = 0;
    for (int i = 0; i < shorter.length; i++) {
      if (longer.contains(shorter[i])) matches++;
    }
    
    return matches / longer.length;
  }
  
  bool _isHealthRelated(String query) {
    final healthKeywords = [
      'health', 'wellness', 'medical', 'doctor', 'symptom', 'pain', 'ache',
      'صحة', 'طبي', 'طبيب', 'ألم', 'عرض', 'مرض', 'علاج'
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
    
    // Check for specific food queries
    if (_matchesAny(query, ['chicken', 'rice', 'salmon', 'egg', 'oats', 'banana', 'broccoli', 'sweet potato', 'quinoa', 'avocado', 
                            'دجاج', 'أرز', 'سلمون', 'بيض', 'شوفان', 'موز', 'بروكلي', 'بطاطا حلوة', 'كينوا', 'أفوكادو'])) {
      return _getFoodInfo(query, isArabic);
    }
    
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
    
    // Enhanced nutrition advice with food database knowledge
    if (isArabic) {
      String proteinSources = proteinConsumed < proteinGoal * 0.7 
          ? '• مصادر البروتين: دجاج (31g/100g), سمك (25g/100g), بيض (13g/حبة), لحم بقري (26g/100g), عدس (9g/100g)\n'
          : '';
      String carbSources = carbsConsumed < carbsGoal * 0.7
          ? '• مصادر الكربوهيدرات: أرز بني (23g/100g), شوفان (66g/100g), بطاطا حلوة (20g/100g), كينوا (21g/100g)\n'
          : '';
      
      return '🥗 **نصائح التغذية الشخصية:**\n\n'
          '**هدفك اليومي:**\n'
          '• السعرات: ${caloriesGoal.toStringAsFixed(0)} سعرة\n'
          '• البروتين: ${proteinGoal.toStringAsFixed(0)} جم\n'
          '• الكربوهيدرات: ${carbsGoal.toStringAsFixed(0)} جم\n'
          '• الدهون: ${fatGoal.toStringAsFixed(0)} جم\n\n'
          '**وجبات اليوم:** ${todayMeals.length} وجبة\n'
          '**التقدم:**\n'
          '• السعرات: ${((caloriesConsumed / caloriesGoal) * 100).toStringAsFixed(0)}%\n'
          '• البروتين: ${((proteinConsumed / proteinGoal) * 100).toStringAsFixed(0)}%\n'
          '• الكربوهيدرات: ${((carbsConsumed / carbsGoal) * 100).toStringAsFixed(0)}%\n'
          '• الدهون: ${((fatConsumed / fatGoal) * 100).toStringAsFixed(0)}%\n\n'
          '💡 **اقتراحات غذائية:**\n'
          '$proteinSources'
          '$carbSources'
          '• اشرب الماء قبل الوجبات (يساعد على الشبع)\n'
          '• تناول الخضروات مع كل وجبة (ألياف وفيتامينات)\n'
          '• تناول وجبات صغيرة متكررة (5-6 وجبات يومياً)\n'
          '• تجنب السكريات المضافة والمشروبات الغازية\n'
          '• اختر الدهون الصحية (أفوكادو، زيت زيتون، مكسرات)\n\n'
          '📝 سجل وجباتك للحصول على نقاط الخبرة!';
    }
    
    String proteinSources = proteinConsumed < proteinGoal * 0.7
        ? '• Protein sources: Chicken (31g/100g), Fish (25g/100g), Eggs (13g/egg), Beef (26g/100g), Lentils (9g/100g)\n'
        : '';
    String carbSources = carbsConsumed < carbsGoal * 0.7
        ? '• Carb sources: Brown rice (23g/100g), Oats (66g/100g), Sweet potato (20g/100g), Quinoa (21g/100g)\n'
        : '';
    
    return '🥗 **Personalized Nutrition Advice:**\n\n'
        '**Your Daily Goals:**\n'
        '• Calories: ${caloriesGoal.toStringAsFixed(0)} kcal\n'
        '• Protein: ${proteinGoal.toStringAsFixed(0)}g\n'
        '• Carbs: ${carbsGoal.toStringAsFixed(0)}g\n'
        '• Fats: ${fatGoal.toStringAsFixed(0)}g\n\n'
        '**Today\'s Meals:** ${todayMeals.length} meals logged\n'
        '**Progress:**\n'
        '• Calories: ${((caloriesConsumed / caloriesGoal) * 100).toStringAsFixed(0)}%\n'
        '• Protein: ${((proteinConsumed / proteinGoal) * 100).toStringAsFixed(0)}%\n'
        '• Carbs: ${((carbsConsumed / carbsGoal) * 100).toStringAsFixed(0)}%\n'
        '• Fats: ${((fatConsumed / fatGoal) * 100).toStringAsFixed(0)}%\n\n'
        '💡 **Nutrition Suggestions:**\n'
        '$proteinSources'
        '$carbSources'
        '• Drink water before meals (aids satiety)\n'
        '• Include vegetables with every meal (fiber & vitamins)\n'
        '• Eat small frequent meals (5-6 meals daily)\n'
        '• Avoid added sugars and sodas\n'
        '• Choose healthy fats (avocado, olive oil, nuts)\n\n'
        '📝 Log your meals to earn XP!';
  }
  
  /// Get food information from knowledge base
  String _getFoodInfo(String query, bool isArabic) {
    final foodMap = {
      'chicken': 'chicken breast',
      'دجاج': 'chicken breast',
      'rice': 'rice',
      'أرز': 'rice',
      'salmon': 'salmon',
      'سلمون': 'salmon',
      'egg': 'eggs',
      'بيض': 'eggs',
      'oats': 'oats',
      'شوفان': 'oats',
      'banana': 'banana',
      'موز': 'banana',
      'broccoli': 'broccoli',
      'بروكلي': 'broccoli',
      'sweet potato': 'sweet potato',
      'بطاطا حلوة': 'sweet potato',
      'quinoa': 'quinoa',
      'كينوا': 'quinoa',
      'avocado': 'avocado',
      'أفوكادو': 'avocado',
    };
    
    String? foodKey;
    for (final entry in foodMap.entries) {
      if (query.contains(entry.key)) {
        foodKey = entry.value;
        break;
      }
    }
    
    if (foodKey == null || !NutritionKnowledgeBase.foodDatabase.containsKey(foodKey)) {
      return isArabic 
          ? 'لم أجد معلومات عن هذا الطعام. جرب: دجاج، أرز، سلمون، بيض، شوفان، موز، بروكلي، بطاطا حلوة، كينوا، أفوكادو'
          : 'I couldn\'t find info about this food. Try: chicken, rice, salmon, eggs, oats, banana, broccoli, sweet potato, quinoa, avocado';
    }
    
    final food = NutritionKnowledgeBase.foodDatabase[foodKey]!;
    
    if (isArabic) {
      return '🥗 **معلومات غذائية: ${foodKey}**\n\n'
          '🔥 السعرات: ${food['calories']} سعرة\n'
          '🥩 البروتين: ${food['protein']} جم\n'
          '🍞 الكربوهيدرات: ${food['carbs']} جم\n'
          '🥑 الدهون: ${food['fat']} جم\n'
          '📏 الحصة: ${food['serving']}\n\n'
          '💡 يمكنك إضافة هذا الطعام في قسم التغذية!';
    }
    
    return '🥗 **Nutrition Info: ${foodKey}**\n\n'
        '🔥 Calories: ${food['calories']} kcal\n'
        '🥩 Protein: ${food['protein']}g\n'
        '🍞 Carbs: ${food['carbs']}g\n'
        '🥑 Fat: ${food['fat']}g\n'
        '📏 Serving: ${food['serving']}\n\n'
        '💡 You can add this food in the Nutrition section!';
  }
  
  Future<String> _handleFitness({
    required String query,
    UserModel? user,
    List<WorkoutModel>? recentWorkouts,
    required bool isArabic,
  }) async {
    final workoutCount = recentWorkouts?.length ?? 0;
    
    // Check for specific workout type queries with enhanced matching
    final isChestQuery = _matchesAny(query, ['chest', 'صدر', 'push', 'bench', 'push-up', 'pushup']);
    final isBackQuery = _matchesAny(query, ['back', 'ظهر', 'pull', 'row', 'deadlift', 'ديدليفت']);
    final isLegQuery = _matchesAny(query, ['leg', 'ساق', 'squat', 'سكوات', 'quad', 'hamstring']);
    final isShoulderQuery = _matchesAny(query, ['shoulder', 'كتف', 'press', 'delt', 'delt']);
    final isArmQuery = _matchesAny(query, ['arm', 'ذراع', 'bicep', 'tricep', 'biceps', 'triceps']);
    final isAbsQuery = _matchesAny(query, ['abs', 'بطن', 'core', 'core', 'abdominal']);
    
    // Provide specific workout recommendations with workout library integration
    if (isChestQuery || isBackQuery || isLegQuery || isShoulderQuery || isArmQuery || isAbsQuery) {
      return _getSpecificWorkoutRecommendation(
        isChest: isChestQuery,
        isBack: isBackQuery,
        isLeg: isLegQuery,
        isShoulder: isShoulderQuery,
        isArm: isArmQuery,
        isAbs: isAbsQuery,
        isArabic: isArabic,
      );
    }
    
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
    
    // General fitness advice with workout library integration
    if (isArabic) {
      return '💪 **نصائح اللياقة البدنية:**\n\n'
          '**الهدف الأسبوعي:** 3-5 جلسات تمرين\n\n'
          '**أنواع التمارين المتاحة:**\n'
          '• **الصدر:** Chest Builder, Push-Up Mastery\n'
          '• **الظهر:** V-Taper Back, Deadlift Power\n'
          '• **الأرجل:** Leg Day Destroyer, Squat Fundamentals\n'
          '• **الأكتاف:** Boulder Shoulders, Shoulder Strength\n\n'
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
        '**Available Workout Types:**\n'
        '• **Chest:** Chest Builder, Push-Up Mastery\n'
        '• **Back:** V-Taper Back, Deadlift Power\n'
        '• **Legs:** Leg Day Destroyer, Squat Fundamentals\n'
        '• **Shoulders:** Boulder Shoulders, Shoulder Strength\n\n'
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
  
  /// Get specific workout recommendations based on muscle group (integrated with workout library)
  String _getSpecificWorkoutRecommendation({
    required bool isChest,
    required bool isBack,
    required bool isLeg,
    required bool isShoulder,
    required bool isArm,
    required bool isAbs,
    required bool isArabic,
  }) {
    // Use actual workout library data
    if (isChest) {
      final workouts = MenWorkoutLibrary.chestWorkouts;
      if (isArabic) {
        return '💪 **تمارين الصدر:**\n\n'
            '**للبداية:**\n'
            '• ${workouts[1].name} (${workouts[1].durationMinutes} دقيقة) - ${workouts[1].description}\n'
            '• ${workouts[1].exercises.join(', ')}\n\n'
            '**للمتوسط:**\n'
            '• ${workouts[0].name} (${workouts[0].durationMinutes} دقيقة) - ${workouts[0].description}\n'
            '• ${workouts[0].exercises.join(', ')}\n\n'
            '**للمتقدم:**\n'
            '• ${workouts[2].name} (${workouts[2].durationMinutes} دقيقة) - ${workouts[2].description}\n'
            '• ${workouts[2].exercises.join(', ')}\n\n'
            '💡 **نصيحة:** ابدأ بتمارين الإحماء واختر التمرين المناسب لمستواك!\n\n'
            '📝 استكشف مكتبة التمارين في قسم اللياقة!';
      }
      return '💪 **Chest Workouts:**\n\n'
          '**For Beginners:**\n'
          '• ${workouts[1].name} (${workouts[1].durationMinutes} min) - ${workouts[1].description}\n'
          '• ${workouts[1].exercises.join(', ')}\n\n'
          '**For Intermediate:**\n'
          '• ${workouts[0].name} (${workouts[0].durationMinutes} min) - ${workouts[0].description}\n'
          '• ${workouts[0].exercises.join(', ')}\n\n'
          '**For Advanced:**\n'
          '• ${workouts[2].name} (${workouts[2].durationMinutes} min) - ${workouts[2].description}\n'
          '• ${workouts[2].exercises.join(', ')}\n\n'
          '💡 **Tip:** Start with warm-up and choose workout matching your level!\n\n'
          '📝 Explore workout library in Fitness section!';
    }
    
    if (isBack) {
      final workouts = MenWorkoutLibrary.backWorkouts;
      if (isArabic) {
        return '💪 **تمارين الظهر:**\n\n'
            '**للبداية:**\n'
            '• ${workouts[2].name} (${workouts[2].durationMinutes} دقيقة)\n'
            '• ${workouts[2].exercises.join(', ')}\n\n'
            '**للمتوسط:**\n'
            '• ${workouts[0].name} (${workouts[0].durationMinutes} دقيقة)\n'
            '• ${workouts[0].exercises.join(', ')}\n\n'
            '**للمتقدم:**\n'
            '• ${workouts[1].name} (${workouts[1].durationMinutes} دقيقة)\n'
            '• ${workouts[1].exercises.join(', ')}\n\n'
            '💡 **نصيحة:** ركز على الشكل الصحيح للظهر القوي!\n\n'
            '📝 استكشف مكتبة التمارين!';
      }
      return '💪 **Back Workouts:**\n\n'
          '**For Beginners:**\n'
          '• ${workouts[2].name} (${workouts[2].durationMinutes} min)\n'
          '• ${workouts[2].exercises.join(', ')}\n\n'
          '**For Intermediate:**\n'
          '• ${workouts[0].name} (${workouts[0].durationMinutes} min)\n'
          '• ${workouts[0].exercises.join(', ')}\n\n'
          '**For Advanced:**\n'
          '• ${workouts[1].name} (${workouts[1].durationMinutes} min)\n'
          '• ${workouts[1].exercises.join(', ')}\n\n'
          '💡 **Tip:** Focus on proper form for a strong back!\n\n'
          '📝 Explore workout library!';
    }
    
    if (isLeg) {
      final workouts = MenWorkoutLibrary.legWorkouts;
      if (isArabic) {
        return '💪 **تمارين الأرجل:**\n\n'
            '**للبداية:**\n'
            '• ${workouts[1].name} (${workouts[1].durationMinutes} دقيقة)\n'
            '• ${workouts[1].exercises.join(', ')}\n\n'
            '**للمتوسط:**\n'
            '• ${workouts[2].name} (${workouts[2].durationMinutes} دقيقة)\n'
            '• ${workouts[2].exercises.join(', ')}\n\n'
            '**للمتقدم:**\n'
            '• ${workouts[0].name} (${workouts[0].durationMinutes} دقيقة)\n'
            '• ${workouts[0].exercises.join(', ')}\n\n'
            '💡 **نصيحة:** يوم الأرجل هو الأهم! لا تتخطاه!\n\n'
            '📝 استكشف مكتبة التمارين!';
      }
      return '💪 **Leg Workouts:**\n\n'
          '**For Beginners:**\n'
          '• ${workouts[1].name} (${workouts[1].durationMinutes} min)\n'
          '• ${workouts[1].exercises.join(', ')}\n\n'
          '**For Intermediate:**\n'
          '• ${workouts[2].name} (${workouts[2].durationMinutes} min)\n'
          '• ${workouts[2].exercises.join(', ')}\n\n'
          '**For Advanced:**\n'
          '• ${workouts[0].name} (${workouts[0].durationMinutes} min)\n'
          '• ${workouts[0].exercises.join(', ')}\n\n'
          '💡 **Tip:** Leg day is the most important! Don\'t skip it!\n\n'
          '📝 Explore workout library!';
    }
    
    if (isShoulder) {
      final workouts = MenWorkoutLibrary.shoulderWorkouts;
      if (isArabic) {
        return '💪 **تمارين الأكتاف:**\n\n'
            '**للبداية:**\n'
            '• ${workouts[2].name} (${workouts[2].durationMinutes} دقيقة)\n'
            '• ${workouts[2].exercises.join(', ')}\n\n'
            '**للمتوسط:**\n'
            '• ${workouts[0].name} (${workouts[0].durationMinutes} دقيقة)\n'
            '• ${workouts[0].exercises.join(', ')}\n\n'
            '**للمتقدم:**\n'
            '• ${workouts[1].name} (${workouts[1].durationMinutes} دقيقة)\n'
            '• ${workouts[1].exercises.join(', ')}\n\n'
            '💡 **نصيحة:** الأكتاف القوية تعطي مظهراً عريضاً!\n\n'
            '📝 استكشف مكتبة التمارين!';
      }
      return '💪 **Shoulder Workouts:**\n\n'
          '**For Beginners:**\n'
          '• ${workouts[2].name} (${workouts[2].durationMinutes} min)\n'
          '• ${workouts[2].exercises.join(', ')}\n\n'
          '**For Intermediate:**\n'
          '• ${workouts[0].name} (${workouts[0].durationMinutes} min)\n'
          '• ${workouts[0].exercises.join(', ')}\n\n'
          '**For Advanced:**\n'
          '• ${workouts[1].name} (${workouts[1].durationMinutes} min)\n'
          '• ${workouts[1].exercises.join(', ')}\n\n'
          '💡 **Tip:** Strong shoulders give a wide appearance!\n\n'
          '📝 Explore workout library!';
    }
    
    if (isArm) {
      final workouts = MenWorkoutLibrary.armWorkouts;
      if (isArabic) {
        return '💪 **تمارين الذراعين:**\n\n'
            '• ${workouts[0].name} (${workouts[0].durationMinutes} دقيقة) - ${workouts[0].description}\n'
            '• ${workouts[0].exercises.join(', ')}\n\n'
            '• ${workouts[1].name} (${workouts[1].durationMinutes} دقيقة) - ${workouts[1].description}\n'
            '• ${workouts[1].exercises.join(', ')}\n\n'
            '• ${workouts[2].name} (${workouts[2].durationMinutes} دقيقة) - ${workouts[2].description}\n'
            '• ${workouts[2].exercises.join(', ')}\n\n'
            '📝 استكشف مكتبة التمارين!';
      }
      return '💪 **Arm Workouts:**\n\n'
          '• ${workouts[0].name} (${workouts[0].durationMinutes} min) - ${workouts[0].description}\n'
          '• ${workouts[0].exercises.join(', ')}\n\n'
          '• ${workouts[1].name} (${workouts[1].durationMinutes} min) - ${workouts[1].description}\n'
          '• ${workouts[1].exercises.join(', ')}\n\n'
          '• ${workouts[2].name} (${workouts[2].durationMinutes} min) - ${workouts[2].description}\n'
          '• ${workouts[2].exercises.join(', ')}\n\n'
          '📝 Explore workout library!';
    }
    
    if (isAbs) {
      final workouts = MenWorkoutLibrary.absWorkouts;
      if (isArabic) {
        return '💪 **تمارين البطن:**\n\n'
            '**للبداية:**\n'
            '• ${workouts[1].name} (${workouts[1].durationMinutes} دقيقة)\n'
            '• ${workouts[1].exercises.join(', ')}\n\n'
            '**للمتوسط:**\n'
            '• ${workouts[0].name} (${workouts[0].durationMinutes} دقيقة)\n'
            '• ${workouts[0].exercises.join(', ')}\n\n'
            '**للمتقدم:**\n'
            '• ${workouts[2].name} (${workouts[2].durationMinutes} دقيقة)\n'
            '• ${workouts[2].exercises.join(', ')}\n\n'
            '💡 **نصيحة:** البطن القوي يحسن الأداء في جميع التمارين!\n\n'
            '📝 استكشف مكتبة التمارين!';
      }
      return '💪 **Abs Workouts:**\n\n'
          '**For Beginners:**\n'
          '• ${workouts[1].name} (${workouts[1].durationMinutes} min)\n'
          '• ${workouts[1].exercises.join(', ')}\n\n'
          '**For Intermediate:**\n'
          '• ${workouts[0].name} (${workouts[0].durationMinutes} min)\n'
          '• ${workouts[0].exercises.join(', ')}\n\n'
          '**For Advanced:**\n'
          '• ${workouts[2].name} (${workouts[2].durationMinutes} min)\n'
          '• ${workouts[2].exercises.join(', ')}\n\n'
          '💡 **Tip:** Strong core improves performance in all exercises!\n\n'
          '📝 Explore workout library!';
    }
    
    // Fallback
    return isArabic 
        ? 'اختر مجموعة عضلية محددة: صدر، ظهر، أرجل، أكتاف، ذراعين، بطن'
        : 'Choose a specific muscle group: chest, back, legs, shoulders, arms, abs';
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
    final sleepQuality = current >= 7 && current <= 9 ? 'good' : (current < 7 ? 'insufficient' : 'excessive');
    
    // Use knowledge base tips
    final tips = HealthKnowledgeBase.sleepTips;
    
    if (isArabic) {
      String qualityMessage = '';
      if (sleepQuality == 'good') {
        qualityMessage = '✅ نومك جيد! حافظ على هذا الروتين.\n\n';
      } else if (sleepQuality == 'insufficient') {
        qualityMessage = '⚠️ نومك غير كافٍ. حاول النوم مبكراً.\n\n';
      } else {
        qualityMessage = '⚠️ نومك أكثر من الموصى به. قد تشعر بالخمول.\n\n';
      }
      
      return '😴 **نومك:**\n\n'
          '${current > 0 ? "⏰ ساعات النوم: ${current.toStringAsFixed(1)} ساعة\n" : "⚠️ لم تسجل نومك بعد\n"}'
          '🎯 الموصى به: $recommended ساعات\n\n'
          '$qualityMessage'
          '💡 **نصائح لتحسين النوم:**\n'
          '• ${tips['routine']}\n'
          '• ${tips['environment']}\n'
          '• ${tips['screens']}\n'
          '• ${tips['caffeine']}\n'
          '• ${tips['meals']}\n'
          '• ${tips['exercise']}\n'
          '• ${tips['relaxation']}\n\n'
          '📝 سجل نومك في قسم الصحة!';
    }
    
    String qualityMessage = '';
    if (sleepQuality == 'good') {
      qualityMessage = '✅ Your sleep is good! Maintain this routine.\n\n';
    } else if (sleepQuality == 'insufficient') {
      qualityMessage = '⚠️ Your sleep is insufficient. Try sleeping earlier.\n\n';
    } else {
      qualityMessage = '⚠️ Your sleep exceeds recommendations. You may feel sluggish.\n\n';
    }
    
    return '😴 **Your Sleep:**\n\n'
        '${current > 0 ? "⏰ Sleep Hours: ${current.toStringAsFixed(1)} hours\n" : "⚠️ No sleep logged yet\n"}'
        '🎯 Recommended: $recommended hours\n\n'
        '$qualityMessage'
        '💡 **Sleep Improvement Tips:**\n'
        '• ${tips['routine']}\n'
        '• ${tips['environment']}\n'
        '• ${tips['screens']}\n'
        '• ${tips['caffeine']}\n'
        '• ${tips['meals']}\n'
        '• ${tips['exercise']}\n'
        '• ${tips['relaxation']}\n\n'
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
    
    // Use knowledge base tips
    final tips = HealthKnowledgeBase.hydrationTips;
    
    if (isArabic) {
      return '💧 **ترطيبك:**\n\n'
          '📊 شربت: ${intake}ml / ${goal}ml\n'
          '📈 التقدم: ${percentage.toStringAsFixed(0)}%\n'
          '${remaining > 0 ? "✅ متبقي: ${remaining}ml\n\n" : "🎉 أكملت هدفك اليوم!\n\n"}'
          '💡 **نصائح الترطيب:**\n'
          '• ${tips['morning']}\n'
          '• ${tips['meals']}\n'
          '• ${tips['workout']}\n'
          '• ${tips['signs']}\n'
          '• ${tips['frequency']}\n'
          '• ${tips['temperature']}\n\n'
          '📝 تتبع الماء في قسم الصحة!';
    }
    
    return '💧 **Your Hydration:**\n\n'
        '📊 Drank: ${intake}ml / ${goal}ml\n'
        '📈 Progress: ${percentage.toStringAsFixed(0)}%\n'
        '${remaining > 0 ? "✅ Remaining: ${remaining}ml\n\n" : "🎉 Goal completed!\n\n"}'
        '💡 **Hydration Tips:**\n'
        '• ${tips['morning']}\n'
        '• ${tips['meals']}\n'
        '• ${tips['workout']}\n'
        '• ${tips['signs']}\n'
        '• ${tips['frequency']}\n'
        '• ${tips['temperature']}\n\n'
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
      return '📱 **ميزات تطبيق صحيح - دليل شامل وأسئلة شائعة:**\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '🏠 **الصفحة الرئيسية (Home Dashboard)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ما الذي يمكنك فعله:**\n'
          '• عرض ملخص يومي شامل (سعرات، تمارين، ماء، نوم)\n'
          '• الوصول السريع لجميع الميزات\n'
          '• رؤى صحية ذكية من الذكاء الاصطناعي\n'
          '• تتبع التقدم والأهداف اليومية\n'
          '• عرض نقاط الخبرة (XP) والمستوى الحالي\n\n'
          '**كيفية الاستخدام:**\n'
          '• افتح التطبيق للوصول مباشرة للصفحة الرئيسية\n'
          '• استخدم الأزرار السريعة للوصول للميزات\n'
          '• اسحب للأسفل لتحديث البيانات\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '💊 **إدارة الأدوية (Medicine Management)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ما الذي يمكنك فعله:**\n'
          '• إضافة دواء جديد مع الجرعة والمواعيد\n'
          '• تذكيرات تلقائية حسب الجدول المحدد\n'
          '• تتبع تاريخ تناول الأدوية\n'
          '• طلب الأدوية من الصيدلية مباشرة\n'
          '• إشعارات عند موعد الدواء\n\n'
          '**كيفية الاستخدام:**\n'
          '• اذهب إلى قسم الصحة → إدارة الأدوية\n'
          '• اضغط "إضافة دواء جديد"\n'
          '• أدخل اسم الدواء، الجرعة، والمواعيد\n'
          '• حدد أيام الأسبوع للدواء\n'
          '• احفظ وسيتم تفعيل التذكيرات تلقائياً\n\n'
          '**أسئلة شائعة:**\n'
          '• س: كيف أضيف دواء؟\n'
          '  ج: اذهب لقسم الصحة → إدارة الأدوية → إضافة دواء جديد\n'
          '• س: كيف أغير موعد التذكير؟\n'
          '  ج: اضغط على الدواء → تعديل → غير الوقت\n'
          '• س: كيف أطلب دواء من الصيدلية؟\n'
          '  ج: اذهب لقسم الصيدلية → ابحث عن الدواء → أضف للسلة → ادفع\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '🥗 **التغذية (Nutrition Tracking)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ما الذي يمكنك فعله:**\n'
          '• سجل الوجبات مع السعرات والماكرو (بروتين، كارب، دهون)\n'
          '• تتبع الأهداف اليومية (سعرات، بروتين، كارب، دهون)\n'
          '• عرض قاعدة بيانات غذائية شاملة\n'
          '• اقتراحات وجبات صحية\n'
          '• كسب XP عند تسجيل الوجبات (+10 XP لكل وجبة)\n'
          '• عرض التقدم اليومي والأسبوعي\n\n'
          '**كيفية الاستخدام:**\n'
          '• اذهب لقسم التغذية من القائمة الرئيسية\n'
          '• اضغط "إضافة وجبة"\n'
          '• أدخل اسم الوجبة، السعرات، والماكرو\n'
          '• اختر نوع الوجبة (فطور، غداء، عشاء، سناك)\n'
          '• احفظ وستظهر في قائمة اليوم\n\n'
          '**أسئلة شائعة:**\n'
          '• س: كيف أعرف السعرات في الطعام؟\n'
          '  ج: اسألني عن أي طعام (مثل: "دجاج" أو "أرز") وسأعطيك المعلومات الغذائية\n'
          '• س: كيف أضيف وجبة؟\n'
          '  ج: قسم التغذية → إضافة وجبة → أدخل التفاصيل → احفظ\n'
          '• س: كيف أعدل هدف السعرات اليومي؟\n'
          '  ج: قسم التغذية → الأهداف → عدل القيم → احفظ\n'
          '• س: كيف أحذف وجبة؟\n'
          '  ج: اضغط مطولاً على الوجبة → احذف\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '💪 **اللياقة البدنية (Fitness & Workouts)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ما الذي يمكنك فعله:**\n'
          '• استكشف مكتبة تمارين شاملة (صدر، ظهر، أرجل، أكتاف، ذراعين، بطن)\n'
          '• تمارين للمبتدئين والمتوسطين والمتقدمين\n'
          '• روابط فيديو YouTube لكل تمرين\n'
          '• تتبع الأنشطة والتقدم\n'
          '• عرض تاريخ التمارين\n'
          '• كسب XP عند إكمال التمارين (+25 XP لكل تمرين)\n\n'
          '**كيفية الاستخدام:**\n'
          '• اذهب لقسم اللياقة من القائمة الرئيسية\n'
          '• اضغط "مكتبة التمارين"\n'
          '• اختر مجموعة عضلية (صدر، ظهر، إلخ)\n'
          '• اختر تمرين مناسب لمستواك\n'
          '• اضغط "بدء التمرين" واتبع التعليمات\n'
          '• اضغط "إنهاء التمرين" عند الانتهاء\n\n'
          '**أسئلة شائعة:**\n'
          '• س: كيف أبدأ تمرين للصدر؟\n'
          '  ج: اسألني "تمارين صدر" وسأعطيك قائمة بالتمارين المتاحة\n'
          '• س: كم مرة يجب أن أتمرن في الأسبوع؟\n'
          '  ج: الموصى به 3-5 مرات أسبوعياً، مع يوم راحة بين جلسات القوة\n'
          '• س: كيف أرى تقدمي في التمارين؟\n'
          '  ج: قسم اللياقة → تاريخ التمارين → عرض الإحصائيات\n'
          '• س: كيف أحصل على فيديو التمرين؟\n'
          '  ج: اضغط على التمرين من المكتبة → اضغط رابط YouTube\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '💧 **تتبع الصحة (Health Tracking)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ما الذي يمكنك فعله:**\n'
          '• تتبع شرب الماء (هدف يومي 2000ml)\n'
          '• تتبع ساعات النوم\n'
          '• الأهداف الصحية القابلة للتخصيص\n'
          '• كسب XP عند شرب الماء (+2 XP لكل 250ml)\n'
          '• كسب XP عند تسجيل النوم (+5 XP لليلة)\n'
          '• عرض التقدم على الصفحة الرئيسية\n\n'
          '**كيفية الاستخدام:**\n'
          '• اذهب لقسم الصحة → تتبع الماء/النوم\n'
          '• اضغط "+" لإضافة كوب ماء (250ml)\n'
          '• سجل ساعات النوم عند الاستيقاظ\n'
          '• راقب التقدم على الصفحة الرئيسية\n\n'
          '**أسئلة شائعة:**\n'
          '• س: كم يجب أن أشرب ماء يومياً؟\n'
          '  ج: الموصى به 2000ml (8 أكواب) يومياً، أكثر عند ممارسة الرياضة\n'
          '• س: كيف أسجل نومي؟\n'
          '  ج: قسم الصحة → تتبع النوم → أدخل ساعات النوم → احفظ\n'
          '• س: كيف أغير هدف الماء اليومي؟\n'
          '  ج: قسم الصحة → إعدادات → هدف الماء → عدل القيمة\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '⭐ **نظام نقاط الخبرة (XP System)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ما الذي يمكنك فعله:**\n'
          '• اكسب XP للأنشطة اليومية:\n'
          '  - تسجيل وجبة: +10 XP\n'
          '  - إكمال تمرين: +25 XP\n'
          '  - شرب ماء: +2 XP\n'
          '  - تسجيل نوم: +5 XP\n'
          '  - إكمال هدف: +50 XP\n'
          '• ترقيات المستوى التلقائية\n'
          '• إنجازات قابلة للفتح\n'
          '• استبدال XP في الصيدلية للحصول على خصومات\n\n'
          '**كيفية الاستخدام:**\n'
          '• استخدم التطبيق يومياً لتنفيذ الأنشطة\n'
          '• راقب XP على الصفحة الرئيسية\n'
          '• عند الوصول للحد المطلوب، سترتقي للمستوى التالي تلقائياً\n'
          '• اذهب لملفك الشخصي لرؤية الإنجازات\n\n'
          '**أسئلة شائعة:**\n'
          '• س: كيف أكسب XP بسرعة؟\n'
          '  ج: سجل وجباتك، أكمل تمارينك، اشرب ماء، وسجل نومك يومياً\n'
          '• س: كيف أعرف كم XP أحتاج للترقي؟\n'
          '  ج: اسألني "نقاطي" أو "XP" وسأعطيك التفاصيل\n'
          '• س: كيف أستبدل XP في الصيدلية؟\n'
          '  ج: قسم الصيدلية → اختر منتج → استبدل XP → احصل على خصم\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '🔗 **ميزات إضافية (Additional Features)**\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
          '**ربط Google Fit / ساعة ذكية:**\n'
          '• اذهب للإعدادات → ربط الأجهزة\n'
          '• اضغط "ربط Google Fit"\n'
          '• امنح الصلاحيات المطلوبة\n'
          '• اضغط "مزامنة الآن" لجلب البيانات\n\n'
          '**الإشعارات:**\n'
          '• اذهب للإعدادات → إشعارات\n'
          '• فعّل/عطّل أنواع الإشعارات المختلفة\n'
          '• تذكيرات الأدوية، التمارين، الماء، إلخ\n\n'
          '**اللغة:**\n'
          '• اذهب للإعدادات → اللغة\n'
          '• اختر العربية أو الإنجليزية\n'
          '• التطبيق يدعم كلا اللغتين بالكامل\n\n'
          '**الوضع الليلي:**\n'
          '• اذهب للإعدادات → المظهر\n'
          '• اختر فاتح، داكن، أو تلقائي\n\n'
          '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
          '💡 **نصائح للاستخدام:**\n'
          '• اسألني عن أي ميزة للحصول على شرح مفصل\n'
          '• استخدم القوائم للوصول السريع\n'
          '• تتبع تقدمك يومياً لكسب المزيد من XP\n'
          '• ربط Google Fit لمزامنة تلقائية للبيانات\n'
          '• فعّل الإشعارات لتذكيرك بالأنشطة المهمة\n\n'
          'ما الميزة التي تريد استكشافها أكثر؟';
    }
    
    return '📱 **Saheeh App Features - Complete Guide & FAQ:**\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '🏠 **Home Dashboard**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**What You Can Do:**\n'
        '• View complete daily summary (calories, workouts, water, sleep)\n'
        '• Quick access to all features\n'
        '• AI-powered health insights\n'
        '• Track progress and daily goals\n'
        '• View XP points and current level\n\n'
        '**How to Use:**\n'
        '• Open app to access home dashboard directly\n'
        '• Use quick action buttons to access features\n'
        '• Pull down to refresh data\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '💊 **Medicine Management**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**What You Can Do:**\n'
        '• Add new medication with dosage and schedule\n'
        '• Automatic reminders based on set schedule\n'
        '• Track medicine intake history\n'
        '• Order medications directly from pharmacy\n'
        '• Get notifications at medication time\n\n'
        '**How to Use:**\n'
        '• Go to Health section → Medicine Management\n'
        '• Tap "Add New Medication"\n'
        '• Enter medicine name, dosage, and times\n'
        '• Select days of week for medication\n'
        '• Save and reminders will activate automatically\n\n'
        '**Frequently Asked Questions:**\n'
        '• Q: How do I add a medication?\n'
        '  A: Go to Health section → Medicine Management → Add New Medication\n'
        '• Q: How do I change reminder time?\n'
        '  A: Tap on medication → Edit → Change time\n'
        '• Q: How do I order medicine from pharmacy?\n'
        '  A: Go to Pharmacy section → Search medicine → Add to cart → Checkout\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '🥗 **Nutrition Tracking**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**What You Can Do:**\n'
        '• Log meals with calories and macros (protein, carbs, fats)\n'
        '• Track daily goals (calories, protein, carbs, fats)\n'
        '• Access comprehensive food database\n'
        '• Get healthy meal suggestions\n'
        '• Earn XP when logging meals (+10 XP per meal)\n'
        '• View daily and weekly progress\n\n'
        '**How to Use:**\n'
        '• Go to Nutrition section from main menu\n'
        '• Tap "Add Meal"\n'
        '• Enter meal name, calories, and macros\n'
        '• Select meal type (breakfast, lunch, dinner, snack)\n'
        '• Save and it will appear in today\'s list\n\n'
        '**Frequently Asked Questions:**\n'
        '• Q: How do I know calories in food?\n'
        '  A: Ask me about any food (e.g., "chicken" or "rice") and I\'ll give you nutrition info\n'
        '• Q: How do I add a meal?\n'
        '  A: Nutrition section → Add Meal → Enter details → Save\n'
        '• Q: How do I change daily calorie goal?\n'
        '  A: Nutrition section → Goals → Edit values → Save\n'
        '• Q: How do I delete a meal?\n'
        '  A: Long press on meal → Delete\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '💪 **Fitness & Workouts**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**What You Can Do:**\n'
        '• Explore comprehensive workout library (chest, back, legs, shoulders, arms, abs)\n'
        '• Workouts for beginners, intermediate, and advanced\n'
        '• YouTube video links for each workout\n'
        '• Track activities and progress\n'
        '• View workout history\n'
        '• Earn XP when completing workouts (+25 XP per workout)\n\n'
        '**How to Use:**\n'
        '• Go to Fitness section from main menu\n'
        '• Tap "Workout Library"\n'
        '• Select muscle group (chest, back, etc.)\n'
        '• Choose workout matching your level\n'
        '• Tap "Start Workout" and follow instructions\n'
        '• Tap "Finish Workout" when done\n\n'
        '**Frequently Asked Questions:**\n'
        '• Q: How do I start a chest workout?\n'
        '  A: Ask me "chest workout" and I\'ll give you available workouts\n'
        '• Q: How many times should I workout per week?\n'
        '  A: Recommended 3-5 times weekly, with rest day between strength sessions\n'
        '• Q: How do I see my workout progress?\n'
        '  A: Fitness section → Workout History → View statistics\n'
        '• Q: How do I get workout video?\n'
        '  A: Tap workout from library → Tap YouTube link\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '💧 **Health Tracking**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**What You Can Do:**\n'
        '• Track water intake (daily goal 2000ml)\n'
        '• Track sleep hours\n'
        '• Customizable health goals\n'
        '• Earn XP when drinking water (+2 XP per 250ml)\n'
        '• Earn XP when logging sleep (+5 XP per night)\n'
        '• View progress on home dashboard\n\n'
        '**How to Use:**\n'
        '• Go to Health section → Track Water/Sleep\n'
        '• Tap "+" to add glass of water (250ml)\n'
        '• Log sleep hours when you wake up\n'
        '• Monitor progress on home dashboard\n\n'
        '**Frequently Asked Questions:**\n'
        '• Q: How much water should I drink daily?\n'
        '  A: Recommended 2000ml (8 glasses) daily, more when exercising\n'
        '• Q: How do I log my sleep?\n'
        '  A: Health section → Sleep Tracking → Enter sleep hours → Save\n'
        '• Q: How do I change daily water goal?\n'
        '  A: Health section → Settings → Water Goal → Edit value\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '⭐ **XP System**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**What You Can Do:**\n'
        '• Earn XP for daily activities:\n'
        '  - Log meal: +10 XP\n'
        '  - Complete workout: +25 XP\n'
        '  - Drink water: +2 XP\n'
        '  - Log sleep: +5 XP\n'
        '  - Complete goal: +50 XP\n'
        '• Automatic level ups\n'
        '• Unlockable achievements\n'
        '• Redeem XP in pharmacy for discounts\n\n'
        '**How to Use:**\n'
        '• Use app daily to perform activities\n'
        '• Monitor XP on home dashboard\n'
        '• When reaching threshold, you\'ll level up automatically\n'
        '• Go to profile to view achievements\n\n'
        '**Frequently Asked Questions:**\n'
        '• Q: How do I earn XP quickly?\n'
        '  A: Log meals, complete workouts, drink water, and log sleep daily\n'
        '• Q: How do I know how much XP I need to level up?\n'
        '  A: Ask me "my XP" or "XP" and I\'ll give you details\n'
        '• Q: How do I redeem XP in pharmacy?\n'
        '  A: Pharmacy section → Select product → Redeem XP → Get discount\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '🔗 **Additional Features**\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n\n'
        '**Google Fit / Smartwatch Integration:**\n'
        '• Go to Settings → Connect Devices\n'
        '• Tap "Connect Google Fit"\n'
        '• Grant required permissions\n'
        '• Tap "Sync Now" to fetch data\n\n'
        '**Notifications:**\n'
        '• Go to Settings → Notifications\n'
        '• Enable/disable different notification types\n'
        '• Medicine reminders, workouts, water, etc.\n\n'
        '**Language:**\n'
        '• Go to Settings → Language\n'
        '• Select Arabic or English\n'
        '• App fully supports both languages\n\n'
        '**Dark Mode:**\n'
        '• Go to Settings → Appearance\n'
        '• Select Light, Dark, or Auto\n\n'
        '━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━\n'
        '💡 **Usage Tips:**\n'
        '• Ask me about any feature for detailed explanation\n'
        '• Use menus for quick access\n'
        '• Track your progress daily to earn more XP\n'
        '• Connect Google Fit for automatic data sync\n'
        '• Enable notifications to remind you of important activities\n\n'
        'What feature would you like to explore more?';
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
  
  /// Get actionable suggestions based on user state (enhanced)
  List<String> getActionableSuggestions({
    required String userEmail,
    UserModel? user,
    List<MealModel>? todayMeals,
    NutritionGoalModel? nutritionGoal,
    int? waterIntake,
    int? waterGoal,
    double? sleepHours,
    List<WorkoutModel>? recentWorkouts,
    required bool isArabic,
  }) {
    final suggestions = <String>[];
    
    // Nutrition suggestions
    if (todayMeals != null && nutritionGoal != null) {
      final caloriesConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.calories);
      final proteinConsumed = todayMeals.fold(0.0, (sum, meal) => sum + meal.protein);
      
      if (caloriesConsumed < nutritionGoal.caloriesGoal * 0.5) {
        suggestions.add(isArabic ? 'سجل وجبة في قسم التغذية' : 'Log a meal in Nutrition section');
      }
      if (caloriesConsumed > nutritionGoal.caloriesGoal * 1.2) {
        suggestions.add(isArabic ? 'فكر في وجبات عشاء أخف' : 'Consider lighter meals for dinner');
      }
      if (proteinConsumed < nutritionGoal.proteinGoal * 0.7) {
        suggestions.add(isArabic ? 'أضف المزيد من البروتين إلى وجباتك' : 'Add more protein to your meals');
      }
    }
    
    // Water suggestions
    if (waterIntake != null && waterGoal != null) {
      final percentage = (waterIntake / waterGoal * 100);
      if (percentage < 50) {
        suggestions.add(isArabic ? 'اشرب ماء الآن - أنت أقل من 50% من هدفك' : 'Drink water now - you\'re below 50% of goal');
      } else if (percentage < 75) {
        suggestions.add(isArabic ? 'استمر في شرب الماء' : 'Keep drinking water');
      }
    }
    
    // Sleep suggestions
    if (sleepHours != null) {
      if (sleepHours < 7) {
        suggestions.add(isArabic ? 'استهدف 7-9 ساعات نوم الليلة' : 'Aim for 7-9 hours of sleep tonight');
      } else if (sleepHours > 9) {
        suggestions.add(isArabic ? 'قد يكون نومك أكثر من اللازم' : 'Your sleep may be excessive');
      }
    } else {
      suggestions.add(isArabic ? 'سجل نومك في قسم الصحة' : 'Log your sleep in Health section');
    }
    
    // Workout suggestions
    if (recentWorkouts != null) {
      final todayWorkouts = recentWorkouts.where((w) {
        final workoutDate = w.workoutDate;
        final today = DateTime.now();
        return workoutDate.year == today.year &&
               workoutDate.month == today.month &&
               workoutDate.day == today.day;
      }).length;
      
      if (todayWorkouts == 0) {
        suggestions.add(isArabic ? 'ابدأ تمريناً اليوم' : 'Start a workout today');
      }
    }
    
    // XP suggestions
    if (user != null) {
      final xpForNext = XPService.xpForNextLevel(user.level, user.xp);
      if (xpForNext < 50) {
        suggestions.add(isArabic ? 'أنت قريب من الترقي! أكمل نشاطاً' : 'You\'re close to leveling up! Complete an activity');
      } else if (user.xp < 100) {
        suggestions.add(isArabic ? 'أكمل الأنشطة اليومية لكسب XP' : 'Complete daily activities to earn XP');
      }
    }
    
    return suggestions;
  }
}

