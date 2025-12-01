import 'package:get/get.dart';
import '../../../data/models/medicine_model.dart';
import '../../../common/widgets/app_snackbar.dart';

class MedicineDetailController extends GetxController {
  final RxInt quantity = 1.obs;
  final RxBool isFavorite = false.obs;
  final RxBool isLoading = false.obs;
  
  late MedicineModel medicine;

  @override
  void onInit() {
    super.onInit();
    // Get medicine from arguments
    medicine = Get.arguments as MedicineModel;
  }

  void increaseQuantity() {
    quantity.value++;
    update();
  }

  void decreaseQuantity() {
    if (quantity.value > 1) {
      quantity.value--;
      update();
    }
  }

  void toggleFavorite() {
    isFavorite.value = !isFavorite.value;
    update();
  }

  void addToCart() {
    AppSnackBar.success(
      title: 'Berhasil',
      message: '${quantity.value}x ${medicine.name} ditambahkan ke keranjang',
      duration: const Duration(seconds: 2),
    );
  }

  void showAllReviews() {
    // TODO: Navigate to reviews screen
  }
}
