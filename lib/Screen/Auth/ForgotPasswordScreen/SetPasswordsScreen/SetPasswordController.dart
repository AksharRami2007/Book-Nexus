import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class SetpasswordcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Setpasswordcontroller());
  }
}

class Setpasswordcontroller extends BaseController {
  var isPasswordhidden = true.obs;
  var isConformPassword = true.obs;

  void togglevisiblity() {
    isPasswordhidden.value = !isPasswordhidden.value;
  }

  void togglevisiblity2() {
    isConformPassword.value = !isConformPassword.value;
  }

  @override
  void onInit() {
    super.onInit();
  }
}
