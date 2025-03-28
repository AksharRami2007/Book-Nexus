import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class ProfiledetailcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Profiledetailcontroller());
  }
}

class Profiledetailcontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
