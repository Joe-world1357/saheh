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

  factory Doctor.fromMap(Map<String, dynamic> data, String id) {
    return Doctor(
      id: id,
      clinicId: data['clinic_id'],
      name: data['name'],
      specialty: data['specialty'],
      yearsExperience: data['years_experience'],
      rating: data['rating']?.toDouble(),
    );
  }

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
