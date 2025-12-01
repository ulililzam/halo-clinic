import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class StressPageStepperWidget extends StatelessWidget {
  final int currentPage;

  const StressPageStepperWidget({
    super.key,
    required this.currentPage,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 19, horizontal: 15),
      color: Colors.white,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          _buildStep(1),
          _buildLine(1),
          _buildStep(2),
          _buildLine(2),
          _buildStep(3),
          _buildLine(3),
          _buildStep(4),
        ],
      ),
    );
  }

  Widget _buildStep(int step) {
    final isActive = step <= currentPage;
    final isCurrent = step == currentPage;

    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive ? AppColors.primary : Colors.grey[300],
        border: isCurrent
            ? Border.all(color: AppColors.primary, width: 3)
            : null,
      ),
      child: Center(
        child: Text(
          step.toString(),
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: isActive ? Colors.white : Colors.grey[600],
          ),
        ),
      ),
    );
  }

  Widget _buildLine(int step) {
    final isActive = step < currentPage;

    return Container(
      width: 40,
      height: 2,
      color: isActive ? AppColors.primary : Colors.grey[300],
    );
  }
}
