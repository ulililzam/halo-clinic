import 'package:get/get.dart';
import '../controllers/stress_test_controller.dart';

class StressTestBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<StressTestController>(() => StressTestController());
  }
}
