import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../../Basecontroller/basecontroller.dart';
import '../../MainTab/MyLibraryScreen/MyLibraryController.dart';
import '../../MainTab/MyLibraryScreen/MyLibraryScreenWrapper.dart';
import '../BookShimmer/GridViewBookSHimmer/GridViewBookShimmer.dart';
import '../CustomBookContainer/CustomBookContainer.dart';

class GridViewBookList extends BaseView<MyLibraryController> {
  final List<Map<String, dynamic>> books;

  const GridViewBookList({
    super.key,
    required this.books,
  });

  @override
  Widget vBuilder(BuildContext context) {
    return SizedBox(
      height: 500.h,
      child: Obx(() {
        if (books.isEmpty) {
          return GridViewBookShimmer();
        }
        return GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 0.60,
                mainAxisSpacing: 1.h),
            itemCount: books.length,
            itemBuilder: (BuildContext context, int index) {
              var book = books[index];
              return Expanded(
                child: Padding(
                  padding: EdgeInsets.only(left: 5.w),
                  child: BookContainer(
                    image: book['imageLinks']['thumbnail'],
                    bookName: book['title'] ?? 'No Title',
                    authorsName: (book['authors'] as List?)?.join(', ') ??
                        'Unknown Author',
                  ),
                ),
              );
            });
      }),
    );
  }
}
