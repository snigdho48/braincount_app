import 'package:get/get.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/auth/bindings/login_binding.dart';
import '../modules/auth/bindings/register_binding.dart';
import '../modules/auth/bindings/otp_binding.dart';
import '../modules/auth/bindings/forgot_password_binding.dart';
import '../modules/auth/bindings/reset_password_binding.dart';
import '../modules/auth/views/login_view.dart';
import '../modules/auth/views/register_view.dart';
import '../modules/auth/views/otp_view.dart';
import '../modules/auth/views/forgot_password_view.dart';
import '../modules/auth/views/reset_password_view.dart';
import '../modules/main_navigation/bindings/main_navigation_binding.dart';
import '../modules/main_navigation/views/main_navigation_view.dart';
import '../modules/dashboard/bindings/dashboard_binding.dart';
import '../modules/dashboard/views/dashboard_view.dart';
import '../modules/tasks/bindings/task_list_binding.dart';
import '../modules/tasks/bindings/task_details_binding.dart';
import '../modules/tasks/views/task_list_view.dart';
import '../modules/tasks/views/task_details_view.dart';
import '../modules/task_submission/bindings/task_submission_binding.dart';
import '../modules/task_submission/views/task_submission_view.dart';
import '../modules/profile/bindings/profile_binding.dart';
import '../modules/profile/views/profile_view.dart';
import '../modules/balance/bindings/balance_history_binding.dart';
import '../modules/balance/views/balance_history_view.dart';
import '../modules/withdraw/bindings/withdraw_binding.dart';
import '../modules/withdraw/views/withdraw_view.dart';
import 'app_routes.dart';

class AppPages {
  static final routes = [
    GetPage(
      name: AppRoutes.splash,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const LoginView(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: AppRoutes.register,
      page: () => const RegisterView(),
      binding: RegisterBinding(),
    ),
    GetPage(
      name: AppRoutes.otpVerification,
      page: () => const OtpView(),
      binding: OtpBinding(),
    ),
    GetPage(
      name: AppRoutes.forgotPassword,
      page: () => const ForgotPasswordView(),
      binding: ForgotPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.resetPassword,
      page: () => const ResetPasswordView(),
      binding: ResetPasswordBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const MainNavigationView(),
      binding: MainNavigationBinding(),
    ),
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardView(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.taskList,
      page: () => const TaskListView(),
      binding: TaskListBinding(),
    ),
    GetPage(
      name: AppRoutes.taskDetails,
      page: () => const TaskDetailsView(),
      binding: TaskDetailsBinding(),
    ),
    GetPage(
      name: AppRoutes.taskSubmission,
      page: () => const TaskSubmissionView(),
      binding: TaskSubmissionBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfileView(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.balanceHistory,
      page: () => const BalanceHistoryView(),
      binding: BalanceHistoryBinding(),
    ),
    GetPage(
      name: AppRoutes.withdraw,
      page: () => const WithdrawView(),
      binding: WithdrawBinding(),
    ),
  ];
}
