import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
import 'package:get/get.dart';

class BookdetailcontrollerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookDetailController());
  }
}

class BookDetailController extends BaseController {
  var bookData = {}.obs;
  var categoryBooks = <Map<String, dynamic>>[].obs;
  var isLoading = true.obs;
  var isBookSaved = false.obs;
   final showFullDescription = false.obs;

 void toggleDescription() {
    showFullDescription.value = !showFullDescription.value;
  }

  final FirestoreBookService _firestoreBookService = FirestoreBookService();
  final BookApiService _bookApiService = BookApiService();

  String? bookTitle;
  List<String>? categories;

  void setBookDetails(Map<String, dynamic> details,
      {List<String>? categoryList}) {
    bookData.value = details;
    bookTitle = details['title'];
    categories = categoryList;

    if (categories != null && categories!.isNotEmpty) {
      fetchBooksByCategory(categories);
    }

    checkIfBookIsSaved();
  }

  void openWebReader(String url) {
    Get.toNamed(RouterName.bookReaderScreenWrapper, arguments: {
      'bookUrl': url,
      'bookTitle': bookData['title'] ?? 'Book Reader',
      'bookDetails': bookData.value
    });
  }

  void openAudioPlayer() {
    Get.toNamed(RouterName.audioPlayerScreen, arguments: {
      'bookTitle': bookData['title'] ?? 'Audio Book',
      'bookDetails': bookData.value,
      'authors': bookData['authors'] != null
          ? bookData['authors'].join(', ')
          : 'Unknown Author',
      'coverImage': bookData['imageLinks']?['thumbnail']
    });
  }

  void setCategories(List<String> bookCategories) {
    categories = bookCategories;
    fetchBooksByCategory(bookCategories);
  }

  Future<void> fetchBookDetails(String title) async {
    try {
      isLoading.value = true;

      final apiBookDetails = await _bookApiService.getBookDetailsByTitle(title);

      if (apiBookDetails != null) {
        bookData.value = apiBookDetails;
        checkIfBookIsSaved();
      } else {
        print('Error: Book details not found for title: $title');
      }
    } catch (e) {
      print('Failed to fetch book details: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> fetchBooksByCategory(List<String>? categories) async {
    if (categories == null || categories.isEmpty) return;

    try {
      isLoading.value = true;

      final apiBooks =
          await _bookApiService.getBooksByCategory(categories.first);

      if (apiBooks != null) {
        categoryBooks.assignAll(apiBooks);
      }
    } catch (e) {
      print('Failed to fetch books by category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> checkIfBookIsSaved() async {
    try {
      if (bookData.isEmpty || bookData['id'] == null) return;

      String bookId = bookData['id'].toString();
      isBookSaved.value = await _firestoreBookService.isBookSaved(bookId);
    } catch (e) {
      print('Error checking if book is saved: $e');
      isBookSaved.value = false;
    }
  }

  Future<bool> saveBook() async {
    try {
      if (bookData.isEmpty) return false;

      bool result = await _firestoreBookService
          .saveBook(Map<String, dynamic>.from(bookData.value));
      if (result) {
        isBookSaved.value = true;
      }
      return result;
    } catch (e) {
      print('Error saving book: $e');
      return false;
    }
  }

  Future<bool> removeBook() async {
    try {
      if (bookData.isEmpty || bookData['id'] == null) return false;

      String bookId = bookData['id'].toString();
      bool result = await _firestoreBookService.removeBook(bookId);
      if (result) {
        isBookSaved.value = false;
      }
      return result;
    } catch (e) {
      print('Error removing book: $e');
      return false;
    }
  }

  Future<bool> toggleSaveStatus() async {
    return isBookSaved.value ? await removeBook() : await saveBook();
  }

  Future<bool> addToReadingHistory(double progress) async {
    try {
      if (bookData.isEmpty || bookData['id'] == null) return false;

      String bookId = bookData['id'].toString();
      return await _firestoreBookService.addToReadingHistory(bookId, progress);
    } catch (e) {
      print('Error adding to reading history: $e');
      return false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['bookDetails'] != null) {
        Map<String, dynamic> details = Get.arguments['bookDetails'];
        List<String>? cats;

        if (Get.arguments['categories'] != null) {
          cats = List<String>.from(Get.arguments['categories']);
        }

        setBookDetails(details, categoryList: cats);
      } else if (Get.arguments['bookTitle'] != null) {
        String title = Get.arguments['bookTitle'];
        List<String>? cats;

        if (Get.arguments['categories'] != null) {
          cats = List<String>.from(Get.arguments['categories']);
        }

        fetchBookDetails(title);
        bookTitle = title;
        categories = cats;

        if (categories != null && categories!.isNotEmpty) {
          fetchBooksByCategory(categories);
        }
      }
    }
  }
}
