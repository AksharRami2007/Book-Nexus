import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomeControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => HomeController());
  }
}

class HomeController extends BaseController {
  var selectedIndex = 0.obs;
  var isKeyboardVisible = false.obs;
  var trendingBooks = <Map<String, dynamic>>[].obs;
  var forYouBooks = <Map<String, dynamic>>[].obs;
  var popularBooks = <Map<String, dynamic>>[].obs;

  final BookApiService _bookApiService = BookApiService();

  void checkKeyboardVisibility(BuildContext context) {
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom > 0;
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchTrendingBooks() async {
    var books = await _bookApiService.getTrendingBooks();
    if (books != null) {
      trendingBooks.assignAll(books);
    }
  }

  Future<void> fetchForYouBooks() async {
    var books = await _bookApiService.getRandomBooks();
    if (books != null) {
      forYouBooks.assignAll(books);
    }
  }

  Future<void> fetchPopularBooks() async {
    var books = await _bookApiService.getPopularBooks();
    if (books != null) {
      popularBooks.assignAll(books);
    }
  }

  @override
  void onInit() {
    fetchTrendingBooks();
    fetchForYouBooks();
    fetchPopularBooks();
    super.onInit();
  }
}
