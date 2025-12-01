import '../utils/bmi_calculator.dart';

class BmiResult {
  final double bmi;
  final double height;
  final double weight;
  final bool isMale;
  final String category;
  final String description;
  final String recommendation;
  final String healthRisk;

  BmiResult({
    required this.bmi,
    required this.height,
    required this.weight,
    required this.isMale,
    required this.category,
    required this.description,
    required this.recommendation,
    required this.healthRisk,
  });

  factory BmiResult.calculate({
    required double height,
    required double weight,
    required bool isMale,
  }) {
    final bmi = BmiCalculator.calculate(
      heightInCm: height,
      weightInKg: weight,
    );

    return BmiResult(
      bmi: bmi,
      height: height,
      weight: weight,
      isMale: isMale,
      category: BmiCalculator.getCategory(bmi),
      description: BmiCalculator.getDescription(bmi),
      recommendation: BmiCalculator.getRecommendation(bmi),
      healthRisk: BmiCalculator.getHealthRisk(bmi),
    );
  }

  /// Get gauge position (0.0 to 1.0)
  double get gaugePosition => BmiCalculator.calculateGaugePosition(bmi);

  /// Get category color hex
  String get categoryColorHex => BmiCalculator.getCategoryColorHex(bmi);
}
