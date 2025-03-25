import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class SignupcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Signupcontroller());
  }
}

class Signupcontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
