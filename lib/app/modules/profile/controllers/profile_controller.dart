import 'package:get/get.dart';
import '../../auth/models/user_model.dart';
import '../../auth/services/auth_service.dart';
import '../../../common/widgets/app_snackbar.dart';

class ProfileController extends GetxController {
  final AuthService _authService = AuthService();
  
  final currentUser = Rxn<UserModel>();
  final isLoading = false.obs;

  @override
  void onInit() {
    super.onInit();
    loadUserProfile();
  }

  Future<void> loadUserProfile() async {
    try {
      isLoading.value = true;
      final user = await _authService.getCurrentUser();
      currentUser.value = user;
    } finally {
      isLoading.value = false;
    }
  }

  void showComingSoon() {
    AppSnackBar.info(
      title: 'Segera Hadir',
      message: 'Fitur ini akan segera tersedia',
    );
  }

  Future<void> logout() async {
    await _authService.logout();
    Get.offAllNamed('/login');
  }
}
