import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../consultation/views/consultation_list_screen.dart';
import '../../profile/views/profile_screen.dart';
import '../../medicine/views/medicine_list_screen.dart';
import '../../support/views/support_list_screen.dart';
import '../widgets/dashboard_widget.dart';
import '../widgets/bottom_nav_bar_widget.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    
    final List<Widget> pages = [
      const DashboardWidget(),
      const MedicineListScreen(),
      const ConsultationListScreen(),
      const SupportListScreen(),
      const ProfileScreen(),
    ];
    

    return Scaffold(
      body: GetBuilder<HomeController>(
        init: HomeController(),
        builder: (ctrl) {
          return IndexedStack(
            index: ctrl.currentIndex.value,
            children: pages,
          );
        },
      ),
      bottomNavigationBar: const BottomNavBarWidget(),
    );
  }
}
