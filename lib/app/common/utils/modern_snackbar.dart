import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/colors.dart';

class ModernSnackbar {
  static void show({
    required String title,
    required String message,
    SnackbarType type = SnackbarType.info,
    Duration duration = const Duration(seconds: 3),
  }) {
    Color backgroundColor;
    IconData icon;

    switch (type) {
      case SnackbarType.success:
        backgroundColor = AppColors.success;
        icon = Icons.check_circle_outline;
        break;
      case SnackbarType.error:
        backgroundColor = AppColors.error;
        icon = Icons.error_outline;
        break;
      case SnackbarType.warning:
        backgroundColor = AppColors.warning;
        icon = Icons.warning_amber_outlined;
        break;
      case SnackbarType.info:
        backgroundColor = AppColors.info;
        icon = Icons.info_outline;
        break;
    }

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: backgroundColor,
      colorText: Colors.white,
      icon: Icon(icon, color: Colors.white),
      duration: duration,
      margin: const EdgeInsets.all(16),
      borderRadius: 12,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
    );
  }

  static void success({required String message}) {
    show(
      title: 'Berhasil',
      message: message,
      type: SnackbarType.success,
    );
  }

  static void error({required String message}) {
    show(
      title: 'Error',
      message: message,
      type: SnackbarType.error,
    );
  }

  static void warning({required String message}) {
    show(
      title: 'Perhatian',
      message: message,
      type: SnackbarType.warning,
    );
  }

  static void info({required String message}) {
    show(
      title: 'Info',
      message: message,
      type: SnackbarType.info,
    );
  }
}

enum SnackbarType {
  success,
  error,
  warning,
  info,
}
