import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/bmi_controller.dart';
import '../widgets/bmi_header_widget.dart';
import '../widgets/bmi_input_field_widget.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/sliding_tabs_widget.dart';
import '../../../common/widgets/global_button.dart';

class BmiCalculatorScreen extends StatelessWidget {
  const BmiCalculatorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BmiController>(
      init: BmiController(),
      builder: (ctrl) {
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
          body: Column(
            children: [
              // Header
              const BmiHeaderWidget(),

              // Gender Tabs
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                color: Colors.white,
                child: Obx(() => SlidingTabsWidget(
                      isFirstSelected: ctrl.isMaleSelected.value,
                      firstLabel: 'Laki-laki',
                      secondLabel: 'Perempuan',
                      onFirstTap: () => ctrl.toggleGender(true),
                      onSecondTap: () => ctrl.toggleGender(false),
                      padding: EdgeInsets.zero,
                      backgroundColor: Colors.transparent,
                    )),
              ),

              // Content
              Expanded(
                child: SingleChildScrollView(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 8),

                      // Height Input
                      BmiInputFieldWidget(
                        label: 'Tinggi (cm)',
                        hint: 'Contoh: 170',
                        controller: ctrl.heightController,
                      ),

                      const SizedBox(height: 20),

                      // Weight Input
                      BmiInputFieldWidget(
                        label: 'Berat (kg)',
                        hint: 'Contoh: 65',
                        controller: ctrl.weightController,
                      ),

                      const SizedBox(height: 32),

                      // Calculate Button
                      GlobalButton(
                        label: 'Lihat hasil',
                        onPressed: ctrl.calculateBmi,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
