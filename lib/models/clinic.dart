class Clinic {
  final String id;        // Firestore document ID
  final String name;
  final String city;
  final String address;
  final String phone;
  final String specialty;

  Clinic({
    required this.id,
    required this.name,
    required this.city,
    required this.address,
    required this.phone,
    required this.specialty,
  });

  // 🔒 SAFE fromMap
  factory Clinic.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return Clinic(
      id: id,
      name: map['name'] as String? ?? '',
      city: map['city'] as String? ?? '',
      address: map['address'] as String? ?? '',
      phone: map['phone'] as String? ?? '',
      specialty: map['specialty'] as String? ?? '',
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'city': city,
      'address': address,
      'phone': phone,
      'specialty': specialty,
    };
  }
}
