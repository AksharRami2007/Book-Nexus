import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class VerifyCodecontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => VerifyCodecontroller());
  }
}

class VerifyCodecontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
