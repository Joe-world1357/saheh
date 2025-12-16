class UserMedicalCondition {
  final String id;        // Firestore document ID
  final String userId;    // FK → AppUser.id
  final String condition;

  UserMedicalCondition({
    required this.id,
    required this.userId,
    required this.condition,
  });

  // 🔒 SAFE fromMap
  factory UserMedicalCondition.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return UserMedicalCondition(
      id: id,

      // required FK
      userId: map['user_id'] as String? ?? '',

      // required text
      condition: map['condition'] as String? ?? '',
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'condition': condition,
    };
  }
}
