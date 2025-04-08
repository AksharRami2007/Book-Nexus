import 'dart:async';
import 'package:book_nexus/model/FirebaseService/FirestoreBookService.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';
import '../../Basecontroller/basecontroller.dart';

class BookReaderControllerBindings implements Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => BookReaderController());
  }
}

class BookReaderController extends BaseController {
  late final WebViewController webController;
  final hasLoadedBook = false.obs;

  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;

  final FirestoreBookService _bookService = FirestoreBookService();
  final currentProgress = 0.0.obs;
  String? currentBookId;
  Map<String, dynamic>? currentBookDetails;

  final readingStartTime = DateTime.now().obs;
  final readingDuration = 0.obs;
  final isTimerActive = false.obs;
  final isTimerDelayed = true.obs;
  Timer? _readingTimer;
  Timer? _delayTimer;

  @override
  void onInit() {
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (url) {
            isLoading.value = true;
            hasError.value = false;
          },
          onPageFinished: (url) {
            isLoading.value = false;
          },
          onWebResourceError: (error) {
            isLoading.value = false;
            hasError.value = true;
            errorMessage.value = 'Error: ${error.description}';
            print('WebView error: ${error.description}');
          },
        ),
      )
      ..setUserAgent(
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
      ..enableZoom(true);
  }

  void loadBook(String url, [Map<String, dynamic>? bookDetails]) {
    try {
      String secureUrl = url.startsWith('http://')
          ? url.replaceFirst('http://', 'https://')
          : url;

      print('Loading book URL: $secureUrl');

      if (bookDetails != null) {
        currentBookId = bookDetails['id'];
        currentBookDetails = bookDetails;
        _startReadingTimer();
      }

      webController.loadRequest(
        Uri.parse(secureUrl),
        headers: {
          'Referer': 'https://books.google.com/',
          'Origin': 'https://books.google.com',
        },
      );

      Future.delayed(const Duration(seconds: 5), () {
        webController.runJavaScript('''
          if (document.body.innerText.includes('not found') || 
              document.body.innerText.includes('error') || 
              document.body.innerText.includes('not available')) {
            window.flutter_inappwebview.callHandler('onError', document.body.innerText);
          }
        ''').catchError((e) {
          print('JavaScript error: $e');
        });
      });

      _trackReadingActivity();
    } catch (e) {
      print('Error loading book: $e');
      hasError.value = true;
      errorMessage.value = 'Error loading book: $e';
    }
  }

  void _startReadingTimer() {
    readingStartTime.value = DateTime.now();
    readingDuration.value = 0;
    isTimerActive.value = true;
    isTimerDelayed.value = true;

    _readingTimer?.cancel();
    _delayTimer?.cancel();

    _delayTimer = Timer(const Duration(minutes: 1), () {
      isTimerDelayed.value = false;
      readingStartTime.value = DateTime.now();

      _readingTimer = Timer.periodic(const Duration(minutes: 1), (_) {
        if (isTimerActive.value && !isTimerDelayed.value) {
          readingDuration.value++;
          print('Reading duration: ${readingDuration.value} mins');
        }
      });
    });
  }

  void _stopReadingTimer() {
    isTimerActive.value = false;
    _readingTimer?.cancel();
    _delayTimer?.cancel();

    if (currentBookId != null && readingDuration.value > 0) {
      _updateReadingHistory();
    }
  }

  void _trackReadingActivity() {
    if (currentBookId != null) {
      currentProgress.value = 0.0;
      _bookService.addToReadingHistory(currentBookId!, currentProgress.value);
      if (currentBookDetails != null) {
        _bookService.addReadingHistoryEntry(
          currentBookId!,
          currentBookDetails!['title'] ?? '',
          currentBookDetails!['imageLinks']?['thumbnail'] ?? '',
          0.0,
          0,
        );
      }
    }
  }

  void _updateReadingProgress() {
    if (currentBookId != null) {
      _bookService.addToReadingHistory(currentBookId!, currentProgress.value);
    }
  }

  void _updateReadingHistory() {
    if (currentBookId != null && currentBookDetails != null) {
      _bookService.addReadingHistoryEntry(
        currentBookId!,
        currentBookDetails!['title'] ?? '',
        currentBookDetails!['imageLinks']?['thumbnail'] ?? '',
        1.0,
        readingDuration.value,
      );
    }
  }

  @override
  void onClose() {
    _stopReadingTimer();
    if (currentBookId != null) {
      currentProgress.value = 1.0;
      _updateReadingProgress();
    }
    super.onClose();
  }
}
