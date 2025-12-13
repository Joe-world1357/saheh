import 'package:flutter/material.dart';

class CartScreen
    extends
        StatefulWidget {
  const CartScreen({
    super.key,
  });

  @override
  State<
    CartScreen
  >
  createState() => _CartScreenState();
}

class _CartScreenState
    extends
        State<
          CartScreen
        > {
  final List<
    Map<
      String,
      dynamic
    >
  >
  cartItems = [
    {
      'name': 'OBH Combi',
      'size': '75ml',
      'quantity': 1,
      'price': 9.99,
    },
    {
      'name': 'Panadol',
      'size': '20pcs',
      'quantity': 2,
      'price': 15.99,
    },
  ];

  double get subtotal {
    return cartItems.fold(
      0,
      (
        sum,
        item,
      ) =>
          sum +
          (item['price'] *
              item['quantity']),
    );
  }

  double get taxes => 1.00;
  double get total =>
      subtotal +
      taxes;

  @override
  Widget build(
    BuildContext context,
  ) {
    const primary = Color(
      0xFF20C6B7,
    );

    return Scaffold(
      backgroundColor: const Color(
        0xFFF5FAFA,
      ),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR --------------------------------------------------------
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 10,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(
                        12,
                      ),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(
                        context,
                      ),
                    ),
                  ),
                  const Spacer(),
                  const Text(
                    "My Cart",
                    style: TextStyle(
                      color: Color(
                        0xFF1A2A2C,
                      ),
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const Spacer(),
                  const SizedBox(
                    width: 48,
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 20,
                      ),

                      // CART ITEMS -------------------------------------------------
                      ...cartItems.asMap().entries.map(
                        (
                          entry,
                        ) {
                          int index = entry.key;
                          Map<
                            String,
                            dynamic
                          >
                          item = entry.value;
                          return Column(
                            children: [
                              _cartItem(
                                name: item['name'],
                                size: item['size'],
                                quantity: item['quantity'],
                                price: item['price'],
                                onQuantityChanged:
                                    (
                                      newQuantity,
                                    ) {
                                      setState(
                                        () {
                                          cartItems[index]['quantity'] = newQuantity;
                                        },
                                      );
                                    },
                                onDelete: () {
                                  setState(
                                    () {
                                      cartItems.removeAt(
                                        index,
                                      );
                                    },
                                  );
                                },
                                primary: primary,
                              ),
                              const SizedBox(
                                height: 16,
                              ),
                            ],
                          );
                        },
                      ).toList(),

                      const SizedBox(
                        height: 20,
                      ),

                      // PAYMENT DETAIL ---------------------------------------------
                      const Text(
                        "Payment Detail",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      _paymentRow(
                        "Subtotal",
                        subtotal,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      _paymentRow(
                        "Taxes",
                        taxes,
                      ),
                      const SizedBox(
                        height: 12,
                      ),
                      const Divider(),
                      const SizedBox(
                        height: 12,
                      ),
                      _paymentRow(
                        "Total",
                        total,
                        isBold: true,
                      ),

                      const SizedBox(
                        height: 28,
                      ),

                      // PAYMENT METHOD ---------------------------------------------
                      const Text(
                        "Payment Method",
                        style: TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      const SizedBox(
                        height: 16,
                      ),

                      Container(
                        padding: const EdgeInsets.all(
                          16,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                          border: Border.all(
                            color: Colors.grey.shade200,
                          ),
                        ),
                        child: Row(
                          children: [
                            const Text(
                              "Pay When Delivered",
                              style: TextStyle(
                                color: Color(
                                  0xFF20C6B7,
                                ),
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const Spacer(),
                            Text(
                              "Change",
                              style: TextStyle(
                                color: Colors.grey.shade600,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),

                      const SizedBox(
                        height: 40,
                      ),
                    ],
                  ),
                ),
              ),
            ),

            // BOTTOM BAR WITH TOTAL & CHECKOUT -------------------------------
            Container(
              padding: const EdgeInsets.all(
                20,
              ),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(
                      0.05,
                    ),
                    blurRadius: 10,
                    offset: const Offset(
                      0,
                      -5,
                    ),
                  ),
                ],
              ),
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "Total",
                        style: TextStyle(
                          color: Colors.grey.shade600,
                          fontSize: 13,
                        ),
                      ),
                      const SizedBox(
                        height: 4,
                      ),
                      Text(
                        "\$${total.toStringAsFixed(2)}",
                        style: const TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        // Checkout action
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primary,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(
                            12,
                          ),
                        ),
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                      ),
                      child: const Text(
                        "Checkout",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  // CART ITEM WIDGET ---------------------------------------------------
  Widget _cartItem({
    required String name,
    required String size,
    required int quantity,
    required double price,
    required Function(
      int,
    )
    onQuantityChanged,
    required VoidCallback onDelete,
    required Color primary,
  }) {
    return Container(
      padding: const EdgeInsets.all(
        16,
      ),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(
          16,
        ),
        border: Border.all(
          color: Colors.grey.shade200,
        ),
      ),
      child: Row(
        children: [
          // Product Image
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: Colors.grey.shade100,
              borderRadius: BorderRadius.circular(
                12,
              ),
            ),
            child: Center(
              child: Icon(
                Icons.medication,
                size: 30,
                color: Colors.grey.shade400,
              ),
            ),
          ),
          const SizedBox(
            width: 16,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        name,
                        style: const TextStyle(
                          color: Color(
                            0xFF1A2A2C,
                          ),
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    GestureDetector(
                      onTap: onDelete,
                      child: Icon(
                        Icons.delete_outline,
                        color: primary,
                        size: 22,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 4,
                ),
                Text(
                  size,
                  style: TextStyle(
                    color: Colors.grey.shade600,
                    fontSize: 13,
                  ),
                ),
                const SizedBox(
                  height: 12,
                ),
                Row(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                          color: Colors.grey.shade300,
                        ),
                        borderRadius: BorderRadius.circular(
                          8,
                        ),
                      ),
                      child: Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              if (quantity >
                                  1)
                                onQuantityChanged(
                                  quantity -
                                      1,
                                );
                            },
                            icon: const Icon(
                              Icons.remove,
                              size: 16,
                            ),
                            color: Colors.grey.shade600,
                            padding: const EdgeInsets.all(
                              4,
                            ),
                            constraints: const BoxConstraints(),
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                            ),
                            child: Text(
                              "$quantity",
                              style: const TextStyle(
                                color: Color(
                                  0xFF1A2A2C,
                                ),
                                fontSize: 14,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          IconButton(
                            onPressed: () => onQuantityChanged(
                              quantity +
                                  1,
                            ),
                            icon: Container(
                              padding: const EdgeInsets.all(
                                2,
                              ),
                              decoration: BoxDecoration(
                                color: primary,
                                borderRadius: BorderRadius.circular(
                                  4,
                                ),
                              ),
                              child: const Icon(
                                Icons.add,
                                size: 14,
                                color: Colors.white,
                              ),
                            ),
                            padding: const EdgeInsets.all(
                              4,
                            ),
                            constraints: const BoxConstraints(),
                          ),
                        ],
                      ),
                    ),
                    const Spacer(),
                    Text(
                      "\$${(price * quantity).toStringAsFixed(2)}",
                      style: const TextStyle(
                        color: Color(
                          0xFF1A2A2C,
                        ),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // PAYMENT ROW WIDGET -------------------------------------------------
  Widget _paymentRow(
    String label,
    double amount, {
    bool isBold = false,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: isBold
                ? const Color(
                    0xFF1A2A2C,
                  )
                : Colors.grey.shade600,
            fontSize: isBold
                ? 16
                : 15,
            fontWeight: isBold
                ? FontWeight.bold
                : FontWeight.normal,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: TextStyle(
            color: const Color(
              0xFF1A2A2C,
            ),
            fontSize: isBold
                ? 16
                : 15,
            fontWeight: isBold
                ? FontWeight.bold
                : FontWeight.w600,
          ),
        ),
      ],
    );
  }
}
