import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:get/get.dart';

class MylibrarycontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLibraryController());
  }
}

class MyLibraryController extends BaseController {
  var library = <Map<String, dynamic>>[].obs;

  final BookApiService _bookApiService = BookApiService();

  Future<void> fetchlibrary() async {
    var books = await _bookApiService.getRandomBooks();
    if (books != null) {
      library.assignAll(books);
    }
  }

  @override
  void onInit() {
    super.onInit();
    fetchlibrary();
  }
}
