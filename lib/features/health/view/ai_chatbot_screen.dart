import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../providers/auth_provider.dart';

class AIChatbotScreen extends ConsumerStatefulWidget {
  const AIChatbotScreen({super.key});

  @override
  ConsumerState<AIChatbotScreen> createState() => _AIChatbotScreenState();
}

class _AIChatbotScreenState extends ConsumerState<AIChatbotScreen>
    with TickerProviderStateMixin {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();
  bool _isTyping = false;

  final List<ChatMessage> _messages = [];

  // Suggested quick actions
  final List<QuickAction> _quickActions = [
    QuickAction(
      icon: Icons.medical_services_outlined,
      label: 'Health Tips',
      query: 'Give me personalized health tips based on my profile',
    ),
    QuickAction(
      icon: Icons.medication_outlined,
      label: 'Medicine Info',
      query: 'Tell me about my current medications and reminders',
    ),
    QuickAction(
      icon: Icons.restaurant_outlined,
      label: 'Nutrition Advice',
      query: 'What should I eat today for better health?',
    ),
    QuickAction(
      icon: Icons.fitness_center_outlined,
      label: 'Workout Plan',
      query: 'Suggest a workout routine for me',
    ),
    QuickAction(
      icon: Icons.bedtime_outlined,
      label: 'Sleep Analysis',
      query: 'Analyze my sleep patterns and give recommendations',
    ),
    QuickAction(
      icon: Icons.water_drop_outlined,
      label: 'Hydration',
      query: 'How much water should I drink today?',
    ),
  ];

  late AnimationController _pulseController;
  late Animation<double> _pulseAnimation;

  @override
  void initState() {
    super.initState();
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..repeat(reverse: true);
    _pulseAnimation = Tween<double>(begin: 0.95, end: 1.05).animate(
      CurvedAnimation(parent: _pulseController, curve: Curves.easeInOut),
    );

    // Add welcome message
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _addWelcomeMessage();
    });
  }

  void _addWelcomeMessage() {
    final user = ref.read(authProvider).user;
    final userName = user?.name?.split(' ').first ?? 'there';
    
    setState(() {
      _messages.add(ChatMessage(
        text: "Hello $userName! 👋\n\nI'm Sehati AI, your personal health assistant. I can help you with:\n\n• Health insights & recommendations\n• Medicine information & reminders\n• Nutrition & diet advice\n• Fitness & workout suggestions\n• Sleep & wellness tips\n\nHow can I assist you today?",
        isUser: false,
        timestamp: DateTime.now(),
      ));
    });
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  void _sendMessage([String? customMessage]) {
    final text = customMessage ?? _messageController.text.trim();
    if (text.isEmpty) return;

    setState(() {
      _messages.add(ChatMessage(
        text: text,
        isUser: true,
        timestamp: DateTime.now(),
      ));
      _isTyping = true;
    });

    _messageController.clear();
    _scrollToBottom();

    // Simulate AI response
    Future.delayed(const Duration(milliseconds: 1500), () {
      if (mounted) {
        setState(() {
          _isTyping = false;
          _messages.add(ChatMessage(
            text: _generateAIResponse(text),
            isUser: false,
            timestamp: DateTime.now(),
          ));
        });
        _scrollToBottom();
      }
    });
  }

  String _generateAIResponse(String query) {
    final lowerQuery = query.toLowerCase().trim();
    
    // Check if query is health/fitness/app related
    if (!_isHealthRelatedQuery(lowerQuery)) {
      return _getOffTopicResponse();
    }
    
    // Greetings
    if (_isGreeting(lowerQuery)) {
      return _getGreetingResponse();
    }
    
    // Thank you responses
    if (lowerQuery.contains('thank') || lowerQuery.contains('thanks')) {
      return "You're welcome! 😊\n\n"
          "I'm always here to help with your health journey. Feel free to ask me anything about:\n\n"
          "• Nutrition & diet planning\n"
          "• Fitness & workouts\n"
          "• Medicine management\n"
          "• Sleep & wellness\n\n"
          "Stay healthy! 💪";
    }
    
    // Analyze query intent and provide smart response
    return _getSmartResponse(lowerQuery);
  }

  bool _isGreeting(String query) {
    final greetings = ['hello', 'hi', 'hey', 'good morning', 'good afternoon', 
                       'good evening', 'good night', 'howdy', 'greetings'];
    return greetings.any((g) => query.startsWith(g) || query == g);
  }

  String _getGreetingResponse() {
    final user = ref.read(authProvider).user;
    final userName = user?.name?.split(' ').first ?? 'there';
    final hour = DateTime.now().hour;
    
    String timeGreeting;
    if (hour < 12) {
      timeGreeting = "Good morning";
    } else if (hour < 17) {
      timeGreeting = "Good afternoon";
    } else {
      timeGreeting = "Good evening";
    }
    
    return "$timeGreeting, $userName! 👋\n\n"
        "I hope you're having a great day! How can I help you with your health today?\n\n"
        "You can ask me about:\n"
        "• 🥗 What to eat for better energy\n"
        "• 💪 Workout recommendations\n"
        "• 💊 Medicine reminders\n"
        "• 😴 Sleep improvement tips\n"
        "• 💧 Hydration goals\n\n"
        "What's on your mind?";
  }

  String _getSmartResponse(String query) {
    // MEDICINE & MEDICATION
    if (_matchesIntent(query, ['medicine', 'medication', 'pill', 'drug', 'prescription', 'dose', 'dosage'])) {
      if (query.contains('side effect') || query.contains('reaction')) {
        return "⚠️ **About Medication Side Effects**\n\n"
            "Side effects vary by medication. Common ones include:\n\n"
            "• **Mild**: Drowsiness, nausea, headache\n"
            "• **Moderate**: Dizziness, stomach upset\n"
            "• **Serious**: Allergic reactions (seek help immediately)\n\n"
            "**Important Tips:**\n"
            "• Always read medication labels carefully\n"
            "• Take medicines with food if they cause stomach upset\n"
            "• Never stop prescribed medication without consulting your doctor\n"
            "• Report unusual symptoms to your healthcare provider\n\n"
            "⚕️ *For specific medication concerns, please consult your doctor or pharmacist.*";
      }
      if (query.contains('miss') || query.contains('forgot') || query.contains('skip')) {
        return "💊 **Missed Dose Guidelines**\n\n"
            "If you missed a dose:\n\n"
            "**General Rule:**\n"
            "• If it's close to the scheduled time → Take it now\n"
            "• If it's almost time for next dose → Skip the missed one\n"
            "• Never double up doses\n\n"
            "**For Specific Medications:**\n"
            "• Blood pressure meds: Take as soon as you remember\n"
            "• Antibiotics: Maintain regular intervals\n"
            "• Pain relievers: Wait for next scheduled dose\n\n"
            "📱 **Tip**: Set up reminders in Sehati to never miss a dose!\n\n"
            "⚕️ *Always follow your doctor's specific instructions.*";
      }
      if (query.contains('remind') || query.contains('schedule') || query.contains('set')) {
        return "⏰ **Setting Up Medicine Reminders**\n\n"
            "To add a medicine reminder in Sehati:\n\n"
            "1️⃣ Go to **Health** → **Medicine Reminders**\n"
            "2️⃣ Tap **Add Medicine**\n"
            "3️⃣ Enter medicine name and dosage\n"
            "4️⃣ Set the time(s) for your doses\n"
            "5️⃣ Choose which days to repeat\n"
            "6️⃣ Save your reminder\n\n"
            "**Benefits of tracking:**\n"
            "• Never miss a dose\n"
            "• Track your adherence\n"
            "• Earn XP for consistency!\n\n"
            "Would you like me to guide you through setting one up?";
      }
      return "💊 **Medication Management**\n\n"
          "Proper medication management is crucial for your health.\n\n"
          "**Best Practices:**\n"
          "• Take medicines at the same time daily\n"
          "• Store medications properly (cool, dry place)\n"
          "• Keep a list of all your medications\n"
          "• Check expiration dates regularly\n"
          "• Don't share prescription medications\n\n"
          "**In Sehati, you can:**\n"
          "• Set up automatic reminders\n"
          "• Track your intake history\n"
          "• Order refills from the pharmacy\n"
          "• View medication information\n\n"
          "What specific help do you need with your medications?";
    }

    // NUTRITION & DIET
    if (_matchesIntent(query, ['nutrition', 'diet', 'food', 'eat', 'meal', 'calorie', 'protein', 'carb', 'fat', 'vitamin', 'breakfast', 'lunch', 'dinner', 'snack', 'hungry'])) {
      if (query.contains('lose weight') || query.contains('weight loss') || query.contains('slim')) {
        return "🎯 **Weight Loss Nutrition Plan**\n\n"
            "**Daily Calorie Target:** 1500-1800 kcal (adjust based on activity)\n\n"
            "**Meal Structure:**\n\n"
            "🌅 **Breakfast (300-400 kcal)**\n"
            "• 2 eggs + whole grain toast + avocado\n"
            "• Or: Greek yogurt + berries + nuts\n\n"
            "☀️ **Lunch (400-500 kcal)**\n"
            "• Grilled chicken salad with olive oil dressing\n"
            "• Or: Quinoa bowl with vegetables\n\n"
            "🌙 **Dinner (400-500 kcal)**\n"
            "• Baked fish + steamed vegetables\n"
            "• Or: Lean protein + brown rice + greens\n\n"
            "🍎 **Snacks (200 kcal total)**\n"
            "• Fruits, nuts, vegetables with hummus\n\n"
            "**Key Tips:**\n"
            "• Drink water before meals\n"
            "• Eat slowly (20 min per meal)\n"
            "• Avoid processed foods\n"
            "• Track everything in Sehati!";
      }
      if (query.contains('gain weight') || query.contains('bulk') || query.contains('muscle mass')) {
        return "💪 **Weight Gain & Muscle Building Plan**\n\n"
            "**Daily Calorie Target:** 2500-3000 kcal\n"
            "**Protein Goal:** 1.6-2g per kg body weight\n\n"
            "**Meal Structure:**\n\n"
            "🌅 **Breakfast (600-700 kcal)**\n"
            "• 4 eggs + oatmeal + banana + peanut butter\n"
            "• Protein shake with whole milk\n\n"
            "☀️ **Lunch (700-800 kcal)**\n"
            "• Large chicken breast + rice + vegetables\n"
            "• Add healthy fats (olive oil, avocado)\n\n"
            "🌙 **Dinner (700-800 kcal)**\n"
            "• Salmon/steak + sweet potato + salad\n"
            "• Post-dinner: Casein shake or cottage cheese\n\n"
            "🍎 **Snacks (400-500 kcal)**\n"
            "• Trail mix, protein bars, smoothies\n\n"
            "**Key Tips:**\n"
            "• Eat every 3-4 hours\n"
            "• Never skip meals\n"
            "• Combine with strength training\n"
            "• Get 7-8 hours sleep for recovery";
      }
      if (query.contains('protein')) {
        return "🥩 **Protein Guide**\n\n"
            "**Daily Requirement:**\n"
            "• Sedentary: 0.8g per kg body weight\n"
            "• Active: 1.2-1.6g per kg\n"
            "• Athletes: 1.6-2.2g per kg\n\n"
            "**Best Protein Sources:**\n\n"
            "🥚 **Animal-Based:**\n"
            "• Chicken breast: 31g per 100g\n"
            "• Eggs: 6g per egg\n"
            "• Greek yogurt: 17g per cup\n"
            "• Fish (salmon): 25g per 100g\n"
            "• Lean beef: 26g per 100g\n\n"
            "🌱 **Plant-Based:**\n"
            "• Lentils: 9g per 100g\n"
            "• Chickpeas: 8g per 100g\n"
            "• Tofu: 8g per 100g\n"
            "• Quinoa: 4g per 100g\n\n"
            "**Timing Tips:**\n"
            "• Spread intake across all meals\n"
            "• Post-workout: 20-30g within 1 hour\n"
            "• Before bed: Slow-digesting protein (casein)";
      }
      if (query.contains('breakfast')) {
        return "🌅 **Healthy Breakfast Ideas**\n\n"
            "A good breakfast should include protein, complex carbs, and healthy fats.\n\n"
            "**Quick Options (5-10 min):**\n"
            "• Greek yogurt + granola + berries (350 kcal)\n"
            "• Overnight oats with banana (400 kcal)\n"
            "• Whole grain toast + avocado + egg (380 kcal)\n\n"
            "**Hearty Options (15-20 min):**\n"
            "• Veggie omelet + whole grain toast (450 kcal)\n"
            "• Smoothie bowl with protein (400 kcal)\n"
            "• Oatmeal with nuts and honey (420 kcal)\n\n"
            "**On-the-Go:**\n"
            "• Protein shake + banana (300 kcal)\n"
            "• Hard-boiled eggs + fruit (250 kcal)\n\n"
            "**Benefits of Breakfast:**\n"
            "• Kickstarts metabolism\n"
            "• Improves concentration\n"
            "• Controls hunger throughout the day\n"
            "• Provides essential nutrients";
      }
      return "🥗 **Personalized Nutrition Advice**\n\n"
          "**Balanced Daily Intake:**\n"
          "• Calories: 1800-2200 kcal (varies by activity)\n"
          "• Protein: 50-100g\n"
          "• Carbs: 225-325g (focus on complex carbs)\n"
          "• Fats: 44-78g (healthy fats)\n"
          "• Fiber: 25-30g\n\n"
          "**Meal Timing:**\n"
          "• Breakfast: Within 1 hour of waking\n"
          "• Lunch: 4-5 hours after breakfast\n"
          "• Dinner: 3 hours before bed\n"
          "• Snacks: Between meals if hungry\n\n"
          "**Foods to Include:**\n"
          "✅ Lean proteins, vegetables, fruits\n"
          "✅ Whole grains, legumes, nuts\n"
          "✅ Healthy fats (olive oil, avocado)\n\n"
          "**Foods to Limit:**\n"
          "❌ Processed foods, sugary drinks\n"
          "❌ Excessive sodium, trans fats\n\n"
          "Log your meals in Sehati to track your nutrition!";
    }

    // FITNESS & WORKOUT
    if (_matchesIntent(query, ['workout', 'exercise', 'fitness', 'gym', 'training', 'muscle', 'cardio', 'strength', 'run', 'running', 'lift', 'weight training'])) {
      if (query.contains('beginner') || query.contains('start') || query.contains('new')) {
        return "🏃 **Beginner Workout Plan**\n\n"
            "Start slow and build consistency!\n\n"
            "**Week 1-2: Foundation**\n"
            "• 3 days/week, 20-30 minutes\n"
            "• Focus on form, not intensity\n\n"
            "**Sample Workout:**\n\n"
            "🔥 **Warm-up (5 min)**\n"
            "• Marching in place\n"
            "• Arm circles\n"
            "• Light stretching\n\n"
            "💪 **Main (15-20 min)**\n"
            "• Bodyweight squats: 2×10\n"
            "• Wall push-ups: 2×10\n"
            "• Lunges: 2×8 each leg\n"
            "• Plank: 2×20 seconds\n"
            "• Glute bridges: 2×10\n\n"
            "🧘 **Cool-down (5 min)**\n"
            "• Stretching all major muscles\n\n"
            "**Progress Tips:**\n"
            "• Add 1 rep per week\n"
            "• Increase to 4 days by week 4\n"
            "• Rest at least 1 day between sessions";
      }
      if (query.contains('home') || query.contains('no equipment') || query.contains('bodyweight')) {
        return "🏠 **Home Workout (No Equipment)**\n\n"
            "**Full Body Circuit (30 min)**\n\n"
            "Perform 3 rounds, 45 sec each exercise, 15 sec rest:\n\n"
            "**Round 1 - Upper Body:**\n"
            "• Push-ups (or knee push-ups)\n"
            "• Tricep dips (using chair)\n"
            "• Plank shoulder taps\n"
            "• Diamond push-ups\n\n"
            "**Round 2 - Lower Body:**\n"
            "• Squats\n"
            "• Lunges (alternating)\n"
            "• Glute bridges\n"
            "• Calf raises\n\n"
            "**Round 3 - Core & Cardio:**\n"
            "• Mountain climbers\n"
            "• Bicycle crunches\n"
            "• Burpees (modified if needed)\n"
            "• High knees\n\n"
            "**Calories Burned:** ~250-350 kcal\n\n"
            "💡 *Do this 3-4 times per week for best results!*";
      }
      if (query.contains('cardio') || query.contains('heart') || query.contains('endurance')) {
        return "❤️ **Cardio & Heart Health**\n\n"
            "**Recommended:** 150 min moderate OR 75 min vigorous cardio/week\n\n"
            "**Cardio Options by Intensity:**\n\n"
            "🚶 **Low Intensity (60-70% max HR)**\n"
            "• Walking: 100 kcal/30 min\n"
            "• Swimming (easy): 150 kcal/30 min\n"
            "• Cycling (casual): 120 kcal/30 min\n\n"
            "🏃 **Moderate (70-80% max HR)**\n"
            "• Jogging: 250 kcal/30 min\n"
            "• Dancing: 200 kcal/30 min\n"
            "• Elliptical: 220 kcal/30 min\n\n"
            "🔥 **High Intensity (80-90% max HR)**\n"
            "• Running: 350 kcal/30 min\n"
            "• HIIT: 400 kcal/30 min\n"
            "• Jump rope: 300 kcal/30 min\n\n"
            "**Your Max HR:** ~(220 - your age) bpm\n\n"
            "**Benefits:**\n"
            "• Strengthens heart\n"
            "• Burns fat\n"
            "• Improves mood\n"
            "• Increases energy";
      }
      return "💪 **Personalized Workout Plan**\n\n"
          "**Weekly Schedule:**\n\n"
          "📅 **Monday - Push (Chest, Shoulders, Triceps)**\n"
          "• Push-ups: 3×12\n"
          "• Shoulder press: 3×10\n"
          "• Tricep dips: 3×10\n\n"
          "📅 **Tuesday - Pull (Back, Biceps)**\n"
          "• Rows: 3×12\n"
          "• Bicep curls: 3×10\n"
          "• Superman holds: 3×30 sec\n\n"
          "📅 **Wednesday - Cardio/Rest**\n"
          "• 30 min walking/jogging\n"
          "• Or active recovery (yoga)\n\n"
          "📅 **Thursday - Legs**\n"
          "• Squats: 3×15\n"
          "• Lunges: 3×10 each\n"
          "• Calf raises: 3×20\n\n"
          "📅 **Friday - Full Body HIIT**\n"
          "• 20 min circuit training\n\n"
          "📅 **Sat/Sun - Rest or Light Activity**\n\n"
          "Track your workouts in Sehati to monitor progress!";
    }

    // SLEEP
    if (_matchesIntent(query, ['sleep', 'insomnia', 'tired', 'fatigue', 'rest', 'nap', 'bedtime', 'wake', 'dream', 'nightmare'])) {
      if (query.contains('can\'t sleep') || query.contains('insomnia') || query.contains('trouble')) {
        return "😴 **Overcoming Sleep Problems**\n\n"
            "**Immediate Relief:**\n"
            "• 4-7-8 breathing: Inhale 4s, hold 7s, exhale 8s\n"
            "• Progressive muscle relaxation\n"
            "• Listen to white noise or rain sounds\n\n"
            "**Sleep Hygiene Checklist:**\n"
            "✅ Same bedtime every night (even weekends)\n"
            "✅ No screens 1 hour before bed\n"
            "✅ Room temperature: 65-68°F (18-20°C)\n"
            "✅ Complete darkness (use blackout curtains)\n"
            "✅ No caffeine after 2 PM\n"
            "✅ No large meals 3 hours before bed\n"
            "✅ Exercise, but not within 4 hours of bedtime\n\n"
            "**Natural Sleep Aids:**\n"
            "• Chamomile tea\n"
            "• Warm milk\n"
            "• Magnesium-rich foods\n"
            "• Lavender aromatherapy\n\n"
            "⚕️ *If problems persist over 2 weeks, consult a doctor.*";
      }
      if (query.contains('how much') || query.contains('how long') || query.contains('hours')) {
        return "⏰ **Sleep Duration by Age**\n\n"
            "**Recommended Hours per Night:**\n\n"
            "👶 Infants (4-12 months): 12-16 hours\n"
            "🧒 Toddlers (1-2 years): 11-14 hours\n"
            "👦 Children (3-5 years): 10-13 hours\n"
            "🧑 School age (6-12): 9-12 hours\n"
            "👨‍🎓 Teens (13-18): 8-10 hours\n"
            "👨 Adults (18-64): 7-9 hours\n"
            "👴 Seniors (65+): 7-8 hours\n\n"
            "**Quality Matters Too:**\n"
            "• Deep sleep: 15-20% of total\n"
            "• REM sleep: 20-25% of total\n"
            "• Sleep cycles: 4-6 per night (90 min each)\n\n"
            "**Signs of Good Sleep:**\n"
            "• Fall asleep within 15-20 min\n"
            "• Wake up refreshed\n"
            "• Alert throughout the day\n"
            "• No daytime drowsiness";
      }
      return "😴 **Complete Sleep Guide**\n\n"
          "**Optimal Sleep:** 7-9 hours for adults\n\n"
          "**Before Bed Routine:**\n"
          "• 2 hours before: No heavy meals\n"
          "• 1 hour before: No screens, dim lights\n"
          "• 30 min before: Relaxation (reading, stretching)\n"
          "• At bedtime: Dark, cool, quiet room\n\n"
          "**Sleep Quality Factors:**\n"
          "🌡️ Room temp: 65-68°F (18-20°C)\n"
          "🌙 Complete darkness\n"
          "🔇 Minimal noise\n"
          "🛏️ Comfortable mattress\n\n"
          "**What Disrupts Sleep:**\n"
          "❌ Caffeine, alcohol, nicotine\n"
          "❌ Blue light from screens\n"
          "❌ Irregular schedule\n"
          "❌ Stress and anxiety\n\n"
          "Track your sleep in Sehati for personalized insights!";
    }

    // WATER & HYDRATION
    if (_matchesIntent(query, ['water', 'hydration', 'drink', 'thirst', 'fluid', 'dehydrat'])) {
      return "💧 **Complete Hydration Guide**\n\n"
          "**Daily Water Intake:**\n"
          "• Women: ~2.7 liters (91 oz)\n"
          "• Men: ~3.7 liters (125 oz)\n"
          "• *Includes water from food (~20%)*\n\n"
          "**Increase Intake If:**\n"
          "• Exercising: +500ml per 30 min workout\n"
          "• Hot weather: +500ml-1L\n"
          "• Illness (fever, diarrhea)\n"
          "• Pregnancy/breastfeeding\n\n"
          "**Signs of Dehydration:**\n"
          "⚠️ Dark yellow urine\n"
          "⚠️ Dry mouth, headache\n"
          "⚠️ Fatigue, dizziness\n"
          "⚠️ Decreased urination\n\n"
          "**Hydration Tips:**\n"
          "• Start day with 1-2 glasses\n"
          "• Drink before you feel thirsty\n"
          "• Carry a water bottle\n"
          "• Set hourly reminders\n"
          "• Eat water-rich foods (cucumber, watermelon)\n\n"
          "Track your intake in Sehati's Water section!";
    }

    // WEIGHT MANAGEMENT
    if (_matchesIntent(query, ['weight', 'bmi', 'lose', 'gain', 'slim', 'overweight', 'obese', 'skinny', 'thin', 'fat'])) {
      if (query.contains('bmi') || query.contains('body mass')) {
        return "📊 **Understanding BMI**\n\n"
            "**BMI Formula:** Weight(kg) / Height(m)²\n\n"
            "**BMI Categories:**\n"
            "• Underweight: < 18.5\n"
            "• Normal: 18.5 - 24.9\n"
            "• Overweight: 25 - 29.9\n"
            "• Obese Class I: 30 - 34.9\n"
            "• Obese Class II: 35 - 39.9\n"
            "• Obese Class III: ≥ 40\n\n"
            "**BMI Limitations:**\n"
            "• Doesn't account for muscle mass\n"
            "• Not accurate for athletes\n"
            "• Doesn't show fat distribution\n\n"
            "**Better Health Indicators:**\n"
            "• Waist circumference\n"
            "• Body fat percentage\n"
            "• Waist-to-hip ratio\n\n"
            "Check your BMI in Sehati's Profile section!";
      }
      return "⚖️ **Weight Management Guide**\n\n"
          "**Healthy Weight Loss:** 0.5-1 kg per week\n"
          "**Healthy Weight Gain:** 0.25-0.5 kg per week\n\n"
          "**For Weight Loss:**\n"
          "• Calorie deficit: 500 kcal/day\n"
          "• High protein (keeps you full)\n"
          "• Cardio + strength training\n"
          "• Avoid processed foods\n"
          "• Get enough sleep\n\n"
          "**For Weight Gain:**\n"
          "• Calorie surplus: 300-500 kcal/day\n"
          "• Eat more frequently\n"
          "• Focus on strength training\n"
          "• Healthy calorie-dense foods\n\n"
          "**Key Principles:**\n"
          "✅ Consistency over perfection\n"
          "✅ Track everything\n"
          "✅ Be patient (results take time)\n"
          "✅ Focus on habits, not just numbers\n\n"
          "Track your progress in Sehati!";
    }

    // STRESS & MENTAL WELLNESS
    if (_matchesIntent(query, ['stress', 'anxiety', 'mental', 'relax', 'calm', 'meditation', 'mood', 'depress', 'worry', 'nervous', 'panic'])) {
      return "🧘 **Mental Wellness & Stress Management**\n\n"
          "**Immediate Stress Relief:**\n\n"
          "🌬️ **Box Breathing (4-4-4-4)**\n"
          "• Inhale: 4 seconds\n"
          "• Hold: 4 seconds\n"
          "• Exhale: 4 seconds\n"
          "• Hold: 4 seconds\n"
          "• Repeat 4 times\n\n"
          "**Daily Stress Prevention:**\n"
          "• Exercise: 30 min daily (natural mood booster)\n"
          "• Sleep: 7-8 hours (reduces cortisol)\n"
          "• Hydration: Dehydration increases stress\n"
          "• Nutrition: Avoid excessive caffeine/sugar\n"
          "• Nature: 20 min outdoors daily\n\n"
          "**Relaxation Techniques:**\n"
          "• Progressive muscle relaxation\n"
          "• Guided meditation (5-10 min)\n"
          "• Journaling\n"
          "• Light stretching or yoga\n\n"
          "**Physical Activity for Mental Health:**\n"
          "• Walking: Reduces anxiety\n"
          "• Yoga: Calms the nervous system\n"
          "• Swimming: Meditative effect\n\n"
          "⚕️ *If stress persists, consider speaking with a professional.*";
    }

    // STEPS & ACTIVITY
    if (_matchesIntent(query, ['step', 'walk', 'activity', 'move', 'active', 'sedentary', 'sitting'])) {
      return "🚶 **Daily Activity & Steps Guide**\n\n"
          "**Step Goals:**\n"
          "• Sedentary: < 5,000 steps\n"
          "• Lightly active: 5,000-7,499\n"
          "• Moderately active: 7,500-9,999\n"
          "• Active: 10,000-12,499\n"
          "• Very active: > 12,500\n\n"
          "**Health Benefits by Steps:**\n"
          "• 4,000 steps: Reduces mortality risk\n"
          "• 7,000 steps: Significant health benefits\n"
          "• 10,000 steps: Optimal for weight management\n\n"
          "**Calories Burned (walking):**\n"
          "• 1,000 steps ≈ 40-50 kcal\n"
          "• 10,000 steps ≈ 400-500 kcal\n\n"
          "**Tips to Move More:**\n"
          "• Take stairs instead of elevator\n"
          "• Walk during phone calls\n"
          "• Park farther away\n"
          "• Set hourly movement reminders\n"
          "• Walking meetings\n"
          "• After-meal walks (aids digestion)\n\n"
          "Track your steps in Sehati!";
    }

    // APP FEATURES
    if (_matchesIntent(query, ['app', 'feature', 'how to', 'use', 'sehati', 'help', 'guide', 'tutorial'])) {
      return "📱 **Sehati App Complete Guide**\n\n"
          "**🏠 Home Dashboard**\n"
          "• View daily summary\n"
          "• Quick access to all features\n"
          "• AI-powered health insights\n\n"
          "**💊 Medicine Management**\n"
          "• Set medication reminders\n"
          "• Track intake history\n"
          "• Never miss a dose\n\n"
          "**🥗 Nutrition Tracking**\n"
          "• Log meals and calories\n"
          "• Track macros (protein, carbs, fat)\n"
          "• Get meal suggestions\n\n"
          "**🏃 Fitness**\n"
          "• Browse workout library\n"
          "• Track activities\n"
          "• Monitor progress\n\n"
          "**💧 Health Tracking**\n"
          "• Water intake\n"
          "• Sleep patterns\n"
          "• Health goals\n\n"
          "**🏥 Services**\n"
          "• Book appointments\n"
          "• Order lab tests\n"
          "• Home health services\n\n"
          "**💊 Pharmacy**\n"
          "• Order medicines\n"
          "• Upload prescriptions\n"
          "• Track orders\n\n"
          "What feature would you like to explore?";
    }

    // GENERAL HEALTH
    if (_matchesIntent(query, ['health', 'healthy', 'wellness', 'tip', 'advice', 'recommend', 'suggest', 'improve', 'better'])) {
      return "🌟 **Your Personalized Health Tips**\n\n"
          "**Daily Health Checklist:**\n\n"
          "☀️ **Morning**\n"
          "• Drink water upon waking\n"
          "• Eat a balanced breakfast\n"
          "• 10 min stretching or exercise\n\n"
          "🌤️ **Throughout the Day**\n"
          "• Stay hydrated (8+ glasses)\n"
          "• Take movement breaks every hour\n"
          "• Eat balanced meals\n"
          "• Practice good posture\n\n"
          "🌙 **Evening**\n"
          "• Light dinner 3 hours before bed\n"
          "• Limit screen time\n"
          "• Relaxation routine\n"
          "• 7-9 hours quality sleep\n\n"
          "**Weekly Goals:**\n"
          "• 150 min moderate exercise\n"
          "• 2+ strength training sessions\n"
          "• Meal prep for healthy eating\n"
          "• Social connection time\n\n"
          "Track your progress in Sehati!";
    }

    // Default smart response
    return "I'd be happy to help with that! 🌟\n\n"
        "Based on your question, I can provide guidance on:\n\n"
        "• 💊 **Medications**: Reminders, dosage, interactions\n"
        "• 🥗 **Nutrition**: Meal plans, calories, macros\n"
        "• 🏃 **Fitness**: Workouts, cardio, strength training\n"
        "• 💧 **Hydration**: Daily water intake goals\n"
        "• 😴 **Sleep**: Quality improvement tips\n"
        "• ⚖️ **Weight**: Management strategies\n"
        "• 🧘 **Wellness**: Stress, mental health\n\n"
        "Could you tell me more specifically what you'd like to know? The more details you provide, the better I can help!";
  }

  /// Check if query matches any of the given keywords
  bool _matchesIntent(String query, List<String> keywords) {
    return keywords.any((keyword) => query.contains(keyword));
  }

  /// Check if the query is related to health, fitness, or app features
  bool _isHealthRelatedQuery(String query) {
    final healthKeywords = [
      // Health general
      'health', 'healthy', 'wellness', 'wellbeing', 'medical', 'doctor', 'hospital',
      // Fitness
      'fitness', 'exercise', 'workout', 'gym', 'training', 'cardio', 'strength',
      'muscle', 'run', 'running', 'walk', 'walking', 'step', 'active', 'activity',
      // Nutrition
      'nutrition', 'diet', 'food', 'eat', 'eating', 'meal', 'calorie', 'protein',
      'carb', 'fat', 'vitamin', 'mineral', 'breakfast', 'lunch', 'dinner', 'snack',
      // Medicine
      'medicine', 'medication', 'pill', 'drug', 'prescription', 'dose', 'reminder',
      'pharmacy', 'supplement',
      // Body
      'weight', 'bmi', 'body', 'lose', 'gain', 'slim', 'muscle', 'heart', 'blood',
      'pressure', 'sugar', 'cholesterol',
      // Sleep
      'sleep', 'rest', 'insomnia', 'tired', 'fatigue', 'nap', 'bedtime', 'wake',
      // Water
      'water', 'hydration', 'drink', 'thirst', 'fluid',
      // Mental
      'stress', 'anxiety', 'mental', 'relax', 'calm', 'meditation', 'mood',
      // App features
      'app', 'feature', 'sehati', 'track', 'log', 'goal', 'progress', 'report',
      'appointment', 'lab', 'test', 'service', 'order', 'reminder',
      // Common health questions
      'tip', 'advice', 'recommend', 'suggest', 'help', 'how to', 'what should',
      'pain', 'ache', 'sick', 'symptom', 'feel', 'better', 'improve',
      // Greetings (allow these)
      'hello', 'hi', 'hey', 'good morning', 'good evening', 'thank', 'thanks',
    ];
    
    for (final keyword in healthKeywords) {
      if (query.contains(keyword)) {
        return true;
      }
    }
    return false;
  }

  /// Response for off-topic queries
  String _getOffTopicResponse() {
    final responses = [
      "I appreciate your question, but I'm specifically designed to help with health and fitness topics! 🏥\n\n"
          "I can assist you with:\n"
          "• 💊 Medicine reminders\n"
          "• 🥗 Nutrition advice\n"
          "• 🏃 Workout plans\n"
          "• 💧 Hydration tracking\n"
          "• 😴 Sleep tips\n\n"
          "Is there anything health-related I can help you with?",
      
      "I'm your health assistant, so I focus only on health, fitness, and wellness topics! 💪\n\n"
          "Try asking me about:\n"
          "• Your medication schedule\n"
          "• Diet and nutrition tips\n"
          "• Exercise recommendations\n"
          "• Sleep improvement\n"
          "• Using the Sehati app\n\n"
          "What health topic can I help you with today?",
      
      "That's outside my area of expertise! I'm here to support your health journey. 🌟\n\n"
          "I'd love to help you with:\n"
          "• Health tips and advice\n"
          "• Fitness and workout guidance\n"
          "• Nutrition and meal planning\n"
          "• Medicine reminders\n"
          "• Wellness tracking\n\n"
          "Feel free to ask me any health-related question!",
    ];
    
    return responses[DateTime.now().second % responses.length];
  }

  void _scrollToBottom() {
    Future.delayed(const Duration(milliseconds: 100), () {
      if (_scrollController.hasClients) {
        _scrollController.animateTo(
          _scrollController.position.maxScrollExtent,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeOut,
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    
    return Scaffold(
      backgroundColor: isDark ? const Color(0xFF0D1B1E) : const Color(0xFFF0F9F8),
      appBar: _buildAppBar(theme, isDark),
      body: Column(
        children: [
          Expanded(
            child: _messages.isEmpty
                ? _buildEmptyState(theme, isDark)
                : _buildMessageList(theme, isDark),
          ),
          if (_isTyping) _buildTypingIndicator(theme, isDark),
          if (_messages.length <= 1) _buildQuickActions(theme, isDark),
          _buildInputArea(theme, isDark),
        ],
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(ThemeData theme, bool isDark) {
    return AppBar(
      backgroundColor: isDark ? const Color(0xFF1A2F33) : Colors.white,
      elevation: 0,
      leading: IconButton(
        icon: Icon(
          Icons.arrow_back_ios_new,
          color: isDark ? Colors.white : const Color(0xFF1A2A2C),
        ),
        onPressed: () => Navigator.pop(context),
      ),
      title: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(12),
            ),
            child: const Icon(
              Icons.psychology_outlined,
              color: Colors.white,
              size: 24,
            ),
          ),
          const SizedBox(width: 12),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Sehati AI',
                style: TextStyle(
                  color: isDark ? Colors.white : const Color(0xFF1A2A2C),
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Online',
                    style: TextStyle(
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                      fontSize: 12,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
      actions: [
        IconButton(
          icon: Icon(
            Icons.more_vert,
            color: isDark ? Colors.white : const Color(0xFF1A2A2C),
          ),
          onPressed: () => _showOptionsMenu(context),
        ),
      ],
    );
  }

  Widget _buildEmptyState(ThemeData theme, bool isDark) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          ScaleTransition(
            scale: _pulseAnimation,
            child: Container(
              width: 100,
              height: 100,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                borderRadius: BorderRadius.circular(25),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF20C6B7).withOpacity(0.3),
                    blurRadius: 20,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),
              child: const Icon(
                Icons.psychology_outlined,
                color: Colors.white,
                size: 50,
              ),
            ),
          ),
          const SizedBox(height: 24),
          Text(
            'Sehati AI Assistant',
            style: TextStyle(
              color: isDark ? Colors.white : const Color(0xFF1A2A2C),
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Your personal health companion',
            style: TextStyle(
              color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
              fontSize: 14,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildMessageList(ThemeData theme, bool isDark) {
    return ListView.builder(
      controller: _scrollController,
      padding: const EdgeInsets.all(16),
      itemCount: _messages.length,
      itemBuilder: (context, index) {
        final message = _messages[index];
        return _buildMessageBubble(message, theme, isDark);
      },
    );
  }

  Widget _buildMessageBubble(ChatMessage message, ThemeData theme, bool isDark) {
    final isUser = message.isUser;
    
    return Padding(
      padding: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment: isUser ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isUser) ...[
            Container(
              width: 32,
              height: 32,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                ),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(
                Icons.psychology_outlined,
                color: Colors.white,
                size: 18,
              ),
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.75,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: isUser
                    ? const Color(0xFF20C6B7)
                    : (isDark ? const Color(0xFF1A2F33) : Colors.white),
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: Radius.circular(isUser ? 20 : 4),
                  bottomRight: Radius.circular(isUser ? 4 : 20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    message.text,
                    style: TextStyle(
                      color: isUser
                          ? Colors.white
                          : (isDark ? Colors.white : const Color(0xFF1A2A2C)),
                      fontSize: 15,
                      height: 1.4,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(message.timestamp),
                    style: TextStyle(
                      color: isUser
                          ? Colors.white.withOpacity(0.7)
                          : (isDark ? Colors.grey.shade500 : Colors.grey.shade500),
                      fontSize: 11,
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (isUser) ...[
            const SizedBox(width: 8),
            CircleAvatar(
              radius: 16,
              backgroundColor: const Color(0xFF20C6B7).withOpacity(0.2),
              child: Text(
                _getUserInitials(),
                style: const TextStyle(
                  color: Color(0xFF20C6B7),
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildTypingIndicator(ThemeData theme, bool isDark) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Row(
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
              ),
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Icon(
              Icons.psychology_outlined,
              color: Colors.white,
              size: 18,
            ),
          ),
          const SizedBox(width: 8),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF1A2F33) : Colors.white,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildTypingDot(0),
                const SizedBox(width: 4),
                _buildTypingDot(1),
                const SizedBox(width: 4),
                _buildTypingDot(2),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTypingDot(int index) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: Duration(milliseconds: 600 + (index * 200)),
      builder: (context, value, child) {
        return Container(
          width: 8,
          height: 8,
          decoration: BoxDecoration(
            color: const Color(0xFF20C6B7).withOpacity(0.3 + (value * 0.7)),
            shape: BoxShape.circle,
          ),
        );
      },
    );
  }

  Widget _buildQuickActions(ThemeData theme, bool isDark) {
    return Container(
      height: 100,
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: _quickActions.length,
        itemBuilder: (context, index) {
          final action = _quickActions[index];
          return Padding(
            padding: const EdgeInsets.only(right: 12),
            child: InkWell(
              onTap: () => _sendMessage(action.query),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                width: 100,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: isDark ? const Color(0xFF1A2F33) : Colors.white,
                  borderRadius: BorderRadius.circular(16),
                  border: Border.all(
                    color: const Color(0xFF20C6B7).withOpacity(0.3),
                  ),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      action.icon,
                      color: const Color(0xFF20C6B7),
                      size: 28,
                    ),
                    const SizedBox(height: 8),
                    Text(
                      action.label,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1A2A2C),
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                      textAlign: TextAlign.center,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildInputArea(ThemeData theme, bool isDark) {
    return Container(
      padding: EdgeInsets.only(
        left: 16,
        right: 16,
        top: 12,
        bottom: MediaQuery.of(context).padding.bottom + 12,
      ),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF1A2F33) : Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: isDark ? const Color(0xFF0D1B1E) : const Color(0xFFF5F5F5),
                borderRadius: BorderRadius.circular(25),
              ),
              child: Row(
                children: [
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextField(
                      controller: _messageController,
                      focusNode: _focusNode,
                      style: TextStyle(
                        color: isDark ? Colors.white : const Color(0xFF1A2A2C),
                        fontSize: 15,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Ask me anything about your health...',
                        hintStyle: TextStyle(
                          color: isDark ? Colors.grey.shade500 : Colors.grey.shade500,
                          fontSize: 15,
                        ),
                        border: InputBorder.none,
                        contentPadding: const EdgeInsets.symmetric(vertical: 12),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                      textInputAction: TextInputAction.send,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.mic_outlined,
                      color: isDark ? Colors.grey.shade400 : Colors.grey.shade600,
                    ),
                    onPressed: () {
                      // TODO: Implement voice input
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Voice input coming soon!'),
                          duration: Duration(seconds: 2),
                        ),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 48,
            height: 48,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: [Color(0xFF20C6B7), Color(0xFF17A89A)],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(24),
            ),
            child: IconButton(
              icon: const Icon(Icons.send_rounded, color: Colors.white),
              onPressed: () => _sendMessage(),
            ),
          ),
        ],
      ),
    );
  }

  void _showOptionsMenu(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1A2F33)
          : Colors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (context) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.delete_outline, color: Color(0xFF20C6B7)),
              title: const Text('Clear Chat'),
              onTap: () {
                Navigator.pop(context);
                setState(() {
                  _messages.clear();
                  _addWelcomeMessage();
                });
              },
            ),
            ListTile(
              leading: const Icon(Icons.info_outline, color: Color(0xFF20C6B7)),
              title: const Text('About Sehati AI'),
              onTap: () {
                Navigator.pop(context);
                _showAboutDialog();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showAboutDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('About Sehati AI'),
        content: const Text(
          'Sehati AI is your personal health assistant powered by artificial intelligence. '
          'It provides personalized health insights, medication reminders, nutrition advice, '
          'and fitness recommendations based on your health profile.\n\n'
          'Note: This is not a substitute for professional medical advice.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Got it'),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final hour = timestamp.hour;
    final minute = timestamp.minute.toString().padLeft(2, '0');
    final period = hour >= 12 ? 'PM' : 'AM';
    final displayHour = hour > 12 ? hour - 12 : (hour == 0 ? 12 : hour);
    return '$displayHour:$minute $period';
  }

  String _getUserInitials() {
    final user = ref.read(authProvider).user;
    final name = user?.name ?? 'User';
    final parts = name.trim().split(' ');
    if (parts.length >= 2) {
      return '${parts[0][0]}${parts[1][0]}'.toUpperCase();
    }
    return name.substring(0, name.length >= 2 ? 2 : 1).toUpperCase();
  }
}

class ChatMessage {
  final String text;
  final bool isUser;
  final DateTime timestamp;

  ChatMessage({
    required this.text,
    required this.isUser,
    required this.timestamp,
  });
}

class QuickAction {
  final IconData icon;
  final String label;
  final String query;

  QuickAction({
    required this.icon,
    required this.label,
    required this.query,
  });
}

