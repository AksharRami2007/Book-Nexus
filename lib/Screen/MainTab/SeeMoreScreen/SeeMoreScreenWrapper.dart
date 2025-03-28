import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
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
                'Fiction',
                style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white100Color),
              ),
              leading: Icon(
                Icons.arrow_back_ios,
                size: 3.h,
                color: AppColors.white100Color,
              ),
            )
          ],
          body: SizedBox(
            height: 500.h,
            child: Obx(() {
              if (controller.fiction.isEmpty) {
                return buildShimmerEffect();
              }
              return GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 2.w,
                  childAspectRatio: 0.6,
                  mainAxisSpacing: 2.h,
                ),
                itemCount: controller.fiction.length,
                itemBuilder: (BuildContext context, int index) {
                  var book = controller.fiction[index];
                  return Padding(
                    padding: EdgeInsets.only(left: 6.w),
                    child: BookContainer(
                      image: book['cover_i'] != null
                          ? 'https://covers.openlibrary.org/b/id/${book['cover_i']}-M.jpg'
                          : 'assets/images/book_placeholder.png',
                      bookName: book['title'] ?? 'No Title',
                      authorsName: (book['author_name'] as List?)?.join(', ') ??
                          'Unknown Author',
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
      itemCount: 5, // Show 5 shimmer placeholders
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
