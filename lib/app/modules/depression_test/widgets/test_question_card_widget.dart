import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class TestQuestionCardWidget extends StatelessWidget {
  final int questionNumber;
  final String question;
  final List<String> options;
  final int? selectedIndex;
  final Function(int) onOptionSelected;

  const TestQuestionCardWidget({
    super.key,
    required this.questionNumber,
    required this.question,
    required this.options,
    required this.selectedIndex,
    required this.onOptionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 8,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Question Text
          Text(
            question,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
              height: 1.5,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Answer Options in Single Row
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: _buildOption(0, options[0]),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildOption(1, options[1]),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildOption(2, options[2]),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: _buildOption(3, options[3]),
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
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          // Circle
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: isSelected ? AppColors.primary : Colors.grey[300]!,
                width: 2,
              ),
              color: Colors.transparent,
            ),
            child: isSelected
                ? Container(
                    margin: const EdgeInsets.all(2),
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.primary,
                    ),
                  )
                : null,
          ),
          const SizedBox(height: 6),
          // Label with fixed height for symmetry
          SizedBox(
            height: 28, // Fixed height for 2 lines + spacing
            child: Text(
              label,
              textAlign: TextAlign.center,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w400,
                color: AppColors.textPrimary,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
