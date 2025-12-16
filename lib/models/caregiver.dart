class Caregiver {
  final String id;              // Firestore document ID
  final String fullName;
  final int age;
  final int experience;
  final double? rating;
  final String serviceDescription;
  final double hourlyRate;

  Caregiver({
    required this.id,
    required this.fullName,
    required this.age,
    required this.experience,
    required this.serviceDescription,
    required this.hourlyRate,
    this.rating,
  });

  // 🔒 SAFE fromMap
  factory Caregiver.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Caregiver(
      id: id,

      // required text fields
      fullName: map['full_name'] as String? ?? '',

      // required ints (safe numeric casting)
      age: (map['age'] as num?)?.toInt() ?? 0,
      experience: (map['experience'] as num?)?.toInt() ?? 0,

      // optional rating
      rating: (map['rating'] as num?)?.toDouble(),

      // required description
      serviceDescription:
          map['service_description'] as String? ?? '',

      // required money value
      hourlyRate:
          (map['hourly_rate'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'full_name': fullName,
      'age': age,
      'experience': experience,
      'service_description': serviceDescription,
      'hourly_rate': hourlyRate,
      if (rating != null) 'rating': rating,
    };
  }
}
