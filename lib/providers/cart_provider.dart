import 'package:flutter_riverpod/flutter_riverpod.dart';

class CartItem {
  final String productId;
  final String productName;
  final double price;
  int quantity;
  final String? imageUrl;
  final String? size;

  CartItem({
    required this.productId,
    required this.productName,
    required this.price,
    this.quantity = 1,
    this.imageUrl,
    this.size,
  });

  double get total => price * quantity;

  CartItem copyWith({
    String? productId,
    String? productName,
    double? price,
    int? quantity,
    String? imageUrl,
    String? size,
  }) {
    return CartItem(
      productId: productId ?? this.productId,
      productName: productName ?? this.productName,
      price: price ?? this.price,
      quantity: quantity ?? this.quantity,
      imageUrl: imageUrl ?? this.imageUrl,
      size: size ?? this.size,
    );
  }
}

class CartNotifier extends Notifier<List<CartItem>> {
  @override
  List<CartItem> build() => [];

  void addItem(CartItem item) {
    final existingIndex = state.indexWhere((i) => i.productId == item.productId);
    if (existingIndex >= 0) {
      final updated = List<CartItem>.from(state);
      updated[existingIndex].quantity += item.quantity;
      state = updated;
    } else {
      state = [...state, item];
    }
  }

  void removeItem(String productId) {
    state = state.where((item) => item.productId != productId).toList();
  }

  void updateQuantity(String productId, int quantity) {
    if (quantity <= 0) {
      removeItem(productId);
      return;
    }
    final updated = state.map((item) {
      if (item.productId == productId) {
        return item.copyWith(quantity: quantity);
      }
      return item;
    }).toList();
    state = updated;
  }

  void clearCart() {
    state = [];
  }

  double get subtotal => state.fold(0.0, (sum, item) => sum + item.total);
  double get tax => subtotal * 0.04; // 4% tax
  double get total => subtotal + tax;
}

final cartProvider = NotifierProvider<CartNotifier, List<CartItem>>(() {
  return CartNotifier();
});

