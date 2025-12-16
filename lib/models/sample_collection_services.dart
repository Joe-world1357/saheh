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

  factory SampleCollectionService.fromMap(
      Map<String, dynamic> data, String id) {
    return SampleCollectionService(
      id: id,
      name: data['name'],
      description: data['description'],
      price: data['price']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'price': price,
      if (description != null) 'description': description,
    };
  }
}
