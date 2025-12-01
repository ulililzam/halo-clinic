import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../themes/colors.dart';

enum SnackBarType { success, info, warning, error }

class AppSnackBar {
  static void show({
    required String title,
    required String message,
    SnackBarType type = SnackBarType.info,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    final config = _getConfig(type);

    Get.snackbar(
      title,
      message,
      snackPosition: SnackPosition.TOP,
      backgroundColor: Colors.white,
      colorText: AppColors.textPrimary,
      titleText: Row(
        children: [
          Container(
            width: 20,
            height: 20,
            decoration: BoxDecoration(
              color: config.backgroundColor,
              shape: BoxShape.circle,
            ),
            child: Icon(
              config.icon,
              color: Colors.white,
              size: 14,
            ),
          ),
          const SizedBox(width: 10),
          Text(
            title,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: AppColors.textPrimary,
            ),
          ),
        ],
      ),
      messageText: Text(
        message,
        style: const TextStyle(
          fontSize: 13,
          color: AppColors.textSecondary,
        ),
      ),
      borderRadius: 8,
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      duration: duration,
      isDismissible: true,
      dismissDirection: DismissDirection.horizontal,
      forwardAnimationCurve: Curves.easeOutCubic,
      reverseAnimationCurve: Curves.easeInCubic,
      animationDuration: const Duration(milliseconds: 400),
      boxShadows: [
        BoxShadow(
          color: Colors.black.withOpacity(0.08),
          blurRadius: 12,
          offset: const Offset(0, 2),
        ),
      ],
      onTap: (_) => onTap?.call(),
    );
  }

  static void success({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.success,
      duration: duration,
      onTap: onTap,
    );
  }

  static void info({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.info,
      duration: duration,
      onTap: onTap,
    );
  }

  static void warning({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.warning,
      duration: duration,
      onTap: onTap,
    );
  }

  static void error({
    required String title,
    required String message,
    Duration duration = const Duration(seconds: 3),
    VoidCallback? onTap,
  }) {
    show(
      title: title,
      message: message,
      type: SnackBarType.error,
      duration: duration,
      onTap: onTap,
    );
  }

  static _SnackBarConfig _getConfig(SnackBarType type) {
    switch (type) {
      case SnackBarType.success:
        return _SnackBarConfig(
          backgroundColor: AppColors.success,
          textColor: AppColors.textPrimary,
          icon: Icons.check_circle,
          iconColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.08),
        );
      case SnackBarType.info:
        return _SnackBarConfig(
          backgroundColor: AppColors.info,
          textColor: AppColors.textPrimary,
          icon: Icons.info,
          iconColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.08),
        );
      case SnackBarType.warning:
        return _SnackBarConfig(
          backgroundColor: AppColors.warning,
          textColor: AppColors.textPrimary,
          icon: Icons.warning,
          iconColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.08),
        );
      case SnackBarType.error:
        return _SnackBarConfig(
          backgroundColor: AppColors.error,
          textColor: AppColors.textPrimary,
          icon: Icons.cancel,
          iconColor: Colors.white,
          shadowColor: Colors.black.withOpacity(0.08),
        );
    }
  }
}

class _SnackBarConfig {
  final Color backgroundColor;
  final Color textColor;
  final IconData icon;
  final Color iconColor;
  final Color shadowColor;

  _SnackBarConfig({
    required this.backgroundColor,
    required this.textColor,
    required this.icon,
    required this.iconColor,
    required this.shadowColor,
  });
}
