import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/depression_test_controller.dart';
import '../../../common/themes/colors.dart';
import '../../../common/widgets/global_button.dart';
import '../../../common/utils/whatsapp_launcher.dart';
import '../../../common/widgets/app_snackbar.dart';

class DepressionTestResultScreen extends StatelessWidget {
  const DepressionTestResultScreen({super.key});

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
              padding: const EdgeInsets.all(20),
              child: Obx(() {
                final colorHex = ctrl.getColorHex();
                final color = Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);

                return Column(
                  children: [
                    // Result Card
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(16),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.05),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Title
                          const Text(
                            'Level depresi yang kamu miliki:',
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w400,
                              color: AppColors.textPrimary,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          
                          // Category
                          Text(
                            ctrl.level.value,
                            style: TextStyle(
                              fontSize: 32,
                              fontWeight: FontWeight.w700,
                              color: color,
                            ),
                          ),
                          
                          const SizedBox(height: 24),
                          
                          // Gauge Bar
                          SizedBox(
                            height: 80,
                            child: Stack(
                              clipBehavior: Clip.none,
                              children: [
                                // Gradient Bar
                                Positioned(
                                  top: 0,
                                  left: 0,
                                  right: 0,
                                  child: Container(
                                    height: 16,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(8),
                                      gradient: const LinearGradient(
                                        colors: [
                                          Color(0xFF51CF66), // Minimal
                                          Color(0xFF95E1A1), // Ringan
                                          Color(0xFFFFC952), // Sedang
                                          Color(0xFFFF9966), // Cukup Berat
                                          Color(0xFFFF6B6B), // Berat
                                        ],
                                        stops: [0.0, 0.2, 0.4, 0.6, 1.0],
                                      ),
                                    ),
                                  ),
                                ),
                                // Value Indicator
                                Positioned(
                                  left: _calculatePosition(context, ctrl.totalScore.value),
                                  top: 16,
                                  child: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      // Triangle pointer
                                      CustomPaint(
                                        size: const Size(12, 8),
                                        painter: _TrianglePainter(color: AppColors.primary),
                                      ),
                                      // Badge with score
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 14,
                                          vertical: 8,
                                        ),
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(20),
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.primary.withOpacity(0.3),
                                              blurRadius: 8,
                                              offset: const Offset(0, 2),
                                            ),
                                          ],
                                        ),
                                        child: Text(
                                          ctrl.totalScore.value.toString(),
                                          style: const TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ),
                          
                          const SizedBox(height: 4),
                          
                          // Description
                          Text(
                            ctrl.getDescription(),
                            style: TextStyle(
                              fontSize: 14,
                              color: AppColors.textSecondary,
                              height: 1.6,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          
                          const SizedBox(height: 14),
                          
                          // Consultation Button
                          SizedBox(
                            width: double.infinity,
                            child: OutlinedButton(
                              onPressed: () async {
                                final success = await WhatsAppLauncher.launchDepressionTestResult(
                                  score: ctrl.totalScore.value,
                                  level: ctrl.level.value,
                                );
                                
                                if (!success) {
                                  AppSnackBar.error(
                                    title: 'Gagal Membuka WhatsApp',
                                    message: 'Pastikan WhatsApp sudah terinstall di perangkat Anda.',
                                  );
                                }
                              },
                              style: OutlinedButton.styleFrom(
                                padding: const EdgeInsets.symmetric(vertical: 16),
                                side: BorderSide(color: AppColors.primary, width: 2),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                              ),
                              child: Text(
                                'Konsultasi',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                          
                          const SizedBox(height: 12),
                          
                          // Cek ulang link
                          Align(
                            alignment: Alignment.centerRight,
                            child: GestureDetector(
                              onTap: () {
                                ctrl.resetTest();
                                Get.back();
                              },
                              child: Text(
                                'Cek ulang',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                );
              }),
            ),
          ),
          
          // Bottom Button
          Container(
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
              child: GlobalButton(
                label: 'Kembali',
                onPressed: () {
                  ctrl.resetTest();
                  Get.offNamedUntil('/support', (route) => route.settings.name == '/home');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  double _calculatePosition(BuildContext context, int score) {
    final containerWidth = MediaQuery.of(context).size.width - 88; // 20 padding * 2 + 24 card padding * 2
    
    // Score range is 0-27
    final percentage = (score / 27).clamp(0.0, 1.0);
    
    // Badge width
    const badgeWidth = 50.0;
    
    // Calculate position
    final position = (containerWidth * percentage) - (badgeWidth / 2);
    
    // Clamp to prevent overflow
    return position.clamp(0.0, containerWidth - badgeWidth);
  }
}

/// Custom painter for triangle pointer
class _TrianglePainter extends CustomPainter {
  final Color color;

  _TrianglePainter({required this.color});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    final path = Path()
      ..moveTo(size.width / 2, 0) // Top center
      ..lineTo(0, size.height) // Bottom left
      ..lineTo(size.width, size.height) // Bottom right
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
