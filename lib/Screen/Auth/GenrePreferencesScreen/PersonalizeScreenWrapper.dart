import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Constant/colors.dart';
import '../../Basecontroller/basecontroller.dart';
import 'GenrePreferencesController.dart';

class GenrePreferencesWrapper extends BaseView<GenrePreferencesController> {
  const GenrePreferencesWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        Get.back();
        return Future.value(false);
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: AppColors.black,
        body: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: 10.h,
              ),
              Text(
                'Select Genres',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white100Color,
                ),
              ),
              SizedBox(
                height: 2.h,
              ),
              Container(
                height: 61.h,
                width: double.infinity,
                decoration: BoxDecoration(
                    color: AppColors.white100Color.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(20)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 5.h,
                    ),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: Text(
                        'Select the type of book you enjoy reading.',
                        style: TextStyle(
                          fontSize: 16.sp,
                          color: AppColors.white100Color,
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
                    Padding(
                      padding: EdgeInsets.only(left: 4.w),
                      child: SizedBox(
                        child: SingleChildScrollView(
                          child: Obx(
                            () {
                              final limitedCategories =
                                  controller.categories.take(15).toList();
                              return Wrap(
                                spacing: 4.w,
                                runSpacing: 3.h,
                                children: limitedCategories.map((category) {
                                  final isSelected = controller
                                      .selectedCategories
                                      .contains(category);
                                  return GestureDetector(
                                    onTap: () {
                                      controller.toggleCategory(category);
                                    },
                                    child: Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 1.h, horizontal: 4.w),
                                      decoration: BoxDecoration( border: Border.all(color: AppColors.grey, width: 0.5),
                                        color: isSelected
                                            ? AppColors.green
                                            : Colors.transparent,
                                        borderRadius:
                                            BorderRadius.circular(10.0),
                                        boxShadow: isSelected
                                            ? [
                                                BoxShadow(
                                                  color: Colors.blueAccent
                                                      .withOpacity(0.5),
                                                  blurRadius: 10.0,
                                                  offset: Offset(0, 4),
                                                ),
                                              ]
                                            : [],
                                      ),
                                      child: Text(
                                        category,
                                        style: TextStyle(
                                          color: isSelected
                                              ? AppColors.black
                                              : AppColors.grey,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 16.sp,
                                        ),
                                      ),
                                    ),
                                  );
                                }).toList(),
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 3.h),
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
