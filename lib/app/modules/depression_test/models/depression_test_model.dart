/// Model for Depression Test Question
class DepressionQuestion {
  final int id;
  final String question;
  final List<DepressionAnswer> answers;

  const DepressionQuestion({
    required this.id,
    required this.question,
    required this.answers,
  });
}

/// Model for Answer Option
class DepressionAnswer {
  final String label;
  final int score;

  const DepressionAnswer({
    required this.label,
    required this.score,
  });
}

/// Depression Test Questions based on standard PHQ-9 questionnaire
class DepressionTestData {
  static const answers = [
    DepressionAnswer(label: 'Tidak pernah', score: 0),
    DepressionAnswer(label: 'Beberapa hari', score: 1),
    DepressionAnswer(label: 'Sebagian besar hari', score: 2),
    DepressionAnswer(label: 'Hampir setiap hari', score: 3),
  ];

  static final questions = [
    DepressionQuestion(
      id: 1,
      question: 'Seberapa sering kamu merasa terganggu oleh hal seperti berikut...',
      answers: answers,
    ),
    DepressionQuestion(
      id: 2,
      question: 'Kurang senang atau tertarik dalam kegiatan sehari-hari?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 3,
      question: 'Merasa sedih, muram, dan putus asa?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 4,
      question: 'Sulit tidur atau tidur nyenyak, atau tidur terlalu banyak tidur?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 5,
      question: 'Merasa lelah atau kekurangan energi?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 6,
      question: 'Tidak nafsu makan, atau terlalu banyak makan?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 7,
      question: 'Merasa buruk tentang diri sendiri, atau merasa gagal atau mengecewakan diri atau keluarga?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 8,
      question: 'Kesulitan berkonsentrasi, seperti saat membaca koran atau menonton TV?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 9,
      question: 'Bergerak atau berbicara dengan lambat hingga orang lain menyedarinya? Atau merasa kurang istirahat dan tidak bisa diam lebih dari biasanya?',
      answers: answers,
    ),
    DepressionQuestion(
      id: 10,
      question: 'Merasa lebih baik mati, atau berpikir ingin menyakiti diri sendiri?',
      answers: answers,
    ),
  ];

  /// Calculate depression level based on total score
  static String getLevel(int score) {
    if (score >= 0 && score <= 4) {
      return 'Minimal';
    } else if (score >= 5 && score <= 9) {
      return 'Ringan';
    } else if (score >= 10 && score <= 14) {
      return 'Sedang';
    } else if (score >= 15 && score <= 19) {
      return 'Cukup Berat';
    } else {
      return 'Berat';
    }
  }

  /// Get color for depression level
  static String getColorHex(int score) {
    if (score >= 0 && score <= 4) {
      return '#51CF66'; // Green - Minimal
    } else if (score >= 5 && score <= 9) {
      return '#95E1A1'; // Light Green - Ringan
    } else if (score >= 10 && score <= 14) {
      return '#FFC952'; // Yellow - Sedang
    } else if (score >= 15 && score <= 19) {
      return '#FF9966'; // Orange - Cukup Berat
    } else {
      return '#FF6B6B'; // Red - Berat
    }
  }

  /// Get description based on score
  static String getDescription(int score) {
    if (score >= 0 && score <= 4) {
      return 'Pastikan asupan kalori sesuai dengan kebutuhan kalori harian & konsumssi makanan sehat';
    } else if (score >= 5 && score <= 9) {
      return 'Anda mengalami gejala depresi ringan. Coba tingkatkan aktivitas menyenangkan dan istirahat yang cukup.';
    } else if (score >= 10 && score <= 14) {
      return 'Anda mengalami gejala depresi sedang. Pertimbangkan untuk berkonsultasi dengan profesional kesehatan mental.';
    } else if (score >= 15 && score <= 19) {
      return 'Anda mengalami gejala depresi cukup berat. Sangat disarankan untuk segera berkonsultasi dengan dokter atau psikolog.';
    } else {
      return 'Anda mengalami gejala depresi berat. Segera konsultasi dengan dokter atau psikolog untuk mendapatkan penanganan yang tepat.';
    }
  }
}
