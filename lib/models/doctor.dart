class Doctor {
  final String id;          // Firestore document ID
  final String clinicId;    // FK → clinics
  final String name;
  final String specialty;
  final int yearsExperience;
  final double? rating;

  Doctor({
    required this.id,
    required this.clinicId,
    required this.name,
    required this.specialty,
    required this.yearsExperience,
    this.rating,
  });

  // 🔒 SAFE fromMap
  factory Doctor.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Doctor(
      id: id,

      // required FK
      clinicId: map['clinic_id'] as String? ?? '',

      // required text
      name: map['name'] as String? ?? '',
      specialty: map['specialty'] as String? ?? '',

      // required int
      yearsExperience:
          (map['years_experience'] as num?)?.toInt() ?? 0,

      // optional rating
      rating: (map['rating'] as num?)?.toDouble(),
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'clinic_id': clinicId,
      'name': name,
      'specialty': specialty,
      'years_experience': yearsExperience,
      if (rating != null) 'rating': rating,
    };
  }
}
