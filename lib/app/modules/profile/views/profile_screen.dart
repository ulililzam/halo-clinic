import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/profile_controller.dart';
import '../widgets/profile_header_widget.dart';
import '../widgets/profile_menu_item_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/loading_widget.dart';

class ProfileScreen extends GetView<ProfileController> {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Obx(() {
        if (controller.isLoading.value) {
          return const LoadingWidget();
        }

        return Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            // Profile Header
            ProfileHeaderWidget(
              user: controller.currentUser.value,
            ),
            SizedBox(height: 130,),

            // Menu List
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 24),
                child: Column(
                  children: [
                    // Account Section
                    ProfileMenuItemWidget(
                      icon: Icons.edit_outlined,
                      title: 'Edit Profile',
                      onTap: controller.showComingSoon,
                    ),
                    ProfileMenuItemWidget(
                      icon: Icons.lock_outline,
                      title: 'Ubah Kata Sandi',
                      onTap: controller.showComingSoon,
                    ),
                    
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    
                    // Features Section
                    ProfileMenuItemWidget(
                      icon: Icons.favorite_outline,
                      title: 'Dokter Favorit',
                      onTap: controller.showComingSoon,
                    ),
                    ProfileMenuItemWidget(
                      icon: Icons.history,
                      title: 'Riwayat Konsultasi',
                      onTap: controller.showComingSoon,
                    ),
                    ProfileMenuItemWidget(
                      icon: Icons.bookmark_outline,
                      title: 'Data Medis Pribadi',
                      onTap: controller.showComingSoon,
                    ),
                    ProfileMenuItemWidget(
                      icon: Icons.location_on_outlined,
                      title: 'Alamat Klinik Favorit',
                      onTap: controller.showComingSoon,
                    ),
                    ProfileMenuItemWidget(
                      icon: Icons.access_time,
                      title: 'Janji Temu Saya',
                      onTap: controller.showComingSoon,
                    ),
                    
                    const SizedBox(height: 10),
                    const Divider(height: 1),
                    const SizedBox(height: 10),
                    
                    // Others Section
                    ProfileMenuItemWidget(
                      icon: Icons.credit_card_outlined,
                      title: 'Pembayaran & Tagihan',
                      onTap: controller.showComingSoon,
                    ),
                    ProfileMenuItemWidget(
                      icon: Icons.chat_bubble_outline,
                      title: 'Bantuan & Pusat Dukungan',
                      onTap: controller.showComingSoon,
                    ),
                    
                    const SizedBox(height: 10),
                    
                    // Logout Button
                    Align(
                      alignment: Alignment.centerRight,
                      child: GestureDetector(
                        onTap: controller.logout,
                        child: const Text(
                          'Log out',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w600,
                            color: AppColors.error,
                          ),
                        ),
                      ),
                    ),
                    
                    const SizedBox(height: 24),
                  ],
                ),
              ),
            ),
          ],
        );
      }),
    );
  }
}
