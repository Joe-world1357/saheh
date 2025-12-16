class PharmacyOrder {
  final String id;        // Firestore document ID
  final String userId;    // FK → users
  final DateTime orderDate;
  final String status;
  final double totalPrice;

  PharmacyOrder({
    required this.id,
    required this.userId,
    required this.orderDate,
    required this.status,
    required this.totalPrice,
  });

  factory PharmacyOrder.fromMap(
      Map<String, dynamic> data, String id) {
    return PharmacyOrder(
      id: id,
      userId: data['user_id'],
      orderDate: DateTime.parse(data['order_date']),
      status: data['status'],
      totalPrice: data['total_price']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'order_date': orderDate.toIso8601String(),
      'status': status,
      'total_price': totalPrice,
    };
  }
}
