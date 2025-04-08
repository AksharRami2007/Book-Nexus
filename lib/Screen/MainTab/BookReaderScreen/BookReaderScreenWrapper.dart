import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../Basecontroller/basecontroller.dart';
import 'BookReaderController.dart';

class BookReaderScreenWrapper extends BaseView<BookReaderController> {
  const BookReaderScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    final Map<String, dynamic> args = Get.arguments ?? {};
    final String bookUrl = args['bookUrl'] ?? '';
    final String bookTitle = args['bookTitle'] ?? 'Book Reader';
    final Map<String, dynamic> bookDetails = args['bookDetails'] ?? {};

    if (bookUrl.isNotEmpty) {
      controller.loadBook(bookUrl, bookDetails);
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(bookTitle),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            // Add debounce to prevent multiple navigation actions
            if (!Get.isSnackbarOpen) {
              Get.back();
            }
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: () {
              if (bookUrl.isNotEmpty) {
                controller.loadBook(bookUrl, bookDetails);
              }
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.hasError.value) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.error_outline, size: 48, color: Colors.red),
                const SizedBox(height: 16),
                Text(
                  controller.errorMessage.value,
                  textAlign: TextAlign.center,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 24),
                ElevatedButton(
                  onPressed: () {
                    if (bookUrl.isNotEmpty) {
                      controller.loadBook(bookUrl, bookDetails);
                    }
                  },
                  child: const Text('Try Again'),
                ),
              ],
            ),
          );
        }

        return Stack(
          children: [
            WebViewWidget(
              controller: controller.webController,
            ),
            if (controller.isLoading.value)
              Container(
                color: Colors.black.withOpacity(0.5),
                child: const Center(
                  child: CircularProgressIndicator(),
                ),
              ),
          ],
        );
      }),
    );
  }
}
