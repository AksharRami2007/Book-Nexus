import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Constant/assets.dart';
import '../../../Constant/colors.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomScaffold extends StatelessWidget {
  final String title;
  final double containerHeight;
  final double containerWidth;
  final Widget child;
  final bool isBackBtn;
  const CustomScaffold({
    super.key,
    required this.title,
    required this.containerHeight,
    required this.containerWidth,
    required this.child,
    this.isBackBtn = false,
  });

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SingleChildScrollView(
          child: Stack(
            children: [
              SizedBox(
                  width: double.infinity,
                  child: Image.asset(AppImages.bgImage,
                      height: 100.h, fit: BoxFit.cover)),
              isBackBtn
                  ? Positioned(
                      left: 2.w,
                      right: 0,
                      top: 4.h,
                      child: Row(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              AppImages.backBtn,
                              height: 3.h,
                            ),
                          ),
                          SizedBox(
                            width: 2.w,
                          ),
                          Text(
                            'Back to Log in',
                            style: TextStyle(
                              fontSize: 17.sp,
                              color: AppColors.white100Color,
                            ),
                          )
                        ],
                      ),
                    )
                  : SizedBox(),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 2.w),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 25.h,
                    ),
                    Text(
                      title,
                      style: TextStyle(
                          fontSize: 23.sp,
                          color: AppColors.white100Color,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 2.h,
                    ),
                    Container(
                      height: containerHeight.h,
                      width: containerWidth.w,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                          color: AppColors.grey4.withOpacity(0.7)),
                      child: child,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
