import 'dart:math';

import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Navigation/routername.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/AccountScreen/AccountController.dart';
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
                    'Home',
                    style: TextStyle(
                        fontSize: 17.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.white100Color),
                  ),
                ],
              ),
              SizedBox(
                height: 3.h,
              ),
              Text(
                'Account',
                style: TextStyle(
                    fontSize: 19.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white100Color),
              ),
              Image.asset(
                AppImages.line,
                width: 22.w,
              ),
              SizedBox(
                height: 3.h,
              ),
              Row(
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(40),
                    child: Image.asset(
                      AppImages.profilePic,
                      height: 7.h,
                    ),
                  ),
                  SizedBox(
                    width: 3.w,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Jone Doe',
                        style: TextStyle(
                            fontSize: 17.sp,
                            fontWeight: FontWeight.bold,
                            color: AppColors.white100Color),
                      ),
                      Text(
                        'john.doe@example.com',
                        style: TextStyle(
                            fontSize: 15.sp, color: AppColors.white100Color),
                      ),
                    ],
                  )
                ],
              ),
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
        ),
      ),
    );
  }
}
