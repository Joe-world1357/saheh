class UserMedicalCondition {
  final String id;        // Firestore document ID
  final String userId;    // FK → AppUser.id
  final String condition;

  UserMedicalCondition({
    required this.id,
    required this.userId,
    required this.condition,
  });

  factory UserMedicalCondition.fromMap(
      Map<String, dynamic> data, String id) {
    return UserMedicalCondition(
      id: id,
      userId: data['user_id'],
      condition: data['condition'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'condition': condition,
    };
  }
}
