import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../models/navigation_item.dart';

class HomeController extends GetxController {
  // Bottom navigation (using RxInt for reactivity)
  final currentIndex = 0.obs;

  // Navigation items
  final List<NavigationItem> navigationItems = [
    NavigationItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home,
      label: 'Beranda',
    ),
    NavigationItem(
      icon: Icons.medication_outlined,
      activeIcon: Icons.medication,
      label: 'Obat',
    ),
    NavigationItem(
      icon: Icons.medical_services_outlined,
      activeIcon: Icons.medical_services,
      label: 'Konsul',
    ),
    NavigationItem(
      icon: Icons.bar_chart_outlined,
      activeIcon: Icons.bar_chart,
      label: 'Penunjang',
    ),
    NavigationItem(
      icon: Icons.person_outline,
      activeIcon: Icons.person,
      label: 'Akun',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onReady() {
    super.onReady();
  }

  void changePage(int index) {
    currentIndex.value = index;
    update(); // Trigger GetBuilder update
  }
}
