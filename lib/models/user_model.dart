class UserModel {
  final int? id;
  final String name;
  final String email;
  final String? phone;
  final int? age;
  final String? gender;
  final double? height; // in cm
  final double? weight; // in kg
  final String? address;
  final int xp;
  final int level;
  final DateTime createdAt;
  final DateTime? updatedAt;

  UserModel({
    this.id,
    required this.name,
    required this.email,
    this.phone,
    this.age,
    this.gender,
    this.height,
    this.weight,
    this.address,
    this.xp = 0,
    this.level = 1,
    DateTime? createdAt,
    this.updatedAt,
  }) : createdAt = createdAt ?? DateTime.now();

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'phone': phone,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
      'address': address,
      'xp': xp,
      'level': level,
      'created_at': createdAt.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      id: map['id'] as int?,
      name: map['name'] as String,
      email: map['email'] as String,
      phone: map['phone'] as String?,
      age: map['age'] as int?,
      gender: map['gender'] as String?,
      height: map['height'] != null ? (map['height'] as num).toDouble() : null,
      weight: map['weight'] != null ? (map['weight'] as num).toDouble() : null,
      address: map['address'] as String?,
      xp: map['xp'] as int? ?? 0,
      level: map['level'] as int? ?? 1,
      createdAt: map['created_at'] != null
          ? DateTime.parse(map['created_at'] as String)
          : DateTime.now(),
      updatedAt: map['updated_at'] != null
          ? DateTime.parse(map['updated_at'] as String)
          : null,
    );
  }

  UserModel copyWith({
    int? id,
    String? name,
    String? email,
    String? phone,
    int? age,
    String? gender,
    double? height,
    double? weight,
    String? address,
    int? xp,
    int? level,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return UserModel(
      id: id ?? this.id,
      name: name ?? this.name,
      email: email ?? this.email,
      phone: phone ?? this.phone,
      age: age ?? this.age,
      gender: gender ?? this.gender,
      height: height ?? this.height,
      weight: weight ?? this.weight,
      address: address ?? this.address,
      xp: xp ?? this.xp,
      level: level ?? this.level,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}

