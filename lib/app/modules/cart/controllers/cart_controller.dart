import 'package:get/get.dart';
import '../../../data/models/cart_model.dart';
import '../../../data/models/medicine_model.dart';
import '../../../common/widgets/app_snackbar.dart';

class CartController extends GetxController {
  final RxList<CartItemModel> cartItems = <CartItemModel>[].obs;
  final RxString promoCode = ''.obs;
  final RxInt promoDiscount = 0.obs;
  final RxBool isLoadingPromo = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadDummyData();
  }

  void loadDummyData() {
    // Dummy cart data
    cartItems.value = [
      CartItemModel(
        id: '1',
        medicine: MedicineModel(
          id: '1',
          name: 'Prove D3-1000 IU 10 Tablet',
          price: 35000,
          unit: 'Per Strip',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
        ),
        quantity: 1,
        isSelected: true,
      ),
      CartItemModel(
        id: '2',
        medicine: MedicineModel(
          id: '2',
          name: 'Betadine Mouthwash and Gargle 1% 100ml',
          price: 32000,
          unit: 'Per Botol',
          imageUrl: 'https://images.unsplash.com/photo-1584308666744-24d5c474f2ae?w=300',
          category: 'Populer',
        ),
        quantity: 1,
        isSelected: false,
      ),
    ];
    update();
  }

  void addToCart(MedicineModel medicine) {
    final existingIndex = cartItems.indexWhere(
      (item) => item.medicine.id == medicine.id,
    );

    if (existingIndex != -1) {
      cartItems[existingIndex].quantity++;
    } else {
      cartItems.add(CartItemModel(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        medicine: medicine,
        quantity: 1,
        isSelected: true,
      ));
    }
    update();
  }

  void toggleSelectAll() {
    final allSelected = cartItems.every((item) => item.isSelected);
    for (var item in cartItems) {
      item.isSelected = !allSelected;
    }
    update();
  }

  void toggleSelectItem(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      cartItems[index].isSelected = !cartItems[index].isSelected;
      update();
    }
  }

  void increaseQuantity(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1) {
      cartItems[index].quantity++;
      update();
    }
  }

  void decreaseQuantity(String itemId) {
    final index = cartItems.indexWhere((item) => item.id == itemId);
    if (index != -1 && cartItems[index].quantity > 1) {
      cartItems[index].quantity--;
      update();
    }
  }

  void removeItem(String itemId) {
    cartItems.removeWhere((item) => item.id == itemId);
    update();
    AppSnackBar.success(
      title: 'Berhasil',
      message: 'Item dihapus dari keranjang',
      duration: const Duration(seconds: 2),
    );
  }

  Future<void> applyPromoCode(String code) async {
    if (code.isEmpty) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Masukkan kode promo',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    isLoadingPromo.value = true;
    update();

    // Simulate API call
    await Future.delayed(const Duration(seconds: 1));

    // Dummy promo validation
    if (code.toUpperCase() == 'DISKON10') {
      promoCode.value = code;
      promoDiscount.value = (subTotal * 0.1).toInt();
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Kode promo berhasil diterapkan',
        duration: const Duration(seconds: 2),
      );
    } else {
      AppSnackBar.error(
        title: 'Gagal',
        message: 'Kode promo tidak valid',
        duration: const Duration(seconds: 2),
      );
    }

    isLoadingPromo.value = false;
    update();
  }

  bool get isAllSelected {
    if (cartItems.isEmpty) return false;
    return cartItems.every((item) => item.isSelected);
  }

  int get subTotal {
    return cartItems
        .where((item) => item.isSelected)
        .fold(0, (sum, item) => sum + item.totalPrice);
  }

  int get shippingCost {
    return selectedItemsCount > 0 ? 0 : 0; // Free shipping
  }

  int get total {
    return subTotal + shippingCost - promoDiscount.value;
  }

  int get selectedItemsCount {
    return cartItems.where((item) => item.isSelected).length;
  }

  void checkout() {
    if (selectedItemsCount == 0) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Pilih item yang ingin dibeli',
        duration: const Duration(seconds: 2),
      );
      return;
    }

    AppSnackBar.success(
      title: 'Berhasil',
      message: 'Pesanan berhasil dibuat',
      duration: const Duration(seconds: 2),
    );
    
    // TODO: Navigate to checkout/payment screen
  }
}
