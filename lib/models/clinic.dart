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

  factory Clinic.fromMap(Map<String, dynamic> data, String id) {
    return Clinic(
      id: id,
      name: data['name'],
      city: data['city'],
      address: data['address'],
      phone: data['phone'],
      specialty: data['specialty'],
    );
  }

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
