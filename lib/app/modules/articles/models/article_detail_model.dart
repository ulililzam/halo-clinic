class ArticleDetailModel {
  final String id;
  final String imageUrl;
  final String title;
  final String date;
  final String content;
  final List<String> relatedArticles;

  ArticleDetailModel({
    required this.id,
    required this.imageUrl,
    required this.title,
    required this.date,
    required this.content,
    this.relatedArticles = const [],
  });
}
