import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/app_user.dart';

class UserRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _users =>
      _db.collection('users');

  // CREATE user (register / first login)
  Future<void> createUser(AppUser user) async {
    await _users.doc(user.id).set(
          user.toMap(),
          SetOptions(merge: true), // 🔒 prevents overwrite
        );
  }

  // GET user (login / app start)
  Future<AppUser?> getUser(String uid) async {
    final doc = await _users.doc(uid).get();

    if (!doc.exists || doc.data() == null) {
      return null; // ✅ safe for first login
    }

    return AppUser.fromMap(doc.data(), doc.id);
  }

  // GET or CREATE user (🔥 MOST IMPORTANT METHOD)
  Future<AppUser> getOrCreateUser(AppUser user) async {
    final doc = await _users.doc(user.id).get();

    if (doc.exists && doc.data() != null) {
      return AppUser.fromMap(doc.data(), doc.id);
    }

    // user exists in Auth but not Firestore
    await createUser(user);
    return user;
  }

  // UPDATE user (profile edits, onboarding, etc.)
  Future<void> updateUser(
    String uid,
    Map<String, dynamic> data,
  ) async {
    await _users.doc(uid).update(data);
  }

  // CHECK existence
  Future<bool> userExists(String uid) async {
    final doc = await _users.doc(uid).get();
    return doc.exists;
  }
}
