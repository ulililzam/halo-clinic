import 'package:get/get.dart';
import '../controllers/address_selection_controller.dart';

class AddressSelectionBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AddressSelectionController>(() => AddressSelectionController());
  }
}
