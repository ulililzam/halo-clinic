import 'package:get/get.dart';

class ArticleData {
  final String id;
  final String imageUrl;
  final String title;
  final String description;

  ArticleData({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.description,
  });
}

class ArticleController extends GetxController {
  final RxBool isLoading = false.obs;
  final RxString searchQuery = ''.obs;
  final RxList<ArticleData> articles = <ArticleData>[].obs;
  final RxList<ArticleData> allArticles = <ArticleData>[].obs;

  @override
  void onInit() {
    super.onInit();
    loadArticles();
  }

  void loadArticles() {
    allArticles.value = [
      ArticleData(
        id: '1',
        imageUrl: 'https://images.unsplash.com/photo-1576091160399-112ba8d25d1d?w=300',
        title: 'Mengapa Sering Lemas? Bisa Jadi Ini Penyebabnya!',
        description: 'Cek kondisi tubuh sebelum terlambat',
      ),
      ArticleData(
        id: '2',
        imageUrl: 'https://images.unsplash.com/photo-1505751172876-fa1923c5c528?w=300',
        title: '5 Tanda Awal Diabetes yang Sering Diabaikan',
        description: 'Kenali gejalanya agar bisa dicegah',
      ),
      ArticleData(
        id: '3',
        imageUrl: 'https://images.unsplash.com/photo-1502904550040-7534597429ae?w=300',
        title: 'Manfaat Jalan Kaki 30 Menit Tiap Hari',
        description: 'Langkah kecil, dampak besar bagi tubuh',
      ),
    ];
    articles.value = List.from(allArticles);
  }

  void onSearch(String query) {
    searchQuery.value = query;
    if (query.isEmpty) {
      articles.value = List.from(allArticles);
    } else {
      articles.value = allArticles
          .where((article) =>
              article.title.toLowerCase().contains(query.toLowerCase()) ||
              article.description.toLowerCase().contains(query.toLowerCase()))
          .toList();
    }
    update();
  }

  void onArticleTap(ArticleData article) {
    Get.toNamed('/articles/${article.id}', parameters: {'id': article.id});
  }
}
