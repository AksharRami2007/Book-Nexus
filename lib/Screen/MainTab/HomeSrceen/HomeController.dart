import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
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

  var savedBooks = <Map<String, dynamic>>[].obs;
  var favoriteBooks = <Map<String, dynamic>>[].obs;
  var readingHistory = <Map<String, dynamic>>[].obs;

  var isDataLoading = false.obs;

  final FirestoreBookService _firestoreBookService = FirestoreBookService();
  final BookApiService _bookApiService = BookApiService();

  void checkKeyboardVisibility(BuildContext context) {
    isKeyboardVisible.value = MediaQuery.of(context).viewInsets.bottom > 0;
  }

  void changeIndex(int index) {
    selectedIndex.value = index;
  }

  Future<void> fetchTrendingBooks() async {
    try {
      var books = await _bookApiService.getTrendingBooks();
      if (books != null) {
        trendingBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching trending books: $e');
    }
  }

  Future<void> fetchForYouBooks() async {
    try {
      var books = await _bookApiService.getRandomBooks();
      if (books != null) {
        forYouBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching for you books: $e');
    }
  }

  Future<void> fetchFictionBooks() async {
    try {
      var books = await _bookApiService.getFictionBooks();
      if (books != null) {
        fictionBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching fiction books: $e');
    }
  }

  Future<void> fetchSciFiBooks() async {
    try {
      var books = await _bookApiService.getSciFiBooks();
      if (books != null) {
        scifiBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching sci-fi books: $e');
    }
  }

  Future<void> fetchRomanceBooks() async {
    try {
      var books = await _bookApiService.getRomanceBooks();
      if (books != null) {
        romanceBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching romance books: $e');
    }
  }

  Future<bool> saveBook(Map<String, dynamic> bookData) async {
    try {
      return await _firestoreBookService.saveBook(bookData);
    } catch (e) {
      print('Error saving book: $e');
      return false;
    }
  }

  Future<bool> removeBook(String bookId) async {
    try {
      return await _firestoreBookService.removeBook(bookId);
    } catch (e) {
      print('Error removing book: $e');
      return false;
    }
  }

  Future<void> fetchSavedBooks() async {
    try {
      final books = await _firestoreBookService.getSavedBooks();
      if (books != null) {
        savedBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching saved books: $e');
    }
  }

  Future<bool> isBookSaved(String bookId) async {
    try {
      return await _firestoreBookService.isBookSaved(bookId);
    } catch (e) {
      print('Error checking if book is saved: $e');
      return false;
    }
  }

  Future<bool> addToFavorites(String bookId) async {
    try {
      return await _firestoreBookService.addToFavorites(bookId);
    } catch (e) {
      print('Error adding to favorites: $e');
      return false;
    }
  }

  Future<bool> removeFromFavorites(String bookId) async {
    try {
      return await _firestoreBookService.removeFromFavorites(bookId);
    } catch (e) {
      print('Error removing from favorites: $e');
      return false;
    }
  }

  Future<void> fetchFavoriteBooks() async {
    try {
      final books = await _firestoreBookService.getFavoriteBooks();
      if (books != null) {
        favoriteBooks.assignAll(books);
      }
    } catch (e) {
      print('Error fetching favorite books: $e');
    }
  }

  Future<bool> addToReadingHistory(String bookId, double progress) async {
    try {
      return await _firestoreBookService.addToReadingHistory(bookId, progress);
    } catch (e) {
      print('Error adding to reading history: $e');
      return false;
    }
  }

  Future<void> fetchReadingHistory() async {
    try {
      final books = await _firestoreBookService.getReadingHistory();
      if (books != null) {
        readingHistory.assignAll(books);
      }
    } catch (e) {
      print('Error fetching reading history: $e');
    }
  }

  var loadedCategories = <String>[].obs;

  Future<void> fetchEssentialBooks() async {
    try {
      isDataLoading.value = true;

      await fetchSavedBooks();
      await fetchFavoriteBooks();
      await fetchReadingHistory();

      await fetchTrendingBooks();
      loadedCategories.add('trending');

      await Future.delayed(Duration(seconds: 5));

      await fetchForYouBooks();
      loadedCategories.add('forYou');

      isDataLoading.value = false;
    } catch (e) {
      print('Error fetching essential books: $e');
      isDataLoading.value = false;
    }
  }

  Future<void> fetchAdditionalCategory(String category) async {
    if (loadedCategories.contains(category)) {
      return;
    }

    try {
      isDataLoading.value = true;

      switch (category) {
        case 'fiction':
          await fetchFictionBooks();
          break;
        case 'scifi':
          await fetchSciFiBooks();
          break;
        case 'romance':
          await fetchRomanceBooks();
          break;
        default:
          print('Unknown category: $category');
          isDataLoading.value = false;
          return;
      }

      loadedCategories.add(category);
      isDataLoading.value = false;
    } catch (e) {
      print('Error fetching $category books: $e');
      isDataLoading.value = false;
    }
  }

  bool isCategoryLoaded(String category) {
    return loadedCategories.contains(category);
  }

  String getGreeting() {
    int hour = DateTime.now().hour;
    if (hour < 12) return "Good Morning";
    if (hour < 18) return "Good Afternoon";
    return "Good Evening";
  }

  @override
  void onInit() {
    super.onInit();
    fetchEssentialBooks();
    Get.lazyPut(() => MyLibraryController());
    Get.lazyPut(() => ExploreController());
  }
}
