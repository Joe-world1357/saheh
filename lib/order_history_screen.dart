import 'package:flutter/material.dart';
import 'order_details_screen.dart';
import 'order_tracking_screen.dart';

class OrderHistoryScreen extends StatefulWidget {
  const OrderHistoryScreen({super.key});

  @override
  State<OrderHistoryScreen> createState() => _OrderHistoryScreenState();
}

class _OrderHistoryScreenState extends State<OrderHistoryScreen> {
  String _selectedFilter = 'All';

  final List<Map<String, dynamic>> _orders = [
    {
      'id': 'ORD-1234567890',
      'date': DateTime.now().subtract(const Duration(days: 2)),
      'status': 'Delivered',
      'total': 42.97,
      'itemCount': 3,
      'items': ['Panadol', 'OBH Combi', 'Betadine'],
    },
    {
      'id': 'ORD-1234567891',
      'date': DateTime.now().subtract(const Duration(days: 5)),
      'status': 'Delivered',
      'total': 15.99,
      'itemCount': 1,
      'items': ['Bodrex Herbal'],
    },
    {
      'id': 'ORD-1234567892',
      'date': DateTime.now().subtract(const Duration(days: 8)),
      'status': 'Cancelled',
      'total': 25.98,
      'itemCount': 2,
      'items': ['Konidin', 'Bodrexin'],
    },
    {
      'id': 'ORD-1234567893',
      'date': DateTime.now().subtract(const Duration(days: 12)),
      'status': 'Delivered',
      'total': 31.98,
      'itemCount': 2,
      'items': ['Panadol', 'OBH Combi'],
    },
  ];

  List<Map<String, dynamic>> get _filteredOrders {
    if (_selectedFilter == 'All') {
      return _orders;
    }
    return _orders.where((order) => order['status'] == _selectedFilter).toList();
  }

  Color _getStatusColor(String status) {
    switch (status) {
      case 'Delivered':
        return const Color(0xFF4CAF50);
      case 'Processing':
        return const Color(0xFF2196F3);
      case 'Shipped':
        return const Color(0xFFFF9800);
      case 'Cancelled':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getStatusIcon(String status) {
    switch (status) {
      case 'Delivered':
        return Icons.check_circle;
      case 'Processing':
        return Icons.hourglass_empty;
      case 'Shipped':
        return Icons.local_shipping;
      case 'Cancelled':
        return Icons.cancel;
      default:
        return Icons.info;
    }
  }

  String _formatDate(DateTime date) {
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays == 0) {
      return 'Today';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} days ago';
    } else {
      return '${date.day}/${date.month}/${date.year}';
    }
  }

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

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
                      "Order History",
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

            // FILTER CHIPS
            SizedBox(
              height: 50,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 20),
                itemCount: ['All', 'Processing', 'Shipped', 'Delivered', 'Cancelled'].length,
                itemBuilder: (context, index) {
                  final filter = ['All', 'Processing', 'Shipped', 'Delivered', 'Cancelled'][index];
                  final isSelected = _selectedFilter == filter;

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedFilter = filter;
                      });
                    },
                    child: Container(
                      margin: const EdgeInsets.only(right: 10),
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 10,
                      ),
                      decoration: BoxDecoration(
                        color: isSelected ? primary : Colors.white,
                        borderRadius: BorderRadius.circular(25),
                        border: Border.all(
                          color: isSelected ? primary : Colors.grey.shade300,
                        ),
                      ),
                      child: Center(
                        child: Text(
                          filter,
                          style: TextStyle(
                            color: isSelected ? Colors.white : const Color(0xFF1A2A2C),
                            fontSize: 14,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),

            const SizedBox(height: 8),

            // ORDERS COUNT
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Row(
                children: [
                  Text(
                    "${_filteredOrders.length} order${_filteredOrders.length != 1 ? 's' : ''}",
                    style: TextStyle(
                      color: Colors.grey.shade600,
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 12),

            // ORDERS LIST
            Expanded(
              child: _filteredOrders.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.all(24),
                            decoration: BoxDecoration(
                              color: Colors.grey.shade100,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.shopping_bag_outlined,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No orders found",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "Your orders will appear here",
                            style: TextStyle(
                              color: Colors.grey.shade500,
                              fontSize: 14,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: _filteredOrders.length,
                      itemBuilder: (context, index) {
                        final order = _filteredOrders[index];
                        final statusColor = _getStatusColor(order['status'] as String);

                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
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
                              // HEADER
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          order['id'] as String,
                                          style: const TextStyle(
                                            color: Color(0xFF1A2A2C),
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          _formatDate(order['date'] as DateTime),
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 12,
                                      vertical: 6,
                                    ),
                                    decoration: BoxDecoration(
                                      color: statusColor.withOpacity(0.1),
                                      borderRadius: BorderRadius.circular(20),
                                    ),
                                    child: Row(
                                      children: [
                                        Icon(
                                          _getStatusIcon(order['status'] as String),
                                          color: statusColor,
                                          size: 16,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          order['status'] as String,
                                          style: TextStyle(
                                            color: statusColor,
                                            fontSize: 12,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),

                              const SizedBox(height: 12),

                              // ITEMS
                              Text(
                                '${order['itemCount']} item${order['itemCount'] > 1 ? 's' : ''}',
                                style: TextStyle(
                                  color: Colors.grey.shade600,
                                  fontSize: 13,
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                (order['items'] as List).join(', '),
                                style: TextStyle(
                                  color: Colors.grey.shade700,
                                  fontSize: 13,
                                ),
                                maxLines: 2,
                                overflow: TextOverflow.ellipsis,
                              ),

                              const SizedBox(height: 12),

                              const Divider(),

                              const SizedBox(height: 12),

                              // FOOTER
                              Row(
                                children: [
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Total",
                                          style: TextStyle(
                                            color: Colors.grey.shade600,
                                            fontSize: 13,
                                          ),
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          "\$${(order['total'] as double).toStringAsFixed(2)}",
                                          style: const TextStyle(
                                            color: Color(0xFF1A2A2C),
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  if (order['status'] != 'Cancelled')
                                    TextButton(
                                      onPressed: () {
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (_) => OrderTrackingScreen(
                                              orderId: order['id'] as String,
                                              orderStatus: order['status'] as String,
                                            ),
                                          ),
                                        );
                                      },
                                      child: const Text(
                                        "Track",
                                        style: TextStyle(
                                          color: Color(0xFF20C6B7),
                                          fontSize: 14,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),
                                  const SizedBox(width: 8),
                                  TextButton(
                                    onPressed: () {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (_) => OrderDetailsScreen(
                                            order: order,
                                          ),
                                        ),
                                      },
                                    },
                                    child: const Text(
                                      "Details",
                                      style: TextStyle(
                                        color: Color(0xFF1A2A2C),
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

