class ArticleModel {
  final String id;
  final String title;
  final String content;
  final String? excerpt;
  final String? imageUrl;
  final String category;
  final String author;
  final DateTime publishedAt;
  final int readTime; // in minutes
  final int views;

  ArticleModel({
    required this.id,
    required this.title,
    required this.content,
    this.excerpt,
    this.imageUrl,
    required this.category,
    required this.author,
    required this.publishedAt,
    required this.readTime,
    this.views = 0,
  });

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      id: json['id'] ?? '',
      title: json['title'] ?? '',
      content: json['content'] ?? '',
      excerpt: json['excerpt'],
      imageUrl: json['image_url'],
      category: json['category'] ?? '',
      author: json['author'] ?? '',
      publishedAt: json['published_at'] != null
          ? DateTime.parse(json['published_at'])
          : DateTime.now(),
      readTime: json['read_time'] ?? 5,
      views: json['views'] ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'image_url': imageUrl,
      'category': category,
      'author': author,
      'published_at': publishedAt.toIso8601String(),
      'read_time': readTime,
      'views': views,
    };
  }
}
