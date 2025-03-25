import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginController.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpController.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpScreenWrapper.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

class Pages {
  static List<GetPage> pages() {
    return [
      GetPage(
        name: Routername.loginscreen,
        page: () => const Loginscreenwrapper(),
        binding: LogincontrollerBindings(),
      ),
      GetPage(
        name: Routername.recoverPasswordscreen,
        page: () => const RecoverPasswordScreenWrapper(),
        binding: RecoverPasswordControllerBindings(),
      ),
      GetPage(
        name: Routername.signupscreen,
        page: () => const Signupscreenwrapper(),
        binding: SignupcontrollerBindings(),
      ),
    ];
  }
}
