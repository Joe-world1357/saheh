import 'dart:convert';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../models/user_model.dart';
import '../models/order_model.dart';
import '../models/medicine_reminder_model.dart';
import '../models/meal_model.dart';
import '../models/workout_model.dart';
import '../models/appointment_model.dart';
import '../models/health_tracking_model.dart';

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
      version: 1,
      onCreate: _createDB,
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
        medicine_name TEXT NOT NULL,
        dosage TEXT NOT NULL,
        days_of_week TEXT NOT NULL,
        time TEXT NOT NULL,
        is_active INTEGER DEFAULT 1,
        created_at TEXT NOT NULL,
        updated_at TEXT
      )
    ''');

    // Meals table
    await db.execute('''
      CREATE TABLE meals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
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
        date TEXT NOT NULL,
        amount INTEGER NOT NULL,
        created_at TEXT NOT NULL
      )
    ''');

    // Health goals table
    await db.execute('''
      CREATE TABLE health_goals (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        title TEXT NOT NULL,
        target TEXT NOT NULL,
        current TEXT NOT NULL,
        progress REAL NOT NULL,
        deadline TEXT NOT NULL,
        created_at TEXT NOT NULL,
        updated_at TEXT
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

  Future<int> updateUser(UserModel user) async {
    final db = await database;
    return await db.update(
      'users',
      user.copyWith(updatedAt: DateTime.now()).toMap(),
      where: 'id = ?',
      whereArgs: [user.id],
    );
  }

  // Order operations
  Future<int> insertOrder(OrderModel order) async {
    final db = await database;
    final orderMap = order.toMap();
    orderMap['items'] = jsonEncode(order.items.map((item) => item.toMap()).toList());
    return await db.insert('orders', orderMap);
  }

  Future<List<OrderModel>> getAllOrders() async {
    final db = await database;
    final maps = await db.query('orders', orderBy: 'created_at DESC');
    return maps.map((map) {
      // Parse items from JSON string
      final itemsJson = jsonDecode(map['items'] as String) as List<dynamic>;
      final items = itemsJson.map((item) => OrderItem.fromMap(item as Map<String, dynamic>)).toList();
      final orderMap = Map<String, dynamic>.from(map);
      orderMap['items'] = items;
      return OrderModel.fromMap(orderMap);
    }).toList();
  }

  Future<int> updateOrderStatus(int id, String status) async {
    final db = await database;
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

  Future<List<MedicineReminderModel>> getAllMedicineReminders() async {
    final db = await database;
    final maps = await db.query('medicine_reminders', orderBy: 'time ASC');
    return maps.map((map) => MedicineReminderModel.fromMap(map)).toList();
  }

  Future<int> deleteMedicineReminder(int id) async {
    final db = await database;
    return await db.delete('medicine_reminders', where: 'id = ?', whereArgs: [id]);
  }

  // Meal operations
  Future<int> insertMeal(MealModel meal) async {
    final db = await database;
    return await db.insert('meals', meal.toMap());
  }

  Future<List<MealModel>> getMealsByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    final maps = await db.query(
      'meals',
      where: "DATE(meal_date) = ?",
      whereArgs: [dateStr],
    );
    return maps.map((map) => MealModel.fromMap(map)).toList();
  }

  // Workout operations
  Future<int> insertWorkout(WorkoutModel workout) async {
    final db = await database;
    return await db.insert('workouts', workout.toMap());
  }

  Future<List<WorkoutModel>> getWorkoutsByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    final maps = await db.query(
      'workouts',
      where: "DATE(workout_date) = ?",
      whereArgs: [dateStr],
    );
    return maps.map((map) => WorkoutModel.fromMap(map)).toList();
  }

  // Appointment operations
  Future<int> insertAppointment(AppointmentModel appointment) async {
    final db = await database;
    return await db.insert('appointments', appointment.toMap());
  }

  Future<List<AppointmentModel>> getAllAppointments() async {
    final db = await database;
    final maps = await db.query('appointments', orderBy: 'appointment_date DESC');
    return maps.map((map) => AppointmentModel.fromMap(map)).toList();
  }

  // Sleep tracking operations
  Future<int> insertSleepTracking(SleepTrackingModel sleep) async {
    final db = await database;
    return await db.insert('sleep_tracking', sleep.toMap());
  }

  Future<SleepTrackingModel?> getSleepByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    final maps = await db.query(
      'sleep_tracking',
      where: "DATE(date) = ?",
      whereArgs: [dateStr],
      limit: 1,
    );
    if (maps.isEmpty) return null;
    return SleepTrackingModel.fromMap(maps.first);
  }

  // Water intake operations
  Future<int> insertWaterIntake(WaterIntakeModel water) async {
    final db = await database;
    return await db.insert('water_intake', water.toMap());
  }

  Future<int> getTotalWaterByDate(DateTime date) async {
    final db = await database;
    final dateStr = date.toIso8601String().split('T')[0];
    final result = await db.rawQuery(
      'SELECT SUM(amount) as total FROM water_intake WHERE DATE(date) = ?',
      [dateStr],
    );
    return result.first['total'] as int? ?? 0;
  }

  // Health goals operations
  Future<int> insertHealthGoal(HealthGoalModel goal) async {
    final db = await database;
    return await db.insert('health_goals', goal.toMap());
  }

  Future<List<HealthGoalModel>> getAllHealthGoals() async {
    final db = await database;
    final maps = await db.query('health_goals', orderBy: 'created_at DESC');
    return maps.map((map) => HealthGoalModel.fromMap(map)).toList();
  }

  Future<int> deleteHealthGoal(int id) async {
    final db = await database;
    return await db.delete('health_goals', where: 'id = ?', whereArgs: [id]);
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }
}

