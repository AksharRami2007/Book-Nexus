import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/BookDetailScreen/BookDetailController.dart';
import 'package:book_nexus/Screen/MainTab/BookDetailScreen/BookDetailScreenWrapper.dart';
import 'package:book_nexus/Screen/MainTab/SeeMoreScreen/SeeMoreController.dart';
import 'package:book_nexus/Screen/Widget/CustomBookContainer/CustomBookContainer.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Seemorescreenwrapper extends BaseView<Seemorecontroller> {
  const Seemorescreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: NestedScrollView(
          headerSliverBuilder: (context, innerBoxIsScrolled) => [
            CupertinoSliverNavigationBar(
              backgroundColor: AppColors.black,
              largeTitle: Text(
                controller.category.value,
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white100Color),
              ),
              leading: GestureDetector(
                onTap: () {
                  // Add debounce to prevent multiple navigation actions
                  if (!Get.isSnackbarOpen) {
                    Get.back();
                  }
                },
                child: Icon(
                  Icons.arrow_back_ios,
                  size: 3.h,
                  color: AppColors.white100Color,
                ),
              ),
            )
          ],
          body: SizedBox(
            height: 500.h,
            child: Obx(() {
              if (controller.books.isEmpty) {
                return buildShimmerEffect();
              }
              return GridView.builder(
                shrinkWrap: true,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 2.h,
                ),
                itemCount: controller.books.length,
                itemBuilder: (BuildContext context, int index) {
                  var book = controller.books[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: GestureDetector(
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
                      child: BookContainer(
                        image: book['imageLinks'] != null &&
                                book['imageLinks']['thumbnail'] != null &&
                                book['imageLinks']['thumbnail']
                                    .toString()
                                    .isNotEmpty
                            ? book['imageLinks']['thumbnail']
                            : 'assets/images/book_placeholder.png',
                        bookName: book['title'] ?? 'No Title',
                        authorsName: (book['authors'] as List?)?.join(', ') ??
                            'Unknown Author',
                      ),
                    ),
                  );
                },
              );
            }),
          ),
        ),
      ),
    );
  }
}

Widget buildShimmerEffect() {
  return SizedBox(
    height: 50.h,
    child: ListView.builder(
      padding: EdgeInsets.symmetric(vertical: 2.h),
      scrollDirection: Axis.vertical,
      itemCount: 5,
      itemBuilder: (context, index) {
        return Padding(
          padding: EdgeInsets.only(right: 2.h),
          child: Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Column(
              children: [
                Container(
                  width: 25.w,
                  height: 35.h,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                SizedBox(height: 1.h),
                Container(
                  width: 20.w,
                  height: 2.h,
                  color: Colors.white,
                ),
                SizedBox(height: 0.5.h),
                Container(
                  width: 15.w,
                  height: 2.h,
                  color: Colors.white,
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}
