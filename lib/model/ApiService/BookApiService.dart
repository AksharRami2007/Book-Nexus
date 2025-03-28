import 'dart:math';

import 'package:book_nexus/model/GenreList/BookGenreList.dart';
import 'package:dio/dio.dart';

class BookApiService {
  final Dio _dio = Dio();
  final List<String> subjects = BookGenreList.genre;

  Future<List<Map<String, dynamic>>?> getTrendingBooks() async {
    try {
      final response = await _dio.get(
        'https://openlibrary.org/trending/daily.json',
      );

      if (response.statusCode == 200 && response.data['works'] != null) {
        List<Map<String, dynamic>> books =
            List<Map<String, dynamic>>.from(response.data['works']);

        books = books.where((book) {
          return (book['has_fulltext'] == true) || (book.containsKey('ia'));
        }).toList();

        return books;
      }
    } catch (e) {
      print('Open Library API Error: $e');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getRandomBooks({int count = 5}) async {
    try {
      final response =
          await _dio.get('https://openlibrary.org/trending/daily.json');

      if (response.statusCode == 200 && response.data['works'] != null) {
        List<Map<String, dynamic>> books =
            List<Map<String, dynamic>>.from(response.data['works']);

        books.shuffle();
        books = books.take(count).toList();

        return books;
      }
    } catch (e) {
      print('Open Library API Error: $e');
    }
    return null;
  }

  Future<List<Map<String, dynamic>>?> getPopularBooks({int count = 5}) async {
    try {
      final response =
          await _dio.get('https://openlibrary.org/trending/most-borrowed.json');

      if (response.statusCode == 200 && response.data['works'] != null) {
        List<Map<String, dynamic>> books =
            List<Map<String, dynamic>>.from(response.data['works']);

        books.shuffle();
        books = books.take(count).toList();

        return books;
      }
    } catch (e) {
      print('Open Library API Error: $e');
    }
    return null;
  }

}
