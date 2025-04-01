import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';

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
  }

  void openWebReader(String url) {
    Get.toNamed(RouterName.bookReaderScreenWrapper, arguments: {
      'bookUrl': url,
      'bookTitle': bookData['title'] ?? 'Book Reader',
      'bookDetails': bookData.value
    });
  }

  void setCategories(List<String> bookCategories) {
    categories = bookCategories;
    fetchBooksByCategory(bookCategories);
  }

  Future<void> fetchBookDetails(String title) async {
    try {
      isLoading.value = true;

      final bookDetails = await _bookApiService.getBookDetailsByTitle(title);

      if (bookDetails != null) {
        bookData.value = bookDetails;
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
      final books = await _bookApiService.getBooksByCategory(categories.first);

      if (books != null) {
        categoryBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch books by category: $e');
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void onInit() {
    super.onInit();
    if (Get.arguments != null) {
      if (Get.arguments['bookDetails'] != null) {
        // Use book details directly from arguments
        Map<String, dynamic> details = Get.arguments['bookDetails'];
        List<String>? cats;

        if (Get.arguments['categories'] != null) {
          cats = List<String>.from(Get.arguments['categories']);
        }

        setBookDetails(details, categoryList: cats);
      } else if (Get.arguments['bookTitle'] != null) {
        // Fallback to fetching by title if only title is provided
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
