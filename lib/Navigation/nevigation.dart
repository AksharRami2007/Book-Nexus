import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/ForgotPasswordController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/ForgotpasswordScreen.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginController.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginScreenWrapper.dart';
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
        name: Routername.forgotpasswordsreen,
        page: () => const Forgotpasswordscreen(),
        binding: ForgotpasswordcontrollerBindings(),
      ),
    ];
  }
}
