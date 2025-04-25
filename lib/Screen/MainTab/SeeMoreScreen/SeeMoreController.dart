import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
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

  var savedBooks = <Map<String, dynamic>>[].obs;

  final FirestoreBookService _firestoreBookService = FirestoreBookService();
  final BookApiService _bookApiService = BookApiService();

  void setCategory(String categoryName) {
    category.value = categoryName;
    fetchBooksByCategory(categoryName);
  }

  Future<void> fetchBooksByCategory(String categoryName) async {
    try {
      isLoading.value = true;

      var apiBooks = await _bookApiService.getBooksByCategory(categoryName);

      if (apiBooks != null) {
        books.assignAll(apiBooks);

        await checkSavedBooks();
      }
    } catch (e) {
      print('Failed to fetch books for category $categoryName: $e');
    } finally {
      isLoading.value = false;
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

  Future<void> checkSavedBooks() async {
    try {
      await fetchSavedBooks();

    } catch (e) {
      print('Error checking saved books: $e');
    }
  }

  Future<bool> saveBook(Map<String, dynamic> bookData) async {
    try {
      bool result = await _firestoreBookService.saveBook(Map<String, dynamic>.from(bookData));
      if (result) {
        await fetchSavedBooks();
      }
      return result;
    } catch (e) {
      print('Error saving book: $e');
      return false;
    }
  }

  Future<bool> removeBook(String bookId) async {
    try {
      bool result = await _firestoreBookService.removeBook(bookId);
      if (result) {
        await fetchSavedBooks();
      }
      return result;
    } catch (e) {
      print('Error removing book: $e');
      return false;
    }
  }

  bool isBookSaved(String bookId) {
    return savedBooks.any((book) => book['id'] == bookId);
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['category'] != null) {
      setCategory(Get.arguments['category']);
    }

    fetchSavedBooks();
  }
}
