import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../ExploreScreen/ExploreController.dart';
import '../MyLibraryScreen/MyLibraryController.dart';

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
  var recentArrive = <Map<String, dynamic>>[].obs;
  var forYouBooks = <Map<String, dynamic>>[].obs;
  var fictionBooks = <Map<String, dynamic>>[].obs;
  var scifiBooks = <Map<String, dynamic>>[].obs;
  var thrillerBooks = <Map<String, dynamic>>[].obs;
  var romanceBooks = <Map<String, dynamic>>[].obs;

  final BookApiService _bookApiService = BookApiService();

  void checkKeyboardVisibility(BuildContext context) {
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom > 0;
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchRecentArrivesBooks() async {
    var books = await _bookApiService.getRecentArrivals();
    if (books != null) {
      recentArrive.assignAll(books);
    }
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

  Future<void> fetchFictionBooks() async {
    var books = await _bookApiService.getFictionBooks();
    if (books != null) {
      fictionBooks.assignAll(books);
    }
  }

  Future<void> fetchSciFiBooks() async {
    var books = await _bookApiService.getSciFiBooks();
    if (books != null) {
      scifiBooks.assignAll(books);
    }
  }

  Future<void> fetchThrillerBooks() async {
    var books = await _bookApiService.getThrillerBooks();
    if (books != null) {
      thrillerBooks.assignAll(books);
    }
  }

  Future<void> fetchRomanceBooks() async {
    var books = await _bookApiService.getRomanceBooks();
    if (books != null) {
      romanceBooks.assignAll(books);
    }
  }

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) {
      return "Good Morning";
    } else if (hour < 18) {
      return "Good Afternoon";
    } else {
      return "Good Evening";
    }
  }

  @override
  void onInit() {
    fetchTrendingBooks();
    fetchForYouBooks();
    fetchFictionBooks();
    fetchSciFiBooks();
    fetchThrillerBooks();
    fetchRomanceBooks();
    fetchRecentArrivesBooks();
    super.onInit();

    Get.lazyPut(() => MyLibraryController());
    Get.lazyPut(() => ExploreController());
  }
}
