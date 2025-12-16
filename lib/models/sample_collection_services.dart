class SampleCollectionService {
  final String id;        // Firestore document ID
  final String name;
  final String? description;
  final double price;

  SampleCollectionService({
    required this.id,
    required this.name,
    required this.price,
    this.description,
  });

  // 🔒 SAFE fromMap
  factory SampleCollectionService.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return SampleCollectionService(
      id: id,

      // required text
      name: map['name'] as String? ?? '',

      // money-safe
      price: (map['price'] as num?)?.toDouble() ?? 0.0,

      // optional text
      description: map['description'] as String?,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      if (description != null) 'description': description,
    };
  }
}
