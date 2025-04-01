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
}
