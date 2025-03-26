import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class BookdetailcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Bookdetailcontroller());
  }
}

class Bookdetailcontroller extends BaseController {
  @override
  void onInit() {
    super.onInit();
  }
}
