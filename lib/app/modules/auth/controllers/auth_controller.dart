import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../models/user_model.dart';
import '../services/auth_service.dart';
import '../../../common/widgets/app_snackbar.dart';
import '../../../routes/app_routes.dart';

class AuthController extends GetxController {
  final AuthService _authService = AuthService();

  // Observables
  final isLoading = false.obs;
  final currentUser = Rxn<UserModel>();
  final isLoggedIn = false.obs;
  final loginType = 'email'.obs; // 'email' or 'phone'
  final rememberMe = false.obs;

  // Text Controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  // Form Keys
  final loginFormKey = GlobalKey<FormState>();
  final registerFormKey = GlobalKey<FormState>();

  // Password visibility
  final isPasswordHidden = true.obs;
  final isConfirmPasswordHidden = true.obs;
  
  // OTP Timer
  final otpResendTimer = 60.obs;
  Timer? _otpTimer;

  @override
  void onInit() {
    super.onInit();
    checkLoginStatus();
  }
  @override
  void onClose() {
    emailController.dispose();
    passwordController.dispose();
    nameController.dispose();
    phoneController.dispose();
    confirmPasswordController.dispose();
    _otpTimer?.cancel();
    super.onClose();
  }

  // Check login status
  Future<void> checkLoginStatus() async {
    try {
      final loggedIn = await _authService.isLoggedIn();
      isLoggedIn.value = loggedIn;

      if (loggedIn) {
        final user = await _authService.getCurrentUser();
        currentUser.value = user;
      }
    } catch (e) {}
  }

