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

  factory Medicine.fromMap(Map<String, dynamic> data, String id) {
    return Medicine(
      id: id,
      userId: data['user_id'],
      name: data['name'],
      dosage: data['dosage'],
      instructions: data['instructions'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'name': name,
      'dosage': dosage,
      if (instructions != null) 'instructions': instructions,
    };
  }
}
