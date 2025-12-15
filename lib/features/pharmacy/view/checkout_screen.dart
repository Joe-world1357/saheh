import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'order_confirmation_screen.dart';
import 'address_management_screen.dart';
import '../../../providers/cart_provider.dart';
import '../../../providers/orders_provider.dart';

class CheckoutScreen extends ConsumerStatefulWidget {
  final double totalAmount;
  final List<CartItem> cartItems;

  const CheckoutScreen({
    super.key,
    required this.totalAmount,
    required this.cartItems,
  });

  @override
  ConsumerState<CheckoutScreen> createState() => _CheckoutScreenState();
}

class _CheckoutScreenState extends ConsumerState<CheckoutScreen> {
  String _selectedPaymentMethod = 'Pay When Delivered';
  Map<String, dynamic>? _selectedAddress;

  final List<Map<String, dynamic>> _paymentMethods = [
    {
      'name': 'Pay When Delivered',
      'icon': Icons.local_shipping,
      'color': const Color(0xFF20C6B7),
    },
    {
      'name': 'Credit/Debit Card',
      'icon': Icons.credit_card,
      'color': const Color(0xFF2196F3),
    },
    {
      'name': 'Digital Wallet',
      'icon': Icons.account_balance_wallet,
      'color': const Color(0xFF4CAF50),
    },
    {
      'name': 'Bank Transfer',
      'icon': Icons.account_balance,
      'color': const Color(0xFF9C27B0),
    },
  ];

  @override
  void initState() {
    super.initState();
    // Set default address
    _selectedAddress = {
      'name': 'John Doe',
      'phone': '+1 (555) 123-4567',
      'address': '742 Evergreen Terrace',
      'city': 'Springfield',
      'state': 'ST',
      'zipCode': '12345',
      'isDefault': true,
    };
  }

  Future<void> _placeOrder() async {
    if (_selectedAddress == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select a delivery address'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    final ordersNotifier = ref.read(ordersProvider.notifier);
    final cartNotifier = ref.read(cartProvider.notifier);
    
    final addressString = '${_selectedAddress!['address']}, ${_selectedAddress!['city']}, ${_selectedAddress!['state']} ${_selectedAddress!['zipCode']}';
    
    final orderId = await ordersNotifier.createOrder(
      items: widget.cartItems,
      shippingAddress: addressString,
      paymentMethod: _selectedPaymentMethod,
    );

    // Clear cart
    cartNotifier.clearCart();

    // Navigate to order confirmation
    if (mounted) {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => OrderConfirmationScreen(
            orderNumber: orderId,
            totalAmount: widget.totalAmount,
            deliveryAddress: _selectedAddress!,
          ),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);
    final subtotal = widget.totalAmount - 1.00; // Assuming $1 tax
    final tax = 1.00;

    return Scaffold(
      backgroundColor: const Color(0xFFF5FAFA),
      body: SafeArea(
        child: Column(
          children: [
            // TOP BAR
            Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 16,
              ),
              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(12),
                      border: Border.all(
                        color: Colors.grey.shade300,
                        width: 1.5,
                      ),
                    ),
                    child: IconButton(
                      icon: const Icon(
                        Icons.arrow_back_ios_new,
                        color: Color(0xFF1A2A2C),
                        size: 20,
                      ),
                      onPressed: () => Navigator.pop(context),
                    ),
                  ),
                  const SizedBox(width: 16),
                  const Expanded(
                    child: Text(
                      "Checkout",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),

            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 20),

                    // DELIVERY ADDRESS
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "Delivery Address",
                          style: TextStyle(
                            color: Color(0xFF1A2A2C),
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            final address = await Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => const AddressManagementScreen(),
                              ),
                            );
                            if (address != null) {
                              setState(() {
                                _selectedAddress = address;
                              });
                            }
                          },
                          child: const Text(
                            "Change",
                            style: TextStyle(
                              color: Color(0xFF20C6B7),
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.location_on,
                                  color: Color(0xFF20C6B7),
                                  size: 20,
                                ),
                              ),
                              const SizedBox(width: 12),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      _selectedAddress?['name'] ?? 'No address',
                                      style: const TextStyle(
                                        color: Color(0xFF1A2A2C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      _selectedAddress != null
                                          ? '${_selectedAddress!['address']}, ${_selectedAddress!['city']}, ${_selectedAddress!['state']} ${_selectedAddress!['zipCode']}'
                                          : 'Please select an address',
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 13,
                                      ),
                                    ),
                                    if (_selectedAddress != null) ...[
                                      const SizedBox(height: 4),
                                      Text(
                                        _selectedAddress!['phone'],
                                        style: TextStyle(
                                          color: Colors.grey.shade600,
                                          fontSize: 13,
                                        ),
                                      ),
                                    ],
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // ORDER SUMMARY
                    const Text(
                      "Order Summary",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        children: [
                          ...widget.cartItems.map((item) => Padding(
                                padding: const EdgeInsets.only(bottom: 12),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            item.productName,
                                            style: const TextStyle(
                                              color: Color(0xFF1A2A2C),
                                              fontSize: 14,
                                              fontWeight: FontWeight.w600,
                                            ),
                                          ),
                                          Text(
                                            '${item.imageUrl ?? 'N/A'} × ${item.quantity}',
                                            style: TextStyle(
                                              color: Colors.grey.shade600,
                                              fontSize: 12,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Text(
                                      "\$${(item.price * item.quantity).toStringAsFixed(2)}",
                                      style: const TextStyle(
                                        color: Color(0xFF1A2A2C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              )),
                          const Divider(),
                          const SizedBox(height: 8),
                          _buildSummaryRow("Subtotal", subtotal),
                          const SizedBox(height: 8),
                          _buildSummaryRow("Delivery Fee", 0.0),
                          const SizedBox(height: 8),
                          _buildSummaryRow("Tax", tax),
                          const Divider(),
                          const SizedBox(height: 8),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                "Total",
                                style: TextStyle(
                                  color: Color(0xFF1A2A2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                              Text(
                                "\$${widget.totalAmount.toStringAsFixed(2)}",
                                style: const TextStyle(
                                  color: Color(0xFF1A2A2C),
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 24),

                    // PAYMENT METHOD
                    const Text(
                      "Payment Method",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 12),

                    ..._paymentMethods.map((method) => Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedPaymentMethod = method['name'] as String;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: _selectedPaymentMethod == method['name']
                                      ? primary
                                      : Colors.grey.shade200,
                                  width: _selectedPaymentMethod == method['name'] ? 2 : 1,
                                ),
                              ),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (method['color'] as Color).withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      method['icon'] as IconData,
                                      color: method['color'] as Color,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: Text(
                                      method['name'] as String,
                                      style: const TextStyle(
                                        color: Color(0xFF1A2A2C),
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                  if (_selectedPaymentMethod == method['name'])
                                    const Icon(
                                      Icons.check_circle,
                                      color: Color(0xFF20C6B7),
                                    ),
                                ],
                              ),
                            ),
                          ),
                        )),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),

            // BOTTOM BUTTON
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, -5),
                  ),
                ],
              ),
              child: SafeArea(
                child: SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    onPressed: _placeOrder,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: primary,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      padding: const EdgeInsets.symmetric(vertical: 16),
                    ),
                    child: const Text(
                      "Place Order",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSummaryRow(String label, double amount) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(
            color: Colors.grey.shade600,
            fontSize: 14,
          ),
        ),
        Text(
          "\$${amount.toStringAsFixed(2)}",
          style: const TextStyle(
            color: Color(0xFF1A2A2C),
            fontSize: 14,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }
}


