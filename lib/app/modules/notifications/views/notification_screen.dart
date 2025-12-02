import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_fcm_notifications/flutter_fcm_notifications.dart';
import 'package:halo_clinic/app/common/utils/modern_snackbar.dart';
import 'package:halo_clinic/app/common/widgets/app_snackbar.dart';
import '../controllers/notification_controller.dart';
import '../../../common/themes/colors.dart';
import '../widgets/notification_card_widget.dart';
import '../widgets/notification_empty_state_widget.dart';

class NotificationScreen extends GetView<NotificationController> {
  const NotificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: AppBar(
        title: const Text(
          'Notifikasi',
          style: TextStyle(
            color: AppColors.textWhite,
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        backgroundColor: AppColors.primary,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios, color: AppColors.textWhite),
          onPressed: () => Get.back(),
        ),
        actions: [
          Obx(() {
            if (controller.notifications.isEmpty) return const SizedBox.shrink();
            
            return PopupMenuButton<String>(
              icon: const Icon(Icons.more_horiz, color: AppColors.textWhite),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              offset: const Offset(0, 55),
              elevation: 3,
              color: Colors.white,
              onSelected: (value) {
                if (value == 'mark_all') {
                  controller.markAllAsRead();
                } else if (value == 'clear_all') {
                  _showClearAllDialog(context);
                }
              },
              itemBuilder: (context) => [
                PopupMenuItem(
                  value: 'mark_all',
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'Tandai Sudah Dibaca',
                    style: TextStyle(
                      color: AppColors.primary,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
                const PopupMenuItem(
                  height: 1,
                  enabled: false,
                  padding: EdgeInsets.zero,
                  child: Divider(height: 1, thickness: 0.5),
                ),
                PopupMenuItem(
                  value: 'clear_all',
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  child: Text(
                    'Hapus Semua',
                    style: TextStyle(
                      color: AppColors.error,
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      letterSpacing: -0.3,
                    ),
                  ),
                ),
              ],
            );
          }),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(
            child: CircularProgressIndicator(
              valueColor: AlwaysStoppedAnimation<Color>(AppColors.primary),
            ),
          );
        }

        if (controller.notifications.isEmpty) {
          return const NotificationEmptyStateWidget();
        }

        return RefreshIndicator(
          onRefresh: controller.refreshNotifications,
          color: AppColors.primary,
          child: CustomScrollView(
            slivers: [
              // Unread count header
              if (controller.unreadCount.value > 0)
                SliverToBoxAdapter(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    margin: const EdgeInsets.only(top: 8),
                    child: Text(
                      '${controller.unreadCount.value} notifikasi belum dibaca',
                      style: const TextStyle(
                        fontSize: 13,
                        color: AppColors.textSecondary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              
              // Notification list
              SliverPadding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                sliver: SliverList(
                  delegate: SliverChildBuilderDelegate(
                    (context, index) {
                      final notification = controller.notifications[index];
                      final isRead = notification.messageId != null 
                          ? controller.isRead(notification.messageId!)
                          : false;
                      
                      return NotificationCardWidget(
                        notification: notification,
                        isRead: isRead,
                        onTap: () => _handleNotificationTap(notification),
                        onDismiss: () {
                          if (notification.messageId != null) {
                            controller.removeNotification(notification.messageId!);
                          }
                        },
                      );
                    },
                    childCount: controller.notifications.length,
                  ),
                ),
              ),
            ],
          ),
        );
      }),
    );
  }

  void _handleNotificationTap(NotificationItem notification) {
    // Mark as read
    if (notification.messageId != null) {
      controller.markAsRead(notification.messageId!);
    }
    
    // Handle navigation based on notification data
    final data = notification.data;
    if (data != null && data.containsKey('route')) {
      final route = data['route'];
      // Navigate to specific screen based on route
      // Get.toNamed(route);
      print('Navigate to: $route');
    }
  }

  void _showClearAllDialog(BuildContext context) {
    Get.dialog(
      AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
        title: const Text(
          'Hapus Semua Notifikasi?',
          style: TextStyle(
            fontWeight: FontWeight.w600,
            fontSize: 18,
          ),
        ),
        content: const Text(
          'Semua notifikasi akan dihapus secara permanen.',
          style: TextStyle(
            color: AppColors.textSecondary,
            fontSize: 14,
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Get.back(),
            child: const Text(
              'Batal',
              style: TextStyle(color: AppColors.textSecondary),
            ),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              controller.clearAll();
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: const Text('Hapus'),
          ),
        ],
      ),
    );
  }
}
