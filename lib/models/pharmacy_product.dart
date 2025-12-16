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

  factory PharmacyProduct.fromMap(
      Map<String, dynamic> data, String id) {
    return PharmacyProduct(
      id: id,
      name: data['name'],
      description: data['description'],
      category: data['category'],
      price: data['price']?.toDouble(),
      stock: data['stock'],
      imageUrl: data['image_url'],
    );
  }

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