import 'dart:math';

import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/AccountScreen/AccountController.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/BookCalendarWidget.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class Accountscreenwrapper extends BaseView<Accountcontroller> {
  const Accountscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 2.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 5.h,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  IconButton(
                      onPressed: () {},
                      icon: Icon(
                        Icons.arrow_back_ios,
                        size: 3.h,
                        color: AppColors.white100Color,
                      )),
                  Text(
                    'Account Deatils',
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white100Color),
                  ),
                ],
              ),
              Obx(() => Text(
                    controller.tabTitles[controller.selectedTabIndex.value],
                    style: TextStyle(
                        fontSize: 19.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white100Color),
                  )),
              Image.asset(
                AppImages.line,
                width: 22.w,
              ),
              SizedBox(
                height: 2.h,
              ),
              _buildTabs(),
              Expanded(
                child: Obx(() => _buildTabContent()),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTabs() {
    return Container(
      height: 5.h,
      decoration: BoxDecoration(
        color: AppColors.grey4,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        children: List.generate(
          controller.tabTitles.length,
          (index) => Expanded(
            child: Obx(() => GestureDetector(
                  onTap: () => controller.changeTab(index),
                  child: Container(
                    decoration: BoxDecoration(
                      color: controller.selectedTabIndex.value == index
                          ? AppColors.green
                          : Colors.transparent,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Center(
                      child: Text(
                        controller.tabTitles[index],
                        style: TextStyle(
                          color: AppColors.white100Color,
                          fontWeight: controller.selectedTabIndex.value == index
                              ? FontWeight.bold
                              : FontWeight.normal,
                        ),
                      ),
                    ),
                  ),
                )),
          ),
        ),
      ),
    );
  }

  Widget _buildTabContent() {
    switch (controller.selectedTabIndex.value) {
      case 0:
        return _buildAccountContent();
      case 1:
        return _buildReadingCalendarContent();
      default:
        return _buildAccountContent();
    }
  }

  Widget _buildAccountContent() {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 3.h,
          ),
          Obx(() => Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      controller.uploadProfilePicture();
                    },
                    child: Stack(
                      children: [
                        ClipRRect(
                          borderRadius: BorderRadius.circular(40),
                          child: controller.profilePictureUrl.value.isNotEmpty
                              ? Image.network(
                                  controller.profilePictureUrl.value,
                                  height: 7.h,
                                  width: 7.h,
                                  fit: BoxFit.cover,
                                  errorBuilder: (context, error, stackTrace) {
                                    return Image.asset(
                                      AppImages.profilePic,
                                      height: 7.h,
                                      width: 7.h,
                                      fit: BoxFit.cover,
                                    );
                                  },
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;
                                    return Container(
                                      height: 7.h,
                                      width: 7.h,
                                      color: AppColors.grey4,
                                      child: Center(
                                        child: CircularProgressIndicator(
                                          color: AppColors.green,
                                          value: loadingProgress
                                                      .expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  loadingProgress
                                                      .expectedTotalBytes!
                                              : null,
                                        ),
                                      ),
                                    );
                                  },
                                )
                              : Image.asset(
                                  AppImages.profilePic,
                                  height: 7.h,
                                  width: 7.h,
                                  fit: BoxFit.cover,
                                ),
                        ),
                        if (controller.isUploadingImage.value)
                          Positioned.fill(
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.black.withOpacity(0.5),
                                borderRadius: BorderRadius.circular(40),
                              ),
                              child: Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.green,
                                ),
                              ),
                            ),
                          ),
                        Positioned(
                          bottom: 0,
                          right: 0,
                          child: Container(
                            padding: EdgeInsets.all(4),
                            decoration: BoxDecoration(
                              color: AppColors.green,
                              shape: BoxShape.circle,
                            ),
                            child: Icon(
                              Icons.camera_alt,
                              size: 1.5.h,
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        controller.userName.value,
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white100Color),
                      ),
                      Text(
                        controller.userEmail.value,
                        style: TextStyle(
                            fontSize: 15.sp, color: AppColors.white100Color),
                      ),
                    ],
                  ),
                  if (controller.isLoadingUserData.value)
                    Padding(
                      padding: EdgeInsets.only(left: 2.w),
                      child: SizedBox(
                        height: 2.h,
                        width: 2.h,
                        child: CircularProgressIndicator(
                          color: AppColors.green,
                          strokeWidth: 2,
                        ),
                      ),
                    ),
                ],
              )),
          SizedBox(
            height: 3.h,
          ),
          Divider(
            color: AppColors.grey4,
            thickness: 2,
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.profile,
                    height: 6.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'Profile Details',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white100Color),
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    Get.toNamed(RouterName.profileDetailScreen);
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 3.h,
                    color: AppColors.white100Color,
                  ))
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.fAQs,
                    height: 6.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'FAQs',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white100Color),
                  ),
                  SizedBox(
                    width: 44.w,
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {},
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 3.h,
                    color: AppColors.white100Color,
                  ))
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                  Image.asset(
                    AppImages.logout,
                    height: 6.h,
                  ),
                  SizedBox(
                    width: 4.w,
                  ),
                  Text(
                    'Logout',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.bold,
                        color: AppColors.white100Color),
                  ),
                  SizedBox(
                    width: 44.w,
                  ),
                ],
              ),
              IconButton(
                  onPressed: () {
                    controller.logout();
                  },
                  icon: Icon(
                    Icons.arrow_forward_ios_sharp,
                    size: 3.h,
                    color: AppColors.white100Color,
                  ))
            ],
          ),
          SizedBox(
            height: 3.h,
          ),
          Container(
            decoration: BoxDecoration(
                color: AppColors.grey4,
                borderRadius: BorderRadius.circular(15)),
            height: 8.h,
            width: double.infinity,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  AppImages.headphone,
                  height: 4.h,
                  color: AppColors.green,
                ),
                SizedBox(
                  width: 2.w,
                ),
                Text(
                  'Feel free to ask, Were are here to help',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.green),
                )
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget _buildReadingCalendarContent() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 2.h),
        Text(
          'Track your reading habits',
          style: TextStyle(
            fontSize: 16.sp,
            color: AppColors.white100Color,
          ),
        ),
        SizedBox(height: 1.h),
        Text(
          'See which books you\'ve read and when',
          style: TextStyle(
            fontSize: 14.sp,
            color: AppColors.white100Color.withOpacity(0.7),
          ),
        ),
        SizedBox(height: 1.h),
        Obx(() => controller.isLoadingStats.value
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColors.green,
                ),
              )
            : Container(
                padding: EdgeInsets.all(2.h),
                decoration: BoxDecoration(
                  color: AppColors.grey4,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Row(
                  children: [
                    Icon(
                      Icons.timer,
                      color: AppColors.green,
                      size: 5.h,
                    ),
                    SizedBox(width: 2.w),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Total Reading Time',
                          style: TextStyle(
                            fontSize: 14.sp,
                            color: AppColors.white100Color,
                          ),
                        ),
                        SizedBox(height: 0.5.h),
                        Text(
                          '${controller.totalReadingHours.value.toStringAsFixed(1)} hours',
                          style: TextStyle(
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.green,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              )),
        SizedBox(height: 2.h),
        Expanded(
          child: BookCalendarWidget(),
        ),
      ],
    );
  }
}
