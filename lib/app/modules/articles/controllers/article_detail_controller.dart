import 'package:get/get.dart';
import '../models/article_detail_model.dart';

class ArticleDetailController extends GetxController {
  final RxBool isLoading = false.obs;
  final Rx<ArticleDetailModel?> article = Rx<ArticleDetailModel?>(null);

  @override
  void onInit() {
    super.onInit();
    loadArticleDetail();
  }

  void loadArticleDetail() {
    isLoading.value = true;

    // Dummy data - sesuai dengan gambar desain
    final articleId = Get.parameters['id'] ?? '1';    
    // Dummy articles database
    final articles = {
      '1': ArticleDetailModel(
        id: '1',
        imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=800',
        title: 'Mengapa Sering Lemas? Bisa Jadi Ini Penyebabnya!',
        date: 'Selasa, 1 April 2025',
        content: '''Sering merasa lemas tanpa alasan yang jelas? Kondisi ini bisa menjadi tanda bahwa tubuh sedang kelelahan atau kekurangan energi karena berbagai faktor. Mulai dari pola tidur yang buruk, asupan nutrisi yang tidak mencukupi, hingga stres yang menumpuk—semuanya bisa memengaruhi tingkat energi harianmu. Aktivitas yang terlalu padat tanpa diselingi waktu istirahat juga dapat membuat tubuh kehilangan tenaga dan terasa lemas sepanjang hari.

Namun, tidak semua rasa lemas berasal dari gaya hidup saja. Dalam beberapa kasus, rasa lelah yang berkepanjangan bisa menjadi gejala awal dari kondisi medis seperti anemia, hipotiroid, diabetes, atau tekanan darah rendah. Misalnya, jika kamu mengalami lemas disertai pusing, jantung berdebar, atau kesulitan berkonsentrasi, bisa jadi tubuhmu sedang mengalami gangguan kesehatan yang memerlukan penanganan khusus. Oleh karena itu, penting untuk memperhatikan gejala yang muncul dan tidak mengabaikannya terlalu lama.

Untuk mengatasi keluhan ini, cobalah menerapkan gaya hidup sehat seperti tidur cukup, konsumsi makanan bergizi seimbang, dan rutin berolahraga ringan. Pastikan tubuh terhidrasi dengan baik dan kelola stres dengan cara yang positif. Bila rasa lemas terus berlangsung meskipun sudah melakukan perubahan gaya hidup, ada baiknya segera konsultasikan kondisi tersebut ke dokter agar mendapat penanganan yang tepat. Mengabaikan sinyal tubuh hanya akan membuat masalah semakin besar di kemudian hari.''',
        relatedArticles: ['2', '3'],
      ),
      '2': ArticleDetailModel(
        id: '2',
        imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=800',
        title: '5 Tanda Awal Diabetes yang Sering Diabaikan',
        date: 'Senin, 31 Maret 2025',
        content: '''Diabetes adalah kondisi kronis yang mempengaruhi cara tubuh mengolah gula darah. Sayangnya, banyak orang tidak menyadari bahwa mereka memiliki diabetes karena gejala awalnya sering diabaikan atau dianggap sepele. Padahal, deteksi dini sangat penting untuk mencegah komplikasi serius di kemudian hari.

Berikut adalah 5 tanda awal diabetes yang perlu Anda waspadai:

1. Sering merasa haus dan buang air kecil
Ginjal bekerja ekstra untuk membuang kelebihan gula dalam darah, sehingga Anda akan sering buang air kecil dan merasa haus terus-menerus.

2. Mudah lapar meski sudah makan
Sel-sel tubuh tidak mendapat cukup energi dari makanan karena insulin tidak berfungsi dengan baik, membuat Anda cepat lapar kembali.

3. Penurunan berat badan tanpa sebab
Meski makan lebih banyak, tubuh kehilangan berat badan karena tidak bisa mengolah gula dengan baik sebagai energi.

4. Penglihatan kabur
Kadar gula darah yang tinggi dapat menyebabkan pembengkakan pada lensa mata, membuat penglihatan menjadi buram.

5. Luka sulit sembuh
Gula darah tinggi mengganggu aliran darah dan sistem kekebalan tubuh, sehingga proses penyembuhan luka menjadi lebih lambat.

Jika Anda mengalami beberapa gejala di atas, segera konsultasikan dengan dokter untuk pemeriksaan lebih lanjut. Diabetes yang terdeteksi dini dapat dikelola dengan baik melalui perubahan gaya hidup dan pengobatan yang tepat.''',
        relatedArticles: ['1', '3'],
      ),
      '3': ArticleDetailModel(
        id: '3',
        imageUrl: 'https://images.unsplash.com/photo-1502904550040-7534597429ae?w=800',
        title: 'Manfaat Jalan Kaki 30 Menit Tiap Hari',
        date: 'Minggu, 30 Maret 2025',
        content: '''Jalan kaki adalah salah satu bentuk olahraga paling sederhana namun memiliki manfaat luar biasa bagi kesehatan. Tidak perlu peralatan khusus atau biaya mahal, cukup luangkan waktu 30 menit setiap hari untuk berjalan kaki dan rasakan perubahan positif pada tubuh Anda.

Berikut adalah berbagai manfaat jalan kaki 30 menit setiap hari:

1. Meningkatkan kesehatan jantung
Jalan kaki rutin membantu meningkatkan sirkulasi darah, menurunkan tekanan darah, dan mengurangi risiko penyakit jantung serta stroke.

2. Membantu kontrol berat badan
Aktivitas ini membakar kalori dan meningkatkan metabolisme tubuh, sehingga efektif untuk menjaga atau menurunkan berat badan.

3. Memperkuat tulang dan otot
Jalan kaki adalah latihan beban ringan yang memperkuat tulang dan otot, terutama pada bagian kaki dan pinggul.

4. Meningkatkan mood dan mengurangi stres
Aktivitas fisik memicu pelepasan endorfin, hormon yang membuat Anda merasa lebih bahagia dan rileks.

5. Meningkatkan sistem kekebalan tubuh
Jalan kaki teratur membantu tubuh melawan infeksi dan penyakit dengan meningkatkan fungsi sistem imun.

6. Meningkatkan kualitas tidur
Orang yang aktif berjalan kaki cenderung tidur lebih nyenyak dan berkualitas.

Mulailah dengan langkah kecil. Anda bisa berjalan kaki saat pagi hari sebelum beraktivitas, atau sore hari setelah pulang kerja. Yang terpenting adalah konsistensi. Jadikan jalan kaki sebagai bagian dari rutinitas harian Anda dan nikmati manfaatnya untuk kesehatan jangka panjang.''',
        relatedArticles: ['1', '2'],
      ),
    };
    
    article.value = articles[articleId] ?? articles['1'];
    isLoading.value = false;
  }
}
