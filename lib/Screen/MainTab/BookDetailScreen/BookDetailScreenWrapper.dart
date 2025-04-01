import 'dart:ui';

import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/BookDetailScreen/BookDetailController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';


import 'package:shimmer/shimmer.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../Widget/BuildRowList/buildRowList.dart';

class Bookdetailscreenwrapper extends BaseView<BookDetailController> {

  
  final String bookTitle;
  final List<String>? categories;
  const Bookdetailscreenwrapper(
      {super.key, required this.bookTitle, this.categories});

  @override
  Widget vBuilder(BuildContext context) {
    
    return SafeArea(
      child: Scaffold(
          backgroundColor: Colors.black,
          body: Obx(() {
            final bookData = controller.bookData;

            if (bookData == null || bookData.isEmpty) {
              return Center(
                child: buildShimmerEffect(),
              );
            }

            return SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 3.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(top: 2.h),
                      child: GestureDetector(
                        onTap: () => Get.back(),
                        child: Icon(
                          Icons.arrow_back_ios,
                          size: 3.h,
                          color: AppColors.white100Color,
                        ),
                      ),
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 60.h,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            image: bookData['imageLinks']?['thumbnail'] != null
                                ? DecorationImage(
                                    image: NetworkImage(
                                        bookData['imageLinks']['thumbnail']),
                                    fit: BoxFit.cover,
                                  )
                                : null,
                          ),
                          child: BackdropFilter(
                            filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: AppColors.black.withOpacity(0.4)),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 27.h,
                          left: 30.w,
                          child: bookData['imageLinks']?['thumbnail'] != null
                              ? Image.network(
                                  bookData['imageLinks']['thumbnail'],
                                  height: 25.h,
                                  fit: BoxFit.cover,
                                )
                              : Image.asset(
                                  'assets/images/book_placeholder.png',
                                  height: 25.h),
                        ),
                        buildReadAndListen()
                      ],
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    buildTitleRow(),
                    buildAuthorsName(),
                    SizedBox(height: 3.h),
                    buildContainer(),
                    SizedBox(height: 3.h),
                    buildDescriptionColumn(),
                    SizedBox(height: 3.h),
                    buildCategories((bookData['categories'] as List<dynamic>?)
                            ?.cast<String>() ??
                        []),
                    SizedBox(height: 3.h),
                    buildSimilarBooks(),
                  ],
                ),
              ),
            );
          })),
    );
  }

  Widget buildSimilarBooks() {
    return BuildRowBookList(
      title: 'Similar Books',
      books: controller.categoryBooks,
    );
  }

  Widget buildShimmerEffect() {
    return Center(
      child: Shimmer.fromColors(
        baseColor: Colors.grey[800]!,
        highlightColor: Colors.grey[600]!,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: BoxDecoration(
            color: Colors.grey[800],
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
    );
  }

  Widget buildReadAndListen() {
    return Positioned(
      top: 51.h,
      left: 4.w,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgshade,
          borderRadius: BorderRadius.circular(20),
        ),
        height: 7.h,
        width: 85.w,
        child: Row(
          children: [
            SizedBox(
              width: 10.w,
            ),
            GestureDetector(
                onTap: () {
                  controller.openWebReader(
                      controller.bookData['accessInfo']['webReaderLink']);
                },
                child: buildTextRow(AppImages.read, 'Read Nexus')),
            SizedBox(
              width: 5.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.4.h),
              child: VerticalDivider(
                color: AppColors.grey,
                thickness: 1,
              ),
            ),
            SizedBox(
              width: 5.w,
            ),
            buildTextRow(AppImages.headphone, 'Play Nexus')
          ],
        ),
      ),
    );
  }

  Widget buildTextRow(String image, String title) {
    return Row(
      children: [
        Image.asset(
          image,
          height: 2.5.h,
        ),
        SizedBox(
          width: 2.w,
        ),
        Text(
          title,
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white100Color,
              fontWeight: FontWeight.bold),
        ),
      ],
    );
  }

  Widget buildTitleRow() {
    final bookData = controller.bookData;

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            bookData['title'] ?? 'Unknown Title',
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 19.sp,
              fontWeight: FontWeight.bold,
              color: AppColors.white100Color,
            ),
          ),
        ),
        IconButton(
          onPressed: () {},
          icon: Icon(
            Icons.bookmark_border_outlined,
            size: 3.5.h,
            color: AppColors.white100Color,
          ),
        ),
      ],
    );
  }

  Widget buildAuthorsName() {
    final bookData = controller.bookData;

    return Padding(
      padding: EdgeInsets.only(right: 2.w),
      child: Wrap(children: [
        Text(
          bookData['authors'] != null
              ? bookData['authors'].join(', ')
              : 'Unknown Author',
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          style: TextStyle(fontSize: 16.sp, color: AppColors.white100Color),
        ),
      ]),
    );
  }

  Widget buildContainer() {
    final bookData = controller.bookData;

    return Padding(
      padding: EdgeInsets.only(left: 15.w),
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.bgshade,
          borderRadius: BorderRadius.circular(10),
        ),
        height: 7.h,
        width: 65.w,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            buildTextColumn(bookData['pageCount'], 'Pages'),
            SizedBox(
              width: 7.w,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 1.4.h),
              child: VerticalDivider(
                color: AppColors.grey,
                thickness: 1,
              ),
            ),
            SizedBox(
              width: 7.w,
            ),
            buildTextColumn(
                bookData['publishedDate'].toString(), 'Published Date'),
          ],
        ),
      ),
    );
  }

  Widget buildTextColumn(String title, String title1) {
    return Padding(
      padding: EdgeInsets.only(top: 1.h),
      child: Column(
        children: [
          Text(
            title,
            style: TextStyle(
                fontSize: 17.sp,
                color: AppColors.white100Color,
                fontWeight: FontWeight.bold),
          ),
          Text(
            title1,
            style: TextStyle(
                fontSize: 16.sp,
                color: AppColors.grey,
                fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }

  Widget buildDescriptionColumn() {
    final bookData = controller.bookData;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'About This Book',
          style: TextStyle(
              fontSize: 16.sp,
              color: AppColors.white100Color,
              fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 1.h,
        ),
        Text(
          bookData['description'] ?? 'No description available.',
          maxLines: 3,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white100Color,
          ),
        ),
      ],
    );
  }

  Widget buildCategories(List<String>? categories) {
    if (categories == null || categories.isEmpty) {
      return SizedBox();
    }

    return Wrap(
      spacing: 8,
      children: categories.map((category) {
        return Container(
          padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
          decoration: BoxDecoration(
            color: AppColors.grey4.withOpacity(0.5),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            category,
            style: TextStyle(fontSize: 15.sp, color: AppColors.white100Color),
          ),
        );
      }).toList(),
    );
  }
}
