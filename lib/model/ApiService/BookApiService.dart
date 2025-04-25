import 'dart:math';
import 'dart:convert';
import 'package:dio/dio.dart';

class BookApiService {
  final Dio _dio = Dio();
  final int maxRetries = 3;
  final int maxBooks = 300;
  final String apiKey = 'AIzaSyAVkjmx50m8eN1Fo6rB53RQPP-qZw6TMog';
  final String baseUrl = 'https://www.googleapis.com/books/v1/volumes';
  final String librivoxBaseUrl = 'https://librivox.org/api/feed/audiobooks';
  final String archiveBaseUrl = 'https://archive.org/advancedsearch.php';
  final String archiveDetailsUrl = 'https://archive.org/metadata/';

  // final String downloadUrl = '&download=epub';

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
    final url = '$baseUrl?q=subject:thriller&orderBy=newest&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      return _extractBookData(response.data['items']);
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getRecentArrivals({int count = 5}) async {
    final url = '$baseUrl?q=*&orderBy=newest&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getRandomBooks({int count = 5}) async {
    final url = '$baseUrl?q=subject:fiction&orderBy=relevance&key=$apiKey';
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
    final url = '$baseUrl?q=subject:fiction&orderBy=relevance&key=$apiKey';
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
        '$baseUrl?q=subject:science_fiction&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getThrillerBooks({int count = 5}) async {
    final url = '$baseUrl?q=subject:thriller&orderBy=relevance&key=$apiKey';
    final response = await _fetchWithRetry(url);

    if (response != null && response.data['items'] != null) {
      List<Map<String, dynamic>> books =
          _extractBookData(response.data['items']);
      return books.take(min(count, maxBooks)).toList();
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getRomanceBooks({int count = 5}) async {
    final url = '$baseUrl?q=subject:romance&orderBy=relevance&key=$apiKey';
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
      String queryCategory = category.toLowerCase();

      if (queryCategory == 'sci-fi') {
        queryCategory = 'science_fiction';
      } else if (queryCategory == 'for you') {
        return await getRandomBooks(count: 20);
      } else if (queryCategory == 'trending') {
        return await getTrendingBooks();
      }

      final encodedCategory = Uri.encodeComponent(queryCategory);
      final url =
          '$baseUrl?q=subject:$encodedCategory&orderBy=relevance&maxResults=20&key=$apiKey';

      print('Fetching books for category: $category with URL: $url');

      final response = await _fetchWithRetry(url);

      if (response != null && response.data['items'] != null) {
        print(
            'Found ${response.data['items'].length} books for category: $category');
        return response.data['items'].map<Map<String, dynamic>>((item) {
          return _extractBookDetails(item);
        }).toList();
      } else {
        print('No books found for category: $category');
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

  Future<Map<String, dynamic>?> searchLibrivoxByTitle(String title) async {
    try {
      final encodedTitle = Uri.encodeComponent(title);
      final url = '$librivoxBaseUrl?title=$encodedTitle&format=json';

      print('Searching LibriVox for title: $title with URL: $url');

      final response = await _fetchWithRetry(url);

      if (response != null && response.statusCode == 200) {
        final data = response.data;

        if (data is Map &&
            data.containsKey('books') &&
            data['books'] is List &&
            data['books'].isNotEmpty) {
          final books = data['books'] as List;

          final book = books.first;

          final Map<String, dynamic> audiobook = {
            'id': book['id']?.toString() ?? '',
            'title': book['title'] ?? 'Unknown Title',
            'authors': book['authors'] != null
                ? List<String>.from(book['authors']
                    .map((a) => a['first_name'] + ' ' + a['last_name']))
                : ['Unknown Author'],
            'url_librivox': book['url_librivox'] ?? '',
            'url_iarchive': book['url_iarchive'] ?? '',
            'url_text_source': book['url_text_source'] ?? '',
            'language': book['language'] ?? 'English',
            'description': book['description'] ?? 'No description available',
            'totaltime': book['totaltime'] ?? '',
            'totaltimesecs': book['totaltimesecs'] ?? 0,
            'sections': book['sections'] ?? []
          };

          if (book['sections'] is List && book['sections'].isNotEmpty) {
            final sections = book['sections'] as List;

            for (var section in sections) {
              if (section['listen_url'] != null &&
                  section['listen_url'].toString().isNotEmpty) {
                audiobook['audio_url'] = section['listen_url'];
                break;
              }
            }
          }

          if (!audiobook.containsKey('audio_url') &&
              book['url_iarchive'] != null) {
            final archiveId = book['url_iarchive'].toString().split('/').last;
            audiobook['audio_url'] =
                'https://archive.org/download/$archiveId/${archiveId}_64kb_mp3.zip';
          }

          print(
              'Found LibriVox audiobook: ${audiobook['title']} with audio URL: ${audiobook['audio_url']}');
          return audiobook;
        } else {
          print('No audiobooks found in LibriVox for title: $title');
        }
      } else {
        print('Failed to get response from LibriVox API for title: $title');
      }
      return null;
    } catch (e) {
      print('Error searching LibriVox: $e');
      return null;
    }
  }

  Future<Map<String, dynamic>?> searchArchiveByTitle(String title) async {
    try {
      final encodedTitle = Uri.encodeComponent(title);
      final query =
          'title:($encodedTitle) AND mediatype:(audio) AND format:(mp3)';
      final url =
          '$archiveBaseUrl?q=$query&output=json&rows=5&sort[]=downloads desc';

      print('Searching Internet Archive for title: $title with URL: $url');

      final response = await _fetchWithRetry(url);

      if (response != null && response.statusCode == 200) {
        final data = response.data;

        if (data is Map &&
            data.containsKey('response') &&
            data['response'] is Map &&
            data['response'].containsKey('docs') &&
            data['response']['docs'] is List &&
            data['response']['docs'].isNotEmpty) {
          final docs = data['response']['docs'] as List;
          final item = docs.first;

          final identifier = item['identifier'];

          final detailsUrl = '$archiveDetailsUrl/$identifier';
          final detailsResponse = await _fetchWithRetry(detailsUrl);

          if (detailsResponse != null && detailsResponse.statusCode == 200) {
            final details = detailsResponse.data;

            final Map<String, dynamic> audiobook = {
              'identifier': identifier,
              'title': item['title'] ?? 'Unknown Title',
              'creator': item['creator'] ?? ['Unknown Author'],
              'description': item['description'] ?? 'No description available',
              'date': item['date'] ?? '',
              'files': details['files'] ?? []
            };

            if (details['files'] is List) {
              final files = details['files'] as List;
              final mp3Files = files
                  .where((file) =>
                      file['name'].toString().toLowerCase().endsWith('.mp3'))
                  .toList();

              if (mp3Files.isNotEmpty) {
                mp3Files.sort((a, b) =>
                    a['name'].toString().compareTo(b['name'].toString()));

                final fileName = mp3Files.first['name'];
                audiobook['audio_url'] =
                    'https://archive.org/download/$identifier/$fileName';

                print(
                    'Found Internet Archive audiobook: ${audiobook['title']} with audio URL: ${audiobook['audio_url']}');
                return audiobook;
              }
            }
          }
        } else {
          print('No audiobooks found in Internet Archive for title: $title');
        }
      } else {
        print(
            'Failed to get response from Internet Archive API for title: $title');
      }
      return null;
    } catch (e) {
      print('Error searching Internet Archive: $e');
      return null;
    }
  }

  Future<String?> getArchiveAudioUrl(String title) async {
    try {
      final audiobook = await searchArchiveByTitle(title);

      if (audiobook != null && audiobook.containsKey('audio_url')) {
        return audiobook['audio_url'];
      }

      return null;
    } catch (e) {
      print('Error getting Internet Archive audio URL: $e');
      return null;
    }
  }

  Future<String?> getLibrivoxAudioUrl(String title) async {
    try {
      final audiobook = await searchLibrivoxByTitle(title);

      if (audiobook != null && audiobook.containsKey('audio_url')) {
        return audiobook['audio_url'];
      } else if (audiobook != null && audiobook.containsKey('url_iarchive')) {
        final archiveUrl = audiobook['url_iarchive'];
        if (archiveUrl != null && archiveUrl.isNotEmpty) {
          final archiveId = archiveUrl.toString().split('/').last;
          return 'https://archive.org/download/$archiveId/${archiveId}_64kb_mp3.zip';
        }
      }

      return null;
    } catch (e) {
      print('Error getting LibriVox audio URL: $e');
      return null;
    }
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
