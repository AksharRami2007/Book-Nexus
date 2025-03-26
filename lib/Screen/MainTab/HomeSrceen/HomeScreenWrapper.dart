import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/MainTab/HomeSrceen/HomeController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart'; // Import shimmer package

import '../../../Constant/font_family.dart';
import '../../Widget/CustomBookContainer/CustomBookContainer.dart';

class HomeScreenWrapper extends BaseView<HomeController> {
  const HomeScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 3.w),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                buildProfileRow(),
                SizedBox(height: 2.h),
                buildForYouBookList(),
                SizedBox(height: 2.h),
                buildTrendingBookList(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildForYouBookList() {
    return Column(
      children: [
        buildRow('For You'),
        SizedBox(height: 1.h),
        Obx(() {
          if (controller.forYouBooks.isEmpty) {
            return buildShimmerEffect();
          }

          return SizedBox(
            height: 40.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              scrollDirection: Axis.horizontal,
              itemCount: controller.forYouBooks.length,
              itemBuilder: (context, index) {
                var book = controller.forYouBooks[index];

                return Padding(
                  padding: EdgeInsets.only(right: 2.h),
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
            ),
          );
        }),
      ],
    );
  }

  Widget buildTrendingBookList() {
    return Column(
      children: [
        buildRow('Trending'),
        SizedBox(height: 1.h),
        Obx(() {
          if (controller.trendingBooks.isEmpty) {
            return buildShimmerEffect();
          }

          return SizedBox(
            height: 40.h,
            child: ListView.builder(
              padding: EdgeInsets.symmetric(vertical: 2.h),
              scrollDirection: Axis.horizontal,
              itemCount: controller.trendingBooks.length,
              itemBuilder: (context, index) {
                var book = controller.trendingBooks[index];

                return Padding(
                  padding: EdgeInsets.only(right: 2.h),
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
            ),
          );
        }),
      ],
    );
  }

  Widget buildShimmerEffect() {
    return SizedBox(
      height: 50.h,
      child: ListView.builder(
        padding: EdgeInsets.symmetric(vertical: 2.h),
        scrollDirection: Axis.horizontal,
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

  Widget buildRow(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          title,
          style: buildSectionTitleTextStyle(),
        ),
        buildSeeAllRow(),
      ],
    );
  }

  Widget buildSeeAllRow() {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.only(top: 0.7.h),
          child: GestureDetector(
            onTap: () {},
            child: Text(
              'See All',
              style: TextStyle(
                color: AppColors.green,
                fontSize: 16.sp,
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
        ),
        SizedBox(width: 2.w),
        Image.asset(AppImages.rightSideArrow, width: 5.w),
      ],
    );
  }

  Widget buildProfileRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Good Afternoon',
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.white100Color,
              ),
            ),
            Image.asset(AppImages.curve, width: 15.w),
          ],
        ),
        ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.asset(AppImages.profilePic, height: 6.h),
        ),
      ],
    );
  }

  TextStyle buildSectionTitleTextStyle() => TextStyle(
        fontSize: 20.sp,
        fontFamily: AppFonts.family2Bold,
        fontWeight: FontWeight.bold,
        color: AppColors.white100Color,
      );
}
