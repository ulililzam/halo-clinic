import 'package:get/get.dart';
import '../../../common/widgets/app_snackbar.dart';

class ArticlePreview {
  final String id;
  final String imageUrl;
  final String title;
  final String description;

  ArticlePreview({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class SupportController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxList<ArticlePreview> articles = <ArticlePreview>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadArticlePreviews();
  }

  void loadArticlePreviews() {
    // Load 3 artikel preview untuk section "Terbaru"
    articles.value = [
      ArticlePreview(
        id: '1',
        imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=300',
        title: 'Mengapa Sering Lemas? Bisa Jadi Ini Penyebabnya!',
        description: 'Cek kondisi tubuh sebelum terlambat',
      ),
      ArticlePreview(
        id: '2',
        imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=300',
        title: '5 Tanda Awal Diabetes yang Sering Diabaikan',
        description: 'Kenali gejalanya agar bisa dicegah',
      ),
      ArticlePreview(
        id: '3',
        imageUrl: 'https://images.unsplash.com/photo-1502904550040-7534597429ae?w=300',
        title: 'Manfaat Jalan Kaki 30 Menit Tiap Hari',
        description: 'Langkah kecil, dampak besar bagi tubuh',
      ),
    ];
  }

  void onSearch(String query) {
    searchQuery.value = query;
    // Implementasi search untuk fitur support lainnya
    update();
  }

  void onMenuTap(String menu) {
    if (menu == 'Artikel Kesehatan') {
      Get.toNamed('/articles');
    } else if (menu == 'Kalkulator BMI') {
      Get.toNamed('/bmi');
    } else if (menu == 'Tes Depresi') {
      Get.toNamed('/depression-test');
    } else if (menu == 'Tes Stres') {
      AppSnackBar.info(
        title: 'Info',
        message: 'Fitur Tes Stres segera hadir',
      );
    } else {
      AppSnackBar.info(
        title: 'Info',
        message: 'Fitur $menu segera hadir',
      );
    }
  }

  void onArticlePreviewTap(ArticlePreview article) {
    Get.toNamed('/articles/${article.id}', parameters: {'id': article.id});
  }
}
