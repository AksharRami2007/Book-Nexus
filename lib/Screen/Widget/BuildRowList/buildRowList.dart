import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../CustomBookContainer/CustomBookContainer.dart';

class ForYouBookList extends StatelessWidget {
  final List<Map<String, dynamic>> books;
  final Widget Function(String title) buildRow;

  const ForYouBookList({
    super.key,
    required this.books,
    required this.buildRow,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        buildRow('For You'),
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
                    var book = books[index];

                    return GestureDetector(
                      onTap: () {
                        // Get.to(() => BookDetailsScreen(book: book));
                      },
                      child: Padding(
                        padding: EdgeInsets.only(right: 2.h),
                        child: BookContainer(
                          image: book['cover_i'] != null
                              ? 'https://covers.openlibrary.org/b/id/${book['cover_i']}-M.jpg'
                              : 'assets/images/book_placeholder.png',
                          bookName: book['title'] ?? 'No Title',
                          authorsName:
                              (book['author_name'] as List?)?.join(', ') ??
                                  'Unknown Author',
                        ),
                      ),
                    );
                  },
                ),
              ),
      ],
    );
  }
}
