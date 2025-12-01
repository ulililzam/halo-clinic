import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';

class SpecializationDropdownWidget extends StatelessWidget {
  final String selectedSpecialization;
  final List<String> specializations;
  final Function(String?) onChanged;
  final bool isExpanded;
  final VoidCallback onToggle;

  const SpecializationDropdownWidget({
    super.key,
    required this.selectedSpecialization,
    required this.specializations,
    required this.onChanged,
    required this.isExpanded,
    required this.onToggle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border(
          bottom: BorderSide(color: Colors.grey[200]!, width: 1),
        ),
      ),
      child: Column(
        children: [
          GestureDetector(
            onTap: onToggle,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[300]!, width: 1),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      selectedSpecialization.isEmpty || selectedSpecialization == 'Semua'
                          ? 'Pilih Spesialisasi' 
                          : selectedSpecialization,
                      style: TextStyle(
                        fontSize: 14,
                        color: selectedSpecialization.isEmpty || selectedSpecialization == 'Semua'
                            ? AppColors.textSecondary
                            : AppColors.textPrimary,
                        fontWeight: selectedSpecialization.isEmpty || selectedSpecialization == 'Semua'
                            ? FontWeight.w400
                            : FontWeight.w600,
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(
                    isExpanded ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                    color: AppColors.textSecondary,
                  ),
                ],
              ),
            ),
          ),
          if (isExpanded)
            Container(
              margin: const EdgeInsets.only(top: 8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(color: Colors.grey[200]!, width: 1),
              ),
              child: Column(
                children: specializations.map((spec) {
                  return InkWell(
                    onTap: () {
                      onChanged(spec);
                      onToggle();
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                      decoration: BoxDecoration(
                        border: Border(
                          bottom: spec != specializations.last
                              ? BorderSide(color: Colors.grey[200]!, width: 1)
                              : BorderSide.none,
                        ),
                      ),
                      child: Row(
                        children: [
                          Expanded(
                            child: Text(
                              spec,
                              style: TextStyle(
                                fontSize: 14,
                                color: spec == selectedSpecialization
                                    ? AppColors.primary
                                    : AppColors.textPrimary,
                                fontWeight: spec == selectedSpecialization
                                    ? FontWeight.w600
                                    : FontWeight.w400,
                              ),
                            ),
                          ),
                          if (spec == selectedSpecialization)
                            const Icon(
                              Icons.check,
                              color: AppColors.primary,
                              size: 20,
                            ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
        ],
      ),
    );
  }
}
