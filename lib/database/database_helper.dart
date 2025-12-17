import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/order_model.dart';
import '../models/medicine_reminder_model.dart';
import '../models/medicine_intake_model.dart';
import '../models/meal_model.dart';
import '../models/workout_model.dart';
import '../models/appointment_model.dart';
import '../models/health_tracking_model.dart';
import '../models/activity_model.dart';
import '../models/fitness_preferences_model.dart';

class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  static Database? _database;

  DatabaseHelper._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('sehati.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(
      path,
      version: 7, // Added fitness_preferences table
      onCreate: _createDB,
      onUpgrade: _upgradeDB,
    );
  }

  Future<void> _createDB(Database db, int version) async {
    // Users table
    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT NOT NULL,
        email TEXT NOT NULL UNIQUE,
        phone TEXT,
        age INTEGER,
        gender TEXT,
        height REAL,
        weight REAL,
        address TEXT,
        xp INTEGER DEFAULT 0,
        level INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Orders table
    await db.execute('''
      CREATE TABLE orders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        order_id TEXT NOT NULL UNIQUE,
        items TEXT NOT NULL,
        subtotal REAL NOT NULL,
        tax REAL NOT NULL,
        total REAL NOT NULL,
        status TEXT DEFAULT 'pending',
        shipping_address TEXT,
        payment_method TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Medicine reminders table
    await db.execute('''
      CREATE TABLE medicine_reminders (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        medicine_name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        days_of_week TEXT NOT NULL,
        time TEXT NOT NULL,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Medicine intake table
    await db.execute('''
      CREATE TABLE medicine_intake (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        medicine_name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        intake_date TEXT NOT NULL,
        intake_time TEXT NOT NULL,
        is_taken INTEGER DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');

    // Meals table
    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        name TEXT NOT NULL,
        meal_type TEXT NOT NULL,
        calories REAL NOT NULL,
        protein REAL NOT NULL,
        carbs REAL NOT NULL,
        fat REAL NOT NULL,
        meal_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Workouts table
    await db.execute('''
      CREATE TABLE workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        name TEXT NOT NULL,
        type TEXT NOT NULL,
        duration INTEGER NOT NULL,
        calories_burned REAL NOT NULL,
        workout_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Appointments table
    await db.execute('''
      CREATE TABLE appointments (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        type TEXT NOT NULL,
        provider_name TEXT NOT NULL,
        specialty TEXT NOT NULL,
        appointment_date TEXT NOT NULL,
        time TEXT NOT NULL,
        status TEXT DEFAULT 'upcoming',
        notes TEXT,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Sleep tracking table
    await db.execute('''
      CREATE TABLE sleep_tracking (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        date TEXT NOT NULL,
        bedtime TEXT,
        wake_time TEXT,
        duration REAL,
        quality INTEGER DEFAULT 3,
        created_at TEXT NOT NULL
      )
    ''');

    // Water intake table
    await db.execute('''
      CREATE TABLE water_intake (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        date TEXT NOT NULL,
        amount INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Health goals table
    await db.execute('''
      CREATE TABLE health_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        title TEXT NOT NULL,
        target TEXT NOT NULL,
        current TEXT NOT NULL,
        progress REAL NOT NULL,
        deadline TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Activity tracking table
    await db.execute('''
      CREATE TABLE activity_tracking (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        date TEXT NOT NULL,
        steps INTEGER DEFAULT 0,
        active_minutes INTEGER DEFAULT 0,
        calories_burned REAL DEFAULT 0,
        workout_minutes INTEGER DEFAULT 0,
        created_at TEXT NOT NULL,
        updated_at TEXT,
        UNIQUE(user_email, date)
      )
    ''');

    // Men's workouts table
    await db.execute('''
      CREATE TABLE men_workouts (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        user_email TEXT NOT NULL,
        name TEXT NOT NULL,
        muscle_group TEXT NOT NULL,
        difficulty TEXT NOT NULL,
        duration_minutes INTEGER NOT NULL,
        calories_burned REAL NOT NULL,
        is_completed INTEGER DEFAULT 0,
        completed_at TEXT,
        workout_date TEXT NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Fitness preferences table
    await db.execute('''
      CREATE TABLE fitness_preferences (
        id TEXT PRIMARY KEY,
        user_email TEXT NOT NULL UNIQUE,
        fitness_goals TEXT,
        preferred_days TEXT,
        workout_duration INTEGER DEFAULT 30,
        workout_type TEXT DEFAULT 'mixed',
        age INTEGER DEFAULT 25,
        weight REAL DEFAULT 70.0,
        height REAL DEFAULT 170.0,
        activity_level TEXT DEFAULT 'moderate',
        onboarding_completed INTEGER DEFAULT 0,
        created_at TEXT NOT NULL
      )
    ''');
  }

  // User operations
  Future<int> insertUser(UserModel user) async {
    final db = await database;
    return await db.insert('users', user.toMap());
  }

  Future<UserModel?> getUser() async {
    final db = await database;
    final maps = await db.query('users', limit: 1);
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  Future<UserModel?> getUserByEmail(String email) async {
    final db = await database;
    final maps = await db.query(
      'users',
      where: 'email = ?',
      whereArgs: [email],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return UserModel.fromMap(maps.first);
  }

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      'users',
      user.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  Future<int> updateUserByEmail(UserModel user) async {
    final db = await database;
    return await db.update(
      'users',
      user.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'email = ?',
      whereArgs: [user.email],
    );
  }

  // Order operations
  Future<int> insertOrder(OrderModel order, {required String userEmail}) async {
    final db = await database;
    final orderMap = order.toMap();
    orderMap['items'] = jsonEncode(order.items.map((item) => item.toMap()).toList());
    orderMap['user_email'] = userEmail;
    return await db.insert('orders', orderMap);
  }

  Future<List<OrderModel>> getAllOrders({String? userEmail}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'orders',
        where: 'user_email = ?',
        whereArgs: [userEmail],
        orderBy: 'created_at DESC',
      );
    } else {
      maps = await db.query('orders', orderBy: 'created_at DESC');
    }
    
    return maps.map((map) {
      // Parse items from JSON string
      final itemsJson = jsonDecode(map['items'] as String) as List<dynamic>;
      final items = itemsJson.map((item) => OrderItem.fromMap(item as Map<String, dynamic>)).toList();
      final orderMap = Map<String, dynamic>.from(map);
      orderMap['items'] = items;
      return OrderModel.fromMap(orderMap);
    }).toList();
  }

  Future<int> updateOrderStatus(int id, String status, {String? userEmail}) async {
    final db = await database;
    if (userEmail != null && userEmail.isNotEmpty) {
      return await db.update(
        'orders',
        {'status': status, 'updated_at': DateTime.now().toIso8601String()},
        where: 'id = ? AND user_email = ?',
        whereArgs: [id, userEmail],
      );
    }
    return await db.update(
      'orders',
      {'status': status, 'updated_at': DateTime.now().toIso8601String()},
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Medicine reminder operations
  Future<int> insertMedicineReminder(MedicineReminderModel reminder) async {
    final db = await database;
    return await db.insert('medicine_reminders', reminder.toMap());
  }

  Future<List<MedicineReminderModel>> getAllMedicineReminders({String? userEmail}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'medicine_reminders',
        where: 'user_email = ?',
        whereArgs: [userEmail],
        orderBy: 'time ASC',
      );
    } else {
      maps = await db.query('medicine_reminders', orderBy: 'time ASC');
    }
    return maps.map((map) => MedicineReminderModel.fromMap(map)).toList();
  }

  Future<int> deleteMedicineReminder(int id, {String? userEmail}) async {
    final db = await database;
    if (userEmail != null && userEmail.isNotEmpty) {
      return await db.delete(
        'medicine_reminders',
        where: 'id = ? AND user_email = ?',
        whereArgs: [id, userEmail],
      );
    }
    return await db.delete('medicine_reminders', where: 'id = ?', whereArgs: [id]);
  }

  // Medicine intake operations
  Future<int> insertMedicineIntake(MedicineIntakeModel intake) async {
    final db = await database;
    return await db.insert('medicine_intake', intake.toMap());
  }

  Future<List<MedicineIntakeModel>> getMedicineIntakesByDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'medicine_intake',
        where: "DATE(intake_date) = ? AND user_email = ?",
        whereArgs: [dateStr, userEmail],
        orderBy: 'intake_time ASC',
      );
    } else {
      maps = await db.query(
        'medicine_intake',
        where: "DATE(intake_date) = ?",
        whereArgs: [dateStr],
        orderBy: 'intake_time ASC',
      );
    }
    return maps.map((map) => MedicineIntakeModel.fromMap(map)).toList();
  }

  Future<int> updateMedicineIntake(MedicineIntakeModel intake) async {
    final db = await database;
    if (intake.id == null) return 0;
    return await db.update(
      'medicine_intake',
      intake.toMap(),
      where: 'id = ? AND user_email = ?',
      whereArgs: [intake.id, intake.userEmail],
    );
  }

  Future<int> deleteMedicineIntake(int id, String userEmail) async {
    final db = await database;
    return await db.delete(
      'medicine_intake',
      where: 'id = ? AND user_email = ?',
      whereArgs: [id, userEmail],
    );
  }

  Future<int> getTakenCountForDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    String query;
    List<dynamic> args;
    if (userEmail != null && userEmail.isNotEmpty) {
      query = 'SELECT COUNT(*) as count FROM medicine_intake WHERE DATE(intake_date) = ? AND is_taken = 1 AND user_email = ?';
      args = [dateStr, userEmail];
    } else {
      query = 'SELECT COUNT(*) as count FROM medicine_intake WHERE DATE(intake_date) = ? AND is_taken = 1';
      args = [dateStr];
    }
    final result = await db.rawQuery(query, args);
    return result.first['count'] as int? ?? 0;
  }

  Future<int> getTotalCountForDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    String query;
    List<dynamic> args;
    if (userEmail != null && userEmail.isNotEmpty) {
      query = 'SELECT COUNT(*) as count FROM medicine_intake WHERE DATE(intake_date) = ? AND user_email = ?';
      args = [dateStr, userEmail];
    } else {
      query = 'SELECT COUNT(*) as count FROM medicine_intake WHERE DATE(intake_date) = ?';
      args = [dateStr];
    }
    final result = await db.rawQuery(query, args);
    return result.first['count'] as int? ?? 0;
  }

  // Clear all user-specific data on logout
  Future<void> clearUserData(String userEmail) async {
    final db = await database;
    await db.delete('medicine_reminders', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('medicine_intake', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('meals', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('workouts', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('appointments', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('sleep_tracking', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('water_intake', where: 'user_email = ?', whereArgs: [userEmail]);
    await db.delete('health_goals', where: 'user_email = ?', whereArgs: [userEmail]);
  }

  // Meal operations
  Future<int> insertMeal(MealModel meal) async {
    final db = await database;
    return await db.insert('meals', meal.toMap());
  }

  Future<List<MealModel>> getMealsByDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'meals',
        where: "DATE(meal_date) = ? AND user_email = ?",
        whereArgs: [dateStr, userEmail],
      );
    } else {
      maps = await db.query(
        'meals',
        where: "DATE(meal_date) = ?",
        whereArgs: [dateStr],
      );
    }
    return maps.map((map) => MealModel.fromMap(map)).toList();
  }

  // Workout operations
  Future<int> insertWorkout(WorkoutModel workout) async {
    final db = await database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<List<WorkoutModel>> getWorkoutsByDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'workouts',
        where: "DATE(workout_date) = ? AND user_email = ?",
        whereArgs: [dateStr, userEmail],
      );
    } else {
      maps = await db.query(
        'workouts',
        where: "DATE(workout_date) = ?",
        whereArgs: [dateStr],
      );
    }
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  // Appointment operations
  Future<int> insertAppointment(AppointmentModel appointment) async {
    final db = await database;
    return await db.insert('appointments', appointment.toMap());
  }

  Future<List<AppointmentModel>> getAllAppointments({String? userEmail}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'appointments',
        where: 'user_email = ?',
        whereArgs: [userEmail],
        orderBy: 'appointment_date DESC',
      );
    } else {
      maps = await db.query('appointments', orderBy: 'appointment_date DESC');
    }
    return maps.map((map) => AppointmentModel.fromMap(map)).toList();
  }

  // Sleep tracking operations
  Future<int> insertSleepTracking(SleepTrackingModel sleep) async {
    final db = await database;
    return await db.insert('sleep_tracking', sleep.toMap());
  }

  Future<SleepTrackingModel?> getSleepByDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'sleep_tracking',
        where: "DATE(date) = ? AND user_email = ?",
        whereArgs: [dateStr, userEmail],
        limit: 1,
      );
    } else {
      maps = await db.query(
        'sleep_tracking',
        where: "DATE(date) = ?",
        whereArgs: [dateStr],
        limit: 1,
      );
    }
    if (maps.isEmpty) return null;
    return SleepTrackingModel.fromMap(maps.first);
  }

  // Water intake operations
  Future<int> insertWaterIntake(WaterIntakeModel water) async {
    final db = await database;
    return await db.insert('water_intake', water.toMap());
  }

  Future<int> getTotalWaterByDate(DateTime date, {String? userEmail}) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    String query;
    List<dynamic> args;
    if (userEmail != null && userEmail.isNotEmpty) {
      query = 'SELECT SUM(amount) as total FROM water_intake WHERE DATE(date) = ? AND user_email = ?';
      args = [dateStr, userEmail];
    } else {
      query = 'SELECT SUM(amount) as total FROM water_intake WHERE DATE(date) = ?';
      args = [dateStr];
    }
    final result = await db.rawQuery(query, args);
    return result.first['total'] as int? ?? 0;
  }

  // Health goals operations
  Future<int> insertHealthGoal(HealthGoalModel goal) async {
    final db = await database;
    return await db.insert('health_goals', goal.toMap());
  }

  Future<List<HealthGoalModel>> getAllHealthGoals({String? userEmail}) async {
    final db = await database;
    List<Map<String, dynamic>> maps;
    if (userEmail != null && userEmail.isNotEmpty) {
      maps = await db.query(
        'health_goals',
        where: 'user_email = ?',
        whereArgs: [userEmail],
        orderBy: 'created_at DESC',
      );
    } else {
      maps = await db.query('health_goals', orderBy: 'created_at DESC');
    }
    return maps.map((map) => HealthGoalModel.fromMap(map)).toList();
  }

  Future<int> deleteHealthGoal(int id, {String? userEmail}) async {
    final db = await database;
    if (userEmail != null && userEmail.isNotEmpty) {
      return await db.delete(
        'health_goals',
        where: 'id = ? AND user_email = ?',
        whereArgs: [id, userEmail],
      );
    }
    return await db.delete('health_goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> _upgradeDB(Database db, int oldVersion, int newVersion) async {
    if (oldVersion < 2) {
      // Add medicine_intake table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS medicine_intake (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          medicine_name TEXT NOT NULL,
          dosage TEXT NOT NULL,
          intake_date TEXT NOT NULL,
          intake_time TEXT NOT NULL,
          is_taken INTEGER DEFAULT 0,
          created_at TEXT NOT NULL
        )
      ''');
    }
    
    if (oldVersion < 3) {
      // Add user_email column to medicine_reminders
      try {
        await db.execute('ALTER TABLE medicine_reminders ADD COLUMN user_email TEXT');
        await db.execute("UPDATE medicine_reminders SET user_email = '' WHERE user_email IS NULL");
      } catch (e) {
        // Column might already exist, ignore
      }
      
      // Add user_email column to medicine_intake
      try {
        await db.execute('ALTER TABLE medicine_intake ADD COLUMN user_email TEXT');
        await db.execute("UPDATE medicine_intake SET user_email = '' WHERE user_email IS NULL");
      } catch (e) {
        // Column might already exist, ignore
      }
    }
    
    if (oldVersion < 4) {
      // Add user_email column to all remaining tables
      final tables = ['meals', 'workouts', 'appointments', 'sleep_tracking', 'water_intake', 'health_goals'];
      for (final table in tables) {
        try {
          await db.execute('ALTER TABLE $table ADD COLUMN user_email TEXT');
          await db.execute("UPDATE $table SET user_email = '' WHERE user_email IS NULL");
        } catch (e) {
          // Column might already exist, ignore
        }
      }
    }
    
    if (oldVersion < 5) {
      // Add user_email column to orders table
      try {
        await db.execute('ALTER TABLE orders ADD COLUMN user_email TEXT');
        await db.execute("UPDATE orders SET user_email = '' WHERE user_email IS NULL");
      } catch (e) {
        // Column might already exist, ignore
      }
    }
    
    if (oldVersion < 6) {
      // Add activity_tracking and men_workouts tables
      await db.execute('''
        CREATE TABLE IF NOT EXISTS activity_tracking (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_email TEXT NOT NULL,
          date TEXT NOT NULL,
          steps INTEGER DEFAULT 0,
          active_minutes INTEGER DEFAULT 0,
          calories_burned REAL DEFAULT 0,
          workout_minutes INTEGER DEFAULT 0,
          created_at TEXT NOT NULL,
          updated_at TEXT,
          UNIQUE(user_email, date)
        )
      ''');

      await db.execute('''
        CREATE TABLE IF NOT EXISTS men_workouts (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          user_email TEXT NOT NULL,
          name TEXT NOT NULL,
          muscle_group TEXT NOT NULL,
          difficulty TEXT NOT NULL,
          duration_minutes INTEGER NOT NULL,
          calories_burned REAL NOT NULL,
          is_completed INTEGER DEFAULT 0,
          completed_at TEXT,
          workout_date TEXT NOT NULL,
          created_at TEXT NOT NULL
        )
      ''');
    }

    if (oldVersion < 7) {
      // Add fitness_preferences table
      await db.execute('''
        CREATE TABLE IF NOT EXISTS fitness_preferences (
          id TEXT PRIMARY KEY,
          user_email TEXT NOT NULL UNIQUE,
          fitness_goals TEXT,
          preferred_days TEXT,
          workout_duration INTEGER DEFAULT 30,
          workout_type TEXT DEFAULT 'mixed',
          age INTEGER DEFAULT 25,
          weight REAL DEFAULT 70.0,
          height REAL DEFAULT 170.0,
          activity_level TEXT DEFAULT 'moderate',
          onboarding_completed INTEGER DEFAULT 0,
          created_at TEXT NOT NULL
        )
      ''');
    }
  }

  // ========== ACTIVITY TRACKING OPERATIONS ==========
  
  Future<int> insertOrUpdateActivity(ActivityModel activity) async {
    final db = await database;
    final dateStr = activity.date.toIso8601String().split('T')[0];
    
    // Check if exists
    final existing = await db.query(
      'activity_tracking',
      where: 'user_email = ? AND date = ?',
      whereArgs: [activity.userEmail, dateStr],
    );
    
    if (existing.isNotEmpty) {
      return await db.update(
        'activity_tracking',
        {
          ...activity.toMap(),
          'updated_at': DateTime.now().toIso8601String(),
        },
        where: 'user_email = ? AND date = ?',
        whereArgs: [activity.userEmail, dateStr],
      );
    } else {
      return await db.insert('activity_tracking', activity.toMap());
    }
  }

  Future<ActivityModel?> getActivityForDate(String userEmail, DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    
    final maps = await db.query(
      'activity_tracking',
      where: 'user_email = ? AND date = ?',
      whereArgs: [userEmail, dateStr],
    );
    
    if (maps.isEmpty) return null;
    return ActivityModel.fromMap(maps.first);
  }

  Future<List<ActivityModel>> getActivityHistory(String userEmail, {int limit = 30}) async {
    final db = await database;
    final maps = await db.query(
      'activity_tracking',
      where: 'user_email = ?',
      whereArgs: [userEmail],
      orderBy: 'date DESC',
      limit: limit,
    );
    return maps.map((m) => ActivityModel.fromMap(m)).toList();
  }

  Future<Map<String, dynamic>> getActivityStats(String userEmail) async {
    final db = await database;
    final today = DateTime.now().toIso8601String().split('T')[0];
    
    // Today's activity
    final todayActivity = await getActivityForDate(userEmail, DateTime.now());
    
    // Weekly totals
    final weekAgo = DateTime.now().subtract(const Duration(days: 7)).toIso8601String().split('T')[0];
    final weeklyResult = await db.rawQuery('''
      SELECT 
        COALESCE(SUM(steps), 0) as total_steps,
        COALESCE(SUM(active_minutes), 0) as total_active_minutes,
        COALESCE(SUM(calories_burned), 0) as total_calories,
        COALESCE(SUM(workout_minutes), 0) as total_workout_minutes
      FROM activity_tracking
      WHERE user_email = ? AND date >= ?
    ''', [userEmail, weekAgo]);
    
    return {
      'today': todayActivity,
      'weekly': weeklyResult.isNotEmpty ? weeklyResult.first : {},
    };
  }

  // ========== MEN'S WORKOUTS OPERATIONS ==========
  
  Future<int> insertMenWorkout(MenWorkoutModel workout) async {
    final db = await database;
    return await db.insert('men_workouts', workout.toMap());
  }

  Future<List<MenWorkoutModel>> getMenWorkoutsForDate(String userEmail, DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    
    final maps = await db.query(
      'men_workouts',
      where: 'user_email = ? AND workout_date = ?',
      whereArgs: [userEmail, dateStr],
      orderBy: 'created_at DESC',
    );
    return maps.map((m) => MenWorkoutModel.fromMap(m)).toList();
  }

  Future<List<MenWorkoutModel>> getMenWorkoutHistory(String userEmail, {int limit = 50}) async {
    final db = await database;
    final maps = await db.query(
      'men_workouts',
      where: 'user_email = ?',
      whereArgs: [userEmail],
      orderBy: 'workout_date DESC, created_at DESC',
      limit: limit,
    );
    return maps.map((m) => MenWorkoutModel.fromMap(m)).toList();
  }

  Future<int> completeMenWorkout(int workoutId, String userEmail) async {
    final db = await database;
    return await db.update(
      'men_workouts',
      {
        'is_completed': 1,
        'completed_at': DateTime.now().toIso8601String(),
      },
      where: 'id = ? AND user_email = ?',
      whereArgs: [workoutId, userEmail],
    );
  }

  Future<int> deleteMenWorkout(int workoutId, String userEmail) async {
    final db = await database;
    return await db.delete(
      'men_workouts',
      where: 'id = ? AND user_email = ?',
      whereArgs: [workoutId, userEmail],
    );
  }

  Future<Map<String, dynamic>> getMenWorkoutStats(String userEmail) async {
    final db = await database;
    
    // Total completed workouts
    final totalResult = await db.rawQuery('''
      SELECT 
        COUNT(*) as total_workouts,
        COALESCE(SUM(duration_minutes), 0) as total_minutes,
        COALESCE(SUM(calories_burned), 0) as total_calories
      FROM men_workouts
      WHERE user_email = ? AND is_completed = 1
    ''', [userEmail]);
    
    // This week
    final weekAgo = DateTime.now().subtract(const Duration(days: 7)).toIso8601String().split('T')[0];
    final weeklyResult = await db.rawQuery('''
      SELECT 
        COUNT(*) as weekly_workouts,
        COALESCE(SUM(duration_minutes), 0) as weekly_minutes,
        COALESCE(SUM(calories_burned), 0) as weekly_calories
      FROM men_workouts
      WHERE user_email = ? AND is_completed = 1 AND workout_date >= ?
    ''', [userEmail, weekAgo]);
    
    // By muscle group
    final muscleGroupResult = await db.rawQuery('''
      SELECT muscle_group, COUNT(*) as count
      FROM men_workouts
      WHERE user_email = ? AND is_completed = 1
      GROUP BY muscle_group
    ''', [userEmail]);
    
    return {
      'total': totalResult.isNotEmpty ? totalResult.first : {},
      'weekly': weeklyResult.isNotEmpty ? weeklyResult.first : {},
      'byMuscleGroup': muscleGroupResult,
    };
  }

  // Fitness Preferences operations
  Future<int> insertFitnessPreferences(FitnessPreferencesModel prefs) async {
    final db = await database;
    return await db.insert(
      'fitness_preferences',
      prefs.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<FitnessPreferencesModel?> getFitnessPreferences(String userEmail) async {
    final db = await database;
    final maps = await db.query(
      'fitness_preferences',
      where: 'user_email = ?',
      whereArgs: [userEmail],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return FitnessPreferencesModel.fromMap(maps.first);
  }

  Future<int> updateFitnessPreferences(FitnessPreferencesModel prefs) async {
    final db = await database;
    return await db.update(
      'fitness_preferences',
      prefs.toMap(),
      where: 'user_email = ?',
      whereArgs: [prefs.userEmail],
    );
  }

  Future<bool> hasCompletedFitnessOnboarding(String userEmail) async {
    final prefs = await getFitnessPreferences(userEmail);
    return prefs?.onboardingCompleted ?? false;
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

