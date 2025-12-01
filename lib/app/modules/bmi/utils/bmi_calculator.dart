/// BMI Calculator utility class
/// Based on WHO (World Health Organization) International Standards
class BmiCalculator {
  /// Calculate BMI value
  /// Formula: BMI = weight (kg) / (height (m))^2
  static double calculate({
    required double heightInCm,
    required double weightInKg,
  }) {
    if (heightInCm <= 0 || weightInKg <= 0) {
      throw ArgumentError('Height and weight must be greater than 0');
    }

    final heightInMeters = heightInCm / 100;
    return weightInKg / (heightInMeters * heightInMeters);
  }

  /// Get BMI category based on WHO standards
  /// Reference: https://www.who.int/health-topics/obesity
  static String getCategory(double bmi) {
    if (bmi < 16.0) {
      return 'Sangat Kurus';
    } else if (bmi < 17.0) {
      return 'Kurus Ringan';
    } else if (bmi < 18.5) {
      return 'Kurus';
    } else if (bmi < 25.0) {
      return 'Normal';
    } else if (bmi < 30.0) {
      return 'Gemuk';
    } else if (bmi < 35.0) {
      return 'Obesitas I';
    } else if (bmi < 40.0) {
      return 'Obesitas II';
    } else {
      return 'Obesitas III';
    }
  }

  /// Get category description
  static String getDescription(double bmi) {
    if (bmi < 16.0) {
      return 'Berat badan Anda sangat kurang. Segera konsultasi dengan dokter.';
    } else if (bmi < 17.0) {
      return 'Berat badan Anda kurang. Perlu perhatian medis.';
    } else if (bmi < 18.5) {
      return 'Berat badan Anda kurang. Tingkatkan asupan nutrisi.';
    } else if (bmi < 25.0) {
      return 'Berat badan Anda ideal. Pertahankan pola hidup sehat!';
    } else if (bmi < 30.0) {
      return 'Berat badan Anda berlebih. Mulai terapkan pola hidup lebih sehat.';
    } else if (bmi < 35.0) {
      return 'Anda mengalami obesitas tingkat I. Konsultasi dengan dokter.';
    } else if (bmi < 40.0) {
      return 'Anda mengalami obesitas tingkat II. Segera konsultasi dengan dokter.';
    } else {
      return 'Anda mengalami obesitas tingkat III. Perlu penanganan medis segera.';
    }
  }

  /// Get health recommendation
  static String getRecommendation(double bmi) {
    if (bmi < 18.5) {
      return 'Tingkatkan asupan kalori dengan makanan bergizi tinggi. Konsumsi protein, karbohidrat kompleks, dan lemak sehat. Konsultasi dengan ahli gizi untuk program penambahan berat badan.';
    } else if (bmi < 25.0) {
      return 'Pertahankan pola makan sehat dengan gizi seimbang. Lakukan olahraga rutin minimal 150 menit per minggu. Jaga pola tidur yang cukup dan kelola stres dengan baik.';
    } else if (bmi < 30.0) {
      return 'Kurangi asupan kalori 500-750 kkal per hari. Tingkatkan aktivitas fisik minimal 200-300 menit per minggu. Fokus pada makanan tinggi serat dan protein rendah lemak.';
    } else {
      return 'Segera konsultasi dengan dokter untuk program penurunan berat badan yang aman dan efektif. Diperlukan pendampingan medis, ahli gizi, dan program olahraga terstruktur.';
    }
  }

  /// Get category color for UI
  static String getCategoryColorHex(double bmi) {
    if (bmi < 18.5) {
      return '#FF6B6B'; // Red
    } else if (bmi < 25.0) {
      return '#51CF66'; // Green
    } else if (bmi < 30.0) {
      return '#FFA94D'; // Orange
    } else {
      return '#FF6B6B'; // Red
    }
  }

  /// Calculate position on gauge (0.0 to 1.0)
  /// Based on BMI ranges for visual representation
  static double calculateGaugePosition(double bmi) {
    // BMI Zones distribution on gauge:
    // 0-18.5 (Underweight) = 0% - 23.125%
    // 18.5-25 (Normal) = 23.125% - 56.25%
    // 25-30 (Overweight) = 56.25% - 75%
    // 30-40 (Obese) = 75% - 100%
    
    double position;
    
    if (bmi <= 18.5) {
      // Underweight zone (0-23.125% of gauge)
      position = (bmi / 18.5) * 0.23125;
    } else if (bmi <= 25.0) {
      // Normal zone (23.125%-56.25% of gauge)
      position = 0.23125 + ((bmi - 18.5) / (25.0 - 18.5)) * 0.33125;
    } else if (bmi <= 30.0) {
      // Overweight zone (56.25%-75% of gauge)
      position = 0.5625 + ((bmi - 25.0) / (30.0 - 25.0)) * 0.1875;
    } else {
      // Obese zone (75%-100% of gauge)
      // Cap at BMI 40 for display purposes
      final cappedBmi = bmi > 40.0 ? 40.0 : bmi;
      position = 0.75 + ((cappedBmi - 30.0) / (40.0 - 30.0)) * 0.25;
    }
    
    return position.clamp(0.0, 1.0);
  }

  /// Validate input values
  static bool isValidHeight(double height) {
    return height >= 50.0 && height <= 300.0;
  }

  static bool isValidWeight(double weight) {
    return weight >= 10.0 && weight <= 500.0;
  }

  /// Get health risk level
  static String getHealthRisk(double bmi) {
    if (bmi < 16.0) {
      return 'Risiko Tinggi';
    } else if (bmi < 18.5) {
      return 'Risiko Rendah';
    } else if (bmi < 25.0) {
      return 'Risiko Minimal';
    } else if (bmi < 30.0) {
      return 'Risiko Sedang';
    } else if (bmi < 35.0) {
      return 'Risiko Tinggi';
    } else {
      return 'Risiko Sangat Tinggi';
    }
  }
}
