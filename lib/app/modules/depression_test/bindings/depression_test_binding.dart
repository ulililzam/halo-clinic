import 'package:get/get.dart';
import '../controllers/depression_test_controller.dart';

class DepressionTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<DepressionTestController>(() => DepressionTestController());
  }
}
