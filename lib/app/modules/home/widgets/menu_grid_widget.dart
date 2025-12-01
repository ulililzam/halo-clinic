import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../common/themes/colors.dart';
import '../../../common/themes/text_styles.dart';

class MenuGridWidget extends StatelessWidget {
  const MenuGridWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: _buildMenuCard(
                  icon: Icons.person,
                  label: 'Konsultasi\nDokter',
                  color: AppColors.primary,
                  onTap: () {
                    Get.toNamed('/consultations');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMenuCard(
                  icon: Icons.medication,
                  label: 'Penjualan\nObat',
                  color: AppColors.primary,
                  onTap: () {
                    Get.toNamed('/medicines');
                  },
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: _buildMenuCard(
                  icon: Icons.calculate_outlined,
                  label: 'Kalkulator\nBMI',
                  color: AppColors.primary,
                  onTap: () {
                    Get.toNamed('/bmi');
                  },
                ),
              ),
              const SizedBox(width: 16),
              Expanded(
                child: _buildMenuCard(
                  icon: Icons.health_and_safety,
                  label: 'Penunjang\nKesehatan',
                  color: AppColors.primary,
                  onTap: () {
                    Get.toNamed('/support');
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildMenuCard({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 56,
              height: 56,
              decoration: BoxDecoration(
                color: color,
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: Colors.white, size: 28),
            ),
            const SizedBox(height: 12),
            Text(
              label,
              style: AppTextStyles.bodySmall.copyWith(
                fontWeight: FontWeight.w600,
                color: AppColors.textPrimary,
                height: 1.3,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
