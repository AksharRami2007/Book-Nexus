import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class SetpasswordcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Setpasswordcontroller());
  }
}

class Setpasswordcontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
