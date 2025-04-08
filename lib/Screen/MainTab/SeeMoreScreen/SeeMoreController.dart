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
  
  // User-specific book lists
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

      // Get books by category from API directly
      var apiBooks = await _bookApiService.getBooksByCategory(categoryName);

      if (apiBooks != null) {
        books.assignAll(apiBooks);
        
        // Check which books are saved
        await checkSavedBooks();
      }
    } catch (e) {
      print('Failed to fetch books for category $categoryName: $e');
    } finally {
      isLoading.value = false;
    }
  }
  
  // Firebase user-specific methods
  
  // Fetch user's saved books
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
  
  // Check which books in the current list are saved
  Future<void> checkSavedBooks() async {
    try {
      await fetchSavedBooks();
      
      // No need to update UI here, just having the saved books list is enough
      // The UI can check if a book is in the savedBooks list
    } catch (e) {
      print('Error checking saved books: $e');
    }
  }
  
  // Save a book to Firebase
  Future<bool> saveBook(Map<String, dynamic> bookData) async {
    try {
      bool result = await _firestoreBookService.saveBook(Map<String, dynamic>.from(bookData));
      if (result) {
        // Refresh saved books list
        await fetchSavedBooks();
      }
      return result;
    } catch (e) {
      print('Error saving book: $e');
      return false;
    }
  }
  
  // Remove a book from saved books
  Future<bool> removeBook(String bookId) async {
    try {
      bool result = await _firestoreBookService.removeBook(bookId);
      if (result) {
        // Refresh saved books list
        await fetchSavedBooks();
      }
      return result;
    } catch (e) {
      print('Error removing book: $e');
      return false;
    }
  }
  
  // Check if a book is saved
  bool isBookSaved(String bookId) {
    return savedBooks.any((book) => book['id'] == bookId);
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null && Get.arguments['category'] != null) {
      setCategory(Get.arguments['category']);
    }
    
    // Fetch saved books on init
    fetchSavedBooks();
  }
}