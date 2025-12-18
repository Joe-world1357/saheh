import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/theme/app_text_styles.dart';
import '../../../core/theme/app_theme.dart';
import '../../../shared/widgets/app_card.dart';

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
      'color': AppColors.warning,
    },
    {
      'type': 'workout',
      'title': 'Workout Reminder',
      'message': 'Your scheduled workout starts in 30 minutes',
      'time': DateTime.now().subtract(const Duration(hours: 2)),
      'read': false,
      'icon': Icons.fitness_center,
      'color': AppColors.info,
    },
    {
      'type': 'nutrition',
      'title': 'Nutrition Tip',
      'message': 'Your protein intake is below target. Add lean protein to your next meal.',
      'time': DateTime.now().subtract(const Duration(hours: 5)),
      'read': true,
      'icon': Icons.restaurant,
      'color': AppColors.success,
    },
    {
      'type': 'appointment',
      'title': 'Appointment Reminder',
      'message': 'Your clinic appointment with Dr. Smith is tomorrow at 10:00 AM',
      'time': DateTime.now().subtract(const Duration(hours: 12)),
      'read': true,
      'icon': Icons.calendar_today,
      'color': AppColors.primary,
    },
    {
      'type': 'achievement',
      'title': 'Achievement Unlocked!',
      'message': 'Congratulations! You completed 7 days of workouts in a row',
      'time': DateTime.now().subtract(const Duration(days: 1)),
      'read': true,
      'icon': Icons.emoji_events,
      'color': AppColors.warning,
    },
    {
      'type': 'order',
      'title': 'Order Update',
      'message': 'Your pharmacy order #12345 has been shipped',
      'time': DateTime.now().subtract(const Duration(days: 2)),
      'read': true,
      'icon': Icons.local_shipping,
      'color': AppColors.tertiary,
    },
    {
      'type': 'lab',
      'title': 'Lab Results Ready',
      'message': 'Your blood test results are now available',
      'time': DateTime.now().subtract(const Duration(days: 3)),
      'read': true,
      'icon': Icons.science,
      'color': AppColors.error,
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
    final theme = Theme.of(context);
    final brightness = theme.brightness;
    final primary = AppColors.getPrimary(brightness);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      appBar: AppBar(
        backgroundColor: theme.colorScheme.surface,
        elevation: 0,
        leading: IconButton(
          icon: Icon(Icons.arrow_back, color: theme.colorScheme.onSurface),
          onPressed: () => Navigator.pop(context),
        ),
        title: Text('Notifications', style: theme.textTheme.titleLarge),
        actions: [
          if (unreadCount > 0)
            TextButton(
              onPressed: _markAllAsRead,
              child: Text(
                "Mark all read",
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            // UNREAD COUNT BADGE
            if (unreadCount > 0)
              Padding(
                padding: const EdgeInsets.all(16),
                child: AppCard(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                  backgroundColor: AppColors.getInfo(brightness).withValues(alpha: 0.1),
                  border: Border.all(
                    color: AppColors.getInfo(brightness).withValues(alpha: 0.3),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: AppColors.getInfo(brightness),
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          "!",
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        "$unreadCount unread notification${unreadCount > 1 ? 's' : ''}",
                        style: theme.textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

            // NOTIFICATIONS LIST
            Expanded(
              child: notifications.isEmpty
                  ? Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(
                            Icons.notifications_none,
                            size: 64,
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                          const SizedBox(height: 16),
                          Text(
                            "No notifications",
                            style: theme.textTheme.bodyLarge,
                          ),
                        ],
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.all(16),
                      itemCount: notifications.length,
                      itemBuilder: (context, index) {
                        final notification = notifications[index];
                        final isUnread = !notification['read'] as bool;
                        final notifColor = notification['color'] as Color;

                        return Dismissible(
                          key: Key('notification_$index'),
                          direction: DismissDirection.endToStart,
                          background: Container(
                            alignment: Alignment.centerRight,
                            padding: const EdgeInsets.only(right: 20),
                            decoration: BoxDecoration(
                              color: AppColors.getError(brightness),
                              borderRadius: BorderRadius.circular(AppTheme.radiusLarge),
                            ),
                            child: const Icon(
                              Icons.delete,
                              color: Colors.white,
                            ),
                          ),
                          onDismissed: (direction) {
                            _deleteNotification(index);
                          },
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: AppCard(
                              padding: const EdgeInsets.all(16),
                              backgroundColor: isUnread
                                  ? notifColor.withValues(alpha: 0.05)
                                  : null,
                              border: Border.all(
                                color: isUnread
                                    ? notifColor.withValues(alpha: 0.3)
                                    : theme.colorScheme.outline.withValues(alpha: 0.2),
                                width: isUnread ? 1.5 : 1,
                              ),
                              onTap: () => _markAsRead(index),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  // ICON
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: notifColor.withValues(alpha: 0.15),
                                      shape: BoxShape.circle,
                                    ),
                                    child: Icon(
                                      notification['icon'] as IconData,
                                      color: notifColor,
                                      size: 24,
                                    ),
                                  ),
                                  const SizedBox(width: 16),

                                  // CONTENT
                                  Expanded(
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Expanded(
                                              child: Text(
                                                notification['title'] as String,
                                                style: theme.textTheme.bodyLarge?.copyWith(
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
                                                decoration: BoxDecoration(
                                                  color: primary,
                                                  shape: BoxShape.circle,
                                                ),
                                              ),
                                          ],
                                        ),
                                        const SizedBox(height: 4),
                                        Text(
                                          notification['message'] as String,
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
                                            height: 1.4,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                        const SizedBox(height: 8),
                                        Text(
                                          _formatTime(notification['time'] as DateTime),
                                          style: theme.textTheme.bodySmall?.copyWith(
                                            color: theme.colorScheme.onSurfaceVariant,
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
