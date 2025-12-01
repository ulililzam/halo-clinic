import 'package:url_launcher/url_launcher.dart';

class WhatsAppLauncher {
  // Official WhatsApp number for Halo Clinic
  static const String clinicPhoneNumber = '6282220146199';

  /// Launch WhatsApp with consultation message
  static Future<bool> launchConsultation({
    String? userName,
    String? concernType,
  }) async {
    String message = _buildConsultationMessage(
      userName: userName,
      concernType: concernType,
    );
    
    return await _launchWhatsApp(
      phoneNumber: clinicPhoneNumber,
      message: message,
    );
  }

  /// Launch WhatsApp with stress test result
  static Future<bool> launchStressTestResult({
    required int score,
    required String level,
  }) async {
    String message = _buildStressTestMessage(
      score: score,
      level: level,
    );
    
    return await _launchWhatsApp(
      phoneNumber: clinicPhoneNumber,
      message: message,
    );
  }

  /// Launch WhatsApp with depression test result
  static Future<bool> launchDepressionTestResult({
    required int score,
    required String level,
  }) async {
    String message = _buildDepressionTestMessage(
      score: score,
      level: level,
    );
    
    return await _launchWhatsApp(
      phoneNumber: clinicPhoneNumber,
      message: message,
    );
  }

  /// Launch WhatsApp with BMI consultation
  static Future<bool> launchBMIConsultation({
    required double bmi,
    required String category,
  }) async {
    String message = _buildBMIMessage(
      bmi: bmi,
      category: category,
    );
    
    return await _launchWhatsApp(
      phoneNumber: clinicPhoneNumber,
      message: message,
    );
  }

  /// Build consultation message
  static String _buildConsultationMessage({
    String? userName,
    String? concernType,
  }) {
    String greeting = userName != null 
        ? 'Halo, saya $userName.\n\n' 
        : 'Halo,\n\n';
    
    String concern = concernType != null
        ? 'Saya ingin berkonsultasi mengenai $concernType.\n\n'
        : 'Saya ingin berkonsultasi dengan dokter.\n\n';
    
    return '$greeting$concern'
        'Mohon informasi jadwal konsultasi yang tersedia.\n\n'
        'Terima kasih.';
  }

  /// Build stress test result message
  static String _buildStressTestMessage({
    required int score,
    required String level,
  }) {
    return 'Halo,\n\n'
        'Saya baru saja menyelesaikan Tes Stres di aplikasi Halo Clinic.\n\n'
        '📊 Hasil Tes Stres:\n'
        '• Skor: $score/40\n'
        '• Level: $level\n\n'
        'Saya ingin berkonsultasi lebih lanjut dengan dokter atau psikolog mengenai hasil tes ini.\n\n'
        'Mohon informasi untuk jadwal konsultasi.\n\n'
        'Terima kasih.';
  }

  /// Build depression test result message
  static String _buildDepressionTestMessage({
    required int score,
    required String level,
  }) {
    return 'Halo,\n\n'
        'Saya baru saja menyelesaikan Tes Depresi di aplikasi Halo Clinic.\n\n'
        '📊 Hasil Tes Depresi:\n'
        '• Skor: $score/27\n'
        '• Level: $level\n\n'
        'Saya ingin berkonsultasi lebih lanjut dengan dokter atau psikolog mengenai hasil tes ini.\n\n'
        'Mohon informasi untuk jadwal konsultasi.\n\n'
        'Terima kasih.';
  }

  /// Build BMI consultation message
  static String _buildBMIMessage({
    required double bmi,
    required String category,
  }) {
    return 'Halo,\n\n'
        'Saya baru saja menghitung BMI di aplikasi Halo Clinic.\n\n'
        '📊 Hasil BMI:\n'
        '• BMI: ${bmi.toStringAsFixed(1)}\n'
        '• Kategori: $category\n\n'
        'Saya ingin berkonsultasi mengenai kondisi kesehatan dan pola hidup yang sesuai.\n\n'
        'Mohon informasi untuk jadwal konsultasi.\n\n'
        'Terima kasih.';
  }

  /// Core WhatsApp launcher
  static Future<bool> _launchWhatsApp({
    required String phoneNumber,
    required String message,
  }) async {
    // Encode message for URL
    final encodedMessage = Uri.encodeComponent(message);
    
    // WhatsApp URL scheme
    final whatsappUrl = 'https://wa.me/$phoneNumber?text=$encodedMessage';
    
    final uri = Uri.parse(whatsappUrl);
    
    try {
      if (await canLaunchUrl(uri)) {
        return await launchUrl(
          uri,
          mode: LaunchMode.externalApplication,
        );
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }
}
