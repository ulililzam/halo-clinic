import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halo_clinic/app/common/widgets/app_snackbar.dart';
import '../controllers/stress_test_controller.dart';
import '../models/stress_test_model.dart';
import '../widgets/stress_page_stepper_widget.dart';
import '../widgets/stress_question_item_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/global_button.dart';

class StressTestQuestionsScreen extends StatelessWidget {
  const StressTestQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<StressTestController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          // Header with back button
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primary],
              ),
            ),
            child: SafeArea(
              bottom: false,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Row(
                  children: [
                    GestureDetector(
                      onTap: () {
                        if (ctrl.currentPage.value > 1) {
                          ctrl.previousPage();
                        } else {
                          Get.back();
                        }
                      },
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: const Icon(
                          Icons.arrow_back,
                          color: Colors.white,
                          size: 24,
                        ),
                      ),
                    ),
                    const SizedBox(width: 16),
                    const Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Tes Stres',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Cari tahu tingkat stresmu',
                            style: TextStyle(
                              fontSize: 13,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // Stepper
          Obx(() => StressPageStepperWidget(currentPage: ctrl.currentPage.value)),

          // Content
          Expanded(
            child: Obx(() {
              if (ctrl.currentPage.value == 1) {
                return _buildPage1(ctrl);
              } else if (ctrl.currentPage.value == 2) {
                return _buildPage2(ctrl);
              } else if (ctrl.currentPage.value == 3) {
                return _buildPage3(ctrl);
              } else {
                return _buildPage4(ctrl);
              }
            }),
          ),

          // Bottom buttons
          Obx(() => _buildBottomButtons(context, ctrl)),
        ],
      ),
    );
  }

  Widget _buildPage1(StressTestController ctrl) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gender selection
          const Text(
            'Apa jenis kelamin kamu?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => Row(
                children: [
                  Expanded(
                    child: _buildGenderButton(
                      'Laki-laki',
                      ctrl.profile.value.gender == 'Laki-laki',
                      () => ctrl.setGender('Laki-laki'),
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: _buildGenderButton(
                      'Perempuan',
                      ctrl.profile.value.gender == 'Perempuan',
                      () => ctrl.setGender('Perempuan'),
                    ),
                  ),
                ],
              )),

          const SizedBox(height: 24),

          // Age range
          const Text(
            'Berapa usia kamu?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => Container(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: AppColors.border),
                ),
                child: DropdownButtonHideUnderline(
                  child: DropdownButton<String>(
                    isExpanded: true,
                    value: ctrl.profile.value.ageRange,
                    hint: const Text('Pilih'),
                    icon: const Icon(Icons.keyboard_arrow_down),
                    items: StressTestData.ageRanges.map((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }).toList(),
                    onChanged: (String? newValue) {
                      ctrl.setAgeRange(newValue);
                    },
                  ),
                ),
              )),

          const SizedBox(height: 24),

          // Health conditions
          const Text(
            'Apakah ada diagnosis kondisi kesehatan?',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 4),
          Text(
            'Tambahkan di sini jika ada.',
            style: TextStyle(
              fontSize: 13,
              color: Colors.grey[600],
            ),
          ),
          const SizedBox(height: 12),
          Obx(() => Column(
                children: StressTestData.healthConditions.map((condition) {
                  final isSelected = ctrl.profile.value.healthConditions.contains(condition);
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: GestureDetector(
                      onTap: () => ctrl.toggleHealthCondition(condition),
                      child: Row(
                        children: [
                          Container(
                            width: 24,
                            height: 24,
                            decoration: BoxDecoration(
                              color: isSelected ? AppColors.primary : Colors.white,
                              border: Border.all(
                                color: isSelected ? AppColors.primary : AppColors.border,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: isSelected
                                ? const Icon(
                                    Icons.check,
                                    size: 16,
                                    color: Colors.white,
                                  )
                                : null,
                          ),
                          const SizedBox(width: 12),
                          Text(
                            condition,
                            style: const TextStyle(
                              fontSize: 15,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )),
        ],
      ),
    );
  }

  Widget _buildPage2(StressTestController ctrl) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: StressTestData.page2Questions.map((question) {
          return Obx(() => StressQuestionItemWidget(
                question: question.question,
                options: question.answers.map((a) => a.label).toList(),
                selectedIndex: ctrl.answers[question.id],
                onOptionSelected: (index) => ctrl.selectAnswer(question.id, index),
              ));
        }).toList(),
      ),
    );
  }

  Widget _buildPage3(StressTestController ctrl) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: StressTestData.page3Questions.map((question) {
          return Obx(() => StressQuestionItemWidget(
                question: question.question,
                options: question.answers.map((a) => a.label).toList(),
                selectedIndex: ctrl.answers[question.id],
                onOptionSelected: (index) => ctrl.selectAnswer(question.id, index),
              ));
        }).toList(),
      ),
    );
  }

  Widget _buildPage4(StressTestController ctrl) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        children: StressTestData.page4Questions.map((question) {
          return Obx(() => StressQuestionItemWidget(
                question: question.question,
                options: question.answers.map((a) => a.label).toList(),
                selectedIndex: ctrl.answers[question.id],
                onOptionSelected: (index) => ctrl.selectAnswer(question.id, index),
              ));
        }).toList(),
      ),
    );
  }

  Widget _buildGenderButton(String label, bool isSelected, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: Border.all(
            color: isSelected ? AppColors.primary : AppColors.border,
            width: 1.5,
          ),
        ),
        child: Text(
          label,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w500,
            color: isSelected ? Colors.white : AppColors.textPrimary,
          ),
        ),
      ),
    );
  }

  Widget _buildBottomButtons(BuildContext context, StressTestController ctrl) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: SafeArea(
        child: Row(
          children: [
            if (ctrl.currentPage.value > 1)
              Expanded(
                child: GlobalButton(
                  label: 'Kembali',
                  outlined: true,
                  onPressed: () => ctrl.previousPage(),
                ),
              ),
            if (ctrl.currentPage.value > 1) const SizedBox(width: 12),
            Expanded(
              flex: ctrl.currentPage.value == 1 ? 1 : 1,
              child: GlobalButton(
                label: ctrl.currentPage.value == 4 ? 'Lihat Hasil' : 'Selanjutnya',
                onPressed: () {
                  if (ctrl.currentPage.value == 1) {
                    if (ctrl.isPage1Complete()) {
                      ctrl.nextPage();
                    } else {
                      AppSnackBar.warning(
                        title: 'Data Belum Lengkap',
                        message: 'Silakan lengkapi jenis kelamin dan usia.',
                      );
                    }
                  } else if (ctrl.currentPage.value == 4) {
                    if (ctrl.areCurrentPageQuestionsAnswered()) {
                      ctrl.calculateScore();
                      Get.toNamed('/stress-test/result');
                    } else {
                      AppSnackBar.info(
                        title: 'Jawaban Belum Lengkap',
                        message: 'Silakan jawab semua pertanyaan sebelum melihat hasil.',
                      );
                    }
                  } else {
                    if (ctrl.areCurrentPageQuestionsAnswered()) {
                      ctrl.nextPage();
                    } else {
                      AppSnackBar.info(
                        title: 'Jawaban Belum Lengkap',
                        message: 'Silakan jawab semua pertanyaan di halaman ini.',
                      );
                    }
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
