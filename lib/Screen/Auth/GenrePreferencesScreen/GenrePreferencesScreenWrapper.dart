import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import '../../../Constant/colors.dart';
import '../../Basecontroller/basecontroller.dart';
import 'GenrePreferencesController.dart';

class GenrePreferencesScreenWrapper extends BaseView<GenrePreferencesController> {
  const GenrePreferencesScreenWrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 5.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 4.h),
              Text(
                'Select Genres',
                style: TextStyle(
                  fontSize: 24.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.white100Color,
                ),
              ),
              SizedBox(height: 2.h),
              Text(
                'Select the type of book you enjoy reading.',
                style: TextStyle(
                  fontSize: 16.sp,
                  color: AppColors.white100Color,
                ),
              ),
              SizedBox(height: 2.h),
              Expanded(
                child: buildGenrePreferencesContainer(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildGenrePreferencesContainer() {
    return Obx(() {
      final isExpanded = controller.isExpanded.value;
      final displayedCategories = isExpanded
          ? controller.categories.toSet().toList()
          : controller.categories.take(10).toSet().toList();

      return Container(
        width: double.infinity,
        padding: EdgeInsets.all(4.w),
        decoration: BoxDecoration(
          color: AppColors.white100Color.withOpacity(0.1),
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          children: [
            // Make the entire list scrollable to prevent overflow
            Flexible(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    Wrap(
                      spacing: 3.w,
                      runSpacing: 2.h,
                      children: displayedCategories.map((category) {
                        final isSelected =
                            controller.selectedCategories.contains(category);
                        return GestureDetector(
                          onTap: () {
                            controller.toggleCategory(category);
                          },
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 1.h, horizontal: 4.w),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.green
                                  : Colors.transparent,
                              border:
                                  Border.all(color: AppColors.grey, width: 0.5),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  category,
                                  style: TextStyle(
                                    color: isSelected
                                        ? AppColors.black
                                        : AppColors.white100Color,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14.sp,
                                  ),
                                ),
                                SizedBox(width: 2.w),
                                Icon(
                                  isSelected
                                      ? Icons.check_circle_outline
                                      : Icons.add_circle_outline,
                                  color: isSelected
                                      ? AppColors.black
                                      : AppColors.white100Color,
                                  size: 5.w,
                                ),
                              ],
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                    SizedBox(height: 2.h),
                  ],
                ),
              ),
            ),
            TextButton(
              onPressed: () => controller.isExpanded.toggle(),
              child: Text(
                isExpanded ? 'Show Less' : 'Show More',
                style: TextStyle(
                  color: AppColors.green,
                  fontSize: 14.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 2.h),
            Container(
              width: double.infinity,
              child: ElevatedButton(
                onPressed:
                    controller.selectedCategories.length >= 3 ? () {} : null,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.green,
                  disabledBackgroundColor: AppColors.grey.withOpacity(0.5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  padding:
                      EdgeInsets.symmetric(vertical: 1.5.h, horizontal: 10.w),
                ),
                child: Text(
                  'Continue',
                  style: TextStyle(
                    color: AppColors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 16.sp,
                  ),
                ),
              ),
            ),
            SizedBox(height: 1.h),
            Text(
              'Select 3 or more genres to continue',
              style: TextStyle(
                fontSize: 14.sp,
                color: AppColors.grey,
              ),
            ),
          ],
        ),
      );
    });
  }
}
