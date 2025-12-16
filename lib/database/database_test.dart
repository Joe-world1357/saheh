import 'package:flutter/foundation.dart';
import 'database_helper.dart';
import '../models/user_model.dart';

/// Test database connection and operations
class DatabaseTest {
  static Future<void> testDatabase() async {
    try {
      debugPrint('🧪 Testing SQLite Database...');
      
      final db = DatabaseHelper.instance;
      
      // Test 1: Check database connection
      debugPrint('✓ Testing database connection...');
      final database = await db.database;
      debugPrint('✓ Database connected successfully!');
      
      // Test 2: Insert a test user
      debugPrint('✓ Testing user insertion...');
      final testUser = UserModel(
        name: 'Test User',
        email: 'test@example.com',
        xp: 0,
        level: 1,
      );
      final userId = await db.insertUser(testUser);
      debugPrint('✓ User inserted with ID: $userId');
      
      // Test 3: Retrieve user
      debugPrint('✓ Testing user retrieval...');
      final retrievedUser = await db.getUser();
      if (retrievedUser != null) {
        debugPrint('✓ User retrieved: ${retrievedUser.name} (${retrievedUser.email})');
      } else {
        debugPrint('⚠ No user found');
      }
      
      // Test 4: Test medicine reminders
      debugPrint('✓ Testing medicine reminders...');
      final reminders = await db.getAllMedicineReminders();
      debugPrint('✓ Found ${reminders.length} medicine reminders');
      
      debugPrint('✅ All database tests passed!');
      
    } catch (e, stackTrace) {
      debugPrint('❌ Database test failed: $e');
      debugPrint('Stack trace: $stackTrace');
      rethrow;
    }
  }
}

