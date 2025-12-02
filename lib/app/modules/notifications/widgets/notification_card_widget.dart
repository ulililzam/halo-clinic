import 'package:flutter/material.dart';
import 'package:flutter_fcm_notifications/flutter_fcm_notifications.dart';
import 'package:intl/intl.dart';
import '../../../common/themes/colors.dart';

class NotificationCardWidget extends StatelessWidget {
  final NotificationItem notification;
  final bool isRead;
  final VoidCallback onTap;
  final VoidCallback onDismiss;

  const NotificationCardWidget({
    super.key,
    required this.notification,
    required this.isRead,
    required this.onTap,
    required this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return Dismissible(
      key: Key(notification.messageId ?? DateTime.now().millisecondsSinceEpoch.toString()),
      direction: DismissDirection.endToStart,
      onDismissed: (_) => onDismiss(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 20),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: AppColors.error,
          borderRadius: BorderRadius.circular(12),
        ),
        child: const Icon(
          Icons.delete_outline,
          color: Colors.white,
          size: 24,
        ),
      ),
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: isRead ? AppColors.cardBackground : AppColors.cardBackground,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isRead ? AppColors.border.withOpacity(0.5) : AppColors.primary.withOpacity(0.3),
            width: 1,
          ),
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: onTap,
            borderRadius: BorderRadius.circular(12),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Unread indicator dot
                  if (!isRead)
                    Container(
                      width: 6,
                      height: 6,
                      margin: const EdgeInsets.only(top: 6, right: 10),
                      decoration: const BoxDecoration(
                        color: AppColors.primary,
                        shape: BoxShape.circle,
                      ),
                    ),
                  
                  // Content
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          notification.title,
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: isRead ? FontWeight.w500 : FontWeight.w600,
                            color: AppColors.textPrimary,
                            letterSpacing: -0.2,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 2),
                        Text(
                          notification.body,
                          style: const TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.3,
                            letterSpacing: -0.1,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(height: 4),
                        Text(
                          _formatTimestamp(notification.timestamp),
                          style: TextStyle(
                            fontSize: 11,
                            color: AppColors.textLight,
                            letterSpacing: -0.1,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  IconData _getNotificationIcon() {
    // You can customize this based on notification type from data
    final type = notification.data?['type'];
    
    switch (type) {
      case 'appointment':
        return Icons.calendar_today;
      case 'message':
        return Icons.message;
      case 'reminder':
        return Icons.notifications_active;
      case 'payment':
        return Icons.payment;
      case 'promo':
        return Icons.local_offer;
      default:
        return Icons.notifications;
    }
  }

  Color _getIconBackgroundColor() {
    final type = notification.data?['type'];
    
    switch (type) {
      case 'appointment':
        return AppColors.primary.withOpacity(0.1);
      case 'message':
        return AppColors.info.withOpacity(0.1);
      case 'reminder':
        return AppColors.warning.withOpacity(0.1);
      case 'payment':
        return AppColors.success.withOpacity(0.1);
      case 'promo':
        return AppColors.accent.withOpacity(0.1);
      default:
        return AppColors.primary.withOpacity(0.1);
    }
  }

  Color _getIconColor() {
    final type = notification.data?['type'];
    
    switch (type) {
      case 'appointment':
        return AppColors.primary;
      case 'message':
        return AppColors.info;
      case 'reminder':
        return AppColors.warning;
      case 'payment':
        return AppColors.success;
      case 'promo':
        return AppColors.accent;
      default:
        return AppColors.primary;
    }
  }

  String _formatTimestamp(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'Baru saja';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes} menit lalu';
    } else if (difference.inHours < 24) {
      return '${difference.inHours} jam lalu';
    } else if (difference.inDays == 1) {
      return 'Kemarin ${DateFormat('HH:mm').format(timestamp)}';
    } else if (difference.inDays < 7) {
      return '${difference.inDays} hari lalu';
    } else {
      return DateFormat('dd MMM yyyy, HH:mm').format(timestamp);
    }
  }
}
