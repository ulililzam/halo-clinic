import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class BmiResultCardWidget extends StatelessWidget {
  final double bmi;
  final String category;
  final String description;

  const BmiResultCardWidget({
    super.key,
    required this.bmi,
    required this.category,
    required this.description,
  });

  Color _getCategoryColor() {
    if (category == 'Kurus') {
      return Colors.orange;
    } else if (category == 'Normal') {
      return Colors.green;
    } else if (category == 'Gemuk') {
      return Colors.orange;
    } else {
      return Colors.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
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
      child: Column(
        children: [
          // BMI Value
          Text(
            bmi.toStringAsFixed(1),
            style: TextStyle(
              fontSize: 64,
              fontWeight: FontWeight.w700,
              color: _getCategoryColor(),
            ),
          ),
          const SizedBox(height: 8),
          // Category
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            decoration: BoxDecoration(
              color: _getCategoryColor().withOpacity(0.1),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(
              category,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: _getCategoryColor(),
              ),
            ),
          ),
          // Description
          Text(
            description,
            style: TextStyle(
              fontSize: 14,
              color: AppColors.textSecondary,
            ),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}
