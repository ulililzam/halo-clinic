import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/bmi_model.dart';
import '../utils/bmi_calculator.dart';
import '../../../common/widgets/app_snackbar.dart';

class BmiController extends GetxController {
  final RxBool isMaleSelected = true.obs;
  final heightController = TextEditingController();
  final weightController = TextEditingController();
  final Rx<BmiResult?> result = Rx<BmiResult?>(null);

  @override
  void onInit() {
    super.onInit();
  }

  @override
  void onClose() {
    heightController.dispose();
    weightController.dispose();
    super.onClose();
  }

  void toggleGender(bool isMale) {
    isMaleSelected.value = isMale;
  }

  void calculateBmi() {
    final heightText = heightController.text.trim();
    final weightText = weightController.text.trim();

    if (heightText.isEmpty || weightText.isEmpty) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Mohon isi tinggi dan berat badan',
      );
      return;
    }

    final height = double.tryParse(heightText);
    final weight = double.tryParse(weightText);

    if (height == null || weight == null) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Mohon masukkan angka yang valid',
      );
      return;
    }

    if (height <= 0 || weight <= 0) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Tinggi dan berat harus lebih dari 0',
      );
      return;
    }

    if (!BmiCalculator.isValidHeight(height)) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Tinggi badan harus antara 50-300 cm',
      );
      return;
    }

    if (!BmiCalculator.isValidWeight(weight)) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Berat badan harus antara 10-500 kg',
      );
      return;
    }

    result.value = BmiResult.calculate(
      height: height,
      weight: weight,
      isMale: isMaleSelected.value,
    );

    // Navigate to result screen
    Get.toNamed('/bmi/result');
  }

  void reset() {
    heightController.clear();
    weightController.clear();
    result.value = null;
  }
}
