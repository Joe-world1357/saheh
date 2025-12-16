class Medicine {
  final String id;        // Firestore document ID
  final String userId;    // FK → users
  final String name;
  final String dosage;
  final String? instructions;

  Medicine({
    required this.id,
    required this.userId,
    required this.name,
    required this.dosage,
    this.instructions,
  });

  // 🔒 SAFE fromMap
  factory Medicine.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Medicine(
      id: id,

      // required FK
      userId: map['user_id'] as String? ?? '',

      // required text
      name: map['name'] as String? ?? '',
      dosage: map['dosage'] as String? ?? '',

      // optional text
      instructions: map['instructions'] as String?,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'dosage': dosage,
      if (instructions != null) 'instructions': instructions,
    };
  }
}
