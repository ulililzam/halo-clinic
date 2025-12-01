class SupportServiceModel {
  final String id;
  final String name;
  final String description;
  final int price;
  final String? priceUnit;
  final String imageUrl;
  final String category;
  final bool isAvailable;
  final double rating;
  final int reviewCount;
  final List<String> features;

  SupportServiceModel({
    required this.id,
    required this.name,
    required this.description,
    required this.price,
    this.priceUnit,
    required this.imageUrl,
    required this.category,
    this.isAvailable = true,
    this.rating = 0.0,
    this.reviewCount = 0,
    this.features = const [],
  });

  factory SupportServiceModel.fromJson(Map<String, dynamic> json) {
    return SupportServiceModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      price: json['price'] ?? 0,
      priceUnit: json['price_unit'],
      imageUrl: json['image_url'] ?? '',
      category: json['category'] ?? '',
      isAvailable: json['is_available'] ?? true,
      rating: (json['rating'] ?? 0.0).toDouble(),
      reviewCount: json['review_count'] ?? 0,
      features: json['features'] != null 
          ? List<String>.from(json['features']) 
          : [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'price': price,
      'price_unit': priceUnit,
      'image_url': imageUrl,
      'category': category,
      'is_available': isAvailable,
      'rating': rating,
      'review_count': reviewCount,
      'features': features,
    };
  }
}
