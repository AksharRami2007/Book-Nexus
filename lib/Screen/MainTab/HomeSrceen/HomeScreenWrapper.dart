import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/MainTab/HomeSrceen/HomeController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

import '../../../Constant/font_family.dart';
import '../../Widget/BuildRowList/buildRowList.dart';

class HomeScreenWrapper extends BaseView<HomeController> {
  const HomeScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
<<<<<<< Updated upstream
    return WillPopScope(
        onWillPop: () async {
          Get.back();
          return false;
        },
        child: SafeArea(
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
                    // buildForYouBookList(),
                    // SizedBox(height: 2.h),
                    // buildRecentArrivesBookList(),
                    // SizedBox(height: 2.h),
                    // buildTrendingBookList(),
                    // SizedBox(height: 2.h),
                    // buildPopularBookList(),
                    // SizedBox(height: 2.h),
                    // buildThrillerBookList(),
                    // SizedBox(height: 2.h),
                    // buildSciFiBookList(),
                    // SizedBox(height: 2.h),
                    // buildRomanceBookList(),
                    // SizedBox(height: 10.h),
                  ],
                ),
              ),
=======
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
                buildRecentArrivesBookList(),
                SizedBox(height: 2.h),
                buildTrendingBookList(),
                SizedBox(height: 2.h),
                buildPopularBookList(),
                SizedBox(height: 2.h),
                buildThrillerBookList(),
                SizedBox(height: 2.h),
                buildSciFiBookList(),
                SizedBox(height: 2.h),
                buildRomanceBookList(),
                SizedBox(height: 10.h),
              ],
>>>>>>> Stashed changes
            ),
          ),
        ));
  }

  Widget buildRecentArrivesBookList() {
    return BuildRowBookList(
      title: 'Recent Arrive',
      books: controller.recentArrive,
    );
  }

  Widget buildRecentArrivesBookList() {
    return BuildRowBookList(
      title: 'Recent Arrive',
      books: controller.recentArrive,
    );
  }

  Widget buildThrillerBookList() {
    return BuildRowBookList(
      title: 'Thriller',
      books: controller.thrillerBooks,
    );
  }

  Widget buildSciFiBookList() {
    return BuildRowBookList(
      title: 'Sci-Fi',
      books: controller.scifiBooks,
    );
  }

  Widget buildRomanceBookList() {
    return BuildRowBookList(
      title: 'Romance',
      books: controller.romanceBooks,
    );
  }

  Widget buildPopularBookList() {
    return BuildRowBookList(
      title: 'Fiction',
      books: controller.fictionBooks,
    );
  }

  Widget buildForYouBookList() {
    return BuildRowBookList(
      title: 'For You',
      books: controller.forYouBooks,
    );
  }

  Widget buildTrendingBookList() {
    return BuildRowBookList(
      title: 'Trending',
      books: controller.trendingBooks,
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
              controller.getGreeting(),
              style: TextStyle(
                fontSize: 20.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.white100Color,
              ),
            ),
            Image.asset(AppImages.curve, width: 15.w),
          ],
        ),
        GestureDetector(
          onTap: () {
<<<<<<< Updated upstream
            // WidgetsBinding.instance.addPostFrameCallback((_) {
            Get.toNamed(RouterName.accountScreen);
            // });
=======
            Get.toNamed(RouterName.accountScreen);
>>>>>>> Stashed changes
          },
          child: ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: Image.asset(AppImages.profilePic, height: 6.h),
          ),
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
