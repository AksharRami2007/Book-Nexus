import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class ForgotpasswordcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Forgotpasswordcontroller());
  }
}

class Forgotpasswordcontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
