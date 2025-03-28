import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

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
                      itemCount: 5,
                      itemBuilder: (context, index) {
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
                                'bookTitle': book['title'],
                                'categories': book['categories'],
                              },
                            );
                          },
                          child: Padding(
                            padding: EdgeInsets.only(right: 2.h),
                            child: BookContainer(
                              image: book['imageLinks']['thumbnail'],
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
