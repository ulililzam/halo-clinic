import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halo_clinic/app/common/widgets/app_snackbar.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/global_button.dart';

class BmiInfoCardWidget extends StatelessWidget {
  final String bmiValue;
  final String category;
  final String description;
  final String imagePath;

  const BmiInfoCardWidget({
    super.key,
    required this.bmiValue,
    required this.category,
    required this.description,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'BMI kamu:',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  '$bmiValue, $category',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: AppColors.primary,
                  ),
                ),
                const SizedBox(height: 12),
                Text(
                  description,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                const SizedBox(height: 16),
                GlobalButton(
                  label: 'Konsultasi',
                                     
                  onPressed: () => Get.toNamed('/consultations'),
                  outlined: true,
                  width: 130,
                ),
              ],
            ),
          ),
          const SizedBox(width: 16),
          Image.asset(
            imagePath,
            width: 120,
            height: 120,
            fit: BoxFit.contain,
            errorBuilder: (context, error, stackTrace) {
              return Container(
                width: 120,
                height: 120,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Icon(
                  Icons.restaurant,
                  size: 48,
                  color: AppColors.primary.withOpacity(0.5),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
