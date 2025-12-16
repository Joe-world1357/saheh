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

  // 🔒 SAFE fromMap
  factory PharmacyOrder.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return PharmacyOrder(
      id: id,

      // required FK
      userId: map['user_id'] as String? ?? '',

      // Firestore / offline safe date
      orderDate: map['order_date'] != null
          ? DateTime.tryParse(
                map['order_date'].toString(),
              ) ??
              DateTime.now()
          : DateTime.now(),

      // order lifecycle safety
      status: map['status'] as String? ?? 'pending',

      // money-safe total
      totalPrice:
          (map['total_price'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'user_id': userId,
      'order_date': orderDate.toIso8601String(),
      'status': status,
      'total_price': totalPrice,
    };
  }
}
