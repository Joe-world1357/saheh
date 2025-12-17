import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/order_model.dart';
import '../database/database_helper.dart';
import 'cart_provider.dart';
import 'auth_provider.dart';

class OrdersNotifier extends Notifier<List<OrderModel>> {
  final _db = DatabaseHelper.instance;

  String? get _userEmail => ref.read(authProvider).user?.email;

  @override
  List<OrderModel> build() {
    // Watch auth provider to reload when user changes
    final authState = ref.watch(authProvider);
    if (authState.isAuthenticated && authState.user != null) {
      _loadOrders();
    }
    return [];
  }

  Future<void> _loadOrders() async {
    final userEmail = _userEmail;
    if (userEmail == null || userEmail.isEmpty) {
      state = [];
      return;
    }
    final orders = await _db.getAllOrders(userEmail: userEmail);
    state = orders;
  }

  Future<void> refresh() async {
    await _loadOrders();
  }

  Future<String> createOrder({
    required List<CartItem> items,
    required String shippingAddress,
    required String paymentMethod,
  }) async {
    final orderId = 'ORD-${DateTime.now().millisecondsSinceEpoch}';
    final orderItems = items.map((item) => OrderItem(
      productId: item.productId,
      productName: item.productName,
      price: item.price,
      quantity: item.quantity,
      imageUrl: item.imageUrl,
    )).toList();

    final subtotal = items.fold(0.0, (sum, item) => sum + item.total);
    final tax = subtotal * 0.04;
    final total = subtotal + tax;

    final order = OrderModel(
      orderId: orderId,
      items: orderItems,
      subtotal: subtotal,
      tax: tax,
      total: total,
      status: 'confirmed',
      shippingAddress: shippingAddress,
      paymentMethod: paymentMethod,
    );

    final userEmail = _userEmail ?? '';
    await _db.insertOrder(order, userEmail: userEmail);
    await _loadOrders();
    return orderId;
  }

  Future<void> updateOrderStatus(int id, String status) async {
    await _db.updateOrderStatus(id, status, userEmail: _userEmail);
    await _loadOrders();
  }
}

final ordersProvider = NotifierProvider<OrdersNotifier, List<OrderModel>>(() {
  return OrdersNotifier();
});
