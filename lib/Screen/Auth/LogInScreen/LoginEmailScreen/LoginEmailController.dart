import 'package:get/get.dart';

import '../../../Basecontroller/basecontroller.dart';

class LoginEmailControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => LoginEmailController());
  }
}

class LoginEmailController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
