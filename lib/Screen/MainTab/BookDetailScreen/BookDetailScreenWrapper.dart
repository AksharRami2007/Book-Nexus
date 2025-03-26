import 'dart:ui';

import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/BookDetailScreen/BookDetailController.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class Bookdetailscreenwrapper extends BaseView<Bookdetailcontroller> {
  const Bookdetailscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 3.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(
                  children: [
                    Container(
                      height: 60.h,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          image: DecorationImage(
                        image: ExactAssetImage(
                          AppImages.bookcover,
                        ),
                      )),
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
                        child: Image.asset(
                          AppImages.bookcover,
                          height: 25.h,
                        )),
                    Positioned(
                      top: 51.h,
                      left: 1.w,
                      child: Container(
                        decoration: BoxDecoration(
                          color: AppColors.bgshade,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        height: 7.h,
                        width: 90.w,
                        child: Row(
                          children: [
                            SizedBox(
                              width: 10.w,
                            ),
                            Image.asset(
                              AppImages.read,
                              height: 2.5.h,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Read Nexus',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.white100Color,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
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
                            Image.asset(
                              AppImages.headphone,
                              height: 2.5.h,
                            ),
                            SizedBox(
                              width: 2.w,
                            ),
                            RichText(
                                text: TextSpan(children: <TextSpan>[
                              TextSpan(
                                text: 'Play Nexus',
                                recognizer: TapGestureRecognizer()
                                  ..onTap = () {},
                                style: TextStyle(
                                    fontSize: 16.sp,
                                    color: AppColors.white100Color,
                                    fontWeight: FontWeight.bold),
                              )
                            ])),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Project Management for the',
                          style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white100Color),
                        ),
                        Text(
                          'Unofficial Project Manager',
                          style: TextStyle(
                              fontSize: 19.sp,
                              fontWeight: FontWeight.bold,
                              color: AppColors.white100Color),
                        ),
                      ],
                    ),
                    IconButton(
                        onPressed: () {},
                        icon: Icon(
                          Icons.bookmark_border_outlined,
                          size: 3.5.h,
                          color: AppColors.white100Color,
                        )),
                  ],
                ),
                SizedBox(
                  height: 2.h,
                ),
                Text(
                  'Kory kogon, Suzette Blakemore, and James Wood',
                  style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                      color: AppColors.white100Color),
                ),
                Text(
                  'A Fanklin Convey Title',
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.white100Color),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: AppColors.bgshade,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  height: 5.h,
                  width: 90.w,
                  child: Row(
                    children: [
                      SizedBox(
                        width: 12.w,
                      ),
                      Image.asset(
                        AppImages.clock,
                        height: 2.5.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: '18 min',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.white100Color,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                      SizedBox(
                        width: 11.w,
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
                      Image.asset(
                        AppImages.bulb,
                        height: 2.5.h,
                      ),
                      SizedBox(
                        width: 2.w,
                      ),
                      RichText(
                          text: TextSpan(children: <TextSpan>[
                        TextSpan(
                          text: '6 Key Ideas',
                          recognizer: TapGestureRecognizer()..onTap = () {},
                          style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.white100Color,
                              fontWeight: FontWeight.bold),
                        )
                      ])),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Text(
                  'About This Book',
                  style: TextStyle(
                      fontSize: 16.sp,
                      color: AppColors.white100Color,
                      fontWeight: FontWeight.bold),
                ),
                Text(
                  'Getting Along(2022) describes the importannce of Workplace interaction and thier effects on productivity and creativity',
                  style: TextStyle(
                    fontSize: 16.sp,
                    color: AppColors.white100Color,
                  ),
                ),
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.h),
                  decoration: BoxDecoration(
                      color: AppColors.grey4.withOpacity(0.5),
                      borderRadius: BorderRadius.circular(10)),
                  child: Text(
                    'Fiction',
                    style: TextStyle(
                        fontSize: 15.sp, color: AppColors.white100Color),
                  ),
                ),
                SizedBox(
                  height: 3.h,
                ),
                Container(
                  decoration: BoxDecoration(
                      color: AppColors.grey4,
                      borderRadius: BorderRadius.circular(10)),
                  height: 20.h,
                  width: double.infinity,
                  child: Row(
                    children: [
                      ClipRRect(
                          borderRadius: BorderRadius.circular(50),
                          child: Image.asset(
                            AppImages.profilePic,
                            height: 10.h,
                          )),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'James Wood',
                            style: TextStyle(
                                fontSize: 18.sp,
                                color: AppColors.white100Color,
                                fontWeight: FontWeight.bold),
                          ),
                          Text(
                            'A FanklinConvey Title',
                            style: TextStyle(
                              fontSize: 15.sp,
                              color: AppColors.white100Color,
                            ),
                          ),
                          Expanded(
                            child: Text(
                              'Managers Who Went to Create Positive Work enviromnet',
                              style: TextStyle(
                                fontSize: 14.sp,
                                color: AppColors.white100Color,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 3.h,
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
