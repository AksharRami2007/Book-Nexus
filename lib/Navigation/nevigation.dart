import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/VerifyCodeScreen/VerifyCodeController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/VerifyCodeScreen/VerifyCodeScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/HomeSrceen/HomeController.dart';
import 'package:book_nexus/Screen/MainTab/HomeSrceen/HomeScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginEmailScreen/LoginEmailController.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginEmailScreen/LoginEmailScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpController.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpScreenWrapper.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

import '../Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordController.dart';
import '../Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordScreenWrapper.dart';
import '../Screen/Auth/GenrePreferencesScreen/GenrePreferencesController.dart';
import '../Screen/Auth/GenrePreferencesScreen/GenrePreferencesScreenWrapper.dart';
import '../Screen/Auth/LogInScreen/LoginPasswordScreen/LoginPasswordController.dart';
import '../Screen/Auth/LogInScreen/LoginPasswordScreen/LoginPasswordScreenWrapper.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
        name: RouterName.loginEmailScreen,
        page: () => const LoginEmailScreenWrapper(),
        binding: LoginEmailControllerBindings(),
      ),
      GetPage(
        name: RouterName.loginPasswordScreen,
        page: () => const LoginPasswordScreenWrapper(),
        binding: LoginPasswordControllerBindings(),
      ),
      GetPage(
        name: RouterName.recoverPasswordscreen,
        page: () => const RecoverPasswordScreenWrapper(),
        binding: RecoverPasswordControllerBindings(),
      ),
      GetPage(
        name: RouterName.signupscreen,
        page: () => const Signupscreenwrapper(),
        binding: SignupcontrollerBindings(),
      ),
      GetPage(
        name: RouterName.setPasswordScreen,
        page: () => const Setpasswordscreenwrapper(),
        binding: SetpasswordcontrollerBindings(),
      ),
      GetPage(
        name: RouterName.verifyCodeScreen,
        page: () => const Verifycodescreenwrapper(),
        binding: VerifyCodecontrollerBindings(),
      ),
      GetPage(
        name: RouterName.genrePreferencesScreen,
        page: () => const GenrePreferencesScreenWrapper(),
        binding: GenrePreferencesControllerBinding(),
      ),
      GetPage(
        name: RouterName.homescreen,
        page: () => const Homescreenwrapper(),
        binding: HomecontrollerBindings(),
      ),
    ];
  }
}
