import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/consultation_controller.dart';
import '../widget/consultation_header_widget.dart';
import '../widget/filter_tabs_widget.dart';
import '../widget/doctor_card_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/loading_widget.dart';
import '../../../common/widgets/empty_state_widget.dart';

class ConsultationListScreen extends StatelessWidget {
  const ConsultationListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      extendBodyBehindAppBar: false,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(0),
        child: AppBar(
          backgroundColor: AppColors.primary,
          elevation: 0,
          systemOverlayStyle: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light,
          ),
        ),
      ),
      body: GetBuilder<ConsultationController>(
        init: ConsultationController(),
        builder: (ctrl) {
          return Stack(
            children: [
              Column(
                children: [
                  // Header with address and search
                  Obx(() => ConsultationHeaderWidget(
                        selectedAddress: ctrl.selectedAddress.value,
                        onAddressTap: () {
                        },
                        onSearch: ctrl.onSearch,
                      )),

                  // Online/Offline Tabs
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                    color: Colors.white,
                    child: Obx(() => FilterTabsWidget(
                          isOnlineSelected: ctrl.isOnlineSelected.value,
                          onOnlineTap: () => ctrl.toggleOnlineOffline(true),
                          onOfflineTap: () => ctrl.toggleOnlineOffline(false),
                        )),
                  ),

                  // Specialization Dropdown Trigger Only
                  Obx(() {
                        final selectedLabel = ctrl.selectedSpecialization.value;
                        final displayLabel = selectedLabel == 'Semua'
                            ? 'Pilih Spesialisasi'
                            : selectedLabel;

                        return Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          border: Border(
                            bottom: BorderSide(color: Colors.grey[200]!, width: 1),
                          ),
                        ),
                        child: GestureDetector(
                          onTap: ctrl.toggleDropdown,
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
                                    displayLabel,
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: selectedLabel == 'Semua'
                                          ? AppColors.textSecondary
                                          : AppColors.textPrimary,
                                      fontWeight: selectedLabel == 'Semua'
                                          ? FontWeight.w400
                                          : FontWeight.w600,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Icon(
                                  ctrl.isDropdownExpanded.value 
                                      ? Icons.keyboard_arrow_up 
                                      : Icons.keyboard_arrow_down,
                                  color: AppColors.textSecondary,
                                ),
                              ],
                            ),
                          ),
                        ),
                        );
                      }),

                  // Doctor List
                  Expanded(
                    child: Obx(() {
                      if (ctrl.isLoading.value) {
                        return const LoadingWidget(message: 'Memuat data dokter...');
                      }

                      if (ctrl.doctors.isEmpty) {
                        return const EmptyStateWidget(
                          icon: Icons.medical_services,
                          title: 'Tidak Ada Dokter',
                          message: 'Tidak ada dokter yang tersedia saat ini',
                        );
                      }

                      return RefreshIndicator(
                        onRefresh: ctrl.fetchDoctors,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          itemCount: ctrl.doctors.length,
                          itemBuilder: (context, index) {
                            final doctor = ctrl.doctors[index];
                            return DoctorCardWidget(
                              doctor: doctor,
                              onConsultTap: () {
                                // Navigate to booking screen
                              },
                            );
                          },
                        ),
                      );
                    }),
                  ),
                ],
              ),
              
              // Dropdown Menu Overlay
              Obx(() {
                if (!ctrl.isDropdownExpanded.value) {
                  return const SizedBox.shrink();
                }

                return Positioned(
                  top: 260, // Adjust based on header height + tabs + trigger
                  left: 20,
                  right: 20,
                  child: Material(
                    elevation: 4,
                    borderRadius: BorderRadius.circular(8),
                    child: Container(
                      constraints: const BoxConstraints(maxHeight: 300),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey[200]!, width: 1),
                      ),
                      child: ListView(
                        shrinkWrap: true,
                        padding: EdgeInsets.zero,
                        children: ctrl.specializations.map((spec) {
                          return InkWell(
                            onTap: () {
                              ctrl.selectSpecialization(spec);
                              ctrl.toggleDropdown();
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                              decoration: BoxDecoration(
                                border: Border(
                                  bottom: spec != ctrl.specializations.last
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
                                        color: spec == ctrl.selectedSpecialization.value
                                            ? AppColors.primary
                                            : AppColors.textPrimary,
                                        fontWeight: spec == ctrl.selectedSpecialization.value
                                            ? FontWeight.w600
                                            : FontWeight.w400,
                                      ),
                                    ),
                                  ),
                                  if (spec == ctrl.selectedSpecialization.value)
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
                  ),
                );
              }),
            ],
          );
        },
      ),
    );
  }
}
