class AppUser {
  // REQUIRED
  final String id;               // Firebase Auth UID
  final String email;
  final String username;         // required at signup
  final DateTime accountCreated;

  // OPTIONAL
  final int? age;
  final String? gender;
  final double? height;
  final double? weight;
  final String? phone;
  final String? address;
  final String? activityLevel;
  final int? xpLevel;

  AppUser({
    required this.id,
    required this.email,
    required this.username,
    required this.accountCreated,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.phone,
    this.address,
    this.activityLevel,
    this.xpLevel,
  });

  factory AppUser.fromMap(Map<String, dynamic> data, String id) {
    return AppUser(
      id: id,
      email: data['email'],
      username: data['username'],
      accountCreated: DateTime.parse(data['account_created']),
      age: data['age'],
      gender: data['gender'],
      height: data['height']?.toDouble(),
      weight: data['weight']?.toDouble(),
      phone: data['phone'],
      address: data['address'],
      activityLevel: data['activity_level'],
      xpLevel: data['xp_level'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'username': username,
      'account_created': accountCreated.toIso8601String(),
      if (age != null) 'age': age,
      if (gender != null) 'gender': gender,
      if (height != null) 'height': height,
      if (weight != null) 'weight': weight,
      if (phone != null) 'phone': phone,
      if (address != null) 'address': address,
      if (activityLevel != null) 'activity_level': activityLevel,
      if (xpLevel != null) 'xp_level': xpLevel,
    };
  }
}
