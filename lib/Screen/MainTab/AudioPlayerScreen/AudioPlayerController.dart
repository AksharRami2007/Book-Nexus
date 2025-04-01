import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:get/get.dart';

class AudioplayercontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Audioplayercontroller());
  }
}

class Audioplayercontroller extends BaseController {
  RxDouble slider = 0.0.obs;
  RxInt selectedIndex = 0.obs;

  @override
  void onInit() {
    super.onInit();
  }

  void onchange(double newValue) {
    slider.value = newValue;
  }
}
