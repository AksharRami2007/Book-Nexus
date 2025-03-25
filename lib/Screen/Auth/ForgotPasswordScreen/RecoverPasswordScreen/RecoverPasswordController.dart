import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class RecoverPasswordControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => RecoverPasswordController());
  }
}

class RecoverPasswordController extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
