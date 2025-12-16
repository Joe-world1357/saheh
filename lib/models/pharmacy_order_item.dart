class PharmacyOrderItem {
  final String id;         // Firestore document ID
  final String orderId;    // FK → pharmacy_orders
  final String productId;  // FK → pharmacy_products
  final int quantity;
  final double subtotal;

  PharmacyOrderItem({
    required this.id,
    required this.orderId,
    required this.productId,
    required this.quantity,
    required this.subtotal,
  });

  // 🔒 SAFE fromMap
  factory PharmacyOrderItem.fromMap(
    Map<String, dynamic>? data,
    String id,
  ) {
    final map = data ?? {};

    return PharmacyOrderItem(
      id: id,

      // required FKs
      orderId: map['order_id'] as String? ?? '',
      productId: map['product_id'] as String? ?? '',

      // quantity-safe (int or num)
      quantity: (map['quantity'] as num?)?.toInt() ?? 0,

      // money-safe
      subtotal: (map['subtotal'] as num?)?.toDouble() ?? 0.0,
    );
  }

  // 🧼 CLEAN toMap
  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}
