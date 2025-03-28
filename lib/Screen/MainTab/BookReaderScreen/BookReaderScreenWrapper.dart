import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:webview_flutter/webview_flutter.dart';

import '../../Basecontroller/basecontroller.dart';
import 'BookReaderController.dart';

class BookReaderScreenWrapper extends BaseView<BookReaderController> {
  final String bookTitle;
  const BookReaderScreenWrapper({super.key, required this.bookTitle});

  @override
  Widget vBuilder(BuildContext context) {
    controller.searchAndLoadBook(bookTitle);

    return Scaffold(
      appBar: AppBar(title: Text(bookTitle)),
      body: Obx(() {
        if (controller.bookUrl.value.isEmpty) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return SizedBox();
          // return WebViewWidget(controller: controller.webViewController);
        }
      }),
    );
  }
}
