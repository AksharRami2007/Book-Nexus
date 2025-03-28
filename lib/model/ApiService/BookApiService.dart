import 'dart:math';
import 'package:dio/dio.dart';

class BookApiService {
  final Dio _dio = Dio();
  final int maxRetries = 3;
  final int maxBooks = 30;
  final String apiKey = 'AIzaSyAVkjmx50m8eN1Fo6rB53RQPP-qZw6TMog';
  final String baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  final String downloadUrl = '&download=epub';

  Future<Response?> _fetchWithRetry(String url, {int retries = 3}) async {
    for (int i = 0; i < retries; i++) {
      try {
        final response = await _dio.get(url);
        if (response.statusCode == 200) return response;
      } catch (e) {
        print('API Error (Attempt ${i + 1}): $e');
        await Future.delayed(Duration(seconds: 2 * pow(2, i).toInt()));
      }
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getTrendingBooks() async {
    final url =
        '$baseUrl?q=subject:thriller$downloadUrl&orderBy=newest&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      return _extractBookData(response.data['items']);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getRandomBooks({int count = 5}) async {
    final url =
        '$baseUrl?q=subject:fiction$downloadUrl&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      books.shuffle();
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getFictionBooks({int count = 5}) async {
    final url =
        '$baseUrl?q=subject:fiction$downloadUrl&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getSciFiBooks({int count = 5}) async {
    final url =
        '$baseUrl?q=subject:science_fiction$downloadUrl&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getThrillerBooks({int count = 5}) async {
    final url =
        '$baseUrl?q=subject:thriller$downloadUrl&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getRomanceBooks({int count = 5}) async {
    final url =
        '$baseUrl?q=subject:romance$downloadUrl&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<Map<String, dynamic>?> getBookDetailsByTitle(String title) async {
    try {
      final encodedTitle = Uri.encodeComponent(title);
      final url = '$baseUrl?q=intitle:$encodedTitle&key=$apiKey';
      final response = await _fetchWithRetry(url);

      if (response != null && response.data['items'] != null) {
        return _extractBookDetails(response.data['items'][0]);
      }
      return null;
    } catch (e) {
      print('Failed to fetch book details: $e');
      return null;
    }
  }

  Future<List<Map<String, dynamic>>?> getBooksByCategory(
      String category) async {
    try {
      final encodedCategory = Uri.encodeComponent(category);
      final url =
          '$baseUrl?q=subject:$encodedCategory$downloadUrl&orderBy=relevance&key=$apiKey';
      final response = await _fetchWithRetry(url);

      if (response != null && response.data['items'] != null) {
        return response.data['items'].map<Map<String, dynamic>>((item) {
          return _extractBookDetails(item);
        }).toList();
      }
      return null;
    } catch (e) {
      print('Failed to fetch books for category: $e');
      return null;
    }
  }

  List<Map<String, dynamic>> _extractBookData(List<dynamic> books) {
    return books
        .map((book) => _extractBookDetails(book))
        .take(maxBooks)
        .toList();
  }

  Map<String, dynamic> _extractBookDetails(Map<String, dynamic> book) {
    final volumeInfo = book['volumeInfo'] ?? {};
    final accessInfo = book['accessInfo'] as Map<String, dynamic>? ?? {};

    return {
      'id': book['id'],
      'title': volumeInfo['title'] ?? 'No title available',
      'subtitle': volumeInfo['subtitle'] ?? '',
      'authors': List<String>.from(volumeInfo['authors'] ?? []),
      'publisher': volumeInfo['publisher'] ?? 'Unknown publisher',
      'publishedDate': volumeInfo['publishedDate'] ?? 'Unknown date',
      'description': volumeInfo['description'] ?? 'No description available',
      'pageCount': volumeInfo['pageCount']?.toString() ?? '0',
      'categories': List<String>.from(volumeInfo['categories'] ?? []),
      'averageRating': volumeInfo['averageRating']?.toString() ?? 0.0,
      'ratingsCount': volumeInfo['ratingsCount'] ?? 0,
      'maturityRating': volumeInfo['maturityRating'] ?? 'Unknown',
      'language': volumeInfo['language'] ?? 'Unknown',
      'industryIdentifiers':
          (volumeInfo['industryIdentifiers'] as List<dynamic>?)
                  ?.map((id) => id['identifier'] as String)
                  .toList() ??
              [],
      'imageLinks': {
        'thumbnail': volumeInfo['imageLinks']?['thumbnail'] ?? '',
        'smallThumbnail': volumeInfo['imageLinks']?['smallThumbnail'] ?? '',
      },
      'previewLink': volumeInfo['previewLink'] ?? '',
      'infoLink': volumeInfo['infoLink'] ?? '',
      'canonicalVolumeLink': volumeInfo['canonicalVolumeLink'] ?? '',
      'accessInfo': {
        'country': accessInfo['country'] ?? 'Unknown',
        'viewability': accessInfo['viewability'] ?? 'Unknown',
        'embeddable': accessInfo['embeddable'] ?? false,
        'publicDomain': accessInfo['publicDomain'] ?? false,
        'textToSpeechPermission':
            accessInfo['textToSpeechPermission'] ?? 'Unknown',
        'webReaderLink': accessInfo['webReaderLink'] ?? '',
        'epubAvailable':
            (accessInfo['epub'] as Map<String, dynamic>?)?['isAvailable'] ??
                false,
        'pdfAvailable':
            (accessInfo['pdf'] as Map<String, dynamic>?)?['isAvailable'] ??
                false,
        'accessViewStatus': accessInfo['accessViewStatus'] ?? 'Unknown',
        'quoteSharingAllowed': accessInfo['quoteSharingAllowed'] ?? false,
      }
    };
  }

}
