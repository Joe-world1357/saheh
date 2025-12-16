import 'package:cloud_firestore/cloud_firestore.dart';
import '../models/pharmacy_product.dart';
import '../models/pharmacy_orders.dart';
import '../models/pharmacy_order_item.dart';

class PharmacyRepository {
  final FirebaseFirestore _db = FirebaseFirestore.instance;

  CollectionReference<Map<String, dynamic>> get _products =>
      _db.collection('pharmacy_products');

  CollectionReference<Map<String, dynamic>> get _orders =>
      _db.collection('pharmacy_orders');

  CollectionReference<Map<String, dynamic>> get _orderItems =>
      _db.collection('pharmacy_order_items');

  /// Get all pharmacy products (catalog)
  Future<List<PharmacyProduct>> getProducts() async {
    final snapshot = await _products.get();

    return snapshot.docs
        .map((d) => PharmacyProduct.fromMap(d.data(), d.id))
        .toList();
  }

  /// Get products by category
  Future<List<PharmacyProduct>> getProductsByCategory(
    String category,
  ) async {
    final snapshot = await _products
        .where('category', isEqualTo: category)
        .get();

    return snapshot.docs
        .map((d) => PharmacyProduct.fromMap(d.data(), d.id))
        .toList();
  }

  /// Create or update order
  Future<void> saveOrder(PharmacyOrder order) async {
    await _orders.doc(order.id).set(
          order.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Get orders for a user
  Future<List<PharmacyOrder>> getUserOrders(
    String userId,
  ) async {
    final snapshot = await _orders
        .where('user_id', isEqualTo: userId)
        .orderBy('order_date', descending: true)
        .get();

    return snapshot.docs
        .map((d) => PharmacyOrder.fromMap(d.data(), d.id))
        .toList();
  }

  /// Add or update order item
  Future<void> saveOrderItem(
    PharmacyOrderItem item,
  ) async {
    await _orderItems.doc(item.id).set(
          item.toMap(),
          SetOptions(merge: true),
        );
  }

  /// Get items for an order
  Future<List<PharmacyOrderItem>> getOrderItems(
    String orderId,
  ) async {
    final snapshot = await _orderItems
        .where('order_id', isEqualTo: orderId)
        .get();

    return snapshot.docs
        .map(
          (d) => PharmacyOrderItem.fromMap(d.data(), d.id),
        )
        .toList();
  }
}
