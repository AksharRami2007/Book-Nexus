import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../MainTab/BookDetailScreen/BookDetailController.dart';
import '../../MainTab/BookDetailScreen/BookDetailScreenWrapper.dart';
import '../BookShimmer/ListViewBookShimmer/BookShimmer.dart';
import '../CustomBookContainer/CustomBookContainer.dart';
import '../SeeMoreRow/SeeMoreRow.dart';

class BuildRowBookList extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  final String title;

  const BuildRowBookList({
    super.key,
    required this.books,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Obx(() => Column(
          children: [
            SeeMoreRow(title: title),
            SizedBox(height: 1.h),
            books.isEmpty
                ? const BookListShimmer()
                : SizedBox(
                    height: 40.h,
                    child: ListView.builder(
                      padding: EdgeInsets.symmetric(vertical: 2.h),
                      scrollDirection: Axis.horizontal,
                      itemCount: books.length,
                      itemBuilder: (context, index) {
                        if (index >= books.length) return Container();
                        var book = books[index];

                        return GestureDetector(
                          onTap: () {
                            Get.to(
                              () => Bookdetailscreenwrapper(
                                bookTitle: book['title'],
                                categories: book['categories'],
                              ),
                              binding: BookdetailcontrollerBindings(),
                              arguments: {
                                'bookDetails': book,
                                'categories': book['categories'],
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 2.h),
                            child: BookContainer(
                              image: book['imageLinks'] != null &&
                                      book['imageLinks']['thumbnail'] != null &&
                                      book['imageLinks']['thumbnail']
                                          .toString()
                                          .isNotEmpty
                                  ? book['imageLinks']['thumbnail']
                                  : 'assets/images/book_placeholder.png',
                              bookName: book['title'] ?? 'No Title',
                              authorsName:
                                  (book['authors'] as List?)?.join(', ') ??
                                      'Unknown Author',
                            ),
                          ),
                        );
                      },
                    ),
                  ),
          ],
        ));
  }
}
