import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class HomecontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Homecontroller());
  }
}

class Homecontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
