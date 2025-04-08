import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:book_nexus/model/FirebaseService/FirebaseAuthService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
import 'package:get/get.dart';

// Category constants
const String CATEGORY_ALL = "All Books";
const String CATEGORY_SAVED = "Saved books";
const String CATEGORY_IN_PROGRESS = "In Progress";
const String CATEGORY_COMPLETED = "Completed";

class MylibrarycontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => MyLibraryController());
  }
}

class MyLibraryController extends BaseController {
  var library = <Map<String, dynamic>>[].obs;
  var savedBooks = <Map<String, dynamic>>[].obs;
  var favorites = <Map<String, dynamic>>[].obs;
  var readingHistory = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var selectedCategory = CATEGORY_ALL.obs;

  final FirestoreBookService _firestoreBookService = FirestoreBookService();
  final BookApiService _bookApiService = BookApiService();
  final FirebaseAuthService _authService = FirebaseAuthService();

  Future<void> fetchlibrary() async {
    try {
      isLoading.value = true;

      // Get random books directly from API
      var apiBooks = await _bookApiService.getRandomBooks();
      if (apiBooks != null) {
        library.assignAll(apiBooks);
      }

      // Fetch user-specific data if user is logged in
      if (_authService.currentUser != null) {
        await fetchSavedBooks();
        await fetchFavorites();
        await fetchReadingHistory();
      }

      // Apply initial category filter
      filterBooksByCategory(selectedCategory.value);
    } catch (e) {
      print('Failed to fetch library: $e');
    } finally {
      isLoading.value = false;
    }
  }

  // Filter books based on selected category
  void filterBooksByCategory(String category) {
    selectedCategory.value = category;

    switch (category) {
      case CATEGORY_SAVED:
        if (savedBooks.isNotEmpty) {
          library.assignAll(savedBooks);
        } else {
          library.clear();
        }
        break;
      case CATEGORY_IN_PROGRESS:
        // Filter reading history for books with progress > 0 and < 1.0
        var inProgressBooks = <Map<String, dynamic>>[];
        for (var entry in readingHistory) {
          if (entry.containsKey('progress') &&
              entry['progress'] > 0.0 &&
              entry['progress'] < 1.0) {
            inProgressBooks.add(entry);
          }
        }
        library.assignAll(inProgressBooks);
        break;
      case CATEGORY_COMPLETED:
        // Filter reading history for books with progress = 1.0
        var completedBooks = <Map<String, dynamic>>[];
        for (var entry in readingHistory) {
          if (entry.containsKey('progress') && entry['progress'] == 1.0) {
            completedBooks.add(entry);
          }
        }
        library.assignAll(completedBooks);
        break;
      case CATEGORY_ALL:
      default:
        // Fetch all books if library is empty
        if (library.isEmpty) {
          fetchlibrary();
        }
        break;
    }
  }

  Future<void> fetchSavedBooks() async {
    try {
      if (_authService.currentUser != null) {
        var userSavedBooks = await _firestoreBookService.getSavedBooks();
        if (userSavedBooks != null) {
          savedBooks.assignAll(userSavedBooks);
        }
      }
    } catch (e) {
      print('Failed to fetch saved books: $e');
    }
  }

  Future<void> fetchFavorites() async {
    try {
      if (_authService.currentUser != null) {
        var userFavorites = await _firestoreBookService.getFavoriteBooks();
        if (userFavorites != null) {
          favorites.assignAll(userFavorites);
        }
      }
    } catch (e) {
      print('Failed to fetch favorites: $e');
    }
  }

  Future<void> fetchReadingHistory() async {
    try {
      if (_authService.currentUser != null) {
        var history = await _firestoreBookService.getReadingHistory();
        if (history != null) {
          readingHistory.assignAll(history);
        }
      }
    } catch (e) {
      print('Failed to fetch reading history: $e');
    }
  }

  Future<bool> saveBook(Map<String, dynamic> bookData) async {
    try {
      if (_authService.currentUser != null) {
        bool result = await _firestoreBookService
            .saveBook(Map<String, dynamic>.from(bookData));
        if (result) {
          await fetchSavedBooks();
        }
        return result;
      } else {
        Get.snackbar('Sign In Required', 'Please sign in to save books');
        return false;
      }
    } catch (e) {
      print('Failed to save book: $e');
      return false;
    }
  }

  Future<bool> removeBook(String bookId) async {
    try {
      if (_authService.currentUser != null) {
        bool result = await _firestoreBookService.removeBook(bookId);
        if (result) {
          await fetchSavedBooks();
        }
        return result;
      }
      return false;
    } catch (e) {
      print('Failed to remove book: $e');
      return false;
    }
  }

  Future<void> addToFavorites(String bookId) async {
    try {
      if (_authService.currentUser != null) {
        await _firestoreBookService.addToFavorites(bookId);
        await fetchFavorites();
      } else {
        Get.snackbar('Sign In Required', 'Please sign in to add favorites');
      }
    } catch (e) {
      print('Failed to add to favorites: $e');
    }
  }

  Future<void> removeFromFavorites(String bookId) async {
    try {
      if (_authService.currentUser != null) {
        await _firestoreBookService.removeFromFavorites(bookId);
        await fetchFavorites();
      }
    } catch (e) {
      print('Failed to remove from favorites: $e');
    }
  }

  Future<bool> addToReadingHistory(String bookId, double progress) async {
    try {
      if (_authService.currentUser != null) {
        bool result =
            await _firestoreBookService.addToReadingHistory(bookId, progress);
        if (result) {
          await fetchReadingHistory();
        }
        return result;
      } else {
        Get.snackbar(
            'Sign In Required', 'Please sign in to track reading progress');
        return false;
      }
    } catch (e) {
      print('Failed to add to reading history: $e');
      return false;
    }
  }

  bool isBookSaved(String bookId) {
    return savedBooks.any((book) => book['id'] == bookId);
  }

  bool isBookInFavorites(String bookId) {
    return favorites.any((book) => book['id'] == bookId);
  }

  @override
  void onInit() {
    super.onInit();
    fetchlibrary();
  }
}
