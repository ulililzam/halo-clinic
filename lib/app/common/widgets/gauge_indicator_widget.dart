import 'package:flutter/material.dart';
import '../themes/colors.dart';

/// Represents a zone/range in the gauge with color
class GaugeZone {
  final double start;
  final double end;
  final Color color;
  final String label;

  const GaugeZone({
    required this.start,
    required this.end,
    required this.color,
    required this.label,
  });
}

/// Reusable gauge indicator widget for various assessments
/// Can be used for BMI, Depression Test, Stress Test, etc.
class GaugeIndicatorWidget extends StatelessWidget {
  final double value;
  final String title;
  final String category;
  final Color categoryColor;
  final String? info1Label;
  final String? info1Value;
  final String? info2Label;
  final String? info2Value;
  final String description;
  final List<GaugeZone> zones;
  final VoidCallback? onActionTap;
  final String? actionLabel;
  final bool showAction;

  const GaugeIndicatorWidget({
    super.key,
    required this.value,
    required this.title,
    required this.category,
    required this.categoryColor,
    required this.description,
    required this.zones,
    this.info1Label,
    this.info1Value,
    this.info2Label,
    this.info2Value,
    this.onActionTap,
    this.actionLabel,
    this.showAction = true,
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
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: AppColors.textPrimary,
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 8),
          
          // Category
          Text(
            category,
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.w700,
              color: categoryColor,
            ),
          ),
          
          const SizedBox(height: 8),
          
          // Info Row (optional)
          if (info1Label != null && info1Value != null)
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  info1Label!,
                  style: TextStyle(
                    fontSize: 13,
                    color: AppColors.textSecondary,
                  ),
                ),
                const SizedBox(width: 8),
                Text(
                  info1Value!,
                  style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: AppColors.textPrimary,
                  ),
                ),
                if (info2Label != null && info2Value != null) ...[
                  const SizedBox(width: 24),
                  Text(
                    info2Label!,
                    style: TextStyle(
                      fontSize: 13,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    info2Value!,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                ],
              ],
            ),
          
          if (info1Label != null && info1Value != null)
            const SizedBox(height: 24),
          if (info1Label == null || info1Value == null)
            const SizedBox(height: 16),
          
          // Gauge Chart - Linear style
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
                      gradient: LinearGradient(
                        colors: _buildGradientColors(),
                        stops: _buildGradientStops(),
                      ),
                    ),
                  ),
                ),
                // Value Indicator
                Positioned(
                  left: _calculatePosition(context),
                  top: 20,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      // Triangle pointer
                      CustomPaint(
                        size: const Size(12, 8),
                        painter: _TrianglePainter(
                          color: AppColors.primary,
                        ),
                      ),
                      // Circle with value
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
                          value.toStringAsFixed(value % 1 == 0 ? 0 : 1),
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
          
          // Description/Recommendation
          Container(
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: AppColors.primary.withOpacity(0.05),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(
              description,
              style: TextStyle(
                fontSize: 13,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
              textAlign: TextAlign.center,
            ),
          ),
          
          if (showAction && actionLabel != null && onActionTap != null) ...[
            const SizedBox(height: 16),
            Align(
              alignment: Alignment.centerRight,
              child: GestureDetector(
                onTap: onActionTap,
                child: Text(
                  actionLabel!,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  List<Color> _buildGradientColors() {
    final colors = <Color>[];
    for (final zone in zones) {
      colors.add(zone.color);
      colors.add(zone.color);
    }
    return colors;
  }

  List<double> _buildGradientStops() {
    final stops = <double>[];
    final totalRange = zones.last.end - zones.first.start;
    
    for (int i = 0; i < zones.length; i++) {
      final zone = zones[i];
      final startPercent = (zone.start - zones.first.start) / totalRange;
      final endPercent = (zone.end - zones.first.start) / totalRange;
      
      stops.add(startPercent);
      stops.add(endPercent);
    }
    
    return stops;
  }

  double _calculatePosition(BuildContext context) {
    final containerWidth = MediaQuery.of(context).size.width - 88;
    
    // Calculate percentage based on zones
    final totalRange = zones.last.end - zones.first.start;
    final valuePosition = (value - zones.first.start) / totalRange;
    
    // Calculate position with badge width
    final badgeWidth = 50.0;
    final position = (containerWidth * valuePosition) - (badgeWidth / 2);
    
    // Clamp position to prevent overflow
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
