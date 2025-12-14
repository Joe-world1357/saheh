import 'package:flutter/material.dart';

class OrderTrackingScreen extends StatelessWidget {
  final String orderId;
  final String orderStatus;

  const OrderTrackingScreen({
    super.key,
    required this.orderId,
    required this.orderStatus,
  });

  @override
  Widget build(BuildContext context) {
    const primary = Color(0xFF20C6B7);

    // Define tracking steps based on order status
    List<Map<String, dynamic>> getTrackingSteps() {
      final steps = [
        {
          'title': 'Order Placed',
          'description': 'Your order has been confirmed',
          'completed': true,
          'date': 'Dec 20, 2024',
          'time': '10:30 AM',
        },
        {
          'title': 'Processing',
          'description': 'Your order is being prepared',
          'completed': orderStatus != 'Placed',
          'date': 'Dec 20, 2024',
          'time': '11:15 AM',
        },
        {
          'title': 'Shipped',
          'description': 'Your order is on the way',
          'completed': orderStatus == 'Shipped' || orderStatus == 'Delivered',
          'date': orderStatus == 'Shipped' || orderStatus == 'Delivered'
              ? 'Dec 21, 2024'
              : null,
          'time': orderStatus == 'Shipped' || orderStatus == 'Delivered'
              ? '2:45 PM'
              : null,
        },
        {
          'title': 'Out for Delivery',
          'description': 'Your order is out for delivery',
          'completed': orderStatus == 'Delivered',
          'date': orderStatus == 'Delivered' ? 'Dec 22, 2024' : null,
          'time': orderStatus == 'Delivered' ? '9:00 AM' : null,
        },
        {
          'title': 'Delivered',
          'description': 'Your order has been delivered',
          'completed': orderStatus == 'Delivered',
          'date': orderStatus == 'Delivered' ? 'Dec 22, 2024' : null,
          'time': orderStatus == 'Delivered' ? '3:30 PM' : null,
        },
      ];

      // Adjust based on actual status
      if (orderStatus == 'Processing') {
        steps[1]['completed'] = true;
      } else if (orderStatus == 'Shipped') {
        steps[1]['completed'] = true;
        steps[2]['completed'] = true;
      } else if (orderStatus == 'Delivered') {
        for (var step in steps) {
          step['completed'] = true;
        }
      }

      return steps;
    }

    final trackingSteps = getTrackingSteps();
    final currentStepIndex = trackingSteps.indexWhere((step) => !step['completed']);

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
                      "Track Order",
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

                    // ORDER INFO CARD
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: Colors.grey.shade200,
                        ),
                      ),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: primary.withOpacity(0.1),
                                  shape: BoxShape.circle,
                                ),
                                child: const Icon(
                                  Icons.local_shipping,
                                  color: Color(0xFF20C6B7),
                                  size: 24,
                                ),
                              ),
                              const SizedBox(width: 16),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Text(
                                      "Order Number",
                                      style: TextStyle(
                                        color: Color(0xFF1A2A2C),
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      orderId,
                                      style: TextStyle(
                                        color: Colors.grey.shade600,
                                        fontSize: 14,
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
                                  color: primary.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(20),
                                ),
                                child: Text(
                                  orderStatus,
                                  style: const TextStyle(
                                    color: Color(0xFF20C6B7),
                                    fontSize: 12,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 32),

                    // TRACKING TIMELINE
                    const Text(
                      "Tracking Information",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // TIMELINE
                    ...trackingSteps.asMap().entries.map((entry) {
                      final index = entry.key;
                      final step = entry.value;
                      final isCompleted = step['completed'] as bool;
                      final isCurrent = index == currentStepIndex;

                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // TIMELINE INDICATOR
                          Column(
                            children: [
                              Container(
                                width: 24,
                                height: 24,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: isCompleted
                                      ? primary
                                      : isCurrent
                                          ? primary.withOpacity(0.3)
                                          : Colors.grey.shade300,
                                  border: Border.all(
                                    color: isCompleted
                                        ? primary
                                        : isCurrent
                                            ? primary
                                            : Colors.grey.shade400,
                                    width: 2,
                                  ),
                                ),
                                child: isCompleted
                                    ? const Icon(
                                        Icons.check,
                                        color: Colors.white,
                                        size: 16,
                                      )
                                    : isCurrent
                                        ? Container(
                                            margin: const EdgeInsets.all(4),
                                            decoration: BoxDecoration(
                                              color: primary,
                                              shape: BoxShape.circle,
                                            ),
                                          )
                                        : null,
                              ),
                              if (index < trackingSteps.length - 1)
                                Container(
                                  width: 2,
                                  height: 60,
                                  color: isCompleted
                                      ? primary
                                      : Colors.grey.shade300,
                                ),
                            ],
                          ),

                          const SizedBox(width: 16),

                          // STEP CONTENT
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                bottom: index < trackingSteps.length - 1 ? 20 : 0,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    step['title'] as String,
                                    style: TextStyle(
                                      color: isCompleted || isCurrent
                                          ? const Color(0xFF1A2A2C)
                                          : Colors.grey.shade600,
                                      fontSize: 16,
                                      fontWeight: isCompleted || isCurrent
                                          ? FontWeight.bold
                                          : FontWeight.normal,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    step['description'] as String,
                                    style: TextStyle(
                                      color: Colors.grey.shade600,
                                      fontSize: 13,
                                    ),
                                  ),
                                  if (step['date'] != null) ...[
                                    const SizedBox(height: 8),
                                    Row(
                                      children: [
                                        Icon(
                                          Icons.calendar_today,
                                          size: 12,
                                          color: Colors.grey.shade500,
                                        ),
                                        const SizedBox(width: 4),
                                        Text(
                                          '${step['date']} at ${step['time']}',
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ],
                              ),
                            ),
                          ),
                        ],
                      );
                    }),

                    const SizedBox(height: 32),

                    // ESTIMATED DELIVERY
                    Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [
                            Color(0xFFE3F2FD),
                            Color(0xFFBBDEFB),
                          ],
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                          color: const Color(0xFF2196F3).withOpacity(0.3),
                        ),
                      ),
                      child: Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(12),
                            decoration: const BoxDecoration(
                              color: Color(0xFF2196F3),
                              shape: BoxShape.circle,
                            ),
                            child: const Icon(
                              Icons.schedule,
                              color: Colors.white,
                              size: 24,
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Estimated Delivery",
                                  style: TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  orderStatus == 'Delivered'
                                      ? 'Delivered on Dec 22, 2024'
                                      : 'Expected by Dec 24, 2024',
                                  style: TextStyle(
                                    color: Colors.grey.shade700,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),

                    // DELIVERY ADDRESS
                    const Text(
                      "Delivery Address",
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
                      child: Row(
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
                                const Text(
                                  "John Doe",
                                  style: TextStyle(
                                    color: Color(0xFF1A2A2C),
                                    fontSize: 15,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "742 Evergreen Terrace, Springfield, ST 12345",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  "+1 (555) 123-4567",
                                  style: TextStyle(
                                    color: Colors.grey.shade600,
                                    fontSize: 14,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}


