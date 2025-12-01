import 'package:get/get.dart';
import '../controllers/medicine_detail_controller.dart';

class MedicineDetailBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<MedicineDetailController>(() => MedicineDetailController());
  }
}
