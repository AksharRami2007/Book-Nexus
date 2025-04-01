import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/RecoverPasswordScreen/RecoverPasswordScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/VerifyCodeScreen/VerifyCodeController.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/VerifyCodeScreen/VerifyCodeScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/AccountScreen/AccountController.dart';
import 'package:book_nexus/Screen/MainTab/AccountScreen/AccountScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/AudioPlayerScreen/AudioPlayerController.dart';
import 'package:book_nexus/Screen/MainTab/AudioPlayerScreen/AudioPlayerScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/BookDetailScreen/BookDetailController.dart';
import 'package:book_nexus/Screen/MainTab/BookDetailScreen/BookDetailScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/BookReaderScreen/BookReaderController.dart';
import 'package:book_nexus/Screen/MainTab/BookReaderScreen/BookReaderScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/HomeSrceen/HomeController.dart';
import 'package:book_nexus/Screen/MainTab/HomeSrceen/HomeScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginEmailScreen/LoginEmailController.dart';
import 'package:book_nexus/Screen/Auth/LogInScreen/LoginEmailScreen/LoginEmailScreenWrapper.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpController.dart';
import 'package:book_nexus/Screen/Auth/SignUpScreen/SignUpScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/MyLibraryScreen/MyLibraryController.dart';
import 'package:book_nexus/Screen/MainTab/MyLibraryScreen/MyLibraryScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/NavBar/NavBArWrapper.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/ProfileDetailController.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/ProfileDetailScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/SeeMoreScreen/SeeMoreController.dart';
import 'package:book_nexus/Screen/MainTab/SeeMoreScreen/SeeMoreScreenWrapper.dart';
import 'package:get/get_navigation/src/routes/get_route.dart';

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
        page: () => const Navbarwrapper(),
        binding: HomeControllerBindings(),
      ),
      GetPage(
        name: RouterName.accountScreen,
        page: () => const Accountscreenwrapper(),
        binding: AccountcontrollerBindings(),
      ),
      GetPage(
        name: RouterName.myLibraryScreen,
        page: () => const MyLibraryScreenWrapper(),
        binding: MylibrarycontrollerBindings(),
      ),
      // GetPage(
        // name: RouterName.seeMoreScreen,
        page: () => const Seemorescreenwrapper(),
        binding: SeemorecontrollerBindings(),
      ),
      GetPage(
<<<<<<< Updated upstream
        name: RouterName.audioPlayerScreen,
        page: () => const Audioplayerscreenwrapper(),
        binding: AudioplayercontrollerBindings(),
// =======
        // name: RouterName.bookReaderScreenWrapper,
        page: () => const BookReaderScreenWrapper(),
        binding: BookReaderControllerBindings(),
>>>>>>> Stashed changes
      ),
    ];
  }
}
