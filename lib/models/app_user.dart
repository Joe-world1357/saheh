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

  // 🔒 SAFE fromMap
  factory AppUser.fromMap(Map<String, dynamic>? data, String id) {
    final map = data ?? {};

    return AppUser(
      id: id,

      // required fields with safe fallback
      email: map['email'] as String? ?? '',
      username: map['username'] as String? ?? '',

      // Firestore-safe date parsing
      accountCreated: map['account_created'] != null
          ? DateTime.tryParse(map['account_created'].toString()) ??
              DateTime.now()
          : DateTime.now(),

      // optional fields (safe casting)
      age: map['age'] as int?,
      gender: map['gender'] as String?,
      height: (map['height'] as num?)?.toDouble(),
      weight: (map['weight'] as num?)?.toDouble(),
      phone: map['phone'] as String?,
      address: map['address'] as String?,
      activityLevel: map['activity_level'] as String?,
      xpLevel: map['xp_level'] as int?,
    );
  }

  // 🧼 CLEAN toMap
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
