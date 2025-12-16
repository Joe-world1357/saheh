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

  factory Caregiver.fromMap(
      Map<String, dynamic> data, String id) {
    return Caregiver(
      id: id,
      fullName: data['full_name'],
      age: data['age'],
      experience: data['experience'],
      rating: data['rating']?.toDouble(),
      serviceDescription: data['service_description'],
      hourlyRate: data['hourly_rate']?.toDouble(),
    );
  }

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
