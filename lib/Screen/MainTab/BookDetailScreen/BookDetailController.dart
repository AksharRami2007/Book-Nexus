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

  void setBookTitle(String title, {List<String>? categoryList}) {
    bookTitle = title;
    categories = categoryList;
    fetchBookDetails(title);

    print("Fetching similar books for categories: $categories");

    if (categories != null && categories!.isNotEmpty) {
      fetchBooksByCategory(categoryList);
    }
  }

  void openWebReader(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      print("Could not open the link.");
    }
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
      if (Get.arguments['bookTitle'] != null) {
        setBookTitle(Get.arguments['bookTitle']);
      }
      if (Get.arguments['categories'] != null) {
        setCategories(List<String>.from(Get.arguments['categories']));
      }
    }
  }
}
