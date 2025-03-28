import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/MyLibraryScreen/MyLibraryController.dart';
import 'package:book_nexus/Screen/Widget/CustomBookContainer/CustomBookContainer.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

class Mylibraryscreenwrapper extends BaseView<Mylibrarycontroller> {
  const Mylibraryscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 5.h,
                ),
                Text(
                  'My Library',
                  style: TextStyle(
                      fontSize: 19.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white100Color),
                ),
                Image.asset(
                  AppImages.line,
                  width: 27.w,
                ),
                SizedBox(
                  height: 3.h,
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: [
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: AppColors.grey4,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.bookmark,
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                'Saved books',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColors.white100Color),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: 2.w,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: AppColors.grey4,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.headphone,
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                'In Progress',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColors.white100Color),
                              ),
                            ],
                          )),
                      SizedBox(
                        width: 2.w,
                      ),
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30)),
                            backgroundColor: AppColors.grey4,
                          ),
                          onPressed: () {},
                          child: Row(
                            children: [
                              Image.asset(
                                AppImages.checked,
                                color: AppColors.white100Color,
                                height: 2.h,
                              ),
                              SizedBox(
                                width: 1.w,
                              ),
                              Text(
                                'Completed',
                                style: TextStyle(
                                    fontSize: 15.sp,
                                    color: AppColors.white100Color),
                              ),
                            ],
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                SizedBox(
                  height: 500.h,
                  child: Obx(() {
                    if (controller.library.isEmpty) {
                      return buildShimmerEffect();
                    }
                    return GridView.builder(
                        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            childAspectRatio: 0.60,
                            mainAxisSpacing: 1.h),
                        itemCount: controller.library.length,
                        itemBuilder: (BuildContext context, int index) {
                          var book = controller.library[index];
                          return Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(left: 5.w),
                              child: BookContainer(
                                image: book['cover_i'] != null
                                    ? 'https://covers.openlibrary.org/b/id/${book['cover_i']}-M.jpg'
                                    : 'assets/images/book_placeholder.png',
                                bookName: book['title'] ?? 'No Title',
                                authorsName: (book['author_name'] as List?)
                                        ?.join(', ') ??
                                    'Unknown Author',
                              ),
                            ),
                          );
                        });
                  }),
                )
              ],
            ),
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
