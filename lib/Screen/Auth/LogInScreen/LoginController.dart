import 'package:get/get.dart';

import '../../Basecontroller/basecontroller.dart';

class LogincontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Logincontroller());
  }
}

class Logincontroller extends BaseController {}
