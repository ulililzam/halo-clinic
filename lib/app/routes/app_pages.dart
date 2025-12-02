import 'package:get/get.dart';
import '../modules/auth/views/onboarding_screen.dart';
import '../modules/auth/views/login_screen.dart';
import '../modules/auth/views/register_screen.dart';
import '../modules/auth/views/forgot_password_screen.dart';
import '../modules/auth/views/otp_verification_screen.dart';
import '../modules/auth/views/reset_password_screen.dart';
import '../modules/auth/views/password_reset_success_screen.dart';
import '../modules/auth/bindings/auth_binding.dart';
import '../modules/home/views/home_screen.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/consultation/views/consultation_list_screen.dart';
import '../modules/consultation/bindings/consultation_binding.dart';
import '../modules/medicine/views/medicine_list_screen.dart';
import '../modules/medicine/views/select_address_screen.dart';
import '../modules/medicine/views/medicine_detail_screen.dart';
import '../modules/medicine/bindings/medicine_binding.dart';
import '../modules/medicine/bindings/address_selection_binding.dart';
import '../modules/medicine/bindings/medicine_detail_binding.dart';
import '../modules/cart/views/cart_screen.dart';
import '../modules/cart/bindings/cart_binding.dart';
import '../modules/support/views/support_list_screen.dart';
import '../modules/support/bindings/support_binding.dart';
import '../modules/articles/views/article_list_screen.dart';
import '../modules/articles/views/article_detail_screen.dart';
import '../modules/articles/bindings/article_detail_binding.dart';
import '../modules/bmi/views/bmi_calculator_screen.dart';
import '../modules/bmi/views/bmi_result_screen.dart';
import '../modules/bmi/bindings/bmi_binding.dart';
import '../modules/depression_test/views/depression_test_intro_screen.dart';
import '../modules/depression_test/views/depression_test_questions_screen.dart';
import '../modules/depression_test/views/depression_test_result_screen.dart';
import '../modules/depression_test/bindings/depression_test_binding.dart';
import '../modules/stress_test/views/stress_test_intro_screen.dart';
import '../modules/stress_test/views/stress_test_questions_screen.dart';
import '../modules/stress_test/views/stress_test_result_screen.dart';
import '../modules/stress_test/bindings/stress_test_binding.dart';
import '../modules/notifications/views/notification_screen.dart';
import '../modules/notifications/bindings/notification_binding.dart';
import 'app_routes.dart';

class AppPages {
  static final pages = [
    // Auth Pages
    GetPage(
      name: AppRoutes.onboarding,
      page: () => const OnboardingScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpVerificationScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordScreen(),
      binding: AuthBinding(),
    ),
    GetPage(
      name: AppRoutes.passwordResetSuccess,
      page: () => const PasswordResetSuccessScreen(),
    ),
    
    // Main Pages
    GetPage(
      name: AppRoutes.home,
      page: () => const HomeScreen(),
      binding: HomeBinding(),
    ),
    
    // Consultation Pages
    GetPage(
      name: AppRoutes.consultationList,
      page: () => const ConsultationListScreen(),
      binding: ConsultationBinding(),
    ),
    
    // Medicine Pages
    GetPage(
      name: AppRoutes.medicineList,
      page: () => const MedicineListScreen(),
      binding: MedicineBinding(),
    ),
    
    // Address Pages
    GetPage(
      name: AppRoutes.addressSelect,
      page: () => const SelectAddressScreen(),
      binding: AddressSelectionBinding(),
    ),
    
    // Medicine Detail
    GetPage(
      name: AppRoutes.medicineDetail,
      page: () => const MedicineDetailScreen(),
      binding: MedicineDetailBinding(),
    ),
    
    // Cart Pages
    GetPage(
      name: AppRoutes.cart,
      page: () => const CartScreen(),
      binding: CartBinding(),
    ),
    
    // Support Pages
    GetPage(
      name: AppRoutes.supportList,
      page: () => const SupportListScreen(),
      binding: SupportBinding(),
    ),
    
    // Article Pages
    GetPage(
      name: AppRoutes.articleList,
      page: () => const ArticleListScreen(),
    ),
    GetPage(
      name: AppRoutes.articleDetail,
      page: () => const ArticleDetailScreen(),
      binding: ArticleDetailBinding(),
    ),
    
    // BMI Pages
    GetPage(
      name: AppRoutes.bmiCalculator,
      page: () => const BmiCalculatorScreen(),
      binding: BmiBinding(),
    ),
    GetPage(
      name: AppRoutes.bmiResult,
      page: () => const BmiResultScreen(),
    ),
    
    // Depression Test Pages
    GetPage(
      name: AppRoutes.depressionTestIntro,
      page: () => const DepressionTestIntroScreen(),
      binding: DepressionTestBinding(),
    ),
    GetPage(
      name: AppRoutes.depressionTestQuestions,
      page: () => const DepressionTestQuestionsScreen(),
      binding: DepressionTestBinding(),
    ),
    GetPage(
      name: AppRoutes.depressionTestResult,
      page: () => const DepressionTestResultScreen(),
      binding: DepressionTestBinding(),
    ),
    
    // Stress Test Pages
    GetPage(
      name: AppRoutes.stressTestIntro,
      page: () => const StressTestIntroScreen(),
      binding: StressTestBinding(),
    ),
    GetPage(
      name: AppRoutes.stressTestQuestions,
      page: () => const StressTestQuestionsScreen(),
      binding: StressTestBinding(),
    ),
    GetPage(
      name: AppRoutes.stressTestResult,
      page: () => const StressTestResultScreen(),
      binding: StressTestBinding(),
    ),
    
    // Notification Pages
    GetPage(
      name: AppRoutes.notifications,
      page: () => const NotificationScreen(),
      binding: NotificationBinding(),
    ),
  ];
}
