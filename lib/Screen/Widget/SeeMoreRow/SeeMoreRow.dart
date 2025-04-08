import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Constant/assets.dart';
import '../../../Constant/colors.dart';
import '../../../Constant/font_family.dart';
import '../../../Navigation/routername.dart';

class SeeMoreRow extends StatelessWidget {
  final String title;
  const SeeMoreRow({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return buildRow(title);
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
            onTap: () {
              // Navigate to see more screen after current frame
              WidgetsBinding.instance.addPostFrameCallback((_) {
                Get.toNamed(RouterName.seeMoreScreenWrapper, arguments: {
                  'category': title,
                });
              });
            },
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

  TextStyle buildSectionTitleTextStyle() => TextStyle(
        fontSize: 20.sp,
        fontFamily: AppFonts.family2Bold,
        fontWeight: FontWeight.bold,
        color: AppColors.white100Color,
      );
}
