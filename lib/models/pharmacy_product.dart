class PharmacyProduct {
  final String id;        // Firestore document ID
  final String name;
  final String? description;
  final String category;
  final double price;
  final int stock;
  final String? imageUrl;

  PharmacyProduct({
    required this.id,
    required this.name,
    required this.category,
    required this.price,
    required this.stock,
    this.description,
    this.imageUrl,
  });

  // 🔒 SAFE fromMap
  factory PharmacyProduct.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return PharmacyProduct(
      id: id,

      // required text
      name: map['name'] as String? ?? '',
      category: map['category'] as String? ?? '',

      // money-safe
      price: (map['price'] as num?)?.toDouble() ?? 0.0,

      // stock-safe
      stock: (map['stock'] as num?)?.toInt() ?? 0,

      // optional text
      description: map['description'] as String?,
      imageUrl: map['image_url'] as String?,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'category': category,
      'price': price,
      'stock': stock,
      if (description != null) 'description': description,
      if (imageUrl != null) 'image_url': imageUrl,
    };
  }
}
