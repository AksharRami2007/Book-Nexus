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
  var books = <Map<String, dynamic>>[].obs;
  var category = ''.obs;
  var isLoading = true.obs;

  final BookApiService _bookApiService = BookApiService();

  void setCategory(String categoryName) {
    category.value = categoryName;
    fetchBooksByCategory(categoryName);
  }

  Future<void> fetchBooksByCategory(String categoryName) async {
    try {
      isLoading.value = true;
      var fetchedBooks = await _bookApiService.getBooksByCategory(categoryName);
      if (fetchedBooks != null) {
        books.assignAll(fetchedBooks);
      }
    } catch (e) {
      print('Failed to fetch books for category $categoryName: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['category'] != null) {
      setCategory(Get.arguments['category']);
    }
  }
}
