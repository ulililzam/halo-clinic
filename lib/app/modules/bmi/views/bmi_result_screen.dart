import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/bmi_controller.dart';
import '../widgets/bmi_indicator_widget.dart';
import '../widgets/bmi_info_card_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/global_button.dart';
import '../../../common/widgets/custom_app_bar.dart';

class BmiResultScreen extends StatelessWidget {
  const BmiResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final ctrl = Get.find<BmiController>();

    return Scaffold(
      backgroundColor: AppColors.scaffoldBackground,
      appBar: const CustomAppBar(
        title: 'Hasil BMI'
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Obx(() {
          final result = ctrl.result.value;
          
          if (result == null) {
            return const Center(
              child: Text('Tidak ada hasil'),
            );
          }

          return Column(
            children: [
              const SizedBox(height: 8),

              // BMI Indicator Widget
              BmiIndicatorWidget(
                bmi: result.bmi,
                height: result.height,
                weight: result.weight,
                isMale: result.isMale,
                onCekUlang: () => Get.back(),
              ),

              const SizedBox(height: 20),

              // BMI Info Card
              BmiInfoCardWidget(
                bmiValue: result.bmi.toStringAsFixed(1),
                category: result.category,
                description: 'Diet yang baik dapat mempertahankan kesehatan & imun',
                imagePath: 'assets/images/basket.png',
              ),

              const SizedBox(height: 32),

              // Back Button
              GlobalButton(
                label: 'Kembali',
                onPressed: () {
                  ctrl.reset();
                  Get.back();
                },
              ),
            ],
          );
        }),
      ),
    );
  }
}
