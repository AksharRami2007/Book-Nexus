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
  final isLoading = true.obs;
  final hasError = false.obs;
  final errorMessage = ''.obs;
<<<<<<< Updated upstream
  final FirestoreBookService _bookService = FirestoreBookService();
  final currentProgress = 0.0.obs;
  String? currentBookId;
  Map<String, dynamic>? currentBookDetails;
  
  // Reading timer variables
  final readingStartTime = DateTime.now().obs;
  final readingDuration = 0.obs; // Duration in minutes
  final isTimerActive = false.obs;
  final isTimerDelayed = true.obs; // 1-minute delay flag
  Timer? _readingTimer;
  Timer? _delayTimer;
=======
>>>>>>> Stashed changes

  @override
  void onInit() {
    super.onInit();
    webController = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            isLoading.value = true;
            hasError.value = false;
          },
          onPageFinished: (String url) {
            isLoading.value = false;
          },
          onWebResourceError: (WebResourceError error) {
            isLoading.value = false;
            hasError.value = true;
            errorMessage.value = 'Error: ${error.description}';
            print('WebView error: ${error.description}');
          },
          onNavigationRequest: (NavigationRequest request) {
            // Allow all navigation requests
            return NavigationDecision.navigate;
          },
        ),
      )
      ..setUserAgent(
          'Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/91.0.4472.124 Safari/537.36')
      ..enableZoom(true);
  }

  void loadBook(String url, [Map<String, dynamic>? bookDetails]) {
    try {
      // Ensure URL uses HTTPS
      String secureUrl = url;
      if (url.startsWith('http://')) {
        secureUrl = url.replaceFirst('http://', 'https://');
      }

      print('Loading book URL: $secureUrl');
      if (bookDetails != null) {
        print('Book details: ${bookDetails['title']}');
<<<<<<< Updated upstream
        currentBookId = bookDetails['id'];
        currentBookDetails = bookDetails;

        // Start reading timer and track activity
        _startReadingTimer();
=======
>>>>>>> Stashed changes
      }

      // Add additional headers for Google Books
      webController.loadRequest(
        Uri.parse(secureUrl),
        headers: {
          'Referer': 'https://books.google.com/',
          'Origin': 'https://books.google.com'
        },
      );

      // Execute JavaScript to check if the page loaded correctly
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
    } catch (e) {
      print('Error loading book URL: $e');
      hasError.value = true;
      errorMessage.value = 'Error loading book: $e';
    }
  }
  
  // Start the reading timer with a 1-minute delay
  void _startReadingTimer() {
    // Reset timer state
    readingStartTime.value = DateTime.now();
    readingDuration.value = 0;
    isTimerActive.value = true;
    isTimerDelayed.value = true;
    
    // Cancel any existing timers
    _readingTimer?.cancel();
    _delayTimer?.cancel();
    
    // Start a 1-minute delay before counting reading time
    _delayTimer = Timer(const Duration(minutes: 1), () {
      isTimerDelayed.value = false;
      readingStartTime.value = DateTime.now(); // Reset start time after delay
      
      // Start the actual reading timer
      _readingTimer = Timer.periodic(const Duration(minutes: 1), (timer) {
        if (isTimerActive.value && !isTimerDelayed.value) {
          readingDuration.value++;
          print('Reading duration: ${readingDuration.value} minutes');
        }
      });
    });
    
    // Track initial reading activity
    _trackReadingActivity();
  }
  
  // Stop the reading timer and update reading history
  void _stopReadingTimer() {
    isTimerActive.value = false;
    _readingTimer?.cancel();
    _delayTimer?.cancel();
    
    // Update reading history with final duration
    if (currentBookId != null && readingDuration.value > 0) {
      _updateReadingHistory();
    }
  }

  // Track reading activity
  void _trackReadingActivity() {
    if (currentBookId != null) {
      // Default to 0.0 progress when starting to read
      currentProgress.value = 0.0;

      // Add to reading history
      _bookService
          .addToReadingHistory(currentBookId!, currentProgress.value)
          .then((success) {
        if (success) {
          print('Reading activity tracked successfully');
        } else {
          print('Failed to track reading activity');
        }
      });
      
      // Also add a reading history entry with duration
      if (currentBookDetails != null) {
        _bookService.addReadingHistoryEntry(
          currentBookId!,
          currentBookDetails!['title'] ?? '',
          currentBookDetails!['imageLinks']?['thumbnail'] ?? '',
          0.0, // Starting progress
          0, // Initial duration
        );
      }
    }
  }

  // Update reading progress and duration
  void _updateReadingProgress() {
    if (currentBookId != null) {
      _bookService
          .addToReadingHistory(currentBookId!, currentProgress.value)
          .then((success) {
        if (success) {
          print('Reading progress updated successfully');
        } else {
          print('Failed to update reading progress');
        }
      });
    }
  }
  
  // Update reading history with duration
  void _updateReadingHistory() {
    if (currentBookId != null && currentBookDetails != null) {
      _bookService.addReadingHistoryEntry(
        currentBookId!,
        currentBookDetails!['title'] ?? '',
        currentBookDetails!['imageLinks']?['thumbnail'] ?? '',
        1.0, // Completed
        readingDuration.value,
      ).then((success) {
        if (success) {
          print('Reading history with duration updated successfully');
        } else {
          print('Failed to update reading history with duration');
        }
      });
    }
  }

  @override
  void onClose() {
    // Stop timer and update reading history when reader is closed
    _stopReadingTimer();
    
    // Final update of reading progress
    if (currentBookId != null) {
      currentProgress.value = 1.0; // Simplified - assume finished when closing
      _updateReadingProgress();
    }
    super.onClose();
  }
}