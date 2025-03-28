import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/ProfileDetailController.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class Profiledetailscreenwrapper extends BaseView<Profiledetailcontroller> {
  const Profiledetailscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: AppColors.black,
        body: SingleChildScrollView(
          child: Padding(
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
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back_ios,
                          size: 3.h,
                          color: AppColors.white100Color,
                        )),
                    Text(
                      'Back',
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
                  'Profile Details',
                  style: TextStyle(
                      fontSize: 20.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white100Color),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 35.w),
                  child: Stack(
                    clipBehavior: Clip.none,
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(70),
                          child: Image.asset(
                            AppImages.profilePic,
                            height: 12.h,
                          )),
                      Positioned(
                        top: 8.h,
                        left: 15.w,
                        child: Container(
                          decoration: BoxDecoration(
                              color: AppColors.green,
                              borderRadius: BorderRadius.circular(60)),
                          height: 5.h,
                          width: 11.w,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                AppImages.upload,
                                height: 3.h,
                              )
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 2.h,
                ),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    'Change Profile Piture',
                    style: TextStyle(
                        fontSize: 16.sp,
                        fontWeight: FontWeight.w500,
                        color: AppColors.green),
                  ),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Divider(
                  color: AppColors.grey4,
                  thickness: 2,
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Text(
                  'Your Name',
                  style: TextStyle(
                      fontSize: 15.sp, color: AppColors.white100Color),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'john doe',
                      hintStyle: TextStyle(color: AppColors.white100Color),
                      fillColor: AppColors.grey4,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Text(
                  'Email',
                  style: TextStyle(
                      fontSize: 15.sp, color: AppColors.white100Color),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextField(style: TextStyle(color: AppColors.white100Color),
                  decoration: InputDecoration(
                      filled: true,
                      hintText: 'john.doe@gmail.com',
                      hintStyle: TextStyle(color: AppColors.white100Color),
                      fillColor: AppColors.grey4,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
                SizedBox(
                  height: 2.5.h,
                ),
                Text(
                  'Date Of Birth',
                  style: TextStyle(
                      fontSize: 15.sp, color: AppColors.white100Color),
                ),
                SizedBox(
                  height: 1.h,
                ),
                TextField(
                  decoration: InputDecoration(
                      filled: true,
                      hintText: '23 Decembre, 1975',
                      hintStyle: TextStyle(color: AppColors.white100Color),
                      fillColor: AppColors.grey4,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(10),
                      )),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
