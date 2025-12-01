abstract class AppRoutes {
  // Auth Routes
  static const onboarding = '/onboarding';
  static const splash = '/splash';
  static const login = '/login';
  static const register = '/register';
  static const forgotPassword = '/forgot-password';
  static const otpVerification = '/otp-verification';
  static const resetPassword = '/reset-password';
  static const passwordResetSuccess = '/password-reset-success';
  
  // Main Routes
  static const home = '/home';
  
  // Article Routes
  static const articleList = '/articles';
  static const articleDetail = '/articles/:id';
  
  // Consultation Routes
  static const consultationList = '/consultations';
  static const consultationDetail = '/consultation/:id';
  static const doctorDetail = '/doctor/:id';
  static const bookingConsultation = '/booking/:doctorId';
  
  // Chat Routes
  static const chatList = '/chats';
  static const chatRoom = '/chat/:id';
  
  // Profile Routes
  static const profile = '/profile';
  static const editProfile = '/profile/edit';
  static const consultationHistory = '/profile/history';
  static const paymentMethod = '/profile/payment-method';
  static const notifications = '/profile/notifications';
  static const help = '/help';
  static const about = '/about';
  
  // Medicine Routes
  static const medicineList = '/medicines';
  static const medicineDetail = '/medicine/detail';
  
  // Cart Routes
  static const cart = '/cart';
  
  // Support Routes
  static const supportList = '/support';
  
  // BMI Routes
  static const bmiCalculator = '/bmi';
  static const bmiResult = '/bmi/result';
  
  // Depression Test Routes
  static const depressionTestIntro = '/depression-test';
  static const depressionTestQuestions = '/depression-test/questions';
  static const depressionTestResult = '/depression-test/result';
  
  // Stress Test Routes
  static const stressTestIntro = '/stress-test';
  static const stressTestQuestions = '/stress-test/questions';
  static const stressTestResult = '/stress-test/result';
  
  // Address Routes
  static const addressSelect = '/address/select';
  static const addressAdd = '/address/add';
  static const addressEdit = '/address/edit/:id';
}
