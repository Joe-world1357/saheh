import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NotificationsScreen extends StatefulWidget {
  const NotificationsScreen({super.key});

  @override
  State<NotificationsScreen> createState() => _NotificationsScreenState();
}

class _NotificationsScreenState extends State<NotificationsScreen> {
  final List<Map<String, dynamic>> notifications = [
    {
      'type': 'medicine',
      'title': 'Medicine Reminder',
      'message': 'Time to take your Aspirin (1 tablet)',
      'time': DateTime.now().subtract(const Duration(minutes: 15)),
      'read': false,
      'icon': Icons.medication,
      'color': const Color(0xFFFF9800),
    },
    {
      'type': 'workout',
      'title': 'Workout Reminder',
      'message': 'Your scheduled workout starts in 30 minutes',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'read': false,
      'icon': Icons.fitness_center,
      'color': const Color(0xFF2196F3),
    },
    {
      'type': 'nutrition',
      'title': 'Nutrition Tip',
      'message': 'Your protein intake is below target. Add lean protein to your next meal.',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'read': true,
      'icon': Icons.restaurant,
      'color': const Color(0xFF4CAF50),
    },
    {
      'type': 'appointment',
      'title': 'Appointment Reminder',
      'message': 'Your clinic appointment with Dr. Smith is tomorrow at 10:00 AM',
      'time': DateTime.now().subtract(const Duration(hours: 12)),
      'read': true,
      'icon': Icons.calendar_today,
      'color': const Color(0xFF20C6B7),
    },
    {
      'type': 'achievement',
      'title': 'Achievement Unlocked!',
      'message': 'Congratulations! You completed 7 days of workouts in a row',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'read': true,
      'icon': Icons.emoji_events,
      'color': const Color(0xFFFFC107),
    },
    {
      'type': 'order',
      'title': 'Order Update',
      'message': 'Your pharmacy order #12345 has been shipped',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'read': true,
      'icon': Icons.local_shipping,
      'color': const Color(0xFF9C27B0),
    },
    {
      'type': 'lab',
      'title': 'Lab Results Ready',
      'message': 'Your blood test results are now available',
      'time': DateTime.now().subtract(const Duration(days: 3)),
      'read': true,
      'icon': Icons.science,
      'color': const Color(0xFFE91E63),
    },
  ];

  int get unreadCount => notifications.where((n) => !n['read']).length;

  String _formatTime(DateTime time) {
    final now = DateTime.now();
    final difference = now.difference(time);

    if (difference.inMinutes < 1) {
      return 'Just now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else if (difference.inDays == 1) {
      return 'Yesterday';
    } else if (difference.inDays < 7) {
      return '${difference.inDays}d ago';
    } else {
      return DateFormat('MMM d').format(time);
    }
  }

  void _markAsRead(int index) {
    setState(() {
      notifications[index]['read'] = true;
    });
  }

  void _markAllAsRead() {
    setState(() {
      for (var notification in notifications) {
        notification['read'] = true;
      }
    });
  }

  void _deleteNotification(int index) {
    setState(() {
      notifications.removeAt(index);
    });
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
                      "Notifications",
                      style: TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  if (unreadCount > 0)
                    TextButton(
                      onPressed: _markAllAsRead,
                      child: const Text(
                        "Mark all read",
                        style: TextStyle(
                          color: Color(0xFF20C6B7),
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // UNREAD COUNT BADGE
            if (unreadCount > 0)
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(
                    color: primary.withOpacity(0.3),
                  ),
                ),
                child: Row(
                  children: [
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: primary,
                        shape: BoxShape.circle,
                      ),
                      child: const Text(
                        "!",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(width: 12),
                    Text(
                      "$unreadCount unread notification${unreadCount > 1 ? 's' : ''}",
                      style: const TextStyle(
                        color: Color(0xFF1A2A2C),
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),

            const SizedBox(height: 16),

            // NOTIFICATIONS LIST
            Expanded(
              child: notifications.isEmpty
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
                              Icons.notifications_none,
                              size: 64,
                              color: Colors.grey.shade400,
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No notifications",
                            style: TextStyle(
                              color: Colors.grey.shade600,
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        final isUnread = !notification['read'] as bool;

                        return Dismissible(
                          key: Key('notification_$index'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(16),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            _deleteNotification(index);
                          },
                          child: GestureDetector(
                            onTap: () => _markAsRead(index),
                            child: Container(
                              margin: const EdgeInsets.only(bottom: 12),
                              padding: const EdgeInsets.all(16),
                              decoration: BoxDecoration(
                                color: isUnread
                                    ? primary.withOpacity(0.05)
                                    : Colors.white,
                                borderRadius: BorderRadius.circular(16),
                                border: Border.all(
                                  color: isUnread
                                      ? primary.withOpacity(0.3)
                                      : Colors.grey.shade200,
                                  width: isUnread ? 1.5 : 1,
                                ),
                              ),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ICON
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: (notification['color'] as Color)
                                          .withOpacity(0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      notification['icon'] as IconData,
                                      color: notification['color'] as Color,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // CONTENT
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                notification['title'] as String,
                                                style: TextStyle(
                                                  color: const Color(0xFF1A2A2C),
                                                  fontSize: 15,
                                                  fontWeight: isUnread
                                                      ? FontWeight.bold
                                                      : FontWeight.w600,
                                                ),
                                              ),
                                            ),
                                            if (isUnread)
                                              Container(
                                                width: 8,
                                                height: 8,
                                                decoration: const BoxDecoration(
                                                  color: primary,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notification['message'] as String,
                                          style: TextStyle(
                                            color: Colors.grey.shade700,
                                            fontSize: 13,
                                            height: 1.4,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _formatTime(
                                            notification['time'] as DateTime,
                                          ),
                                          style: TextStyle(
                                            color: Colors.grey.shade500,
                                            fontSize: 12,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
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

