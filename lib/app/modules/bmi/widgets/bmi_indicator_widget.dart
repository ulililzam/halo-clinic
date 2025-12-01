import 'package:flutter/material.dart';
import '../../../common/themes/colors.dart';
import '../utils/bmi_calculator.dart';

class BmiIndicatorWidget extends StatelessWidget {
  final double bmi;
  final double height;
  final double weight;
  final bool isMale;
  final VoidCallback? onCekUlang;

  const BmiIndicatorWidget({
    super.key,
    required this.bmi,
    required this.height,
    required this.weight,
    required this.isMale,
    this.onCekUlang,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.08),
            blurRadius: 16,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          // Title
          Text(
            'BMI untuk ${isMale ? 'laki-laki' : 'perempuan'}',
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
          ),
          const SizedBox(height: 8),
          
          // Category
          Text(
            BmiCalculator.getCategory(bmi),
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: _getCategoryColor(bmi),
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Height and Weight Info
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Tinggi',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${height.toInt()} cm',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
              const SizedBox(width: 24),
              Text(
                'Berat',
                style: TextStyle(
                  fontSize: 13,
                  color: AppColors.textSecondary,
                ),
              ),
              const SizedBox(width: 8),
              Text(
                '${weight.toInt()} kg',
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: AppColors.textPrimary,
                ),
              ),
            ],
          ),
          
          const SizedBox(height: 24),
          
          // Gauge Chart - Linear style like in design
          SizedBox(
            height: 80,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                // Linear gauge bar
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      gradient: const LinearGradient(
                        colors: [
                          Color(0xFFFF6B6B), // Red - Kurus
                          Color(0xFFFF6B6B),
                          Color(0xFF95E1A1), // Green - Normal
                          Color(0xFF95E1A1),
                          Color(0xFFFFC952), // Yellow - Gemuk
                          Color(0xFFFFC952),
                          Color(0xFFFF6B6B), // Red - Obesitas
                          Color(0xFFFF6B6B),
                        ],
                        stops: [0.0, 0.2, 0.2, 0.5, 0.5, 0.7, 0.7, 1.0],
                      ),
                    ),
                  ),
                ),
                // BMI Indicator
                Positioned(
                  left: _calculatePosition(context),
                  top: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Triangle pointer
                      CustomPaint(
                        size: const Size(12, 8),
                        painter: TrianglePainter(
                          color: AppColors.primary,
                        ),
                      ),
                      // Circle with BMI value
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 14,
                          vertical: 6,
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
                          bmi.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: 16,
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
          
          const SizedBox(height: 24),
          
          // Result info - Only description/recommendation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              BmiCalculator.getDescription(bmi),
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          const SizedBox(height: 16),
          
          // Cek ulang link
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: onCekUlang,
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
    );
  }

  Color _getCategoryColor(double bmi) {
    final colorHex = BmiCalculator.getCategoryColorHex(bmi);
    return Color(int.parse(colorHex.substring(1), radix: 16) + 0xFF000000);
  }

  double _calculatePosition(BuildContext context) {
    // Get container width minus padding (24 left + 24 right + indicator half width)
    final containerWidth = MediaQuery.of(context).size.width - 88;
    // Use calculator's gauge position (0.0 to 1.0)
    final percentage = BmiCalculator.calculateGaugePosition(bmi);
    // Calculate position with indicator badge width (approximately 50px)
    final badgeWidth = 50.0;
    final position = (containerWidth * percentage) - (badgeWidth / 2);
    
    // Clamp position to prevent overflow
    // Min: 0, Max: containerWidth - badgeWidth
    return position.clamp(0.0, containerWidth - badgeWidth);
  }
}

// Custom painter for triangle pointer
class TrianglePainter extends CustomPainter {
  final Color color;

  TrianglePainter({required this.color});

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
