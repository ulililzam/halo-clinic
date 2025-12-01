import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:halo_clinic/app/common/widgets/app_snackbar.dart';
import '../controllers/depression_test_controller.dart';
import '../models/depression_test_model.dart';
import '../widgets/test_question_card_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/global_button.dart';

class DepressionTestQuestionsScreen extends StatelessWidget {
  const DepressionTestQuestionsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<DepressionTestController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      body: Column(
        children: [
          // Header
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
                      onTap: () => Get.back(),
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
                            'Tes Depresi',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(height: 4),
                          Text(
                            'Cari tahu tingkat depresimu',
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
          
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Column(
                children: [
                  // Intro Card
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Dalam 2 minggu terakhir,',
                        style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w400,
                          color: Colors.grey[600],
                          height: 1.5,
                        ),
                      ),
                      const SizedBox(height: 4),
                      const Text(
                        'Seberapa sering kamu merasa terganggu oleh hal berikut...',
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          color: AppColors.textPrimary,
                          height: 1.5,
                        ),
                      ),
                      Divider(
                        color: Colors.grey[300],
                        thickness: 1,
                        height: 50,
                      ),
                    ],
                  ),


                  // Questions (skip first one as it's just intro)
                  ...List.generate(
                    DepressionTestData.questions.length - 1,
                    (index) {
                      final question = DepressionTestData.questions[index + 1];
                      return Obx(() => TestQuestionCardWidget(
                            questionNumber: index + 1,
                            question: question.question,
                            options: question.answers
                                .map((a) => a.label)
                                .toList(),
                            selectedIndex: ctrl.answers[question.id],
                            onOptionSelected: (optionIndex) {
                              ctrl.selectAnswer(question.id, optionIndex);
                            },
                          ));
                    },
                  ),

                  const SizedBox(height: 80),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
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
          child: Obx(() => GlobalButton(
                label: 'Lihat hasil',
                onPressed: ctrl.areAllQuestionsAnswered()
                    ? () {
                        ctrl.calculateScore();
                        Get.toNamed('/depression-test/result');
                      }
                    : () {
                        AppSnackBar.info(
                          title: 'Jawaban Belum lengkap',
                          message:
                              'Silakan jawab semua pertanyaan sebelum melihat hasil.',
                        );
                      },
              )),
        ),
      ),
    );
  }
}
