import 'package:book_nexus/Constant/assets.dart';
import 'package:book_nexus/Constant/colors.dart';
import 'package:book_nexus/Screen/Auth/ForgotPasswordScreen/SetPasswordsScreen/SetPasswordController.dart';
import 'package:book_nexus/Screen/Basecontroller/basecontroller.dart';
import 'package:book_nexus/Screen/Widget/CustomScafflod/CustomScaffold.dart';
import 'package:book_nexus/Screen/Widget/Custombutton/Custombutton.dart';
import 'package:book_nexus/Screen/Widget/Customtextfield/Customtextfield.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:get/get.dart';


class Setpasswordscreenwrapper extends BaseView<Setpasswordcontroller> {
  const Setpasswordscreenwrapper({super.key});

  @override
  Widget vBuilder(BuildContext context) {
    return CustomScaffold(
      title: 'Set Password',
      containerHeight: 45,
      containerWidth: 95,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            height: 2.h,
          ),
          Image.asset(
            AppImages.checked,
            height: 7.h,
          ),
          SizedBox(
            height: 1.h,
          ),
          Text(
            'Code Verified',
            style: TextStyle(
                fontSize: 15.sp,
                fontWeight: FontWeight.w500,
                color: AppColors.white100Color),
          ),
          SizedBox(
            height: 2.h,
          ),
          Customtextfield(
              name: 'Enter New Password',
              obsecuretext: controller.isPasswordhidden.value,
              onchanged: (String value) {},suffixicon: IconButton(onPressed: (){}, icon: Icon(Icons.)),),
          SizedBox(
            height: 2.h,
          ),
          Customtextfield(
              name: 'Re-type a New Password',
              obsecuretext: true,
              onchanged: (String value) {}),
          SizedBox(
            height: 1.h,
          ),
          Padding(
            padding:  EdgeInsets.only(right: 48.w),
            child: Text(
              'At-Least 8 Characters',
              style: TextStyle(fontSize: 15.sp, color: AppColors.white100Color),
            ),
          ),
          SizedBox(
            height: 2.h,
          ),
          Custombutton(
            name: 'Set Password',
            onclick: () {},
          )
        ],
      ),
    );
  }
}
