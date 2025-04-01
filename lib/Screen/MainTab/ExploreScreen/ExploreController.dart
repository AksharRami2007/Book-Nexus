import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/model/ApiService/BookApiService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ExploreControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => ExploreController());
  }
}

class ExploreController extends BaseController {
  var isLoading = true.obs;
  var searchQuery = ''.obs;
  var selectedTopicIndex = 0.obs;

  var fictionBooks = <Map<String, dynamic>>[].obs;
  var cultureBooks = <Map<String, dynamic>>[].obs;
  var lifestyleBooks = <Map<String, dynamic>>[].obs;
  var romanceBooks = <Map<String, dynamic>>[].obs;
  var scifiBooks = <Map<String, dynamic>>[].obs;
  var thrillerBooks = <Map<String, dynamic>>[].obs;

  var _allFictionBooks = <Map<String, dynamic>>[];
  var _allCultureBooks = <Map<String, dynamic>>[];
  var _allLifestyleBooks = <Map<String, dynamic>>[];
  var _allRomanceBooks = <Map<String, dynamic>>[];
  var _allScifiBooks = <Map<String, dynamic>>[];
  var _allThrillerBooks = <Map<String, dynamic>>[];

  final List<String> topics = [
    'All',
    'Recent arrivals',
    'Culture & books',
    'Biography',
    'Education',
  ].obs;

  final BookApiService _bookApiService = BookApiService();
  final TextEditingController searchController = TextEditingController();

  void setSearchQuery(String query) {
    searchQuery.value = query;
    _applyFilters();
  }

  void selectTopic(int index) {
    selectedTopicIndex.value = index;
    _applyFilters();
  }

  void _applyFilters() {
    final query = searchQuery.value.toLowerCase();
    final topicIndex = selectedTopicIndex.value;

    _filterBooksBySearch(_allFictionBooks, fictionBooks, query);
    _filterBooksBySearch(_allCultureBooks, cultureBooks, query);
    _filterBooksBySearch(_allLifestyleBooks, lifestyleBooks, query);
    _filterBooksBySearch(_allRomanceBooks, romanceBooks, query);
    _filterBooksBySearch(_allScifiBooks, scifiBooks, query);
    _filterBooksBySearch(_allThrillerBooks, thrillerBooks, query);

    if (topicIndex > 0) {
      final topic = topics[topicIndex].toLowerCase();
      _filterBooksByTopic(fictionBooks, topic);
      _filterBooksByTopic(cultureBooks, topic);
      _filterBooksByTopic(lifestyleBooks, topic);
      _filterBooksByTopic(romanceBooks, topic);
      _filterBooksByTopic(scifiBooks, topic);
      _filterBooksByTopic(thrillerBooks, topic);
    }
  }

  void _filterBooksBySearch(List<Map<String, dynamic>> source,
      RxList<Map<String, dynamic>> target, String query) {
    if (query.isEmpty) {
      target.assignAll(source);
      return;
    }

    final filteredBooks = source.where((book) {
      final title = (book['title'] ?? '').toString().toLowerCase();
      final authors = (book['authors'] as List?)?.join(' ').toLowerCase() ?? '';
      final description = (book['description'] ?? '').toString().toLowerCase();

      return title.contains(query) ||
          authors.contains(query) ||
          description.contains(query);
    }).toList();

    target.assignAll(filteredBooks);
  }

  void _filterBooksByTopic(RxList<Map<String, dynamic>> books, String topic) {
    final currentBooks = books.toList();
    final filteredBooks = currentBooks.where((book) {
      final categories = (book['categories'] as List?)
              ?.map((c) => c.toString().toLowerCase())
              .toList() ??
          [];
      return categories.any((category) => category.contains(topic));
    }).toList();

    books.assignAll(filteredBooks);
  }

  Future<void> fetchFictionBooks() async {
    try {
      var books = await _bookApiService.getFictionBooks(count: 10);
      if (books != null) {
        _allFictionBooks = books;
        fictionBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch fiction books: $e');
    }
  }

  Future<void> fetchCultureBooks() async {
    try {
      var books = await _bookApiService.getBooksByCategory('culture');
      if (books != null) {
        _allCultureBooks = books;
        cultureBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch culture books: $e');
    }
  }

  Future<void> fetchLifestyleBooks() async {
    try {
      var books = await _bookApiService.getBooksByCategory('lifestyle');
      if (books != null) {
        _allLifestyleBooks = books;
        lifestyleBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch lifestyle books: $e');
    }
  }

  Future<void> fetchRomanceBooks() async {
    try {
      var books = await _bookApiService.getRomanceBooks(count: 10);
      if (books != null) {
        _allRomanceBooks = books;
        romanceBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch romance books: $e');
    }
  }

  Future<void> fetchSciFiBooks() async {
    try {
      var books = await _bookApiService.getSciFiBooks(count: 10);
      if (books != null) {
        _allScifiBooks = books;
        scifiBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch sci-fi books: $e');
    }
  }

  Future<void> fetchThrillerBooks() async {
    try {
      var books = await _bookApiService.getThrillerBooks(count: 10);
      if (books != null) {
        _allThrillerBooks = books;
        thrillerBooks.assignAll(books);
      }
    } catch (e) {
      print('Failed to fetch thriller books: $e');
    }
  }

  Future<void> fetchAllBooks() async {
    isLoading.value = true;
    await Future.wait([
      fetchFictionBooks(),
      fetchCultureBooks(),
      fetchLifestyleBooks(),
      fetchRomanceBooks(),
      fetchSciFiBooks(),
      fetchThrillerBooks(),
    ]);
    isLoading.value = false;
  }

  @override
  void onInit() {
    super.onInit();
    fetchAllBooks();
  }

  @override
  void onClose() {
    searchController.dispose();
    super.onClose();
  }
}
