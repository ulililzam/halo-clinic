import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../../../common/themes/colors.dart';
import '../../../routes/app_routes.dart';
import '../../notifications/controllers/notification_controller.dart';
import 'header_widget.dart';
import 'menu_grid_widget.dart';
import 'recommendation_section_widget.dart';

class DashboardWidget extends StatelessWidget {
  const DashboardWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: CustomScrollView(
        slivers: [
          // Frozen AppBar with profile, name, and notification
          SliverAppBar(
            pinned: true,
            floating: false,
            expandedHeight: 0,
            toolbarHeight: 64,
            backgroundColor: AppColors.primary,
            elevation: 0,
            systemOverlayStyle: const SystemUiOverlayStyle(
              statusBarColor: Colors.transparent,
              statusBarIconBrightness: Brightness.light,
            ),
            flexibleSpace: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.primary,
                    AppColors.primary.withOpacity(0.85),
                  ],
                ),
              ),
              child: SafeArea(
                child: Padding(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                  child: Row(
                    children: [
                      // Profile Picture
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(color: Colors.white, width: 2),
                          image: const DecorationImage(
                            image: NetworkImage('https://i.pravatar.cc/150?img=12'),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      // Greeting
                      const Expanded(
                        child: Text(
                          'Hi, Tupex!',
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w600,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      // Notification Icon with Badge
                      GetX<NotificationController>(
                        init: NotificationController(),
                        builder: (controller) {
                          return Stack(
                            children: [
                              IconButton(
                                icon: const Icon(Icons.notifications_outlined),
                                color: Colors.white,
                                iconSize: 24,
                                onPressed: () {
                                  Get.toNamed(AppRoutes.notifications);
                                },
                                padding: EdgeInsets.zero,
                                constraints: const BoxConstraints(),
                              ),
                              if (controller.unreadCount.value > 0)
                                Positioned(
                                  right: 0,
                                  top: 0,
                                  child: Container(
                                    padding: const EdgeInsets.all(4),
                                    decoration: const BoxDecoration(
                                      color: AppColors.error,
                                      shape: BoxShape.circle,
                                    ),
                                    constraints: const BoxConstraints(
                                      minWidth: 16,
                                      minHeight: 16,
                                    ),
                                    child: Text(
                                      controller.unreadCount.value > 99
                                          ? '99+'
                                          : '${controller.unreadCount.value}',
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontSize: 9,
                                        fontWeight: FontWeight.bold,
                                      ),
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          
          // Scrollable content
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Health Card & Search Bar (scrollable part)
                HeaderWidget(
                  userName: 'Tupex',
                  onNotificationTap: () {
                    // Handle notification tap
                  },
                ),
                
                const SizedBox(height: 20),
                
                // Menu Grid (4 cards in 2x2)
                const MenuGridWidget(),
                
                const SizedBox(height: 32),
                
                // Recommendations Section
                const RecommendationSectionWidget(),
                
                const SizedBox(height: 24),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
