import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class LoginPasswordControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginPasswordController());
  }
}

class LoginPasswordController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
