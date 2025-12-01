import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class StressQuestionItemWidget extends StatelessWidget {
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final Function(int) onOptionSelected;

  const StressQuestionItemWidget({
    super.key,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 28),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Text(
            question,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Answer Options in 2x2 grid + 1 center
          Column(
            children: [
              // First row - Tidak pernah | Cukup sering
              Row(
                children: [
                  Expanded(
                    child: _buildOption(0, options[0]), // Tidak pernah
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildOption(3, options[3]), // Cukup sering
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Second row - Jarang | Sangat sering
              Row(
                children: [
                  Expanded(
                    child: _buildOption(1, options[1]), // Jarang
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildOption(4, options[4]), // Sangat sering
                  ),
                ],
              ),
              const SizedBox(height: 12),
              // Third row - Kadang-kadang (centered)
              Align(
                alignment: Alignment.centerLeft,
                child: SizedBox(
                  width: MediaQuery.of(context).size.width * 0.43,
                  child: _buildOption(2, options[2]), // Kadang-kadang
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildOption(int index, String label) {
    final isSelected = selectedIndex == index;
    
    return GestureDetector(
      onTap: () => onOptionSelected(index),
      child: Row(
        children: [
          // Radio Circle
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey[400]!,
                width: 2,
              ),
              color: Colors.transparent,
            ),
            child: isSelected
                ? Center(
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: const BoxDecoration(
                        shape: BoxShape.circle,
                        color: AppColors.primary,
                      ),
                    ),
                  )
                : null,
          ),
          const SizedBox(width: 10),
          // Label
          Flexible(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
