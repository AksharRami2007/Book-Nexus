import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class AccountcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Accountcontroller());
  }
}

class Accountcontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
