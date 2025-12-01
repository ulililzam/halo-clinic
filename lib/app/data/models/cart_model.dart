import 'medicine_model.dart';

class CartItemModel {
  final String id;
  final MedicineModel medicine;
  int quantity;
  bool isSelected;

  CartItemModel({
    required this.id,
    required this.medicine,
    this.quantity = 1,
    this.isSelected = false,
  });

  int get totalPrice => medicine.price * quantity;

  CartItemModel copyWith({
    String? id,
    MedicineModel? medicine,
    int? quantity,
    bool? isSelected,
  }) {
    return CartItemModel(
      id: id ?? this.id,
      medicine: medicine ?? this.medicine,
      quantity: quantity ?? this.quantity,
      isSelected: isSelected ?? this.isSelected,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'medicine': medicine.toJson(),
      'quantity': quantity,
      'isSelected': isSelected,
    };
  }

  factory CartItemModel.fromJson(Map<String, dynamic> json) {
    return CartItemModel(
      id: json['id'],
      medicine: MedicineModel.fromJson(json['medicine']),
      quantity: json['quantity'] ?? 1,
      isSelected: json['isSelected'] ?? false,
    );
  }
}