  // Login dengan Validasi Form
  Future<void> login() async {
    // Validasi form terlebih dahulu
    if (!loginFormKey.currentState!.validate()) {
      return;
    }
    
    try {
      isLoading.value = true;

      await Future.delayed(const Duration(milliseconds: 500));

      // DEVELOPMENT MODE: Mock login tanpa validasi
      final email = emailController.text.trim().isEmpty 
          ? 'dev@haloclinic.com' 
          : emailController.text.trim();
      
      currentUser.value = UserModel(
        id: '1',
        name: 'Dev User',
        email: email,
        phone: phoneController.text.isEmpty ? '081234567890' : phoneController.text,
        avatar: null,
      );
      
      isLoggedIn.value = true;
      
      // Simpan dummy token untuk development
      await _authService.saveDummyToken();
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Login berhasil!',
      );
      
      // Navigate ke home dengan delay kecil
      await Future.delayed(const Duration(milliseconds: 300));
      Get.offAllNamed(AppRoutes.home);

    } catch (e) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Error: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Register dengan Validasi Form
  Future<void> register() async {
    // Validasi form terlebih dahulu
    if (!registerFormKey.currentState!.validate()) {
      return;
    }

    try {
      isLoading.value = true;

      // Simulasi delay
      await Future.delayed(const Duration(milliseconds: 500));

      // DEVELOPMENT MODE: Mock register
      final email = emailController.text.trim().isEmpty 
          ? 'newuser@haloclinic.com' 
          : emailController.text.trim();
      
      currentUser.value = UserModel(
        id: '2',
        name: 'New User',
        email: email,
        phone: phoneController.text.isEmpty ? '081234567890' : phoneController.text,
        avatar: null,
      );
      
      isLoggedIn.value = true;
      await _authService.saveDummyToken();
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Registrasi berhasil! (Dev Mode)',
      );
      
      await Future.delayed(const Duration(milliseconds: 300));
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Error: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Forgot Password - Send OTP
  Future<void> forgotPassword(String email) async {
    try {
      isLoading.value = true;

      final response = await _authService.forgotPassword(email);

      if (!response.success) {
        AppSnackBar.error(
          title: 'Gagal',
          message: response.message ?? 'Gagal mengirim kode OTP',
        );
        return;
      }
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: response.message ?? 'Kode OTP telah dikirim (Dev: 1234)',
      );
      
      // Navigate ke OTP verification screen
      startOtpTimer();
      Get.toNamed(AppRoutes.otpVerification, arguments: email);
      
    } catch (e) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Start OTP Timer
  void startOtpTimer() {
    otpResendTimer.value = 60;
    _otpTimer?.cancel();
    _otpTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (otpResendTimer.value > 0) {
        otpResendTimer.value--;
      } else {
        timer.cancel();
      }
    });
  }
  
  // Verify OTP
  Future<void> verifyOtp(String otp, String email) async {
    try {
      isLoading.value = true;

      // DEVELOPMENT MODE: Validasi OTP
      await Future.delayed(const Duration(milliseconds: 500));
      
      if (otp == '1234') {
        AppSnackBar.success(
          title: 'Berhasil',
          message: 'Kode OTP berhasil diverifikasi',
        );
        
        // Navigate ke reset password screen
        Get.offNamed(AppRoutes.resetPassword);
      } else {
        AppSnackBar.error(
          title: 'Gagal',
          message: 'Kode OTP salah. Silakan coba lagi.\n(Dev: Gunakan 1234)',
        );
      }
      
    } catch (e) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Resend OTP
  Future<void> resendOtp(String email) async {
    try {
      isLoading.value = true;

      // DEVELOPMENT MODE: Simulasi kirim ulang OTP
      await Future.delayed(const Duration(seconds: 1));
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Kode OTP telah dikirim ulang\n(Dev: Gunakan kode 1234)',
      );
      
      startOtpTimer();
      
    } catch (e) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
  
  // Reset Password
  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    try {
      isLoading.value = true;

      // DEVELOPMENT MODE: Simulasi reset password
      await Future.delayed(const Duration(seconds: 1));
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Password berhasil diubah',
      );
      
      // Navigate ke success screen
      Get.offAllNamed(AppRoutes.passwordResetSuccess);
      
    } catch (e) {
      AppSnackBar.error(
        title: 'Error',
        message: 'Terjadi kesalahan: $e',
      );
      isLoading.value = false;
    }
  }

  // Logout
  // Logout
  Future<void> logout() async {
    try {
      await _authService.logout();
      currentUser.value = null;
      isLoggedIn.value = false;
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Logout berhasil',
      );
      Get.offAllNamed(AppRoutes.login);
    } catch (e) {
      AppSnackBar.error(
        title: 'Gagal',
        message: 'Logout gagal: $e',
      );
    }
  }

  // Toggle password visibility
  void togglePasswordVisibility() {
    isPasswordHidden.value = !isPasswordHidden.value;
  }

  void toggleConfirmPasswordVisibility() {
    isConfirmPasswordHidden.value = !isConfirmPasswordHidden.value;
  }

  // Set login type (email or phone)
  void setLoginType(String type) {
    loginType.value = type;
  }

  // Toggle remember me
  void toggleRememberMe() {
    rememberMe.value = !rememberMe.value;
  }

  // Social Login - Apple (Prepared for Firebase)
  Future<void> loginWithApple() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Apple Sign In with Firebase
      // final appleProvider = AppleAuthProvider();
      // final userCredential = await FirebaseAuth.instance.signInWithProvider(appleProvider);
      
      // DEVELOPMENT MODE: Mock login
      await Future.delayed(const Duration(seconds: 1));
      
      currentUser.value = UserModel(
        id: 'apple_user',
        name: 'Apple User',
        email: 'apple@user.com',
        phone: null,
        avatar: null,
      );
      
      isLoggedIn.value = true;
      await _authService.saveDummyToken();
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Login dengan Apple berhasil!',
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      AppSnackBar.error(
        title: 'Gagal',
        message: 'Login dengan Apple gagal: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }

  // Social Login - Google (Prepared for Firebase)
  Future<void> loginWithGoogle() async {
    try {
      isLoading.value = true;
      
      // TODO: Implement Google Sign In with Firebase
      // final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      // final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;
      // final credential = GoogleAuthProvider.credential(
      //   accessToken: googleAuth?.accessToken,
      //   idToken: googleAuth?.idToken,
      // );
      // final userCredential = await FirebaseAuth.instance.signInWithCredential(credential);
      
      // DEVELOPMENT MODE: Mock login
      await Future.delayed(const Duration(seconds: 1));
      
      currentUser.value = UserModel(
        id: 'google_user',
        name: 'Google User',
        email: 'google@user.com',
        phone: null,
        avatar: null,
      );
      
      isLoggedIn.value = true;
      await _authService.saveDummyToken();
      
      AppSnackBar.success(
        title: 'Berhasil',
        message: 'Login dengan Google berhasil!',
      );
      Get.offAllNamed(AppRoutes.home);
    } catch (e) {
      AppSnackBar.error(
        title: 'Gagal',
        message: 'Login dengan Google gagal: $e',
      );
    } finally {
      isLoading.value = false;
    }
  }
}
