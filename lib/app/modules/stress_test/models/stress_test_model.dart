/// Model for User Profile Data (Page 1)
class StressTestProfile {
  String? gender;
  String? ageRange;
  List<String> healthConditions;

  StressTestProfile({
    this.gender,
    this.ageRange,
    this.healthConditions = const [],
  });
}

/// Model for Stress Test Question
class StressQuestion {
  final int id;
  final String question;
  final List<StressAnswer> answers;

  const StressQuestion({
    required this.id,
    required this.question,
    required this.answers,
  });
}

/// Model for Answer Option
class StressAnswer {
  final String label;
  final int score;

  const StressAnswer({
    required this.label,
    required this.score,
  });
}

/// Stress Test Questions based on DASS-21 Stress subscale
class StressTestData {
  static const answers = [
    StressAnswer(label: 'Tidak pernah', score: 0),
    StressAnswer(label: 'Jarang', score: 1),
    StressAnswer(label: 'Kadang-kadang', score: 2),
    StressAnswer(label: 'Cukup sering', score: 3),
    StressAnswer(label: 'Sangat sering', score: 4),
  ];

  // Age range options
  static const ageRanges = [
    '< 20 tahun',
    '21 - 30 tahun',
    '31 - 40 tahun',
    '41 - 50 tahun',
    '51 - 60 tahun',
    '> 60 tahun',
  ];

  // Health conditions options
  static const healthConditions = [
    'Asma',
    'Penyakit jantung',
    'Diabetes',
    'Obesitas / malnutrisi',
    'Lainnya',
  ];

  // Page 2 questions (3 questions)
  static final page2Questions = [
    StressQuestion(
      id: 1,
      question: 'Merasa kesal karena sesuatu terjadi secara tidak terduga?',
      answers: answers,
    ),
    StressQuestion(
      id: 2,
      question: 'Merasa tidak dapat mengendalikan hal-hal penting dalam hidupmu?',
      answers: answers,
    ),
    StressQuestion(
      id: 3,
      question: 'Merasa gelisah dan stres?',
      answers: answers,
    ),
  ];

  // Page 3 questions (3 questions)
  static final page3Questions = [
    StressQuestion(
      id: 4,
      question: 'Merasa yakin terhadap kemampuanmu dalam menangani masalah pribadi?',
      answers: answers,
    ),
    StressQuestion(
      id: 5,
      question: 'Merasa yakin bahwa segala sesuatu berjalan sesuai keinginanmu?',
      answers: answers,
    ),
    StressQuestion(
      id: 6,
      question: 'Menemukan bahwa kamu tidak dapat mengatasi segala hal yang harus dilakukan?',
      answers: answers,
    ),
  ];

  // Page 4 questions (4 questions)
  static final page4Questions = [
    StressQuestion(
      id: 7,
      question: 'Mampu mengendalikan hal-hal yang mengganggu dalam hidupmu?',
      answers: answers,
    ),
    StressQuestion(
      id: 8,
      question: 'Merasa dapat mengendalikan hal-hal dalam hidupmu?',
      answers: answers,
    ),
    StressQuestion(
      id: 9,
      question: 'Merasa marah karena hal-hal terjadi di luar kendalimu?',
      answers: answers,
    ),
    StressQuestion(
      id: 10,
      question: 'Merasa kesulitanmu sangat banyak sehingga kamu tidak mampu mengatasinya?',
      answers: answers,
    ),
  ];

  /// Calculate stress level based on total score (max: 40)
  static String getLevel(int score) {
    if (score >= 0 && score <= 10) {
      return 'Normal';
    } else if (score >= 11 && score <= 18) {
      return 'Ringan';
    } else if (score >= 19 && score <= 26) {
      return 'Sedang';
    } else if (score >= 27 && score <= 34) {
      return 'Berat';
    } else {
      return 'Sangat Berat';
    }
  }

  /// Get color for stress level
  static String getColorHex(int score) {
    if (score >= 0 && score <= 10) {
      return '#51CF66'; // Green - Normal
    } else if (score >= 11 && score <= 18) {
      return '#95E1A1'; // Light Green - Ringan
    } else if (score >= 19 && score <= 26) {
      return '#FFC952'; // Yellow - Sedang
    } else if (score >= 27 && score <= 34) {
      return '#FF9966'; // Orange - Berat
    } else {
      return '#FF6B6B'; // Red - Sangat Berat
    }
  }

  /// Get description based on score
  static String getDescription(int score) {
    if (score >= 0 && score <= 10) {
      return 'Tingkat stres Anda dalam batas normal. Terus pertahankan pola hidup sehat dan seimbang.';
    } else if (score >= 11 && score <= 18) {
      return 'Anda mengalami stres ringan. Cobalah untuk meluangkan waktu beristirahat, melakukan aktivitas yang menyenangkan, dan berbicara dengan orang terdekat.';
    } else if (score >= 19 && score <= 26) {
      return 'Anda mengalami stres sedang. Disarankan untuk mengelola stres dengan teknik relaksasi seperti meditasi, olahraga ringan, atau konseling.';
    } else if (score >= 27 && score <= 34) {
      return 'Anda mengalami stres berat. Sangat disarankan untuk segera berkonsultasi dengan profesional kesehatan mental untuk mendapatkan dukungan yang tepat.';
    } else {
      return 'Anda mengalami stres sangat berat. Segera konsultasi dengan dokter atau psikolog untuk mendapatkan penanganan yang sesuai.';
    }
  }
}
