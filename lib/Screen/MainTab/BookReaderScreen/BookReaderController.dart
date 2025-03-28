import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

import '../../Basecontroller/basecontroller.dart';

class BookReaderControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookReaderController());
  }
}

class BookReaderController extends BaseController {
  // late WebViewController webViewController;
  var bookUrl = ''.obs;

  @override
  void onInit() {
    super.onInit();
    // webViewController = WebViewController()
    //   ..setJavaScriptMode(JavaScriptMode.unrestricted);
  }

  Future<void> searchAndLoadBook(String bookTitle) async {
    try {
      final String apiUrl = "https://gutendex.com/books/?search=$bookTitle"; // Gutenberg API
      final response = await http.get(Uri.parse(apiUrl));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);

        if (data['results'].isNotEmpty) {
          var book = data['results'][0];

          String? readableUrl = book['formats']['text/html'];

          readableUrl ??= book['formats']['text/plain'];

          if (readableUrl != null) {
            bookUrl.value = readableUrl;
            // webViewController.loadRequest(Uri.parse(readableUrl));
          } else {
            Get.snackbar("Error", "No readable format found for this book.");
          }
        } else {
          Get.snackbar("Error", "Book not found.");
        }
      } else {
        Get.snackbar("Error", "Failed to fetch book data.");
      }
    } catch (e) {
      Get.snackbar("Error", "An error occurred while searching for the book.");
    }
  }
}
