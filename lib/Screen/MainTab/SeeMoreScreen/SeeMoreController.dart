import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:get/get.dart';

class SeemorecontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => Seemorecontroller());
  }
}

class Seemorecontroller extends BaseController {
  var fiction = <Map<String, dynamic>>[].obs;

  final BookApiService _bookApiService = BookApiService();

  Future<void> fetchfiction() async {
    var books = await _bookApiService.getTrendingBooks();
    if (books != null) {
      fiction.assignAll(books);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchfiction();
  }
}
