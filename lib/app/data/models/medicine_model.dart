class MedicineModel {
  final String id;
  final String name;
  final int price;
  final String unit;
  final String imageUrl;
  final String category;
  final String? description;
  final int stock;

  MedicineModel({
    required this.id,
    required this.name,
    required this.price,
    required this.unit,
    required this.imageUrl,
    required this.category,
    this.description,
    this.stock = 100,
  });

  factory MedicineModel.fromJson(Map<String, dynamic> json) {
    return MedicineModel(
      id: json['id'],
      name: json['name'],
      price: json['price'],
      unit: json['unit'],
      imageUrl: json['imageUrl'],
      category: json['category'],
      description: json['description'],
      stock: json['stock'] ?? 100,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'unit': unit,
      'imageUrl': imageUrl,
      'category': category,
      'description': description,
      'stock': stock,
    };
  }
}
