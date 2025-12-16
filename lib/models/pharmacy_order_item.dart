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

  factory PharmacyOrderItem.fromMap(
      Map<String, dynamic> data, String id) {
    return PharmacyOrderItem(
      id: id,
      orderId: data['order_id'],
      productId: data['product_id'],
      quantity: data['quantity'],
      subtotal: data['subtotal']?.toDouble(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'order_id': orderId,
      'product_id': productId,
      'quantity': quantity,
      'subtotal': subtotal,
    };
  }
}
