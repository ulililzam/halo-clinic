import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import '../controllers/auth_controller.dart';
import '../../../common/themes/colors.dart';
import '../../../common/themes/text_styles.dart';
import '../../../common/widgets/global_button.dart';
import '../../../common/widgets/custom_app_bar.dart';

class OtpVerificationScreen extends GetView<AuthController> {
  const OtpVerificationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final email = Get.arguments as String? ?? '';
    final List<TextEditingController> otpControllers = List.generate(
      4,
      (index) => TextEditingController(),
    );
    final List<FocusNode> focusNodes = List.generate(
      4,
      (index) => FocusNode(),
    );

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: const CustomAppBar(title: 'Verifikasi OTP'),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Column(
            children: [
              const SizedBox(height: 20),
              
              // Illustration
              Container(
                width: 200,
                height: 200,
                decoration: BoxDecoration(
                  color: AppColors.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Center(
                  child: Image.asset(
                    'assets/images/forgot_pass.png',
                    width: 150,
                    height: 150,
                    errorBuilder: (context, error, stackTrace) {
                      return Icon(
                        Icons.lock_outline,
                        size: 80,
                        color: AppColors.primary,
                      );
                    },
                  ),
                ),
              ),
              
              const SizedBox(height: 32),
              
              // Title
              Text(
                'Kode Verifikasi',
                style: AppTextStyles.h2,
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 12),
              
              // Subtitle
              Text(
                'Masukkan kode verifikasi yang telah kami\nkirimkan ke email $email',
                style: AppTextStyles.subtitle.copyWith(
                  color: AppColors.textSecondary,
                ),
                textAlign: TextAlign.center,
              ),
              
              const SizedBox(height: 40),
              
              // OTP Input Fields
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(4, (index) {
                  return SizedBox(
                    width: 64,
                    height: 64,
                    child: TextFormField(
                      controller: otpControllers[index],
                      focusNode: focusNodes[index],
                      textAlign: TextAlign.center,
                      keyboardType: TextInputType.number,
                      maxLength: 1,
                      style: AppTextStyles.h2.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                      ],
                      decoration: InputDecoration(
                        counterText: '',
                        filled: true,
                        fillColor: AppColors.cardBackground,
                        contentPadding: EdgeInsets.zero,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: AppColors.border),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 2,
                          ),
                        ),
                      ),
                      onChanged: (value) {
                        if (value.isNotEmpty && index < 3) {
                          focusNodes[index + 1].requestFocus();
                        } else if (value.isEmpty && index > 0) {
                          focusNodes[index - 1].requestFocus();
                        }
                        
                        // Auto verify when all fields are filled
                        if (index == 3 && value.isNotEmpty) {
                          final otp = otpControllers
                              .map((c) => c.text)
                              .join();
                          if (otp.length == 4) {
                            controller.verifyOtp(otp, email);
                          }
                        }
                      },
                    ),
                  );
                }),
              ),
              
              const SizedBox(height: 32),
              
              // Continue Button
              Obx(() => GlobalButton(
                label: 'Lanjutkan',
                onPressed: () {
                  final otp = otpControllers.map((c) => c.text).join();
                  if (otp.length == 4) {
                    controller.verifyOtp(otp, email);
                  } else {
                    Get.snackbar(
                      'Error',
                      'Mohon masukkan kode OTP lengkap',
                      backgroundColor: Colors.red,
                      colorText: Colors.white,
                    );
                  }
                },
                isLoading: controller.isLoading.value,
              )),
              
              const SizedBox(height: 24),
              
              // Resend Code
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Tidak menerima kode? ',
                    style: AppTextStyles.bodyMedium.copyWith(
                      color: AppColors.textSecondary,
                    ),
                  ),
                  Obx(() {
                    final remainingTime = controller.otpResendTimer.value;
                    if (remainingTime > 0) {
                      return Text(
                        'Kirim ulang dalam ${remainingTime}s',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.textSecondary,
                        ),
                      );
                    }
                    return GestureDetector(
                      onTap: () => controller.resendOtp(email),
                      child: Text(
                        'Kirim ulang',
                        style: AppTextStyles.bodyMedium.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    );
                  }),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
