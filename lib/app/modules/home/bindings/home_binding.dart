import 'package:get/get.dart';
import '../controllers/home_controller.dart';
import '../../articles/controllers/article_controller.dart';
import '../../consultation/controllers/consultation_controller.dart';
import '../../profile/controllers/profile_controller.dart';

class HomeBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(() => HomeController());
    
    Get.lazyPut<ArticleController>(() => ArticleController());
    
    Get.lazyPut<ConsultationController>(() => ConsultationController());
    
    Get.lazyPut<ProfileController>(() => ProfileController());
  }
}
