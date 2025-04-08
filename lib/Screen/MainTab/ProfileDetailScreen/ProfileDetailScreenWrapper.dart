import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/MainTab/ProfileDetailScreen/ProfileDetailController.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';

class Profiledetailscreenwrapper extends BaseView<Profiledetailcontroller> {
  const Profiledetailscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      appBar: AppBar(
        backgroundColor: AppColors.black,
        leading: IconButton(
          onPressed: () {
            // Add debounce to prevent multiple navigation actions
            if (!Get.isSnackbarOpen) {
              Get.back();
            }
          },
          icon: Icon(
            Icons.arrow_back_ios,
            size: 3.h,
            color: AppColors.white100Color,
          ),
        ),
        title: Text(
          'Back',
          style: TextStyle(
            fontSize: 17.sp,
            fontWeight: FontWeight.w500,
            color: AppColors.white100Color,
          ),
        ),
        actions: [
          // Edit/Save button
          Obx(() => controller.isLoading.value
              ? Container() // Hide button when loading
              : controller.isEditing.value
                  ? Row(
                      children: [
                        // Save button
                        IconButton(
                          onPressed: controller.saveUserData,
                          icon: Icon(
                            Icons.check,
                            color: AppColors.green,
                            size: 3.h,
                          ),
                        ),
                        // Cancel button
                        IconButton(
                          onPressed: controller.cancelEditing,
                          icon: Icon(
                            Icons.close,
                            color: AppColors.white100Color,
                            size: 3.h,
                          ),
                        ),
                      ],
                    )
                  : IconButton(
                      onPressed: controller.toggleEditMode,
                      icon: Icon(
                        Icons.edit,
                        color: AppColors.white100Color,
                        size: 3.h,
                      ),
                    )),
        ],
      ),
      body: Obx(() {
        // Show loading indicator when loading
        if (controller.isLoading.value) {
          return Center(
            child: CircularProgressIndicator(
              color: AppColors.green,
            ),
          );
        }

        // Show profile content when loaded
        return SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 2.w),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 2.h),
                Text(
                  'Profile Details',
                  style: TextStyle(
                    fontSize: 20.sp,
                    fontWeight: FontWeight.bold,
                    color: AppColors.white100Color,
                  ),
                ),
                SizedBox(height: 3.h),
                // Profile picture
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
                        ),
                      ),
                      Positioned(
                        top: 8.h,
                        left: 15.w,
                        child: Container(
                          decoration: BoxDecoration(
                            color: AppColors.green,
                            borderRadius: BorderRadius.circular(60),
                          ),
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
                SizedBox(height: 2.h),
                Padding(
                  padding: EdgeInsets.only(left: 30.w),
                  child: Text(
                    'Change Profile Picture',
                    style: TextStyle(
                      fontSize: 16.sp,
                      fontWeight: FontWeight.w500,
                      color: AppColors.green,
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),
                Divider(
                  color: AppColors.grey4,
                  thickness: 2,
                ),
                SizedBox(height: 2.5.h),

                // Name field
                Text(
                  'Your Name',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.white100Color,
                  ),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: controller.nameController,
                  style: TextStyle(color: AppColors.white100Color),
                  enabled: controller.isEditing.value,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Enter your name',
                    hintStyle: TextStyle(color: AppColors.grey),
                    fillColor: AppColors.grey4,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),

                // Email field
                Text(
                  'Email',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.white100Color,
                  ),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: controller.emailController,
                  style: TextStyle(color: AppColors.white100Color),
                  enabled: false, // Email cannot be edited
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'Your email address',
                    hintStyle: TextStyle(color: AppColors.grey),
                    fillColor: AppColors.grey4,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),
                SizedBox(height: 2.5.h),

                // Date of Birth field
                Text(
                  'Date Of Birth',
                  style: TextStyle(
                    fontSize: 15.sp,
                    color: AppColors.white100Color,
                  ),
                ),
                SizedBox(height: 1.h),
                TextField(
                  controller: controller.dobController,
                  style: TextStyle(color: AppColors.white100Color),
                  enabled: controller.isEditing.value,
                  decoration: InputDecoration(
                    filled: true,
                    hintText: 'DD Month, YYYY',
                    hintStyle: TextStyle(color: AppColors.grey),
                    fillColor: AppColors.grey4,
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                ),

                SizedBox(height: 4.h),

                // Save button (only shown in edit mode)
                Obx(() => controller.isEditing.value
                    ? Center(
                        child: ElevatedButton(
                          onPressed: controller.saveUserData,
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.green,
                            padding: EdgeInsets.symmetric(
                              horizontal: 10.w,
                              vertical: 1.5.h,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 16.sp,
                              color: AppColors.white100Color,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      )
                    : Container()),
              ],
            ),
          ),
        );
      }),
    );
  }
}
